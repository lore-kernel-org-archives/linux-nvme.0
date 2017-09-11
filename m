From: mwilck@suse.de (Martin Wilck)
Date: Mon, 11 Sep 2017 11:44:38 +0200
Subject: [PATCH] string.h: un-fortify memcpy_and_pad
In-Reply-To: <20170906123657.25534-1-mwilck@suse.com>
References: <20170831182101.0e4ad9a2@canb.auug.org.au>
 <20170906123657.25534-1-mwilck@suse.com>
Message-ID: <1505123078.4683.5.camel@suse.de>

On Wed, 2017-09-06@14:36 +0200, Martin Wilck wrote:
> The way I'd implemented the new helper memcpy_and_pad  with
> __FORTIFY_INLINE caused compiler warnings for certain kernel
> configurations.
> 
> This helper is only used in a single place at this time, and thus
> doesn't benefit much from fortification. So simplify the code
> by dropping fortification support for now.
> 
> Fixes: 01f33c336e2d "string.h: add memcpy_and_pad()"
> Signed-off-by: Martin Wilck <mwilck at suse.com>
> Acked-by: Arnd Bergmann <arnd at arndb.de>
> 
> ---
>  include/linux/string.h | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)

Hello Stephen and Christoph,

my broken patch 01f33c336e2d is in Linus' tree and causing compiler
warnings there. Could you please take care that this fix is pulled in
on top of it? Or should I take another action myself?

Thanks,
Martin


> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index e1eeb0a8a9693..54d21783e18dd 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -434,20 +434,9 @@ __FORTIFY_INLINE char *strcpy(char *p, const
> char *q)
>   * @count: The number of bytes to copy
>   * @pad: Character to use for padding if space is left in
> destination.
>   */
> -__FORTIFY_INLINE void memcpy_and_pad(void *dest, size_t dest_len,
> -				     const void *src, size_t count,
> int pad)
> +static inline void memcpy_and_pad(void *dest, size_t dest_len,
> +				  const void *src, size_t count, int
> pad)
>  {
> -	size_t dest_size = __builtin_object_size(dest, 0);
> -	size_t src_size = __builtin_object_size(src, 0);
> -
> -	if (__builtin_constant_p(dest_len) &&
> __builtin_constant_p(count)) {
> -		if (dest_size < dest_len && dest_size < count)
> -			__write_overflow();
> -		else if (src_size < dest_len && src_size < count)
> -			__read_overflow3();
> -	}
> -	if (dest_size < dest_len)
> -		fortify_panic(__func__);
>  	if (dest_len > count) {
>  		memcpy(dest, src, count);
>  		memset(dest + count, pad,  dest_len - count);
