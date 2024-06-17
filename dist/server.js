import Fastify from "fastify";
import { z } from "zod";
import { serializerCompiler, validatorCompiler, } from "fastify-type-provider-zod";
import { fromError } from "zod-validation-error";
export function start_web_server() {
    const web_server = Fastify({
        logger: true,
    }).withTypeProvider();
    web_server.setValidatorCompiler(validatorCompiler);
    web_server.setSerializerCompiler(serializerCompiler);
    web_server.setErrorHandler(async function (error, _, reply) {
        if (error instanceof z.ZodError) {
            const valerror = fromError(error);
            reply.code(error.statusCode || 400);
            return { message: valerror.toString() };
        }
        else {
            reply.status(500);
            console.error(error);
            return { message: "i don't know what to do with this error" };
        }
    });
    let operations = [];
    web_server.post("/operations", {
        schema: {
            body: z.object({
                rhs: z.coerce.number(),
                lhs: z.coerce.number(),
                kind: z.string(),
            }),
        },
    }, async (req, res) => {
        let rhs = req.body.rhs;
        let lhs = req.body.lhs;
        let kind = req.body.kind;
        let result;
        switch (kind) {
            case "ADD":
                result = lhs + rhs;
                break;
            case "SUB":
                result = lhs - rhs;
                break;
            case "MUL":
                result = lhs * rhs;
                break;
            case "DIV":
                if (rhs === 0) {
                    res.code(400);
                    return { message: "Erreur : division par zéro" };
                }
                return lhs / rhs;
            case "MOD":
                if (rhs === 0) {
                    res.code(400);
                    return { message: "Erreur : division par zéro" };
                }
                result = lhs % rhs;
                break;
            default:
                res.code(400);
                return "Opération non valide";
        }
        operations.push({ lhs, result, rhs });
        res.code(201);
        return {
            id: operations.length - 1,
            message: `created`,
            result: result,
        };
    });
    web_server.get("/operations", async () => {
        return operations;
    });
    web_server.get("/operations/:id", { schema: { params: z.object({ id: z.coerce.number() }) } }, async (req, res) => {
        let id = req.params.id;
        if (id < operations.length) {
            return operations[id];
        }
        res.code(404);
        return { message: `not found`, id };
    });
    let names = ["Jérôme Cahuzac", "Sergueï Choïgou"];
    web_server.post("/names", async (req, res) => {
        let name = req.body.name;
        names.push(name);
        res.code(201);
        return { message: `created`, id: names.length - 1 };
    });
    web_server.get("/names", async () => {
        return names;
    });
    web_server.get("/names/:id", async (req, res) => {
        let id = req.params.id;
        if (id < names.length) {
            return names[id];
        }
        res.code(404);
        return { message: `not found`, id };
    });
    web_server.listen({ port: 1234, host: "0.0.0.0" }, (err, address) => {
        if (err) {
            console.error(err);
        }
        else {
            console.log(`listening on ${address}`);
        }
    });
}
