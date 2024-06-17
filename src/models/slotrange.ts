import { z } from "zod";

export const ZSlotRange = z.object({
    id: z.number(),
    name: z.string(),
    startDate: z.date(),
    endDate: z.date(),
});

export const ZSlotRangeWithoutId = ZSlotRange.omit({ id: true });

export const ZPartialSlotRange = ZSlotRange.partial();

export type SlotRange = z.infer<typeof ZSlotRange>;
export type SlotRangeWithoutId = z.infer<typeof ZSlotRangeWithoutId>;
export type PartialSlotRange = z.infer<typeof ZPartialSlotRange>;
