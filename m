From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 20 Jun 2017 23:09:25 +0000
Subject: [PATCH 1/9] fs: add fcntl() interface for setting/getting write
 life time hints
In-Reply-To: <1497891902-25737-2-git-send-email-axboe@kernel.dk>
References: <1497891902-25737-1-git-send-email-axboe@kernel.dk>
 <1497891902-25737-2-git-send-email-axboe@kernel.dk>
Message-ID: <1498000164.13905.30.camel@wdc.com>

On Mon, 2017-06-19@11:04 -0600, Jens Axboe wrote:
> +static long fcntl_rw_hint(struct file *file, unsigned int cmd,
> +			  u64 __user *ptr)
> +{
> +	struct inode *inode = file_inode(file);
> +	long ret = 0;
> +	u64 hint;
> +
> +	switch (cmd) {
> +	case F_GET_RW_HINT:
> +		hint = mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT);
> +		if (put_user(hint, ptr))
> +			ret = -EFAULT;
> +		break;
> +	case F_SET_RW_HINT:
> +		if (get_user(hint, ptr)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +		switch (hint) {
> +		case WRITE_LIFE_NONE:
> +		case WRITE_LIFE_SHORT:
> +		case WRITE_LIFE_MEDIUM:
> +		case WRITE_LIFE_LONG:
> +		case WRITE_LIFE_EXTREME:
> +			inode_set_write_hint(inode, hint);
> +			ret = 0;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}

Hello Jens,

Do we need an (inline) helper function for checking the validity of a
numerical WRITE_LIFE value next to the definition of the WRITE_LIFE_*
constants, e.g. WRITE_LIFE_NONE <= hint && hint <= WRITE_LIFE_EXTREME?

> +/*
> + * Steal 3 bits for stream information, this allows 8 valid streams
> + */
> +#define IOCB_WRITE_LIFE_SHIFT	7
> +#define IOCB_WRITE_LIFE_MASK	(BIT(7) | BIT(8) | BIT(9))

A minor comment: how about making this easier to read by defining
IOCB_WRITE_LIFE_MASK as (7 << IOCB_WRITE_LIFE_SHIFT)?

>  /*
> + * Expected life time hint of a write for this inode. This uses the
> + * WRITE_LIFE_* encoding, we just need to define the shift. We need
> + * 3 bits for this. Next S_* value is 131072, bit 17.
> + */
> +#define S_WRITE_LIFE_MASK	0x1c000	/* bits 14..16 */
> +#define S_WRITE_LIFE_SHIFT	14	/* 16384, next bit */

Another minor comment: how about making this easier to read by defining
S_WRITE_LIFE_MASK as (7 << S_WRITE_LIFE_SHIFT)?

> /*
> + * Write life time hint values.
> + */
> +enum rw_hint {
> +	WRITE_LIFE_NONE = RWH_WRITE_LIFE_NONE,
> +	WRITE_LIFE_SHORT = RWH_WRITE_LIFE_SHORT,
> +	WRITE_LIFE_MEDIUM = RWH_WRITE_LIFE_MEDIUM,
> +	WRITE_LIFE_LONG = RWH_WRITE_LIFE_LONG,
> +	WRITE_LIFE_EXTREME = RWH_WRITE_LIFE_EXTREME
> +};
> [ ... ]
> +/*
> + * Valid hint values for F_{GET,SET}_RW_HINT
> + */
> +#define RWH_WRITE_LIFE_NONE	0
> +#define RWH_WRITE_LIFE_SHORT	1
> +#define RWH_WRITE_LIFE_MEDIUM	2
> +#define RWH_WRITE_LIFE_LONG	3
> +#define RWH_WRITE_LIFE_EXTREME	4

Maybe I missed something, but it's not clear to me why we have both an enum and
defines with the same numerical values? BTW, I prefer an enum above #defines.

Thanks,

Bart.
