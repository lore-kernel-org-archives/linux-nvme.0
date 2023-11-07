Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E641CC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 00:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9NZIf37fBTpnUBIuF43ewN2w/ewl+C75YsV5rj428oc=; b=gE+wTS7mRLeeL/IU943HqrmzUI
	GblhdlY6NmBd6UVDHGvOPKwijWgjlOSBQoaDfAHkYi37vAp8gu093R8OVKw6vgGJfKSZsLm9H9MVh
	BU5G2OBXk+x19Uu3Q/mUv2+u5ia/G8MizxQbqrzNiUDWfKRx7XYBH2F/7/zjnVl1y+5Yj/iwapOVA
	uIVLbY0J3tDfzcaOAaNVAlSKimWyGcPRXkkx3t/pfuxhIOPfNwf0vMWkIvyAR1zVgSD3RGjuixt0b
	jKZj/bVoikY3RHH8LCq1uCJeSonGGkbiB1F5h9lZXKscbBTUAyodKMHntheZxxkEOX343bBjXOqnJ
	BANYZ1zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r09YW-000Bst-0x;
	Tue, 07 Nov 2023 00:02:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r09YT-000BsY-0R
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 00:02:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699315368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NZIf37fBTpnUBIuF43ewN2w/ewl+C75YsV5rj428oc=;
	b=YK1Sa8BEdW6inIxHBHrBibimgDP34N3nXHrp+7dfBQbVJtrLvHWOgY0hxevrak9Ku+dgav
	p4ef0wVP9m8JBH+lNMqcPBs/duaSTGY1RJGQ+g6sREmPH+gWHxfQvkEfB3WrUtGD62V1EG
	1ZOe1R4QN46+BXw4KP4SrJYmIOuXFwQ=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-ze2DKsB7PliFBk0Q1S7ceg-1; Mon, 06 Nov 2023 19:02:45 -0500
X-MC-Unique: ze2DKsB7PliFBk0Q1S7ceg-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7ba2b284b32so365027241.1
        for <linux-nvme@lists.infradead.org>; Mon, 06 Nov 2023 16:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315365; x=1699920165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NZIf37fBTpnUBIuF43ewN2w/ewl+C75YsV5rj428oc=;
        b=vBn2MWqqZUyLi03tuhaXrQUB42xZ8/0dh3ehE50Sisyf0sY0JAic7c6q07yXDNL27U
         OiwivsRZmobl1VHFLjSUDBkpCL7uXW43f4cp2nyeoC5mh3bxdBcjnJV2zdR2svOeMTRW
         PDyApCBcsjUti5I5ZCWN1/n3Vw0M37hX2a/BX1Vk0vOw3KoMZVXPvfJ1axNCPJBoa6dd
         MjZscGhfT/huY31VJWPT+o99ULkC2dg4A8+/wjuv8UdztOxk49/+nVJ+/as1Vg/7plks
         ESDk9u017F0QYCUWaZkIH7+QqV/3cxH7K85ImM9G9DRq0EAN8BRA2RUIZ90wEyl00WkN
         6NPw==
X-Gm-Message-State: AOJu0YxhLjQ25bIPLpw8TRqJ9W4gml/GR3fT6bVbFB16fGY5fqWKI4hN
	nlzNy9DnZ+O1wcObZTzBcxMCEZRlns0JxtZtgLn7i9rUx/zZjG8qy4DX7RtawGpeukgAAcLLJ39
	6vxExryxvkbjbDr+tXa1T75qvVxnAgodWfKHatQu7E2I=
X-Received: by 2002:a05:6102:396e:b0:45d:a23a:fcf2 with SMTP id ho14-20020a056102396e00b0045da23afcf2mr6924724vsb.1.1699315365037;
        Mon, 06 Nov 2023 16:02:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN3Ndo/SCvMYHfp+XeOIoB2agqT0I3r6sPGvkNeOTXDuQo4QUFPnqMWwJ3rL5D1xq0UWYPtwSb2U1QTo+roL0=
X-Received: by 2002:a05:6102:396e:b0:45d:a23a:fcf2 with SMTP id
 ho14-20020a056102396e00b0045da23afcf2mr6924711vsb.1.1699315364808; Mon, 06
 Nov 2023 16:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20230707212157.1158725-1-mliang@purestorage.com> <20230707212157.1158725-3-mliang@purestorage.com>
In-Reply-To: <20230707212157.1158725-3-mliang@purestorage.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 7 Nov 2023 08:02:33 +0800
Message-ID: <CAFj5m9KR3YjbHye_Qu1=0ZLr6HR4Qs6iS5FmfVLu4D3KjY4rdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme-fc: fix race between error recovery and creating association
To: Michael Liang <mliang@purestorage.com>
Cc: linux-nvme@lists.infradead.org, jsmart2021@gmail.com, 
	randyj@purestorage.com, csander@purestorage.com, ushankar@purestorage.com, 
	psajeepa@purestorage.com, Ming Lei <ming.lei@redhat.com>, 
	Ewan Milne <emilne@redhat.com>, Marco Patalano <mpatalan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_160253_271017_30A8C09D 
X-CRM114-Status: GOOD (  12.10  )
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

On Sat, Jul 8, 2023 at 5:24=E2=80=AFAM Michael Liang <mliang@purestorage.co=
m> wrote:
>
> There is a small race window between nvme-fc association creation and err=
or
> recovery. Fix this race condition by protecting accessing to controller
> state and ASSOC_FAILED flag under nvme-fc controller lock.
>
> Signed-off-by: Michael Liang <mliang@purestorage.com>
> Reviewed-by: Caleb Sander <csander@purestorage.com>
> ---

...

> @@ -3172,12 +3179,16 @@ nvme_fc_create_association(struct nvme_fc_ctrl *c=
trl)
>                 else
>                         ret =3D nvme_fc_recreate_io_queues(ctrl);
>         }
> +
> +       spin_lock_irqsave(&ctrl->lock, flags);
>         if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
>                 ret =3D -EIO;
> -       if (ret)
> +       if (ret) {
> +               spin_unlock_irqrestore(&ctrl->lock, flags);
>                 goto out_term_aen_ops;
> -
> +       }
>         changed =3D nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
> +       spin_unlock_irqrestore(&ctrl->lock, flags);

nvme_change_ctrl_state() may sleep in nvme_kick_requeue_lists(),
this patch has caused regression with
"BUG: scheduling while atomic: kworker/u33:5/31604/0x00000002".

Thanks,


