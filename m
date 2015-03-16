From: keith.busch@intel.com (Keith Busch)
Date: Mon, 16 Mar 2015 17:22:24 +0000 (UTC)
Subject: [PATCH] NVMe: Fix error handling of class_create("nvme")
In-Reply-To: <1425681821-620-1-git-send-email-khoroshilov@ispras.ru>
References: <1425681821-620-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <alpine.LNX.2.00.1503161721490.32385@localhost.lm.intel.com>

On Fri, 6 Mar 2015, Alexey Khoroshilov wrote:
> class_create() returns ERR_PTR on failure,
> so IS_ERR() should be used instead of check for NULL.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov at ispras.ru>

Thanks for the fix.

Acked-by: Keith Busch <keith.busch at intel.com>
