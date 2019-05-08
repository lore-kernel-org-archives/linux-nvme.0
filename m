From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 9 May 2019 00:42:20 +0900
Subject: [PATCH v2 4/7] nvme.h: add telemetry log page definisions
In-Reply-To: <81c0d1bd-c117-3fcb-959b-4507504021dd@intel.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-5-git-send-email-akinobu.mita@gmail.com>
 <81c0d1bd-c117-3fcb-959b-4507504021dd@intel.com>
Message-ID: <CAC5umyjDn579iu4V1pXhKJ_PUQdNgY3LBZWgWgqQw_ZoNd88FQ@mail.gmail.com>

2019?5?8?(?) 2:28 Heitke, Kenneth <kenneth.heitke at intel.com>:
>
>
>
> On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> > Copy telemetry log page definisions from nvme-cli.
> >
> > Cc: Johannes Berg <johannes at sipsolutions.net>
> > Cc: Keith Busch <keith.busch at intel.com>
> > Cc: Jens Axboe <axboe at fb.com>
> > Cc: Christoph Hellwig <hch at lst.de>
> > Cc: Sagi Grimberg <sagi at grimberg.me>
> > Cc: Minwoo Im <minwoo.im.dev at gmail.com>
> > Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> > ---
> > * v2
> > - New patch in this version.
> >
> >   include/linux/nvme.h | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> > index c40720c..5217fe4 100644
> > --- a/include/linux/nvme.h
> > +++ b/include/linux/nvme.h
> > @@ -396,6 +396,28 @@ enum {
> >       NVME_NIDT_UUID          = 0x03,
> >   };
> >
> > +/* Derived from 1.3a Figure 101: Get Log Page ? Telemetry Host
> > + * -Initiated Log (Log Identifier 07h)
> > + */
> > +struct nvme_telemetry_log_page_hdr {
> > +     __u8    lpi; /* Log page identifier */
> > +     __u8    rsvd[4];
> > +     __u8    iee_oui[3];
> > +     __le16  dalb1; /* Data area 1 last block */
> > +     __le16  dalb2; /* Data area 2 last block */
> > +     __le16  dalb3; /* Data area 3 last block */
> > +     __u8    rsvd1[368]; /* TODO verify */
>
> Remove the TODO

OK.

> > +     __u8    ctrlavail; /* Controller initiated data avail?*/
> > +     __u8    ctrldgn; /* Controller initiated telemetry Data Gen # */
> > +     __u8    rsnident[128];
> > +     /* We'll have to double fetch so we can get the header,
> > +      * parse dalb1->3 determine how much size we need for the
> > +      * log then alloc below. Or just do a secondary non-struct
> > +      * allocation.
> > +      */
>
> This comment isn't necessary. You usually can't read the entire
> telemetry log at once and the header is a fixed size. You would likely
> just read the header followed by reads of the different data areas.

This comment is derived from nvme-cli.  So firstly, I'll send a patch
for nvme-cli.  If the changes are accepted, I'll update this comment, too.

> > +     __u8    telemetry_dataarea[0];
> > +};
> > +
> >   struct nvme_smart_log {
> >       __u8                    critical_warning;
> >       __u8                    temperature[2];
> > @@ -832,6 +854,7 @@ enum {
> >       NVME_LOG_FW_SLOT        = 0x03,
> >       NVME_LOG_CHANGED_NS     = 0x04,
> >       NVME_LOG_CMD_EFFECTS    = 0x05,
> > +     NVME_LOG_TELEMETRY_CTRL = 0x08,
> >       NVME_LOG_ANA            = 0x0c,
> >       NVME_LOG_DISC           = 0x70,
> >       NVME_LOG_RESERVATION    = 0x80,
> >
