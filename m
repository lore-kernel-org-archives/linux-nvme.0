From: johannes@sipsolutions.net (Johannes Berg)
Date: Thu, 02 May 2019 14:42:49 +0200
Subject: [PATCH 1/4] devcoredump: use memory_read_from_buffer
In-Reply-To: <1556787561-5113-2-git-send-email-akinobu.mita@gmail.com>
 (sfid-20190502_105940_876596_E74F58C8)
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <1556787561-5113-2-git-send-email-akinobu.mita@gmail.com>
 (sfid-20190502_105940_876596_E74F58C8)
Message-ID: <e5cfeb7ad11b3783239e05ab7414fcec28dce1b5.camel@sipsolutions.net>

On Thu, 2019-05-02@17:59 +0900, Akinobu Mita wrote:
> Use memory_read_from_buffer() to simplify devcd_readv().

Reviewed-by: Johannes Berg <johannes at sipsolutions.net>

> Cc: Johannes Berg <johannes at sipsolutions.net>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> ---
>  drivers/base/devcoredump.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index f1a3353..3c960a6 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -164,16 +164,7 @@ static struct class devcd_class = {
>  static ssize_t devcd_readv(char *buffer, loff_t offset, size_t count,
>  			   void *data, size_t datalen)
>  {
> -	if (offset > datalen)
> -		return -EINVAL;
> -
> -	if (offset + count > datalen)
> -		count = datalen - offset;
> -
> -	if (count)
> -		memcpy(buffer, ((u8 *)data) + offset, count);
> -
> -	return count;
> +	return memory_read_from_buffer(buffer, count, &offset, data, datalen);
>  }
>  
>  static void devcd_freev(void *data)
