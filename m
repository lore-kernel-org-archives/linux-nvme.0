From: keith.busch@intel.com (Keith Busch)
Date: Fri, 14 Nov 2014 23:04:10 +0000 (UTC)
Subject: [PATCH] NVMe: Add rw_page support
In-Reply-To: <546688BB.3030802@kernel.dk>
References: <1415923538-18760-1-git-send-email-keith.busch@intel.com>
 <CANvN+ekQTdNgPe33iaM_9=2Hjrfds2B2R3d3XK06K9n=SY+ZKA@mail.gmail.com>
 <alpine.LNX.2.00.1411142238330.4225@localhost.lm.intel.com>
 <546688BB.3030802@kernel.dk>
Message-ID: <alpine.LNX.2.00.1411142259190.4225@localhost.lm.intel.com>

On Fri, 14 Nov 2014, Jens Axboe wrote:
> On 11/14/2014 03:50 PM, Keith Busch wrote:
>> But nvme_cmd_info does not contain the opcode. I do have the struct
>> request here, and I can certainly pull the data direction from its
>> cmd_flags, so thanks for the suggestion!
>>
>> Now I wonder if there's something else unused in a request that I
>> can repurpose to save the dma_addr_t in so I don't add it in the
>> nvme_cmd_info...
>
> For the rw_page path, you don't use ->special to store the iod. So you
> could use that... That might break for 32-bit platforms and 64-bit DMA,
> though. If you really want to get nasty, ->__cmd is 16 bytes of unused
> goodness as well, though I do want to make that one dynamically
> allocated for the queues that need it.

Ah, but I already got req->special pointing to the page. Maybe we can
union another field with a new "special_2" field.
