From: mwilck@suse.com (Martin Wilck)
Date: Tue,  5 Sep 2017 20:23:26 +0200
Subject: [PATCH] string.h: un-fortify memcpy_and_pad
In-Reply-To: <CAK8P3a0u5w1C+L6t9h5+4fu0gt79u68B+txhF6adAT3MVfwW3Q@mail.gmail.com>
References: <CAK8P3a0u5w1C+L6t9h5+4fu0gt79u68B+txhF6adAT3MVfwW3Q@mail.gmail.com>
Message-ID: <20170905182326.15681-1-mwilck@suse.com>

The way I'd implemented the new helper memcpy_and_pad  with
__FORTIFY_INLINE caused compiler warnings for certain kernel
configurations.

This helper is only used in a single place at this time, and thus
doesn't benefit much from fortification. So simplify the code
by dropping fortification support for now.

Fixes: 3c5fa8cd18f8 "string.h: add memcpy_and_pad()"
Signed-off-by: Martin Wilck <mwilck at suse.com>
---
 include/linux/string.h | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 0bec4151b0eb9..0495cd3c81689 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -404,20 +404,9 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
  * @count: The number of bytes to copy
  * @pad: Character to use for padding if space is left in destination.
  */
-__FORTIFY_INLINE void memcpy_and_pad(void *dest, size_t dest_len,
-				     const void *src, size_t count, int pad)
+static inline void memcpy_and_pad(void *dest, size_t dest_len,
+				  const void *src, size_t count, int pad)
 {
-	size_t dest_size = __builtin_object_size(dest, 0);
-	size_t src_size = __builtin_object_size(src, 0);
-
-	if (__builtin_constant_p(dest_len) && __builtin_constant_p(count)) {
-		if (dest_size < dest_len && dest_size < count)
-			__write_overflow();
-		else if (src_size < dest_len && src_size < count)
-			__read_overflow3();
-	}
-	if (dest_size < dest_len)
-		fortify_panic(__func__);
 	if (dest_len > count) {
 		memcpy(dest, src, count);
 		memset(dest + count, pad,  dest_len - count);
-- 
2.14.0
