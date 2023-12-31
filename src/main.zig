const std = @import("std");
const fmt = std.fmt;
pub fn main() !void {
    // std.debug.print("Hello World Zig\n", .{});
    const file_Data = "day.txt";

    try elf_amount(file_Data);
    // const file = try std.fs.cwd().openFile(file_Data, .{});
    // defer file.close();
    // var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    // defer arena.deinit();
    // const allocator = arena.allocator();

    // const reade_buffer = try file.readToEndAlloc(allocator, 1024 * 1024);
    // defer allocator.free(reade_buffer);
    // var iterator = std.mem.splitSequence(u8, reade_buffer, "\n");

    // var array_Amount = std.ArrayList(u32).init(allocator);
    // defer array_Amount.deinit();
    // var current_amount: u32 = 0;
    // while (iterator.next()) |amount| {
    // if you using window pc before to convert number you must trim the whitespace 🤯🗣️😶‍🌫️🤕
    // this date 28/12/2023 my advice is please use linux or mac
    // when you are learning zig lang PC is headache to many error you may face it that may cost you given up,
    // std.debug.print("{s}\n", .{amount_trim});
    // const amount_trim = std.mem.trim(u8, amount, "\r");
    // if (amount.len == 0) {
    //     try array_Amount.append(current_amount);
    //     current_amount = 0;
    // } else {
    //     const amount_num: u32 = try std.fmt.parseUnsigned(u32, amount_trim, 10);
    //     current_amount += amount_num;
    // }
    // }
    // example using O(n2) to find the max number in slice <--- 🤕what is slice, is a just arraylist items:😁
    // var max_val: u32 = 0;
    // for (array_Amount.items) |a| {
    //     for (array_Amount.items) |b| {
    //         if (a > b) {
    //             max_val = a;
    //         }
    //     }
    // }
    // const max_item = std.mem.max(u32, array_Amount.items);
    // std.debug.print("using zig std method mem.max: {}\n", .{max_item});
    // std.debug.print("using O(n2): {}\n", .{max_val});
}

fn elf_amount(file_Data: []const u8) !void {
    const file = try std.fs.cwd().openFile(file_Data, .{});
    defer file.close();
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    const allocator = arena.allocator();
    defer arena.deinit();
    const read_buff = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(read_buff);
    var it = std.mem.splitSequence(u8, read_buff, "\n");

    var array_amount = std.ArrayList(u32).init(allocator);
    defer array_amount.deinit();
    var current_amount: u32 = 0;
    while (it.next()) |amount| {
        if (amount.len == 0) {
            try array_amount.append(current_amount);
            current_amount = 0;
        } else {
            const result = try std.fmt.parseInt(u32, amount, 10);
            current_amount += result;
        }
    }
    const max = std.mem.max(u32, array_amount.items);
    std.debug.print("{}\n", .{max});
    // std.io.getStdOut().readAll(max);
}
