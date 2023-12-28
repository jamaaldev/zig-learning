const std = @import("std");
const fmt = std.fmt;
pub fn main() !void {
    // std.debug.print("Hello World Zig\n", .{});
    const file_Data = "day.txt";
    // try elf_amount(file_Data);
    const file = try std.fs.cwd().openFile(file_Data, .{});
    defer file.close();
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const reade_buffer = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(reade_buffer);
    var iterator = std.mem.splitSequence(u8, reade_buffer, "\n");

    var array_Amount = std.ArrayList(u32).init(allocator);
    defer array_Amount.deinit();
    var current_amount: u32 = 0;
    while (iterator.next()) |amount| {
        // if you using window pc before to convert number you must trim the whitespace 🤯🗣️😶‍🌫️🤕
        // this date 28/12/2023 my advice is please use linux or mac
        // when you are learning zig lang PC is headache to many error you may face it that may cost you given up,
        // std.debug.print("{s}\n", .{amount_trim});
        const amount_trim = std.mem.trim(u8, amount, "\r");
        if (amount.len == 0) {
            try array_Amount.append(current_amount);
            current_amount = 0;
        } else {
            const amount_num: u32 = try std.fmt.parseUnsigned(u32, amount_trim, 10);
            current_amount += amount_num;
        }
    }
    std.debug.print("{}\n", .{array_Amount});
    // std.io.getStdOut().writeAll(array_Amount);
}

fn elf_amount(file_Data: []const u8) !void {
    const file = try std.fs.cwd().openFile(file_Data, .{});
    defer file.close();

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const read_file = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(read_file);
    // const array_Amount = std.ArrayList([]u32);
    // _ = array_Amount;
    // const current_amount = 0;
    // _ = current_amount;
    // try std.io.getStdOut().writeAll(read_file); //this only output the file
    // var iterator = std.mem.splitSequence(u8, read_file, "\n");
    // const it = std.mem.trim(u8, iterator.next(), "");
    // const amount_num: i32 = fmt.parseInt(u32, it.len, 10);

}
