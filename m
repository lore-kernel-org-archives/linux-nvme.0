From: mundu2510@gmail.com (mundu agarwal)
Date: Wed, 16 Jul 2014 22:38:51 +0530
Subject: [PATCH 1/1] Replace the dma_alloc_coherent() with
 dma_zalloc_coherent()
In-Reply-To: <alpine.LRH.2.03.1407160844140.4703@AMR>
References: <1405447906-7220-1-git-send-email-mundu2510@gmail.com>
 <20140715182846.GG5855@linux.intel.com>
 <CACuVHZ=-oROVOOXJRRoZ6EvXCky9DpXbjvUh0Uf3SmAjzhRGLQ@mail.gmail.com>
 <20140716141632.GI5855@linux.intel.com>
 <alpine.LRH.2.03.1407160844140.4703@AMR>
Message-ID: <CACuVHZnWhDZtdqG6O_xQKQv37_n-zvtYYkZk0QbepJ9du64DJA@mail.gmail.com>

Thanks Keith/Willy for pointing out the missing link.

On Wed, Jul 16, 2014@8:22 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, 16 Jul 2014, Matthew Wilcox wrote:
>>
>> On Wed, Jul 16, 2014@11:27:38AM +0530, mundu agarwal wrote:
>>>
>>> Willy,
>>>
>>> There is patch merged for dma_zalloc_coherent for cqee to avoid the
>>> memset, where as memset still happing for same in nvme_init_queue. I
>>> guess this is not needed, and rest are to maintain the consistancy. I
>>> feel instead of mix use of the apis, should be use as clean/single
>>> one. There are couple of places during initialization variables are
>>> reseting to 0 after allocating the memory using zalloc which we can
>>> avoid. In case this patch ok then my next task will be doing the
>>> cleanup without any impacting the current functionality.
>>
>>
>> Better not to guess.  Joe's quite careful to only do the ones that are
>> obviously correct.  I believe your patches to be incorrect, since some of
>> the places don't need to be zeroed (eg SQEs are zeroed before each use).
>>
>> In the specific case of nvme_init_queue() zeroing the memory, I think
>> it's necessary on that path because that path is called on resume from
>> D3 and we need to reinitialise the CQ state to all zeroes.  Keith should
>> be able to confirm that.
>
>
> Yes, we have to clear the cmdid data and completion queues in init for
> the resume and reset cases otherwise we would leak command id's that
> were active at the time we shut down the device, or potentially read a
> stale cq "phase" and misinterpret that as a new completion.
