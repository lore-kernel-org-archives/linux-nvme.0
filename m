From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Oct 2018 15:18:10 +0200
Subject: [PATCH 10/16] nvmet-fcloop: Suppress a compiler warning
In-Reply-To: <20181008212854.68310-11-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
 <20181008212854.68310-11-bvanassche@acm.org>
Message-ID: <20181010131810.GA22031@lst.de>

On Mon, Oct 08, 2018@02:28:48PM -0700, Bart Van Assche wrote:
> Building with W=1 enables the compiler warning -Wimplicit-fallthrough=3. That
> option does not recognize the fall-through comment in the fcloop driver. Hence
> relax that compiler option. This patch avoids that the compiler reports the
> following warning when building with W=1:
> 
> drivers/nvme/target/fcloop.c:647:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (op == NVMET_FCOP_READDATA)

Can you please just fix up the comments to use normal /* FALLTHRU */
annotation?  I rather hate having special compiler flags in drivers.
