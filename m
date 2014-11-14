From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 14 Nov 2014 15:56:59 -0700
Subject: [PATCH] NVMe: Add rw_page support
In-Reply-To: <alpine.LNX.2.00.1411142238330.4225@localhost.lm.intel.com>
References: <1415923538-18760-1-git-send-email-keith.busch@intel.com>
 <CANvN+ekQTdNgPe33iaM_9=2Hjrfds2B2R3d3XK06K9n=SY+ZKA@mail.gmail.com>
 <alpine.LNX.2.00.1411142238330.4225@localhost.lm.intel.com>
Message-ID: <546688BB.3030802@kernel.dk>

On 11/14/2014 03:50 PM, Keith Busch wrote:
> On Fri, 14 Nov 2014, Andrey Kuzmin wrote:
>> On Nov 14, 2014 3:13 AM, "Keith Busch" <keith.busch@intel.com> wrote:
>> > +static void pgwr_completion(struct nvme_queue *nvmeq, void *ctx,
>> > +                                               struct
>> nvme_completion *cqe)
>> > +{
>> > +       struct request *req = ctx;
>> > +       struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
>> > +       struct page *page = req->special;
>> > +       u16 status = le16_to_cpup(&cqe->status) >> 1;
>> > +
>> > +       dma_unmap_page(nvmeq->q_dmadev, cmd_rq->dma,
>> PAGE_CACHE_SIZE, DMA_TO_DEVICE);
>> > +       page_endio(page, WRITE, status != NVME_SC_SUCCESS);
>> > +       blk_put_request(req);
>> > +}
>> > +
>>
>> As you have access to the nvme_cmd_info - and thus command opcode - in
>> the
>> completion handler, having separate completion handlers for read and
>> write
>> operations looks like unnecessary code duplication. Just my .02 :).
> 
> But nvme_cmd_info does not contain the opcode. I do have the struct
> request here, and I can certainly pull the data direction from its
> cmd_flags, so thanks for the suggestion!
> 
> Now I wonder if there's something else unused in a request that I
> can repurpose to save the dma_addr_t in so I don't add it in the
> nvme_cmd_info...

For the rw_page path, you don't use ->special to store the iod. So you
could use that... That might break for 32-bit platforms and 64-bit DMA,
though. If you really want to get nasty, ->__cmd is 16 bytes of unused
goodness as well, though I do want to make that one dynamically
allocated for the queues that need it.

-- 
Jens Axboe
