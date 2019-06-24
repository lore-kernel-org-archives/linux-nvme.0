From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 25 Jun 2019 03:46:32 +0900
Subject: [PATCH nvme-cli 01/13] Remove superfluous casts
In-Reply-To: <4fbac30a-51f0-95a7-7146-28805103f6a8@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
 <20190619173701.8263-2-bvanassche@acm.org>
 <87tvcfnw05.fsf@solarflare.com>
 <4fbac30a-51f0-95a7-7146-28805103f6a8@acm.org>
Message-ID: <20190624184632.GA6526@minwooim-desktop>

On 19-06-24 06:55:21, Bart Van Assche wrote:
> On 6/24/19 3:00 AM, Mikhail Skorzhinskii wrote:
> > I'm not completely sure that anyone interesting in fixing this, but this
> > change breaks compilation on anything with glibc v2.24 or lower. This is
> > due to long lasting bug #16458[1] which was fixed 2 years ago and landed
> > in glibc v2.25.
> > 
> > I noticed it due to compiling it in rhel7\centos7 which is using glibc
> > v2.17.
> 
> How about restoring RHEL 7 compatibility with the (untested) patch below?

Bart,

It works for me.

> 
> Thanks,
> 
> Bart.
> 
> diff --git a/nvme.h b/nvme.h
> index a149005a0425..ecac52d4d172 100644
> --- a/nvme.h
> +++ b/nvme.h
> @@ -119,19 +119,31 @@ struct nvme_bar_cap {
>  #define __force
>  #endif
> 
> -#define cpu_to_le16(x) \
> -	((__force __le16)htole16(x))
> -#define cpu_to_le32(x) \
> -	((__force __le32)htole32(x))
> -#define cpu_to_le64(x) \
> -	((__force __le64)htole64(x))
> -
> -#define le16_to_cpu(x) \
> -	le16toh((__force __u16)(x))
> -#define le32_to_cpu(x) \
> -	le32toh((__force __u32)(x))
> -#define le64_to_cpu(x) \
> -	le64toh((__force __u64)(x))
> +static inline __le16 cpu_to_le16(uint16_t x)
> +{
> +	return ((__force __le16)htole16(x));
> +}
> +static inline __le32 cpu_to_le32(uint32_t x)
> +{
> +	return ((__force __le32)htole32(x));
> +}
> +static inline __le64 cpu_to_le64(uint64_t x)
> +{
> +	return ((__force __le64)htole64(x));
> +}
> +
> +static inline uint16_t le16_to_cpu(__le16 x)
> +{
> +	return le16toh((__force __u16)x);
> +}
> +static inline uint32_t le32_to_cpu(__le32 x)
> +{
> +	return le32toh((__force __u32)x);
> +}
> +static inline uint64_t le64_to_cpu(__le64 x)
> +{
> +	return le64toh((__force __u64)x);
> +}
> 
>  #define MAX_LIST_ITEMS 256
>  struct list_item {
> -- 
> 2.21.0
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
