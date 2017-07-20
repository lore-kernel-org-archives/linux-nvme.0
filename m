From: mwilck@suse.com (Martin Wilck)
Date: Thu, 20 Jul 2017 18:34:00 +0200
Subject: [PATCH v3 1/3] string.h: add memcpy_and_pad()
In-Reply-To: <20170720163402.17793-1-mwilck@suse.com>
References: <20170720163402.17793-1-mwilck@suse.com>
Message-ID: <20170720163402.17793-2-mwilck@suse.com>

This helper function is useful for the nvme subsystem, and maybe
others.

Signed-off-by: Martin Wilck <mwilck at suse.com>
---
 include/linux/string.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index a467e617eeb08..0bec4151b0eb9 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -200,6 +200,7 @@ static inline const char *kbasename(const char *path)
 void fortify_panic(const char *name) __noreturn __cold;
 void __read_overflow(void) __compiletime_error("detected read beyond size of object passed as 1st parameter");
 void __read_overflow2(void) __compiletime_error("detected read beyond size of object passed as 2nd parameter");
+void __read_overflow3(void) __compiletime_error("detected read beyond size of object passed as 3rd parameter");
 void __write_overflow(void) __compiletime_error("detected write beyond size of object passed as 1st parameter");
 
 #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
@@ -395,4 +396,33 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 
 #endif
 
+/**
+ * memcpy_and_pad - Copy one buffer to another with padding
+ * @dest: Where to copy to
+ * @dest_len: The destination buffer size
+ * @src: Where to copy from
+ * @count: The number of bytes to copy
+ * @pad: Character to use for padding if space is left in destination.
+ */
+__FORTIFY_INLINE void memcpy_and_pad(void *dest, size_t dest_len,
+				     const void *src, size_t count, int pad)
+{
+	size_t dest_size = __builtin_object_size(dest, 0);
+	size_t src_size = __builtin_object_size(src, 0);
+
+	if (__builtin_constant_p(dest_len) && __builtin_constant_p(count)) {
+		if (dest_size < dest_len && dest_size < count)
+			__write_overflow();
+		else if (src_size < dest_len && src_size < count)
+			__read_overflow3();
+	}
+	if (dest_size < dest_len)
+		fortify_panic(__func__);
+	if (dest_len > count) {
+		memcpy(dest, src, count);
+		memset(dest + count, pad,  dest_len - count);
+	} else
+		memcpy(dest, src, dest_len);
+}
+
 #endif /* _LINUX_STRING_H_ */
-- 
2.13.2
