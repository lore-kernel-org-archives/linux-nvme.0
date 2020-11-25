Return-Path: <SRS0=cokh=E7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31A2C56201
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 16:23:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127B32067C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 16:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oEZlODXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127B32067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=oEZlODXQw8g7pown/t/Fo5X9b
	CCcymSMDv2GQXN3RA2r3QOshkZr9ZgQtDRHEwNmPoR+tmPeGXG7+WOLtncE9kCQsTZByAJgMJ+YuR
	cRT37lkG0GObOVG+LCaD18drc6PtlOIXmc/uNcXnUYO8noOQgOL5YHiRF0PgsH+SplDdLl0irAy/F
	hyxv+chndoOLrZnN/mAdzOFLB6PykZEdvJptyjGmlJRHTrG2NlNhSw7vflWhsuYVKHffC5TJvvkgh
	VfLpbCcNnTcFfKV+aQQMfkmAmfklms7ACBseG4+mbj6rYCGvaWt5SKxzXgau9zgN8WxzVOrlfVQ1k
	NY47g9wxw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khxZz-0000ov-95; Wed, 25 Nov 2020 16:23:39 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khxZt-0000n8-BQ
 for linux-nvme@lists.infradead.org; Wed, 25 Nov 2020 16:23:36 +0000
Received: by mail-wr1-f65.google.com with SMTP id u12so2507946wrt.0
 for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2020 08:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=ainRfuwgzwwhd3QGiezYQ3176ParXTSfoU50r+LiRchfaLK1Nu5gR9xHk+f3ty5t3n
 BRdX4i/eShuA05FtpCFyLTJQP0TlvEtP/9RQ65YxqFDRMYAnBf5/7n0Os0lI9zzT/000
 ao+JRVLVc4cb3jgCD55TrCBYGYOiTjvmySVm7692eI2j1JZ2hgzWWsfUAZZesOIO8Lg7
 1P6IJlQ99NCB3ZvhougtB9zUJ7aYms+vvmTVypEHdem1Co9KjEzc9Qx5AtLSwc/kxksP
 oBya6FRdAOK7ALawMihkgo1CcvReXY79Y+Qa9X6bUGJ/myeKZHApfXFFHdMzzY0LMhmp
 Q8Lg==
X-Gm-Message-State: AOAM531jyuDEvV2Nyl4lTdqCM2+qqqJNrSQTUIdKKTwCnBJ+Vp9ElgOJ
 UZ+T02LlqZhBKFiK+eUK4UE=
X-Google-Smtp-Source: ABdhPJwQzsq6v+na3PTjkxe3S/z4CsWNB08ShyoasN/9c3aWcLh1DWiY0Z7OWuxVfJx8Vke/FbRUQw==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr4937772wrm.259.1606321410955; 
 Wed, 25 Nov 2020 08:23:30 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:117d:a91b:107a:b504?
 ([2601:647:4802:9070:117d:a91b:107a:b504])
 by smtp.gmail.com with ESMTPSA id q17sm6578133wro.36.2020.11.25.08.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2020 08:23:30 -0800 (PST)
Subject: Re: [PATCH 1/1] nvmet: make sure discovery change log event is
 protected
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com, hch@lst.de
References: <20201125122736.4423-1-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e4bc685c-ff83-2196-f637-4a6517a5db99@grimberg.me>
Date: Wed, 25 Nov 2020 08:23:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201125122736.4423-1-mgurtovoy@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_112333_532115_0FDDAD94 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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
Cc: Israel Rukshin <israelr@nvidia.com>, oren@nvidia.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
