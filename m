Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE3ECAC5B9
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 18:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GCwL8SXUdlfwXeL8qzp+u5OC8lgUfGYR3U0v0leyOhE=; b=kATVHI/RrVhU0o9o3pVCB5zZWo
	1Jid+vbVjls0y7qnHsjXaM363bROu2Xr9NaaXPzym4VN+dfc/Baxb2MCKwkdOgoNDaVWnGBVvVUWc
	vV8hnUY42Ikv+oUgEk3HqLCuDchIBH+61Qxg2ZCzqtxwC2NlqQGiu/oX1S3CvBhTX6lxRhgqOeg/U
	SMD4a6kVpUveoQqxILcsbXqU5VTaU2xhh4jGPy7u06P/XTLXzi9t7F0omRSZ24WUDIqItbtHQaVPA
	RQyJPbQnjmGEJxjyU/kvxl6yhmkqn7qnc8hbizud4CtYgGGGtw7VFlKl4BgtTFuGZNWL5hwAohPHs
	BC4fG+ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1qwA-0000000C1LX-2jS8;
	Thu, 25 Sep 2025 18:43:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1qw6-0000000C1Ie-2l5J
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 18:43:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758825800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCwL8SXUdlfwXeL8qzp+u5OC8lgUfGYR3U0v0leyOhE=;
	b=Y2RanIwaB9pUyKTH35Eea41xtBknO9QF1WuS+Wkx9R6IpUm/uZUALyUIChkE7HoS99UTi0
	GMON/1egHAPdKG/JeL3bMZS/fJOF4NozXGiyqAYXA7QSZ96B5rFs47D52E8MiV9S6kvuU+
	dFykFNbgbyyWZxv7ePakD8U1RoWZlKg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-6lI2l9JIPwCtPi7AZIxOxw-1; Thu, 25 Sep 2025 14:43:19 -0400
X-MC-Unique: 6lI2l9JIPwCtPi7AZIxOxw-1
X-Mimecast-MFC-AGG-ID: 6lI2l9JIPwCtPi7AZIxOxw_1758825797
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f42b54d159so965867f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 25 Sep 2025 11:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825797; x=1759430597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCwL8SXUdlfwXeL8qzp+u5OC8lgUfGYR3U0v0leyOhE=;
        b=idgLOfaNKovx/BLFuHO/t5l+c2WecBVVKLPUHa+333cjntAEpZ/yhP1abUfA+hjHww
         edkSSYnuTSr0Ql+FyxzXSokjeAb+YM5ZL/8bY//wNTt0Ut9tCQflK6m3si/MR5iFOFtt
         HcQapG/muFhGVbeRti9WscHnao5f8yEfEIDw7iy6C7Ml614z53hsB+Wfgho3FM6pldI7
         OqIh65dCLIBR+W7Wi4fXMMgwekGbL2cdA82qj033TEpBHoPoUiBJv3zgmy090Ou+Bwvu
         Z8kXtiFB5Y0Aykem75vMFpMPd6DPLJt/5BS52F96KM8DfTyFrsVJFNypnAdP6DJZGbRp
         8fkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+upS68poG44ZnB7SibYfmnoSOzILjHlfPuFp7Vsbfjq3okErMxoaCf41+4eANw5JGjuWg4OQDJy9b@lists.infradead.org
X-Gm-Message-State: AOJu0YwJkLOyfQPnwn+/FTx/2TtYFIc79jwALrIT5zgpimgk9KM9pTEZ
	n+5s6W9f78R3HTybAd69aYIdhoe77PgyCKEL+MvXLJ0T/k8xG5LxS3T5UWaPVHA7qFWva/9tDcQ
	FRoD0VoUIYFoDa2+zXYQKaPHEBiBSw75oh5GJ6iZmjNp6tzNVXmt+faNj49bI1lGvcxQszxsGVa
	X0WnPzrCtnjTj+AHZzTC70Q3R0sOMAUF0PT4izMAA3CNQ=
X-Gm-Gg: ASbGnctch8qwl7ugcAH4jAgeCF+EiH6jfJdIHI1396feaqUGAjOJP1r8/G6oiNWsESM
	Vo760CFQKZAaTJNt8n4T4GpePDZXlDaJ8KlHtEn+eG0Rc4oIY4lxYPJKEg9dmMlabRO7G1WyEaQ
	ybH4B8tW3FXDUUaaxQT1Z6Qw==
X-Received: by 2002:adf:a314:0:b0:40f:5eb7:f234 with SMTP id ffacd0b85a97d-40f5eb7f48cmr2845644f8f.5.1758825796912;
        Thu, 25 Sep 2025 11:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE88PMsbz8pPK3SEua9+FkvwWXj3+M2OYdB33VngMoCil+x4wPGRNDKD5gCmIANA4SBdzwL9F5/1f+LVE1qRc=
X-Received: by 2002:adf:a314:0:b0:40f:5eb7:f234 with SMTP id
 ffacd0b85a97d-40f5eb7f48cmr2845619f8f.5.1758825796463; Thu, 25 Sep 2025
 11:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <fbbef12e-fc43-464f-b92d-f42f3692a46c@redhat.com>
 <20250925170223.18238-1-bgurney@redhat.com> <e58d743b-a999-4e00-8f2e-31707744c5bb@embeddedor.com>
In-Reply-To: <e58d743b-a999-4e00-8f2e-31707744c5bb@embeddedor.com>
From: Bryan Gurney <bgurney@redhat.com>
Date: Thu, 25 Sep 2025 14:43:04 -0400
X-Gm-Features: AS18NWCHTZQIxNrKgiFSSzKrwF5EleTnCC_ffWawvQOYJkv4JLiwwoWDLY4SGGs
Message-ID: <CAHhmqcTdC_we4x9e0Q-NT=k-9LM5Q8azFH51_Wbpr4tKgpOzDg@mail.gmail.com>
Subject: Re: [PATCH RFC] scsi: qla2xxx: zero default_item last in qla24xx_free_purex_item
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org, kbusch@kernel.org, 
	hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, james.smart@broadcom.com, 
	njavali@marvell.com, linux-scsi@vger.kernel.org, hare@suse.de, 
	linux-hardening@vger.kernel.org, kees@kernel.org, gustavoars@kernel.org, 
	emilne@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZvE1EfGtBTeNl6iRFXUCpizntPryJam4UGta7OPtCf4_1758825797
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_114323_692875_69C5685A 
X-CRM114-Status: GOOD (  21.82  )
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

On Thu, Sep 25, 2025 at 1:23=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 9/25/25 19:02, Bryan Gurney wrote:
> > In order to avoid a null pointer dereference, the vha->default_item
> > should be set to 0 last if the item pointer passed to the function
> > matches.
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000936
> > ...
> > RIP: 0010:qla24xx_free_purex_item+0x5e/0x90 [qla2xxx]
> > ...
> > Call Trace:
> >   <TASK>
> >   qla24xx_process_purex_list+0xda/0x110 [qla2xxx]
> >   qla2x00_do_dpc+0x8ac/0xab0 [qla2xxx]
> >   ? __pfx_qla2x00_do_dpc+0x10/0x10 [qla2xxx]
> >   kthread+0xf9/0x240
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork+0xf1/0x110
> >   ? __pfx_kthread+0x10/0x10
> >
> > Also use a local variable to avoid multiple de-referencing of the item.
> >
> > Fixes: 6f4b10226b6b ("scsi: qla2xxx: Fix memcpy() field-spanning write =
issue")
> > Signed-off-by: Bryan Gurney <bgurney@redhat.com>
> > ---
> >   drivers/scsi/qla2xxx/qla_os.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_o=
s.c
> > index 98a5c105fdfd..7e28c7e9aa60 100644
> > --- a/drivers/scsi/qla2xxx/qla_os.c
> > +++ b/drivers/scsi/qla2xxx/qla_os.c
> > @@ -6459,9 +6459,11 @@ void qla24xx_process_purex_rdp(struct scsi_qla_h=
ost *vha,
> >   void
> >   qla24xx_free_purex_item(struct purex_item *item)
> >   {
> > -     if (item =3D=3D &item->vha->default_item) {
> > -             memset(&item->vha->default_item, 0, sizeof(struct purex_i=
tem));
> > -             memset(&item->vha->__default_item_iocb, 0, QLA_DEFAULT_PA=
YLOAD_SIZE);
> > +     scsi_qla_host_t *base_vha =3D item->vha;
> > +
> > +     if (item =3D=3D &base_vha->default_item) {
> > +             memset(&base_vha->__default_item_iocb, 0, QLA_DEFAULT_PAY=
LOAD_SIZE);
> > +             memset(&base_vha->default_item, 0, sizeof(struct purex_it=
em));
> >       } else
> >               kfree(item);
> >   }
>
> I see. I think it's probably better to go ahead with the revert, and then=
 apply
> the patch I proposed in my previous e-mail (it's more straightforward and=
 introduces
> fewer changes).
>
> If you agree with that, I can submit both the revert and the patch.
>
> Thanks
> -Gustavo
>

Hi Gustavo,

I just built a kernel with your patch, on top of the NVMe FPIN link
integrity v9 patch set, and a test run on qla2xxx passes without any
field-spanning write warnings, nor with any null pointer dereference
errors.


Thanks,

Bryan


