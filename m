From: omri@excelero.com (Omri Mann)
Date: Wed, 30 Aug 2017 13:34:26 +0300
Subject: [PATCH] Add support for reservations to NVMeoF target
In-Reply-To: <20170830082825.GA8834@infradead.org>
References: <1503497088-12775-1-git-send-email-omri@excelero.com>
 <d787b603-ce2c-c130-d5f9-5178f1e55997@grimberg.me>
 <20170830082825.GA8834@infradead.org>
Message-ID: <CAJgS9SUW90MY-0S58K1wELTYU7U3x71zgpGcLiAshgn1AskZxg@mail.gmail.com>

  I think nvme-cli already supports the reservation related commands
including resv-report
in version 1.1

On Wed, Aug 30, 2017@11:28 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Aug 28, 2017@09:00:20AM +0300, Sagi Grimberg wrote:
>> Hi Omri,
>>
>> First, please follow the format of patch submission as described
>> in: Documentation/process/submitting-patches.rst
>>
>> Second, I would love to see a generic reservations lib so nvmet
>> and LIO can share the same abstraction (with proper callouts
>> in place). But I don't think its a gating issue.
>> Adding Mike to the thread.
>>
>> Third, persistent reservations should survive power loss, which
>> means they need to be logged in a file at least.
>
> Strictly speaking they only need to be persistent depending on the CPTPL
> field in the Reservation Register command, but implementing that is
> mandatory, so yes we'll need it.  And I really want it to actually
> do atomic updates, unlike the LIO code which could corrupt its database
> fairly easily.
>
> Bart (added to Cc) did some nice work on a switch and even a DLM
> implementation for SCST, which I'd really like to get into mainline:
>
>         https://github.com/bvanassche/scst/blob/master/scst/src/scst_pres.c
>         https://github.com/bvanassche/scst/blob/master/scst/src/scst_dlm.c
>
> and I'd love to get some of that code (or at least the ideas) into
> mainline - both for NVMe and possibly also for the existing SCSI
> target.
>
>
>> As for the implementation itself, any reason to choose a rw_lock
>> instead of a rcu protection scheme? Up until now we got the
>> IO path to be lock free and I'm not very enthusiast starting now.
>
> Agreed.
>
>> > index 3b4d47a..4eb4182 100644
>> > --- a/drivers/nvme/target/io-cmd.c
>> > +++ b/drivers/nvme/target/io-cmd.c
>> > @@ -16,6 +16,8 @@
>> >   #include <linux/module.h>
>> >   #include "nvmet.h"
>> > +#define IEKEY      0x8     /* Ignore Existing Key */
>
> Needs to got to include/linux/nvme.h
>
>> > +static void nvmet_execute_resv_report(struct nvmet_req *req)
>> > +{
>> > +   union {
>> > +           struct {
>> > +                   __le32  gen;
>> > +                   u8      rtype;
>> > +                   __le16  regctls;
>> > +                   u16     rsvd2;
>> > +                   u8      ptpls;
>> > +                   u8      rsvd14[14];
>> > +           } __packed hdr;
>> > +           struct {
>> > +                   __le16  cntlid;
>> > +                   u8      rcsts;
>> > +                   u8      rsvd5[5];
>> > +                   __le64  hostid;
>> > +                   __le64  rkey;
>> > +           } __packed cntrl;
>>
>> These are generic nvme structures, so they should live in
>> nvme protocol header.
>
> Agreed.   Also support for the reservation report command in nvme-cli
> would be really nice for debugging.
