From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 22 May 2018 15:28:19 -0600
Subject: [PATCH v4 06/14] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
In-Reply-To: <59b7762e-6d38-7746-20f3-22fd762ecfe7@infradead.org>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-7-logang@deltatee.com>
 <59b7762e-6d38-7746-20f3-22fd762ecfe7@infradead.org>
Message-ID: <9e20024d-8b32-61ff-4b9a-c9392082987f@deltatee.com>

Thanks for the review Randy! I'll make the changes for the next time we
post the series.

On 22/05/18 03:24 PM, Randy Dunlap wrote:
>> +The first task an orchestrator driver must do is compile a list of
>> +all client drivers that will be involved in a given transaction. For
>> +example, the NVMe Target driver creates a list including all NVMe drives
>                                                                      ^^^^^^
>                                                                    or drivers ?
> Could be either, I guess, but the previous sentence says "compile a list of drivers."

I did mean "drives". But perhaps "devices" would be more clear. A list
of all NVMe drivers doesn't make much sense as I'm pretty sure there is
only one NVMe driver.

Logan
