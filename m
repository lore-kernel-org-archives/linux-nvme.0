Return-Path: <SRS0=kA5W=CC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3EEC433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 22:50:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE37020706
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 22:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T9/2nLSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE37020706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AMCYJHeUIZ+xyc06PROkeIFwaJ3TifBO568DJiYxjDA=; b=T9/2nLSZqDdxaKzoQWMsBNBtv
	z+w3GuYnU77wxu2/ZgWBOyJig7hfR6iKQJTjlmyFYA1/JIfzEaKUWCiPbMespe306KrEG6RRhZ+/G
	SvXCQfIoH8ocUXZEHO4HVfh2H7rqHpRHw/iRwX7XfRcRNofYGbshcGw663bCZM58x7FWokyo/uVl/
	a6PK/p+CUbXMFzoA1XBx+q8D+ArDcIXBqjp0PVugN6ufWt0mFrfkbS5sONjSuzuzHEz+tJNQCOj1h
	vmD2fsry+t+8cRkJH4EMQ5a2G4hYyqagjHVOUVaZoS3uWvj4yfcS8UyR80WNofuMmtgL6WC/vKWFl
	forhSYDHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kALIV-00072L-5d; Mon, 24 Aug 2020 22:50:39 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kALIR-00071R-Dv
 for linux-nvme@lists.infradead.org; Mon, 24 Aug 2020 22:50:36 +0000
Received: by mail-pj1-f65.google.com with SMTP id nv17so201751pjb.3
 for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2020 15:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3e4h4wdc6nmxxAzEZrTp3OfzsocUV6qba6fakScoabs=;
 b=gitS4vQLyt/ETRvUP8KVkMBkAIL1J23hrieFvPEOif8D9Z3x9bS3usro5pVOppW1bh
 0shCmQvzyxJjg5AXrZDI2cXH2N9GPIawyl7u/2fq1lT2iIBRNdCOy7tVDQV2pZesoigY
 wranJ2yPCwriMGWEmOkPA0oly+zCcnKcC6zliwEK2uRbQw9R3+gmSSxitAiSPyxEKNoL
 jrDi/xCX/prgVNIr3DxjbK9HZQpZvSaWMthLB/mq7OR0dyCEpEg70/WudAM1mLTSoUVZ
 Zzy/TLrWz/bQELNDCQZT8D2/AFRNBgklRf+zv8NoGTJwtIS6XKsV9lsIMWKQ6SARZJZ8
 UDtQ==
X-Gm-Message-State: AOAM530HHcfyObfB0y7sQQu3/EjxdN6Kc7t0FILXos6HElm8txb6LFKP
 8ftvnfFttl0u9/u8HAwXvBA=
X-Google-Smtp-Source: ABdhPJwRLwWbpAsw0bIh6CYurAB4uSWC9NbAnGcaNMcgtcd2WmyPTrFxO6NnfMDTFjdR8jNIKLK3Vw==
X-Received: by 2002:a17:90b:1b09:: with SMTP id
 nu9mr1128364pjb.214.1598309433642; 
 Mon, 24 Aug 2020 15:50:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d?
 ([2601:647:4802:9070:cda6:bf68:c972:645d])
 by smtp.gmail.com with ESMTPSA id 65sm7736646pfc.218.2020.08.24.15.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2020 15:50:32 -0700 (PDT)
Subject: Re: Null pointer dereference in nvme_ctrl_reconnect_delay_show
To: Tobias Markus <tobias@markus-regensburg.de>, linux-nvme@lists.infradead.org
References: <59c468d3-b688-260e-b491-581c3ba96a21@markus-regensburg.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <49c95bdd-d55c-582a-a238-74b7c564c228@grimberg.me>
Date: Mon, 24 Aug 2020 15:50:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <59c468d3-b688-260e-b491-581c3ba96a21@markus-regensburg.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200824_185035_529697_D5E620EB 
X-CRM114-Status: GOOD (  20.40  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi all,
> 
> I hope this is the right channel for bug reports regarding the NVMe subsystem.
> 
> Trying to read sysfs attributes of an NVMe drive resulted in a null pointer dereference on 5.9.0-rc2.
> 
> The precise command was:
>      udevadm info --attribute-walk --path=/sys/block/nvme0n1
> 
> Using strace, I found out that the bug occurs reproducibly when reading
>      /sys/block/nvme0n1/device/ctrl_loss_tmo
> 
> I could further determine that ctrl->opts is not set in the struct nvme_ctrl in nvme_ctrl_reconnect_delay_show.
> 
> I could reproduce this bug with the latest NVMe fixes (commit c41c3ec4) as well.

Yep, thanks for reporting, this should fix the issue:

nvme: Fix NULL dereference for pci nvme controllers

PCIe controllers do not have fabric opts, verify they exist before
showing ctrl_loss_tmo or reconnect_delay attributes.

Fixes: 764075fdcb2f ("nvme: expose reconnect_delay and ctrl_loss_tmo via 
sysfs")
Reported-by: Tobias Markus <tobias@markus-regensburg.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
  drivers/nvme/host/core.c | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 537dcd900cb5..2039f5dac4f4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3676,6 +3676,12 @@ static umode_t nvme_dev_attrs_are_visible(struct 
kobject *kobj,
                 return 0;
         if (a == &dev_attr_hostid.attr && !ctrl->opts)
                 return 0;
+       if (a == &dev_attr_hostid.attr && !ctrl->opts)
+               return 0;
+       if (a == &dev_attr_ctrl_loss_tmo.attr && !ctrl->opts)
+               return 0;
+       if (a == &dev_attr_reconnect_delay.attr && !ctrl->opts)
+               return 0;

         return a->mode;
  }
--

Will send a patch

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
