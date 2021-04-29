Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C724C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 04:53:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE3A61450
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 04:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE3A61450
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hK+ZFQMGiKWZcmRIG+2/Y+HRTo7CjakygBFHmOqWh8U=; b=CYJ+Cp0Uz8InouGL9WKGGr15Y
	/Qpm6Rj6OLQ1YGFsLZhSjmkDstl93d6N/pOqaU+HVhFF7YsgxCO4N6LTVtyxtwOJaPBmlNr2dDWex
	+dYJfjGZTV/gs+LncaeGt5puBrcao4SRY7jjM8nzKpdsof2ew+LMP1KyXUd46EftlkfzPMnFeIbRL
	nauN3bL+dTVA/MIBS13PLbdQ4HPPikdrFoj2wsm2ESCd5BD3UHMQodwvzcRehgEr6K3bKImlIzgxH
	uaAx9/f5AcwwWstTp4bFcI38MQ20mJU5dMcupGU3ScOjjOg88wOh623k3jqovAG7lUyfwBLR4vHau
	tnovUpE8A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbyfV-004v8X-R2; Thu, 29 Apr 2021 04:52:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbyfT-004v8O-6M
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 04:52:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=CrHgwFrW7PDuK5dznS89v2eh03yZqG2OFGrkm78wsWg=; b=PMahOGhJYdebH6/zUspbsOg5bJ
 LSvoDiQC47id4J0hmYMkspJx9o4r9KLkPLpLGJUFDtuTy1b9blIfg9b4ohjs3VbCzxWnbTbJpp5W7
 Wb3Jtd3+dI4b3ecm1VXdgRLGm6im9+4TRLGf3KL22tTsdtgBwgaxvKoDeJ/e3Yq2xrIKKMydrMqUw
 7U9hTwM3abuUzSk50fDr2pATu8WIHaiVFrtaCTBSp64/kMoC0Cr8kmgUJBA5TZOIpP3a4V71JbkXA
 L7sXHCICGfwQKEtj59ZmWnbSwHNjsKoMi8LWUlVCX/t45xB0n9bcrwN8f6l9Iw37gFit0rSYKiO8v
 wzG1O8vg==;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbyfQ-000N8F-31
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 04:52:49 +0000
Received: by mail-wr1-f48.google.com with SMTP id a4so65377858wrr.2
 for <linux-nvme@lists.infradead.org>; Wed, 28 Apr 2021 21:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CrHgwFrW7PDuK5dznS89v2eh03yZqG2OFGrkm78wsWg=;
 b=pbgDxa8WN+l8FVG6E9ILGPCrNPc9GLSpWfr2su+P9Sw7NgMLzglkDqH/9O896Zl8n9
 FU6z+HQtF0LMdgB+saeW+ho0De66rLlgcDNe9zWPUvr0JRvzaJinpVUGlPO+AMG1/Erk
 OBsIwZE6MAbhjVAMnmDIdVroJytHgcdcSDSwdlKimcZqU+64cr2FgEavsvCu5i9Ov/QF
 a1syAKTu+ul3o1M2Ue6QG8fRBI3EPu0K6lopyDCOetPxGc1T2MWiRMeJIwffoJ4Wst52
 geZ677whGZ5lbgNDJZkUnf1ar4MyYqPE0m3WbiwNamFqcqKcF1YK0oWl2K4F0YQ7M1/7
 ReeA==
X-Gm-Message-State: AOAM5301rtGzzyeOvYSalM2to137vswqeWtTMkaxUK/by6+dhjDUHA+D
 oosGjDtS4VKOKly2RMJ1DbWuaQoznCI=
X-Google-Smtp-Source: ABdhPJyI34BTqpiy1YaguL9U2Pw/95k8sOybOOSFCb0KvjrWgXCy7/WS1CCFk4Iv+83r7HwogP1e4Q==
X-Received: by 2002:adf:e510:: with SMTP id j16mr1439455wrm.28.1619671965805; 
 Wed, 28 Apr 2021 21:52:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:caa1:f76f:3865:edcb?
 ([2601:647:4802:9070:caa1:f76f:3865:edcb])
 by smtp.gmail.com with ESMTPSA id o1sm2981353wrw.95.2021.04.28.21.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Apr 2021 21:52:45 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <20210407195319.GA30623@redsun51.ssa.fujisawa.hgst.com>
 <8d8c5c82-f1d3-5599-ae3e-5af5ff12eb9d@grimberg.me>
 <20210427233956.GA631292@dhcp-10-100-145-180.wdc.com>
 <549e4f57-5f6e-d5ed-db63-8f82e9a7490a@grimberg.me>
 <20210428155847.GA21854@redsun51.ssa.fujisawa.hgst.com>
 <00a3b480-2885-b32b-139a-ef68ff21bad5@grimberg.me>
 <20210428180147.GB21854@redsun51.ssa.fujisawa.hgst.com>
 <500074cf-c0e8-807b-5b30-a3474d37700f@grimberg.me>
 <20210429033328.GC24074@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bd3c39f9-3768-7494-e63b-7baf9ad9b615@grimberg.me>
Date: Wed, 28 Apr 2021 21:52:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429033328.GC24074@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_215248_161466_A5D5E0B1 
X-CRM114-Status: GOOD (  16.04  )
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


> The driver tracepoints captured millions of IO's where everything
> happened as expected, so I really think something got confused and
> mucked with the wrong request. I've added more trace points to increase
> visibility because I frankly didn't find how that could happen just from
> code inspection. We will also incorporate your patch below for the next
> recreate.

Keith, does the issue still happen with eliminating the network send
from .queue_rq() ?

--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index eb1feaacd11a..b3fafa536345 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -288,7 +288,7 @@ static inline void nvme_tcp_queue_request(struct 
nvme_tcp_request *req,
          * directly, otherwise queue io_work. Also, only do that if we
          * are on the same cpu, so we don't introduce contention.
          */
-       if (queue->io_cpu == __smp_processor_id() &&
+       if (0 && queue->io_cpu == __smp_processor_id() &&
             sync && empty && mutex_trylock(&queue->send_mutex)) {
                 queue->more_requests = !last;
                 nvme_tcp_send_all(queue);
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
