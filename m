Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF81C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:56:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24C2206DA
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xDZeww32";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gnf7TH3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24C2206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LSL4W0o/s+CLPl6HX/xTKPKu+Y0iAqsamV5Xj6JtzAs=; b=xDZeww32fg6v5Gg0asR7B/P9Z
	GGKkqoZOdWgdbD5Kh/KCVtH0pyM0Jt58guXVcppNIkZGyzIQ4FteibIlwMWwbtE6HzYDHGdpZLgmo
	q2NaeUmZk4J6ZzktKdjdDT8VhI1ExDDWXalDpDQROCR8FPcKtnyFCdKCsTSddMMFAn8U1f/sBvaE1
	I0traUb+Q1UXUGQ1GpQFJuLP/rIumSSVSVPZFKzGWGyLMV6muB/zvCtbAtQi0I3oKesiiwi+aTNn9
	2CcqaQcQbXq2Vt7MsyS5cLhfEB/c3illX7WkryQ4S27G+QFGuN7GR8cmloJvbe2PWof5wpi5tAbY5
	mXzjW1fGA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6c3i-0000vv-Ok; Fri, 14 Aug 2020 15:55:59 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6c3e-0000vR-Qh
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 15:55:56 +0000
Received: by mail-pg1-x544.google.com with SMTP id d19so4724436pgl.10
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=uIr3MSGLAcZ4hlniGb2suvHlL9y/uuYSH/664pgjiaY=;
 b=gnf7TH3bk0IwhabgDM3d74cFotOwdbYzNY+IhMZIeWZs0345phynEQnCZmErTjUq5W
 rtyY5LkpBdgmi2hOVSU7OMBBI7dDT0xIOzbT3096VRN8wmWP7yMqSeAAtR4FeMvsNfMQ
 Py5OeWGTJmrhbC3Yxl7n7COJpl+adoULc5nxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uIr3MSGLAcZ4hlniGb2suvHlL9y/uuYSH/664pgjiaY=;
 b=qiWSARQH9FJnzE1PWXDnIwPhDA0NQMwj+3ZCImbVkb8SSVR8EqPJaUtrB6f+DhiebJ
 gqwYGBVngdqnHN/O4/zuppPx4pLQH8l5CowdOozEFMyMPtiVD2W6O1TyL8dKTyHAnG9x
 Ye1Cg2NndEHnM6qiY9WvHCDUVSvrLog4HrAzj3C5nhTh2hjeYZLL2YHOa3xok3qw2Jqh
 yE7WNAMCirYQG2zrLbDEflShj+SsVnRufotqXCidg3/Nr8olnwPc7m+QG3bVaD68DuIG
 kfcEMfcOlpNMtEK8CyyfCaC1SMoQ4wUHLlZL0McpLs86qUT/k1cQT+Z7natLrmNDz8d9
 2CvA==
X-Gm-Message-State: AOAM531GmNwAZ/3qsJONHhu2vr+qKCJcMuaeHBnqtbCFFoWs9LKnp++j
 bL/uYP7W2R7M8KitXT4yaQ4Epbam02tduQ==
X-Google-Smtp-Source: ABdhPJyJgJeHdJaVffghesWmVcJjbXupT3PAz+tK2x1Rw44FEXmie1i/qiPOB6jWhHSKg0GgDLcH+Q==
X-Received: by 2002:aa7:9f5a:: with SMTP id h26mr2294296pfr.114.1597420551316; 
 Fri, 14 Aug 2020 08:55:51 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id b15sm9382061pje.52.2020.08.14.08.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 08:55:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] nvme-fabrics: allow to queue requests for live
 queues
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-2-sagi@grimberg.me> <20200814064414.GA1719@lst.de>
 <27f60468-269a-34d8-9e51-920106c3a139@grimberg.me>
 <20200814072202.GA2429@lst.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <4a229e46-c5c4-95f2-2144-b3e2033f404b@broadcom.com>
Date: Fri, 14 Aug 2020 08:55:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814072202.GA2429@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_115555_098450_C7F5BEB9 
X-CRM114-Status: GOOD (  17.75  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/14/2020 12:22 AM, Christoph Hellwig wrote:
> On Fri, Aug 14, 2020 at 12:08:52AM -0700, Sagi Grimberg wrote:
>>> Which will still happen with the admin queue user passthrough
>>> commands with this patch, so I don't think it actually solves anything,
>>> it just reduces the exposure a bit.
>> The original version of the patch removed that as well, but james
>> indicated that it's still needed because we have no way to make sure
>> the admin (re)connect will be the first request when we unquiesce.
> Is that whole thing really a problem?  All the pass through requests
> are inserted at the head of the queue, so how could something else
> slip in before it?  If we have a race window we probably need
> to use BLK_MQ_REQ_PREEMPT or something like to force executing the
> connect on an otherwise frozen queue.

It wasn't connect I was worried about - but rather ioctls competing with 
the ios to init the controller on the admin queue. Had really odd ioctls 
getting in immediately after connect and before controller enabled.

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
