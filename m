From: hch@lst.de (Christoph Hellwig)
Date: Sat, 28 Oct 2017 08:13:42 +0200
Subject: [PATCH 04/17] block: add a blk_steal_bios helper
In-Reply-To: <ac15137b-b1a4-3988-17cc-fd6c25749542@mellanox.com>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-5-hch@lst.de>
 <ac15137b-b1a4-3988-17cc-fd6c25749542@mellanox.com>
Message-ID: <20171028061342.GA13723@lst.de>

On Tue, Oct 24, 2017@11:44:26AM +0300, Max Gurtovoy wrote:
>> + * Steal bios from a request.  The request must not have been partially
>> + * completed before.
>> + */
>
> Maybe we can add to the comment that "list" is the destination for the 
> stolen bio.

Sure.

>> +void blk_steal_bios(struct bio_list *list, struct request *rq)
>> +{
>> +	if (rq->bio) {
>> +		if (list->tail)
>> +			list->tail->bi_next = rq->bio;
>> +		else
>> +			list->head = rq->bio;
>> +		list->tail = rq->biotail;
>
> if list->tail != NULL don't we lose the "list->tail->bi_next = rq->bio;" 
> assignment after assigning "list->tail = rq->biotail;" ?

the biolists are a little weird, they are a single linked list of bi_next
plus a tail pointer.

So if the list is emptry (->tail == NULL) we assign the biolist
to ->head and point ->tail to end of the list in the request.

But if the list is not empty we let ->bi_next of the last entry
(as found in ->tail) point to the list we splice on, and still update
->tail to end of the list we spliced on.  So I think this looks all ok.

>> +	}
>> +
>> +	rq->bio = NULL;
>
> we can add this NULL assignment inside the big "if", but I'm not sure 
> regarding the next 2 assignments.
> Anyway not a big deal.

We can move both the ->bio and ->biotail assignments, and I've done it.
