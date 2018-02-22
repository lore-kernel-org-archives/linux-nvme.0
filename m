From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 22 Feb 2018 22:26:58 +0900
Subject: nvme-pci: about page_size of DMA pool
In-Reply-To: <20180220160603.GB7076@localhost.localdomain>
References: <2dfcc20c-a0c4-d01a-cde8-01662202cff8@gmail.com>
 <20180220160603.GB7076@localhost.localdomain>
Message-ID: <e2823a5e-38df-2002-8374-0408adfb1abd@gmail.com>

On 02/21/2018 01:06 AM, Keith Busch wrote:
>> Q1. Should dev->prp_page_pool be created with dev->ctrl.page_size
>> instead of PAGE_SIZE?
> 
> Yeah, the current method looks like it may potentially be over-allocating
> some memory for very large IO transfers. The size of the "large" pool
> ought to be the same as ctrl.page_size.
>   
>>
>> Q2. Is there any special reason why page_shift in nvme_enable_ctrl()
>> is hard-coded to 12, not PAGE_SHIFT?
> 
> Some CPU architectures have different alignment when comparing DMA mapped
> addresses with the virual address, so we have to go to the lowest common
> denominator. Previous discussion here:
> 
>    http://lists.infradead.org/pipermail/linux-nvme/2015-October/002893.html
> 

Thanks for your kind response, Keith. :)
