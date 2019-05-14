From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Tue, 14 May 2019 23:04:33 +0900
Subject: [PATCH v3 4/7] nvme: add basic facility to get telemetry log page
In-Reply-To: <SN6PR04MB4527A2B52661330D519FD618860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-5-git-send-email-akinobu.mita@gmail.com>
 <SN6PR04MB4527A2B52661330D519FD618860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <CAC5umyjjjuj04mkBd3O23Stjs9s56r+F_XTSimrJbnasy5PBcQ@mail.gmail.com>

2019?5?14?(?) 0:34 Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>:
>
> On 05/12/2019 08:55 AM, Akinobu Mita wrote:
> > This adds the required definisions to get telemetry log page.
> s/definisions/definitions/

OK.

> > diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> > index c40720c..8c0b29d 100644
> > --- a/include/linux/nvme.h
> > +++ b/include/linux/nvme.h
> > @@ -294,6 +294,8 @@ enum {
> >       NVME_CTRL_OACS_DIRECTIVES               = 1 << 5,
> >       NVME_CTRL_OACS_DBBUF_SUPP               = 1 << 8,
> >       NVME_CTRL_LPA_CMD_EFFECTS_LOG           = 1 << 1,
> > +     NVME_CTRL_LPA_EXTENDED_DATA             = 1 << 2,
> > +     NVME_CTRL_LPA_TELEMETRY_LOG             = 1 << 3,
> >   };
> >
> >   struct nvme_lbaf {
> > @@ -396,6 +398,20 @@ enum {
> >       NVME_NIDT_UUID          = 0x03,
> >   };
> >
> > +struct nvme_telemetry_log_page_hdr {
> > +     __u8    lpi; /* Log page identifier */
> > +     __u8    rsvd[4];
> > +     __u8    iee_oui[3];
> > +     __le16  dalb1; /* Data area 1 last block */
> > +     __le16  dalb2; /* Data area 2 last block */
> > +     __le16  dalb3; /* Data area 3 last block */
> > +     __u8    rsvd1[368];
> > +     __u8    ctrlavail; /* Controller initiated data avail?*/
> > +     __u8    ctrldgn; /* Controller initiated telemetry Data Gen # */
> > +     __u8    rsnident[128];
> > +     __u8    telemetry_dataarea[0];
> > +};
> > +
>
> nit:- Thanks for adding the comments, can you please align all the above
> comments like :-

OK.  I'll send a patch for nvme-cli at first.

> +struct nvme_telemetry_log_page_hdr {
> +       __u8    lpi;            /* Log page identifier */
> +       __u8    rsvd[4];
> +       __u8    iee_oui[3];
> +       __le16  dalb1;          /* Data area 1 last block */
> +       __le16  dalb2;          /* Data area 2 last block */
> +       __le16  dalb3;          /* Data area 3 last block */
> +       __u8    rsvd1[368];
> +       __u8    ctrlavail;      /* Controller initiated data avail?*/
> +       __u8    ctrldgn;        /* Controller initiated telemetry Data
> Gen # */
> +       __u8    rsnident[128];
> +       __u8    telemetry_dataarea[0];
> +};
> +
