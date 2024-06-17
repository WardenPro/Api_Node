import { z } from "zod";
export const ZSlotRange = z.object({
    id: z.number(),
    name: z.string(),
    startDate: z.date(),
    endDate: z.date(),
});
export const ZSlotRangeWithoutId = ZSlotRange.omit({ id: true });
export const ZPartialSlotRange = ZSlotRange.partial();
