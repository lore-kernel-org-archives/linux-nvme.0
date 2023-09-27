Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29458E80A9A
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 07:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aZauaCLkNwE4A6H85o71OM9ExzKON1ReeWI5W9FdiRQ=; b=OdQZzPotOvAaMNw0lKn8Y8H1CO
	eOno3TJi7WfW/b1Q50jSatg0Z8KUNm3me/6SWk4NpfNOUkgBPrcArk9XEaP4K64nQwj16xPL256Tp
	AvVsG2UT6CqdLizBrRfMJDZIIwUIeHpU7x4z8Xwn5qnGNpZKmx7tWwXYDzussC/5bVmYPMAmySRLZ
	NbFucbEXNhK5sNvYNcWfAIYzdxyHXTwkKXE6zseeo7aCGPYHM5rljSzZUDe0K41yrc1RaNoVxrYpj
	eczWh019/wtiHD1U7yhL/44AYjMMviaXY1+Pw7b/rd/2Bw91yopoAcUuOLXz9eC0xjxJ7td7phaBl
	7uPUkm6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlOhR-0009kg-0M;
	Wed, 27 Sep 2023 07:11:09 +0000
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlOhK-0009jU-1U
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 07:11:07 +0000
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-495d687b138so3741404e0c.3
        for <linux-nvme@lists.infradead.org>; Wed, 27 Sep 2023 00:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shadow-tech.20230601.gappssmtp.com; s=20230601; t=1695798660; x=1696403460; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZauaCLkNwE4A6H85o71OM9ExzKON1ReeWI5W9FdiRQ=;
        b=FrTaPSrDuVZO3JeicrOozg0svdMGrsOofbfLTcB6mBTaMqS0C8nrpw97kMRZDvJfM/
         pWkzI32iioMU2uIx1/kK13Lyc0fEgL2ZZ12p7lL4g49VxsZWiHYeIcoiRod+pMZ/xEDr
         S1KyGxJyBLBHjCfCVH2QDqMFVogZJV/lPkpi0YHsKMVoOAJdvf7lX4AswEOzcFJqVzL0
         dI1ophJWeH0O+O3X/l6OzUGazwJnLZxQjDGICubikEAyaoNcMbLkZy2HxR2vhnFQCX1B
         CdcoOWINLLq2XmrdiLYw7EAbVfpRqL659GqJkt8s62hAy1heHk1J3d/F6rdZCNtSSocV
         X2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695798660; x=1696403460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZauaCLkNwE4A6H85o71OM9ExzKON1ReeWI5W9FdiRQ=;
        b=wFpVbu54iPgISlH+6vKHRp6EAKV7R0UDGBdrtx4y94EQI95JjhW9n2BQTwxj5vrEd2
         aa8aYRqVlH/hrEd6lSHI6MCDJYxTZz4rAFYsiAwy9YE+bASCgtvnnSlMjR+eA1jfTF21
         wgefEYEodVQYXV/8lzT+JKYwtHVMPFAiorAUEp71lyQlBbSP8TvZ1E2Kyta+gosIvDxr
         yVEYD9giMojjvzEqCTocwef0na3rAuznBkQx7MWBs5iSji627xNKQ/0saNSTOjq51aWN
         Ko4k7bzS6bDYypmyRXRSAWdOO++N9d/RwogbbnXVZBuwsZ4jfCYypMU8Bicq4swhmCMb
         C4oQ==
X-Gm-Message-State: AOJu0YzTh7xnSmPT/UMFuttB7F4FYSwMC19SW8DbtSD+UE9y0RbOzHHs
	J2Vf8HsisIQru9EFixeh6TIohEC/W/t6roTOuqEn7w==
X-Google-Smtp-Source: AGHT+IEgn/w81DJmJy+Co/dJmGGzJh2036Fly1AoDLZ4/vjfDw/RwPTWndrewLHjQ/kR4pOoin0Cedhehq8kD0mF6Ik=
X-Received: by 2002:a1f:c887:0:b0:48d:3b80:fba9 with SMTP id
 y129-20020a1fc887000000b0048d3b80fba9mr741282vkf.11.1695798660479; Wed, 27
 Sep 2023 00:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230920141205.26637-1-redouane.boufenghour@shadow.tech>
 <20230920141205.26637-2-redouane.boufenghour@shadow.tech> <635234b9-6ad9-4d5f-891e-4c76fbea8d63@gmail.com>
In-Reply-To: <635234b9-6ad9-4d5f-891e-4c76fbea8d63@gmail.com>
From: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
Date: Wed, 27 Sep 2023 09:10:49 +0200
Message-ID: <CAEjkvFheymYDK80J4P5kYma3rB0qj-sU7UYmzdKLYtZsRGT0KA@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvmet: View subsystem connections on nvmeof target
To: James Smart <jsmart2021@gmail.com>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, hch@lst.de, 
	sagi@grimberg.me, antoine.damhet@shadow.tech, valentin.brice@shadow.tech
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_001102_725882_657B4B05 
X-CRM114-Status: GOOD (  35.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,
Thank you for your answers. If I transfer my display code to the
debugfs, is it ok if I create a tree
nvmet/subsystem/nameofsubsystem/crtl/NumberOfcontroler/host_traddr and
nvmet/subsystem/nameofsubsystem/crtl/NumberOfcontroler/host_nqn?
Concerning the traddr value, for me this information is directly
retrieved from the queue_tcp and rdma so it will only be ipv6 or ipv4
but in any case I will add a security on the destbuffer.

I'll get back to you with the corrected patch.

Redouane,


Le sam. 23 sept. 2023 =C3=A0 01:08, James Smart <jsmart2021@gmail.com> a =
=C3=A9crit :
>
> On 9/20/2023 7:12 AM, Redouane BOUFENGHOUR wrote:
> > We add a new entry in the tcp and rdma factories to retrieve the peer
> > address of a ctrl.
> >
> > The functions nvmet_rdma_disc_peer_addr and nvmet_tcp_disc_peer_addr re=
turn
> > a snprintf of size NVMF_TRADDR_SIZE with the address connected to the c=
tlrs
> >
> > which is then displayed in a subsys attribute attr_connected_ctrls on R=
O
>
> The "peertraddr" term is odd. On the host side we have "host traddr" for
> the address information for the host side of the connection to the
> controller. I'd prefer to use host traddr over the peer traddr name.
>
> as for the patches:
> - I'm not a fan of dstaddr passed between common/transport layers and
> transports "assuming" they know the length via a compile time define.
> I'd prefer being explicit and having the dstaddr buffer length passed
> around as well.
>
> - Are there cases where the address field is more than a single traddr
> value ?  For example, do you need to know host IP address and port # ?
> You can leave it up to the transport to fill in whatever data
> constitutes an "address" which if the max length of the destbuffer is
> known, makes that easier.
>
> -- james
>
>
>
> >
> > Co-developed-by: Valentin BRICE <valentin.brice@shadow.tech>
> > Signed-off-by: Valentin BRICE <valentin.brice@shadow.tech>
> > Co-developed-by: Antoine DAMHET <antoine.damhet@shadow.tech>
> > Signed-off-by: Antoine DAMHET <antoine.damhet@shadow.tech>
> > Co-developed-by: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech=
>
> > Signed-off-by: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
> > ---
> >   drivers/nvme/target/configfs.c | 30 ++++++++++++++++++++++++++++++
> >   drivers/nvme/target/core.c     |  7 +++++++
> >   drivers/nvme/target/nvmet.h    |  2 ++
> >   drivers/nvme/target/rdma.c     | 10 ++++++++++
> >   drivers/nvme/target/tcp.c      | 13 +++++++++++++
> >   5 files changed, 62 insertions(+)
> >
> > diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/confi=
gfs.c
> > index 907143870da5..6cbbe71244dd 100644
> > --- a/drivers/nvme/target/configfs.c
> > +++ b/drivers/nvme/target/configfs.c
> > @@ -1426,6 +1426,35 @@ static ssize_t nvmet_subsys_attr_qid_max_store(s=
truct config_item *item,
> >   }
> >   CONFIGFS_ATTR(nvmet_subsys_, attr_qid_max);
> >
> > +static ssize_t nvmet_subsys_attr_connected_ctrls_show(
> > +     struct config_item *item, char *page)
> > +{
> > +     ssize_t len, ret;
> > +     int peer;
> > +     char dstaddr[NVMF_TRADDR_SIZE];
> > +     struct nvmet_subsys *subsys;
> > +     struct nvmet_ctrl *ctrl;
> > +
> > +     subsys =3D to_subsys(item);
> > +     len =3D 0;
> > +
> > +     list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > +             peer =3D get_peer_traddr(ctrl, ctrl->sqs[0], dstaddr);
> > +             if (peer < 0)
> > +                     snprintf(dstaddr, NVMF_TRADDR_SIZE, "unknown");
> > +             ret =3D snprintf(page + len, PAGE_SIZE - len,
> > +                            "hostnqn: %s; peer_addr: %s\n",
> > +                            ctrl->hostnqn, dstaddr);
> > +             if (ret >=3D PAGE_SIZE - len) {
> > +                     sprintf(page + PAGE_SIZE - 14, "\n[truncated]");
> > +                     return PAGE_SIZE;
> > +             }
> > +             len +=3D ret;
> > +     }
> > +     return len;
> > +}
> > +CONFIGFS_ATTR_RO(nvmet_subsys_, attr_connected_ctrls);
> > +
> >   static struct configfs_attribute *nvmet_subsys_attrs[] =3D {
> >       &nvmet_subsys_attr_attr_allow_any_host,
> >       &nvmet_subsys_attr_attr_version,
> > @@ -1436,6 +1465,7 @@ static struct configfs_attribute *nvmet_subsys_at=
trs[] =3D {
> >       &nvmet_subsys_attr_attr_qid_max,
> >       &nvmet_subsys_attr_attr_ieee_oui,
> >       &nvmet_subsys_attr_attr_firmware,
> > +     &nvmet_subsys_attr_attr_connected_ctrls,
> >   #ifdef CONFIG_BLK_DEV_INTEGRITY
> >       &nvmet_subsys_attr_attr_pi_enable,
> >   #endif
> > diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> > index 3935165048e7..ba5997a14675 100644
> > --- a/drivers/nvme/target/core.c
> > +++ b/drivers/nvme/target/core.c
> > @@ -1629,6 +1629,13 @@ static void nvmet_subsys_free(struct kref *ref)
> >       kfree(subsys);
> >   }
> >
> > +int get_peer_traddr(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, char=
 *dstaddr)
> > +{
> > +     if (ctrl->ops->disc_peertraddr =3D=3D NULL)
> > +             return -EOPNOTSUPP;
> > +     return ctrl->ops->disc_peertraddr(sq, ctrl->port, dstaddr);
> > +}
> > +
> >   void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys)
> >   {
> >       struct nvmet_ctrl *ctrl;
> > diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> > index 8cfd60f3b564..60ea2391a957 100644
> > --- a/drivers/nvme/target/nvmet.h
> > +++ b/drivers/nvme/target/nvmet.h
> > @@ -341,6 +341,8 @@ struct nvmet_fabrics_ops {
> >       void (*discovery_chg)(struct nvmet_port *port);
> >       u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
> >       u16 (*get_max_queue_size)(const struct nvmet_ctrl *ctrl);
> > +     int (*disc_peertraddr)(struct nvmet_sq *nvme_sq,
> > +                            struct nvmet_port *port, char *dstaddr);
> >   };
> >
> >   #define NVMET_MAX_INLINE_BIOVEC     8
> > diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> > index 4597bca43a6d..395554a77fc1 100644
> > --- a/drivers/nvme/target/rdma.c
> > +++ b/drivers/nvme/target/rdma.c
> > @@ -1992,6 +1992,15 @@ static void nvmet_rdma_disc_port_addr(struct nvm=
et_req *req,
> >               memcpy(traddr, nport->disc_addr.traddr, NVMF_TRADDR_SIZE)=
;
> >       }
> >   }
> > +int nvmet_rdma_disc_peer_addr(struct nvmet_sq *nvme_sq,
> > +                           struct nvmet_port *nport, char *dstaddr)
> > +{
> > +     struct nvmet_rdma_queue *queue =3D
> > +             container_of(nvme_sq, struct nvmet_rdma_queue, nvme_sq);
> > +
> > +     snprintf(dstaddr, NVMF_TRADDR_SIZE, "%pISc",
> > +              (struct sockaddr *)&queue->cm_id->route.addr.dst_addr);
> > +}
> >
> >   static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
> >   {
> > @@ -2015,6 +2024,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_=
ops =3D {
> >       .queue_response         =3D nvmet_rdma_queue_response,
> >       .delete_ctrl            =3D nvmet_rdma_delete_ctrl,
> >       .disc_traddr            =3D nvmet_rdma_disc_port_addr,
> > +     .disc_peertraddr        =3D nvmet_rdma_disc_peer_addr,
> >       .get_mdts               =3D nvmet_rdma_get_mdts,
> >       .get_max_queue_size     =3D nvmet_rdma_get_max_queue_size,
> >   };
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index 868aa4de2e4c..ae454c176fac 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -1871,6 +1871,18 @@ static void nvmet_tcp_disc_port_addr(struct nvme=
t_req *req,
> >       }
> >   }
> >
> > +int nvmet_tcp_disc_peer_addr(struct nvmet_sq *sq,
> > +                          struct nvmet_port *nport, char *dstaddr)
> > +{
> > +     struct nvmet_tcp_queue *queue =3D
> > +             container_of(sq, struct nvmet_tcp_queue, nvme_sq);
> > +
> > +     if (queue->sockaddr_peer.ss_family =3D=3D AF_UNSPEC)
> > +             return -EINVAL;
> > +     return snprintf(dstaddr, NVMF_TRADDR_SIZE, "%pISc",
> > +                      (struct sockaddr *)&queue->sockaddr_peer);
> > +}
> > +
> >   static const struct nvmet_fabrics_ops nvmet_tcp_ops =3D {
> >       .owner                  =3D THIS_MODULE,
> >       .type                   =3D NVMF_TRTYPE_TCP,
> > @@ -1881,6 +1893,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_o=
ps =3D {
> >       .delete_ctrl            =3D nvmet_tcp_delete_ctrl,
> >       .install_queue          =3D nvmet_tcp_install_queue,
> >       .disc_traddr            =3D nvmet_tcp_disc_port_addr,
> > +     .disc_peertraddr        =3D nvmet_tcp_disc_peer_addr,
> >   };
> >
> >   static int __init nvmet_tcp_init(void)
>


--=20

Redouane Boufenghour

Storage Engineer

Join us at shadow.tech

