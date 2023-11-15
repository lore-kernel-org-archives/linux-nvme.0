Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB37FC54FB9
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Nov 2023 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qVb5W/1ykgcPuZJWIxg+rdppxH8eWqp/RkGKjVY9a8A=; b=1BsKT2TnCSAs8J6L0dL3fADgVM
	LC/kiAjvwWERs+GTbpW8+HIpnGJwPr98sCE7EF+Ok3RTWw/q0MfMFCvk5/YQQK+2Qk+EOUhjGfWV5
	gDyGZbR73hUdA0Ovm3z2HmkQsHMYrkptVCqqeJvrChYMqusbUOtBYT6vipTM88o4UM+ru5QaPTBxb
	0ABBRjj1QhtYmufcscLAH8deeScbMUuxLgrd3aAOi0jK7x1RWOQuKsrecfmrElaSUwqF80JL1meEs
	YlAl1j8X+Xe9t40NRzvZUedw9onfVOYCx0zRFUQUPhfn21RmdAkKbk1l3YADmUVW8ewVh7UI6+lIo
	KQifSv8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3LSo-001Zxo-23;
	Wed, 15 Nov 2023 19:22:14 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3LSm-001Zwk-08
	for linux-nvme@lists.infradead.org;
	Wed, 15 Nov 2023 19:22:13 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41e3e77e675so231521cf.1
        for <linux-nvme@lists.infradead.org>; Wed, 15 Nov 2023 11:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1700076125; x=1700680925; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVb5W/1ykgcPuZJWIxg+rdppxH8eWqp/RkGKjVY9a8A=;
        b=fpo9ht0Ny+p+KJsiYtXLkl2bNb23R0TOwxrP5liCLxl52qewY32WkfwTdVptKbj6WF
         o2tD0gf2ej1bnE/9C6N0MdURiKEeioPdCn2+ObSAYRpv/LA2+vXAfpxFGmut/cyiydtK
         N09UodgjXe4hHkzEdtJje+bPiBf39msGBCPaj2/ummhITRT0/oTK2F98G9pdzPTyXfWt
         TTl930TcY8ddP3csQyG5Tbg0icBBnX8Ks1UKA9g2quy2P3FjaS/pZ9DNX0vKhX01n8nM
         2O/5VTEg+QUuefu0PNPWoW9IuJEf1fWo1d2BDTDyeZVDjhSYIMihyl5MfXCMQPuQTrpL
         Mt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700076125; x=1700680925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVb5W/1ykgcPuZJWIxg+rdppxH8eWqp/RkGKjVY9a8A=;
        b=NQ1e6b5NzABj1eLm2UlkOoa7HDBmbEPD0qETnhsgRvkUnkkj0XrcTqlo4/ilOC5LYZ
         VNzPXaxwQ8gfWgSjMjzlo9V8Hm5LqQRz8L7hpBn86FHfRoM/oOuSNdUrdPexxWUtaIoj
         CqDInZE017eTBNgZH4P4YbRMWJbEvUyBobCE/KJWGnug3c5HISwgf9LWOu5WdpsztvSE
         xu+VZ7HcIIIrXNtFmVVs9h1beps7EtZ9YqhMm0h012dTq9N+PNkLsHyORLYRwcAIeYDP
         plfBFzpEaIqiK/Dvys3z89Mxv3pcf/O25VsBj3VmBKkGSsQgfNnm09aSFDSAHsHQliRW
         LoRg==
X-Gm-Message-State: AOJu0Yxw3ymxYXRNHe961rsUDpf+dXbpQLJoBmHabLDx6bBQzXLzz7an
	nDSw1YxXhEee/u0I4My4ngiRCYlr5+7uKkdtdk6jWw==
X-Google-Smtp-Source: AGHT+IE/Uzv7uLPhimfHDicm/C4KHNQJqKyrjXYg8WfoewFPhALm305YuLmbFGXkfMcRGxhRypZjMcsUoS9BzOed6/4=
X-Received: by 2002:ac8:4e53:0:b0:41b:774b:b1a2 with SMTP id
 e19-20020ac84e53000000b0041b774bb1a2mr7456363qtw.22.1700076124662; Wed, 15
 Nov 2023 11:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20231115185439.2616073-1-yzhong@purestorage.com> <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk>
In-Reply-To: <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk>
From: Yuanyuan Zhong <yzhong@purestorage.com>
Date: Wed, 15 Nov 2023 11:21:53 -0800
Message-ID: <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
To: Jens Axboe <axboe@kernel.dk>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	randyj@purestorage.com, hcoutinho@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_112212_078293_F2E8632E 
X-CRM114-Status: GOOD (  21.80  )
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

On Wed, Nov 15, 2023 at 11:02=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 11/15/23 11:54 AM, Yuanyuan Zhong wrote:
> > The head->effects stores a pointer to the controller's Command Sets
> > Supported and Effects log. When the namespace head is shared by multipl=
e
> > controllers, if the particular controller is removed, dereferencing
> > head->effects causes use-after-free:
> >
> > [  227.820066] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  227.820069] BUG: KFENCE: use-after-free read in nvme_command_effects=
+0x1f/0x90 [nvme_core]
> >
> > [  227.820091] Use-after-free read at 0x00000000c02dadcf (in kfence-#0)=
:
> > [  227.820094]  nvme_command_effects+0x1f/0x90 [nvme_core]
> > [  227.820107]  nvme_passthru_start+0x19/0x80 [nvme_core]
> > [  227.820121]  nvme_submit_user_cmd+0xc7/0x170 [nvme_core]
> > [  227.820136]  nvme_user_cmd.constprop.16+0x152/0x1d0 [nvme_core]
> > [  227.820149]  nvme_ns_head_ioctl+0x92/0x140 [nvme_core]
> > [  227.820162]  blkdev_ioctl+0x1c5/0x280
> > [  227.820169]  __x64_sys_ioctl+0x93/0xd0
> > [  227.820174]  do_syscall_64+0x45/0xf0
> > [  227.820177]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >
> > [  227.820182] kfence-#0: 0x000000000fac1d5d-0x00000000a28a73c3, size=
=3D4096, cache=3Dkmalloc-4k
> >
> > [  227.820185] allocated by task 2559 on cpu 3 at 188.703118s:
> > [  227.820233]  __kmem_cache_alloc_node+0x3c9/0x410
> > [  227.820236]  kmalloc_trace+0x2a/0xa0
> > [  227.820238]  nvme_get_effects_log+0x68/0xd0 [nvme_core]
> > [  227.820251]  nvme_init_identify+0x5ef/0x640 [nvme_core]
> > [  227.820263]  nvme_init_ctrl_finish+0x8d/0x250 [nvme_core]
> > [  227.820275]  nvme_tcp_setup_ctrl+0x1ce/0x710 [nvme_tcp]
> > [  227.820281]  nvme_tcp_create_ctrl+0x359/0x450 [nvme_tcp]
> > [  227.820286]  nvmf_dev_write+0x203/0x3b0 [nvme_fabrics]
> > [  227.820292]  vfs_write+0xd2/0x3d0
> > [  227.820294]  ksys_write+0x5d/0xd0
> > [  227.820297]  do_syscall_64+0x45/0xf0
> > [  227.820298]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >
> > [  227.820302] freed by task 2521 on cpu 28 at 220.115945s:
> > [  227.820329]  nvme_free_ctrl+0xa6/0x260 [nvme_core]
> > [  227.820342]  device_release+0x37/0x90
> > [  227.820345]  kobject_release+0x57/0x120
> > [  227.820347]  nvme_sysfs_delete+0x39/0x50 [nvme_core]
> > [  227.820360]  kernfs_fop_write_iter+0x144/0x1e0
> > [  227.820362]  vfs_write+0x25f/0x3d0
> > [  227.820364]  ksys_write+0x5d/0xd0
> > [  227.820366]  do_syscall_64+0x45/0xf0
> > [  227.820368]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >
> > Fix this by removing head->effects. Use the Commands Supported and Effe=
cts log
> > in ctrl->cels directly.
> >
> > Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported=
 and Effects log pages")
> > Signed-off-by: Yuanyuan Zhong <yzhong@purestorage.com>
> > Reviewed-by: Randy Jennings <randyj@purestorage.com>
> > Reviewed-by: Hamilton Coutinho <hcoutinho@purestorage.com>
> > ---
> >  drivers/nvme/host/core.c | 17 ++++++++---------
> >  drivers/nvme/host/nvme.h |  1 -
> >  2 files changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 88b54cdcbd68..14fdc2de3a75 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1085,7 +1085,9 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns, u8 opcode)
> >       u32 effects =3D 0;
> >
> >       if (ns) {
> > -             effects =3D le32_to_cpu(ns->head->effects->iocs[opcode]);
> > +             struct nvme_effects_log *cel =3D xa_load(&ctrl->cels, ns-=
>head->ids.csi);
> > +
> > +             effects =3D le32_to_cpu(cel->iocs[opcode]);
> >               if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS=
_LBCC))
> >                       dev_warn_once(ctrl->device,
> >                               "IO command:%02x has unusual effects:%08x=
\n",
>
> This is in the hot path for passthrough, can't we simply reload
> ->effects when we need?

Do you mean something like this? If not, can you please elaborate
"when we need"?
-               struct nvme_effects_log *cel =3D xa_load(&ctrl->cels,
ns->head->ids.csi);
+               struct nvme_effects_log *cel =3D (ns->head->ids.csi =3D=3D
NVME_CSI_NVM) ?
+                       ctrl->effects : xa_load(&ctrl->cels, ns->head->ids.=
csi);
Will it be good to change ctrl->effects to ctrl->effects[3] for
already defined CSI?


>
> --
> Jens Axboe
>


--
Regards,
Yuanyuan Zhong

