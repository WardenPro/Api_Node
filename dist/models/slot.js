import { z } from "zod";
export const ZSlot = z.object({
    rangeid: z.number(),
    id: z.number(),
    user: z.string(),
    title: z.string(),
    description: z.string(),
    startDate: z.date(),
    endDate: z.date(),
});
export const ZSlotWithoutId = ZSlot.omit({ id: true });
export const ZPartialSlot = ZSlot.partial();
