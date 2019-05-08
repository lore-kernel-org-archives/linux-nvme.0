From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 9 May 2019 00:54:42 +0900
Subject: [PATCH v2 4/7] nvme.h: add telemetry log page definisions
In-Reply-To: <67f0d1ab-2edb-24ea-a4b5-62c90c1ef0fb@intel.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-5-git-send-email-akinobu.mita@gmail.com>
 <67f0d1ab-2edb-24ea-a4b5-62c90c1ef0fb@intel.com>
Message-ID: <CAC5umyi032svV31SmvcR3+MgQarvhg2x9mNrYH1_2svDBzE51g@mail.gmail.com>

2019?5?8?(?) 2:53 Heitke, Kenneth <kenneth.heitke at intel.com>:
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
>
> Is this Host Initiated or Controller Initiated? The comment says host
> initiated but everything else seems to indicated controller initiated.

Both telemetry host initiated and controller initiated log headers have
the same structure.  If this comment is confusing, it is also considered
to be removed.

> Is controller initiated even the correct choice because the controller
> would have sent an AER to indicate that the host should pull the
> telemetry data.

It seems useful to retrieve telemetry log continually with the aid of
user space tool reacting an Asynchronous Event.

Similarly, it could be useful to retrieve telemetry log as soon as the
device is successfully recovered from the crash.  (Although I still do
not find the device that has Telemetry Controller-Initiated Data Available
field is set to 1h.)
