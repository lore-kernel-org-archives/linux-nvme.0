Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8000C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+bp/n1eKHvBjRcbJucKpCps5LutFfJymrh0vIJVvk+Q=; b=qfohQZ/xb0dEpxXZhXKJkAJMDA
	yrXNsHzn87oGowyq930OF7fdrLfWQk3PqpqAPwWYmbSRc5762oHTGmX4L4MtF9ja/muMP7JyM6PWa
	jPDLbaa0MOOPqCvVUjRY2GdUPm7umliVMiDynK43WNgFPxGYujkM8asmbyFGPdQl7amuKe2wqYixK
	gDG94JeawW9Ri8uQQRNPDW5P7zSMAWdpWs+lT2y/xu9kyz0l1KDqpmUoa/y4/EhznUF9IyloNkom0
	gjHnylZp4dzWUutVuMECbCETf/YCZHi/LitKMpenDhbXdilGRSdcpKNnGaL7Ta/ubZz/cJIllEFh5
	KBQWCb3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEv3L-00CfXS-Cp; Tue, 01 Feb 2022 15:26:43 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEv1m-00Cemd-AJ
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 15:25:08 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 i187-20020a1c3bc4000000b0034d2ed1be2aso2266957wma.1
 for <linux-nvme@lists.infradead.org>; Tue, 01 Feb 2022 07:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=+bp/n1eKHvBjRcbJucKpCps5LutFfJymrh0vIJVvk+Q=;
 b=wsKAkBDRZAKy9g7eTvGt8HN0mRLaty3XAXD8SUrjDM4490FFqvqQb83soSZ8RnEd/D
 GBWq9xYC8uF6f9uKYD1JKnPcdteaBec4+QHsB44QdEGjTX0BBZ/1CnX8uNc/Zfy6fT3N
 OR5D+lhyOpPuzV494NbJU94K+cCCaeEv/zG//EB3CUZAbAo5a/v3cADHjRHrDU/15+YT
 nUfUE5E+P30X5TpLpRbV0s3e53/59HAybKqc7TPbKKYUlZAl4OP3B1wcRxma0rEb/nTG
 CpRKNn7y0GJtJmZDX+tdhrFKvplzNcC5EHjSZ8VXPWMDMvHJL3mRjVKhRBmeOfdnPppf
 JWCA==
X-Gm-Message-State: AOAM532RSiACwsyiTePOUz25xwuX9S0vwb+gClXnHF8vxFFFDA/8BuBf
 ML5dcVX/emq5fMGA56zmx5eYwpJD4e8=
X-Google-Smtp-Source: ABdhPJwf8knaSeAFrZkYYeHayzrqTAWXqFAMBoksmKR+843iE11jGxkyx+wEmITlUxAut9hvlZOLZg==
X-Received: by 2002:a7b:c3c3:: with SMTP id t3mr2339905wmj.94.1643729104117;
 Tue, 01 Feb 2022 07:25:04 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id p7sm16447708wrr.7.2022.02.01.07.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Feb 2022 07:25:03 -0800 (PST)
Message-ID: <59c5afdf-c7c8-58ea-90d0-83b8edb5b4cb@grimberg.me>
Date: Tue, 1 Feb 2022 17:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] nvme-tcp: fix a possible use-after-free in controller
 reset during load
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chris Leech <cleech@redhat.com>
References: <20220130092119.595854-1-sagi@grimberg.me>
 <20220130092119.595854-2-sagi@grimberg.me> <20220201080335.GB29518@lst.de>
 <654808ec-81e9-0205-779b-7502ee6c5b0a@grimberg.me>
 <20220201135841.GA2518@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220201135841.GA2518@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_072506_432599_9EBDD834 
X-CRM114-Status: GOOD (  17.57  )
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


> On Tue, Feb 01, 2022 at 02:36:03PM +0200, Sagi Grimberg wrote:
>> The driver will make sure to flush ctrl->async_event_work _after_
>> changing the controller state (it is flushed in nvme_stop_ctrl).
>> Only after that it will continue to free the admin queue. So if
>> this check passed, it is safe to submit the aer command.
>>
>> I think that the ctrl->state check should be sufficient. In fact, I
>> think we can move it to the core instead of doing it in the drivers:
> 
> Maybe through in a comment explaining this?  Otherwise having less
> checks and having them in the core is always a good thing, so I'm
> in favour.

I sent a v2 already. You want me to send a v3 with something like:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c11cd3a814fd..4beeb53e33e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4253,6 +4253,12 @@ static void nvme_async_event_work(struct 
work_struct *work)
         nvme_aen_uevent(ctrl);
         if (ctrl->state != NVME_CTRL_LIVE)
                 return;
+       /*
+        * drivers must guarantee aer submission here is safe
+        * by flushing the ctrl async_event_work after changing
+        * the controller state from LIVE and before freeing the
+        * admin queue.
+        */
         ctrl->ops->submit_async_event(ctrl);
  }
--

