Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB62C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 14:08:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D893619F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 14:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D893619F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hf+fqArwTwEDxc3ZOUcv5uKJSa121J0YV5U43bUq9nM=; b=3ehK0MgoJswCpP65G0hWIZojfY
	UXrK1H8KeqMHimOE15BlTPmKnDyFemgddw730EtUBlRO1rHXwdhxkeGZFp8Z26J6z2x8jsFJGSIOi
	Fe7FNMvJSLYVQQWWY+ROLYrC+5EpqIhbZk555Dt8F8Ep13DTU+o+LA3E8xPj+/no4EQTGOmNZNmur
	mtas/dvTk3heyIQGMpBC4/8SoQB2TV8pvld9Gw+qA5HKY45SDLcn1ixzJ/begychPoJLdvX16en/E
	fi+ArGnPSAelSWffRisLrsg7xcACvkXkFQDlBekICsU4oBJtZOz3iWjnudsP87wrvPDvZeNYIjMZa
	CnCk4dJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVwjG-00Ee7G-GG; Thu, 30 Sep 2021 14:08:06 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVwjE-00Ee3b-DL
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 14:08:05 +0000
Received: by mail-wm1-f48.google.com with SMTP id v127so4764624wme.5
 for <linux-nvme@lists.infradead.org>; Thu, 30 Sep 2021 07:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MH2AjkC1f+wfQFUwN+uYijRUSXhG1GjCKaamXrLeRx8=;
 b=7E+RxviNKXxRCeWK+blGSDNTRnWWmbhRTlZ2mO/xBx9KaGjD5T7TImceZ7aKLiz+C7
 CHC/erDu43yNkcLcQe2+H81ElvEcBJ+jnopqnFGVVxcWBiOKg+pagwueO83pyO1GpInU
 4bdP1eOxu7cOVcPd5IM4H50iHmdtq64TR8bxDVM1WCymy5Yf4EcP8Zjsd4dG/CJ06jFQ
 G1+XRP5nyFx1tPlOz5d7p8YqyABTEMAcqRer9DD2AcvRVCkzZhbEp8IgY8Bylt6TKQqo
 +X1jme/sYdHjRXL2PS69S5m8dZmg0gYzW/rYgZmnBrBgvLesAtFmcNRMNz5VlNB0l+qy
 U0Ow==
X-Gm-Message-State: AOAM530rlkBDbow1R6VNFwntVYkIGGctCBrryCRgCNNm3/jrulDlHALw
 8ktiUEyveNs5ljs+aDiog0L861u0rsQ=
X-Google-Smtp-Source: ABdhPJxye+QGZRp8QC4xmd9cmbxpYjlHhjdhucVuh1GVTZZSum+0SnKWvN3QFAVRAV/s7DQu0cOoXg==
X-Received: by 2002:a05:600c:3585:: with SMTP id
 p5mr16345799wmq.110.1633010860134; 
 Thu, 30 Sep 2021 07:07:40 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h18sm3061549wrs.75.2021.09.30.07.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Sep 2021 07:07:39 -0700 (PDT)
Subject: Re: [bug report] kmemleak observed with blktests nvme-tcp tests
To: Yi Zhang <yi.zhang@redhat.com>, minwoo.im.dev@gmail.com
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <CAHj4cs8pcLTjHMhh_0vebWUgwTY+UtYoKAhQntCsFvKM4zcKfA@mail.gmail.com>
 <caa2467e-9763-b9dd-db91-4cb7020bab47@nvidia.com>
 <CAHj4cs_NqB6WYQQOpqjoOFvTbbN_VydJkn1VquzTkyGpFqMM2Q@mail.gmail.com>
 <0a8810e0-4c42-4275-acd6-475fd42485fe@grimberg.me>
 <CAHj4cs_icpHAf7wN3LFt7avcPcrhjOYiSnU8SnCLQN1ObkRV1Q@mail.gmail.com>
 <CAHj4cs9QBFXca-rnP05ZmWBKDJv4aviiDQ=q2_JihMQuESE7OA@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1b992460-26a6-cff6-bee4-b81ac28e93f5@grimberg.me>
Date: Thu, 30 Sep 2021 17:07:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs9QBFXca-rnP05ZmWBKDJv4aviiDQ=q2_JihMQuESE7OA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_070804_488582_7F5CD2AD 
X-CRM114-Status: GOOD (  12.07  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Bisect shows it was introduced from the below commit:
> 
> commit 2637baed78010eeaae274feb5b99ce90933fadfb
> Author: Minwoo Im <minwoo.im.dev@gmail.com>
> Date:   Wed Apr 21 16:45:04 2021 +0900
> 
>      nvme: introduce generic per-namespace chardev
> 

Makes sense as both leaks relate to the nshead cdev...

I think another put on the cdev_device is missing?
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1d103ae4afdf..328e314af199 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3668,6 +3668,7 @@ void nvme_cdev_del(struct cdev *cdev, struct 
device *cdev_device)
  {
         cdev_device_del(cdev, cdev_device);
         ida_simple_remove(&nvme_ns_chr_minor_ida, 
MINOR(cdev_device->devt));
+       put_device(cdev_device);
  }

  int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
