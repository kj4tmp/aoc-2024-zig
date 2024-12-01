const std = @import("std");

const real_data = @embedFile("data/day01.txt");

pub fn solution_part_1(data: []const u8) !u32 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    const allocator = gpa.allocator();
    var left_numbers = std.ArrayList(u32).init(allocator);
    var right_numbers = std.ArrayList(u32).init(allocator);

    var token_iter = std.mem.tokenizeAny(u8, data, &.{ '\n', ' ', 0x00 });

    var alternate_list_side: bool = true; // starts on left side of list
    while (token_iter.next()) |token| {
        // std.debug.print("token: {s}\n", .{token});
        if (alternate_list_side) {
            try left_numbers.append(try std.fmt.parseInt(u32, token, 10));
        } else {
            try right_numbers.append(try std.fmt.parseInt(u32, token, 10));
        }
        alternate_list_side = !alternate_list_side;
    }

    std.mem.sort(u32, left_numbers.items, void{}, std.sort.asc(u32));
    std.mem.sort(u32, right_numbers.items, void{}, std.sort.asc(u32));

    var sum: u32 = 0;
    for (left_numbers.items, right_numbers.items) |left, right| {
        sum += @max(left, right) - @min(left, right);
    }

    return sum;
}

pub fn solution_part_2(data: []const u8) !u32 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    const allocator = gpa.allocator();
    var left_numbers = std.ArrayList(u32).init(allocator);
    var right_numbers = std.ArrayList(u32).init(allocator);

    var token_iter = std.mem.tokenizeAny(u8, data, &.{ '\n', ' ', 0x00 });

    var alternate_list_side: bool = true; // starts on left side of list
    while (token_iter.next()) |token| {
        // std.debug.print("token: {s}\n", .{token});
        if (alternate_list_side) {
            try left_numbers.append(try std.fmt.parseInt(u32, token, 10));
        } else {
            try right_numbers.append(try std.fmt.parseInt(u32, token, 10));
        }
        alternate_list_side = !alternate_list_side;
    }

    std.mem.sort(u32, left_numbers.items, void{}, std.sort.asc(u32));
    std.mem.sort(u32, right_numbers.items, void{}, std.sort.asc(u32));

    var sum: u32 = 0;
    for (left_numbers.items) |left| {
        sum += left * @as(u32, @intCast(std.mem.count(u32, right_numbers.items, &.{left})));
    }
    return sum;
}

test {
    const data =
        \\3   4
        \\4   3
        \\2   5
        \\1   3
        \\3   9
        \\3   3
    ;
    try std.testing.expectEqual(@as(u32, 11), try solution_part_1(data));
    try std.testing.expectEqual(@as(u32, 31), try solution_part_2(data));
}

pub fn main() !void {
    std.debug.print("solution part 1: {any}\n", .{solution_part_1(real_data)});
    std.debug.print("solution part 2: {any}\n", .{solution_part_2(real_data)});
}

// Generated from template/template.zig.
// Run `zig build generate` to update.
// Only unmodified days will be updated.
