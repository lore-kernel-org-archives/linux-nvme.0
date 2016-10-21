From: pandit.parav@gmail.com (Parav Pandit)
Date: Fri, 21 Oct 2016 21:20:47 +0530
Subject: [PATCH RFC v2 2/3] rdma_cm: add rdma_consumer_reject() helper
 function
In-Reply-To: <005f01d22ba4$aeadeab0$0c09c010$@opengridcomputing.com>
References: <cover.1477003235.git.swise@opengridcomputing.com>
 <cb135696be86c21c144ef35a4d6f7f71394a3627.1477003235.git.swise@opengridcomputing.com>
 <20161021121428.GB17028@lst.de>
 <005f01d22ba4$aeadeab0$0c09c010$@opengridcomputing.com>
Message-ID: <CAG53R5Xyp+n7KYj6zZF6PFuXke3XtqaMgaGTRmgd_uGXTFNDtw@mail.gmail.com>

On Fri, Oct 21, 2016@7:39 PM, Steve Wise <swise@opengridcomputing.com> wrote:
>>
>> On Thu, Oct 20, 2016@03:40:26PM -0700, Steve Wise wrote:
>> > Return true if the peer consumer application rejected the
>> > connection attempt.
>> >
>> > Signed-off-by: Steve Wise <swise at opengridcomputing.com>
>> > ---
>> >  drivers/infiniband/core/cma.c | 13 +++++++++++++
>> >  include/rdma/ib_cm.h          |  9 +++++++++
>> >  include/rdma/iw_cm.h          |  9 +++++++++
>> >  include/rdma/rdma_cm.h        |  6 ++++++
>> >  4 files changed, 37 insertions(+)
>> >
>> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
>> > index 7cc7346..4ec16a3 100644
>> > --- a/drivers/infiniband/core/cma.c
>> > +++ b/drivers/infiniband/core/cma.c
>> > @@ -114,6 +114,19 @@ const char *__attribute_const__
>> rdma_reject_msg(struct rdma_cm_id *id,
>> >  }
>> >  EXPORT_SYMBOL(rdma_reject_msg);
>> >
>> > +bool rdma_consumer_reject(struct rdma_cm_id *id, int reason)
>> > +{
>> > +   if (rdma_ib_or_roce(id->device, id->port_num))
>> > +           return ib_consumer_reject(reason);
>> > +
>> > +   if (rdma_protocol_iwarp(id->device, id->port_num))
>> > +           return iw_consumer_reject(reason);
>> > +
>> > +   /* FIXME should we WARN_ONCE() here? */
>> > +   return false;
>>
>> Yes.  Also I'd just inline the ib_consumer_reject and iw_consumer_reject
>> helpers here.
>>
>> Aso wouldn't it be better named rdma_consumer_is_reject or similar
>> given that we don't reject anything here, but check if the request
>> has been rejected?
>
> How about rdma_rejected_by_consumer()?
>
How about rdma_reject_by_ulp()?
We have ulp directory holding iser, srp etc.
