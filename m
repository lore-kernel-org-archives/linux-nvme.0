From: axboe@fb.com (Jens Axboe)
Date: Tue, 12 Jan 2016 15:11:30 -0700
Subject: [PATCH] block: split bios to max possible length
In-Reply-To: <1452636519-32697-1-git-send-email-keith.busch@intel.com>
References: <1452636519-32697-1-git-send-email-keith.busch@intel.com>
Message-ID: <56957A12.8040902@fb.com>

On 01/12/2016 03:08 PM, Keith Busch wrote:
> This splits bio in the middle of a vector to form the largest possible
> bio at the h/w's desired alignment, and guarantees the bio being split
> will have some data.
>
> The criteria for splitting is changed from the max sectors to the h/w's
> optimal sector alignment if it is provided. For h/w that advertise their
> block storage's underlying chunk size, it's a big performance win to not
> submit commands that cross them. If sector alignment is not provided,
> this patch uses the max sectors as before.
>
> This addresses the performance issue commit d380561113 attempted to
> fix, but was reverted due to splitting logic error.

Thanks Keith, added for 4.5.

-- 
Jens Axboe
