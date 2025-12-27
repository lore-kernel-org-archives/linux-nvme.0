Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAB2E9270E
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Dec 2025 12:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TvOsps6cmPfIY1d49bXX2hzYUiz1m4GNX0Yr8eJPMkc=; b=gsL80L085UWjh+svJKlbFiAdTj
	S4iUpLsW9F6fwxQe5ftgrdBqXNPjwD8NM2s+zYw7wqKuEWQahGSIE8tBy8p62IbfbqdJxZFNj055x
	SfW/cdG4gPj0a/5hZGjyYEGRkW0rLT+gfUIWm46yGmEXJtI5JQ5a1U8bhiG2VVKDYQizw5d0sfRpX
	sc4Lg+mhEE7sfcZ6VQG8aL3jCDjPuCzMCzclQxnYwdm0nidxxFVrBq+ivAXEyi/nEFzA4v5PaLrWH
	MSEyveVV6O6GHDoY6pae1C1eQDNDrWiesjomrsRNBz9kF79Z4+V9q5xRZKimFywz7JN41DWlCl9+I
	sZ+lyO1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZT81-00000001v1k-48YZ;
	Sat, 27 Dec 2025 12:10:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZT7y-00000001v1E-2RvO
	for linux-nvme@lists.infradead.org;
	Sat, 27 Dec 2025 12:10:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766837431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TvOsps6cmPfIY1d49bXX2hzYUiz1m4GNX0Yr8eJPMkc=;
	b=figCuqV64djoeOrnL+EdgH8c4ODTEZ4TrnIRM4YrHDrczZSJSYBlHCjfyKG2FL69l26lLg
	YeMC+KOYO0NJlxfM+cYRpfbhBtlKaVN7aPsLXJHAqOKOPQXJYCsFQHMFgAZAKhWFIxrbVD
	pYpH0kaARyj360FQczBjwsAPmi5aDi0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-eIg9TmwSMMaCQIWkhegAcA-1; Sat, 27 Dec 2025 07:10:28 -0500
X-MC-Unique: eIg9TmwSMMaCQIWkhegAcA-1
X-Mimecast-MFC-AGG-ID: eIg9TmwSMMaCQIWkhegAcA_1766837427
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-598ea011be5so1873003e87.0
        for <linux-nvme@lists.infradead.org>; Sat, 27 Dec 2025 04:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837427; x=1767442227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvOsps6cmPfIY1d49bXX2hzYUiz1m4GNX0Yr8eJPMkc=;
        b=himQNgJCYHy5OekzOS/6K1XSeUvzLx4hMhdGTOhV2xIC6EWshKwnQE3CgmLjHfz5oM
         MDLD0r3nsqNDzgySN9upydry2+qF+ihxt2YTth/l7hC+gqS0/R+pTEbbd5q2EiTf6Q9+
         MxFk6X9pxio5e4qFzvWKb3MKjWtNs4hnbYR61/P5YvaFC5RQBiqBlIIVdiCKcQcsM3tu
         oiXAiANPCPs1AEc8gW0BYBa/WH6MmP5WQcRB3g3RPxSWt4ecPWVgFM2CREm7ZY7XO0ku
         zgw0nqb7ZKAnW7kUa/scf4oPifRn21CoIFt9j1E3VXFNa11ZRJq5hAbr5n2zkL2gnLko
         vPOA==
X-Forwarded-Encrypted: i=1; AJvYcCU1pLYP3INKZa28DrSiyaOVA5WQIxJKIdTZzI6OK87m+tASpknTP3yx/tK3m5oila+GRAG3F6JhSyl3@lists.infradead.org
X-Gm-Message-State: AOJu0YzjL3oWWI27h88EpFRLcpJFOWXl0hs3c6IJN9NDb9GgdfzPJBZw
	7dOXtKQrC6El0BTxvarrrrivinC9YYwGy70BBPUgtW18ilog0gxIS75yOOvN3gtwlm7lDiokxMQ
	GmlBXKOiqbGS9aJ6MvJ8MezRNEDyzcj7qyT0vukbj9QyDWoQld3/Jrl8FSX0gXWPnprG6Tqwr4v
	k8HaDuICOn/kN+je9gBw0LmuMaH0IZ8MLIFmvJO/TEp/M=
X-Gm-Gg: AY/fxX6bOHoEnRJ5WyyAfC0cQIlwI9FNA/ny/8sBoslEcSvSbU/uBi+RWhWae6xh8v+
	31rKjDWfM33oEW2m2lAyUCphFkdVQxTwG+4NDWVGPxrYWOKgRwW3W1RR8fSJ9suZDnBAnZkXWfZ
	kq+qprHevNyeNQH0ZI+lHAzWLpDvzqz5r+qrcbcX8MniANqIrtDummPno0XwPlz+dL0g4=
X-Received: by 2002:a05:6512:1446:20b0:598:f1be:7e1b with SMTP id 2adb3069b0e04-59a17ddb4f3mr7034687e87.27.1766837427083;
        Sat, 27 Dec 2025 04:10:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEx+do6hym2GBt0SdC9GHHeXpYJbjfN5KO/klGde6KECeXB6L8RYRK43lxXz8zZZ4d1FOBeeO21xgXUDKy9ofQ=
X-Received: by 2002:a05:6512:1446:20b0:598:f1be:7e1b with SMTP id
 2adb3069b0e04-59a17ddb4f3mr7034679e87.27.1766837426698; Sat, 27 Dec 2025
 04:10:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
 <262c8ac1-e625-4e4c-8b3c-85f842aba6fe@gmail.com> <7d718bc8-64b6-4e8f-bad7-7e1615c577ca@nvidia.com>
In-Reply-To: <7d718bc8-64b6-4e8f-bad7-7e1615c577ca@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 27 Dec 2025 20:10:13 +0800
X-Gm-Features: AQt7F2pQQN-paPTMMBs5zAdwkh45Y8piwyH_iEGWsTo-SVLxEQoYcfscwKHfBCE
Message-ID: <CAHj4cs9gBTHLB_7JrFpZnJ-imc7jmqnhZpqkemaRVQYLn9j_rQ@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed during blktests nvme/fc
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>, 
	Daniel Wagner <dwagner@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HOCVvGsGscKBTkeAAruiFY_U-caJfC8-7IBpkEATFB4_1766837427
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041034_692022_8663D31C 
X-CRM114-Status: GOOD (  19.09  )
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

> > Can you try following ? FYI : - Potential fix, only compile tested.
> >
> > From b3c2e350ae741b18c04abe489dcf9d325537c01c Mon Sep 17 00:00:00 2001
> > From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> > Date: Sun, 14 Dec 2025 19:29:24 -0800
> > Subject: [PATCH COMPILE TESTED ONLY] nvme-fc: release admin tagset if
> > init fails
> >
> > nvme_fabrics creates an NVMe/FC controller in following path:
> >
> >     nvmf_dev_write()
> >       -> nvmf_create_ctrl()
> >         -> nvme_fc_create_ctrl()
> >           -> nvme_fc_init_ctrl()
> >
> > Check ctrl->ctrl.admin_tagset in the fail_ctrl path and call
> > nvme_remove_admin_tag_set() to release the resources.
> >
> > Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> > ---
> >  drivers/nvme/host/fc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index bc455fa98246..6948de3f438a 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -3587,6 +3587,8 @@ nvme_fc_init_ctrl(struct device *dev, struct
> > nvmf_ctrl_options *opts,
> >
> >      ctrl->ctrl.opts = NULL;
> >
> > +    if (ctrl->ctrl.admin_tagset)
> > +        nvme_remove_admin_tag_set(&ctrl->ctrl);
> >      /* initiate nvme ctrl ref counting teardown */
> >      nvme_uninit_ctrl(&ctrl->ctrl);
> >
> did you get a chance to try this ?

Hi Chaitanya

Sorry for the late response, I tried to reproduce this issue recently
but with no luck to reproduce it again.
And during the stress blktests nvme/fc test, I reproduced several panic issue.
I will report it later after I get more info.


>
> -ck
>


-- 
Best Regards,
  Yi Zhang


