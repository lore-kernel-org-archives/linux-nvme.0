Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BA3C25B75
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lVAdRu+n381ckT6SKcUwnFzXRuF5PZNEAWA5XuBMSV4=; b=zSKf2l5XVQtza6UZNRCnm4mjNb
	JG8Uf3Zcg0OECiAnMuO6/FPPTN8HPIWiJlZ68VQKQnY8ap0r4Eqy2lG/Rhbs+lioeROuS4fdwhHW9
	7zdy9Wj5ozURBPznYMCL5T0FZDzIpxXmlslU52YvUL+gU6+jFFG+6kr64Rww/qPg6QWPLyoXkCXif
	qBdBT4oXHWAyOPXICpHMGvjFzbbeo1I7waSfLXkcPD1erBHCKdMNyviQBwFWSu2IHLtq8Dje2ObCM
	rmjvrbIwspe5UZ7Ey6Z0tCNUqHlBCVKG/DhU9ddGIatQe3jiZi0RrV0MTJ8WglcJAPe10RgNK5Fo6
	F+OMx2tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCJcN-00000004Kej-44bI;
	Wed, 29 May 2024 13:45:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCJcJ-00000004Kby-36bC
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 13:45:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716990320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVAdRu+n381ckT6SKcUwnFzXRuF5PZNEAWA5XuBMSV4=;
	b=CqAY4bXh+N18fvXwYqJKMDQX1dUimffbrRBuWrBslGD/7Vj+9lbFMGhVDuwpi8q+pIWb/Y
	ZLnCv+Ubj/lZk05Jc/J7ILnqtT19GcpWcHr/PtEdqRVtr/Jsw191DiaY1ihF/FNiQGNFxw
	pKiXFWEUTWHmlqt6Dhore429sglADWQ=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-b3kwKFKMMp640a6TagOimQ-1; Wed, 29 May 2024 09:45:17 -0400
X-MC-Unique: b3kwKFKMMp640a6TagOimQ-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4e4effad7f6so859873e0c.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 May 2024 06:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716990316; x=1717595116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVAdRu+n381ckT6SKcUwnFzXRuF5PZNEAWA5XuBMSV4=;
        b=tuTFkuACDCDcP2dx8Foo4+e1eznD9kJZt9n6yy4sepav6H/kyTd7VX1U1n/ot8zaEV
         ep4l5ThuBJxifPif7pUfnrCgt5wLAQn8BLXk3VRTrUGWeBBqVGLrbcRZdrqnI+L6yiY7
         ibdMNL2PrEMjKCmoPVIgohNOdTXWo7d4jfJEUCfPZDXJM6s1kfeqrE74O/W/S6pDCSyB
         sIgcLHwt1b1v9Hk2WDeGGeEXuH/pMxWKhSuBIj1Xh9wuuiFYXDVIGwd5ZtP//S3N5K7i
         BQ+fvQowaoPZIS0D68q2VrNwDvg12tuQOBfC4fwxdcUoiKt25XJ8d9JJBOMcSMo1rn57
         qetg==
X-Forwarded-Encrypted: i=1; AJvYcCWb/wBtBl9DmCWm6V7adV8GE9KRyqz4BK5qmv18/t5ZZUolqhL4cKTJmOEm48N6mk1JAwJbJfdAq/L9wOGErp+2fZhXPYMuuIj7Od8iZSw=
X-Gm-Message-State: AOJu0YxEC4G1QJyddK2Of212ilkwlX1pz1Y7Zl7Mq3pMwct/6zSpk0s4
	R+UkT58YVAgeeuDLI42zcLJjU1+rOFktsXwssBkxq4UR6ytg4DQpJZGTWn9NPW9/gwY67V63dvj
	3mjAqHMTm5xth3Z31gH8phs/HILbpjLMUy6W9Q6/GUKF2SSA6lMsiRj9CMKnMfb254J5cOGnYlA
	DXqWd/owQ0qYIlgtisoVQX6Kas3j9NOiFKNFV9b/U=
X-Received: by 2002:a1f:7381:0:b0:4e9:7e39:cc9f with SMTP id 71dfb90a1353d-4e97e39d44fmr1459586e0c.11.1716990316364;
        Wed, 29 May 2024 06:45:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMlocdkTIVHxOTIXJRkRGcafwqKhOfsEGUcbwTw9Xky6gAUwCSWRP7V5dUBMTHZRE++Xa3y89kZdQIouEJxC4=
X-Received: by 2002:a1f:7381:0:b0:4e9:7e39:cc9f with SMTP id
 71dfb90a1353d-4e97e39d44fmr1459505e0c.11.1716990314444; Wed, 29 May 2024
 06:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me>
 <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
 <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
 <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com> <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me>
In-Reply-To: <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Wed, 29 May 2024 15:45:02 +0200
Message-ID: <CAFL455nrv=sTgeD+B25H16HpoEUNTSvknEwB_hXh=_G1deAz9w@mail.gmail.com>
Subject: Re: blktests nvme 041,042 leak memory
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_064523_944559_CE682047 
X-CRM114-Status: GOOD (  14.89  )
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

st 29. 5. 2024 v 14:51 odes=C3=ADlatel Sagi Grimberg <sagi@grimberg.me> nap=
sal:
>
> --
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f62fd49c1411..8a9d51e1ccd6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4702,6 +4702,14 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct
> device *dev,
>          nvme_fault_inject_fini(&ctrl->fault_inject);
>          dev_pm_qos_hide_latency_tolerance(ctrl->device);
>          cdev_device_del(&ctrl->cdev, ctrl->device);
> +       /*
> +        * this is nasty hack, but device_add allocated a device private
> +        * dev->p, which is freed assymmetricly in device_release, and
> +        * in order to cleanup after ourselves, and not rely on the devic=
e
> +        * .release handler (which also calls the nvme transport free
> handler)
> +        * we explicitly free the device private.
> +        */
> +       kfree(ctrl->device->p);
>   out_free_name:
>          nvme_put_ctrl(ctrl);
>          kfree_const(ctrl->device->kobj.name)
> --
>
> But this is ugly...
>

I like the fact that it's just a one-liner in nvme_init_ctrl, but
yes... it's really a hack that may stop working if device_add()'s
implementation changes.

Maurizio


