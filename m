From: axboe@fb.com (Jens Axboe)
Date: Tue, 8 Dec 2015 12:15:03 -0700
Subject: [PATCH] nvme: fix another 32-bit build warning
In-Reply-To: <8914775.foiT9pJv7s@wuerfel>
References: <8914775.foiT9pJv7s@wuerfel>
Message-ID: <56672C37.401@fb.com>

On 12/08/2015 08:22 AM, Arnd Bergmann wrote:
> The nvme_user_cmd function was recently moved around from one file
> to another, which made a warning reappear that I had fixed before
> at some point:
>
> drivers/nvme/host/core.c: In function 'nvme_user_cmd':
> drivers/nvme/host/core.c:424:4: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>
> This applies the same workaround that we have elsewhere in the
> driver with an extra type cast to uintptr_t.

Applied to for-4.5/nvme, thanks Arnd.



-- 
Jens Axboe
