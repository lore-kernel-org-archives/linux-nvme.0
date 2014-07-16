From: mundu2510@gmail.com (mundu agarwal)
Date: Wed, 16 Jul 2014 11:27:38 +0530
Subject: [PATCH 1/1] Replace the dma_alloc_coherent() with
 dma_zalloc_coherent()
In-Reply-To: <20140715182846.GG5855@linux.intel.com>
References: <1405447906-7220-1-git-send-email-mundu2510@gmail.com>
 <20140715182846.GG5855@linux.intel.com>
Message-ID: <CACuVHZ=-oROVOOXJRRoZ6EvXCky9DpXbjvUh0Uf3SmAjzhRGLQ@mail.gmail.com>

Willy,

There is patch merged for dma_zalloc_coherent for cqee to avoid the
memset, where as memset still happing for same in nvme_init_queue. I
guess this is not needed, and rest are to maintain the consistancy. I
feel instead of mix use of the apis, should be use as clean/single
one. There are couple of places during initialization variables are
reseting to 0 after allocating the memory using zalloc which we can
avoid. In case this patch ok then my next task will be doing the
cleanup without any impacting the current functionality.

Regards,
Mundu

On Tue, Jul 15, 2014@11:58 PM, Matthew Wilcox <willy@linux.intel.com> wrote:
> On Tue, Jul 15, 2014@11:41:46PM +0530, Mundu wrote:
>> Signed-off-by: Mundu <mundu2510 at gmail.com>
>
> why?
