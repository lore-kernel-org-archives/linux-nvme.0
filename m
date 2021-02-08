Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47CDC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 23:44:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1B564EB9
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 23:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1B564EB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=jJw6G/mmBSvwVd0BGC8Ch/zAD
	BF7DdyBwofJ7UWlBgoUuen+NN8OL/nuqA/TqIfScRKo4JLrB7gQyPwHEsZQ6/EYK1Zyu8CUh2lPqZ
	wsRm0Px+38a9QPOHjzItjmJvOVpILETFX1uupimYQiXUAnciwFGICKE3eGstNQPH/ISegB5t7Mffd
	hOQbThDJqY7U9BuUxVR7KeTd8QFueqyLpBDmSMS2zD5ztH4UMEWDZLbGd93b5BuFX6SMIsKEIuksj
	h0PURK84m7r1RtVfjz5+TZyZKrA47VCfHpx51mYP0ma/OFiutniGRpyRcpS1Y26ybIHeS9/rmvlYf
	YYYn5rgqg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9GCo-0004xK-GU; Mon, 08 Feb 2021 23:44:34 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9GCm-0004wt-5o
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 23:44:32 +0000
Received: by mail-wm1-f41.google.com with SMTP id o24so634821wmh.5
 for <linux-nvme@lists.infradead.org>; Mon, 08 Feb 2021 15:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Luxc8IUoddl81kUWJl5SjiAxwf0Uj0u3c9Q1UTCQyEs4exe7CXHKyL5EBDPoSle7mv
 YY3AJPZSmwKwj7lPcqHPLcHQAN/BjQbedSRjWlqq5uWxpIxZ+JDO2UCucDRbghk8gX4+
 pyUzVjJoA5u13aJniIu+ibMEBEPzrlCzujIrYTDOPZ8syx5kqR08ym68swi9rGVeNn4s
 C4/OcaPoHuFHeecP0a+uiAVDMUcJKgXhuVsSBN81Gos/GfS/vs2+lJtfHB/Kp4VFk8zx
 r2wBu9YP5H3EYUqRtRPhJOuuna3RxuRgFZcBxLFNjBm+fCi4BvZIkreJfBXVk2pIFkZZ
 k/kg==
X-Gm-Message-State: AOAM533NZDLMTmoqW02730S27CbSfpVrMLNG0CnrFDoYbJrOEbILcZTH
 Gs5VvH4FAiu5M9/JVOeazd7q0aBEn1o=
X-Google-Smtp-Source: ABdhPJzPkWUEUBO6ipppVaUv0m7IHQXhdum8nGrbnjYsJdpVp1HLRcp3ltmOkYt+a/Ey5JpW7EzjOA==
X-Received: by 2002:a05:600c:19c8:: with SMTP id
 u8mr895833wmq.59.1612827870662; 
 Mon, 08 Feb 2021 15:44:30 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5?
 ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
 by smtp.gmail.com with ESMTPSA id n193sm1242788wmb.0.2021.02.08.15.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 15:44:20 -0800 (PST)
Subject: Re: [PATCH] nvmet-fc: add a missing __rcu annotation to
 nvmet_fc_tgt_assoc.queues
To: Christoph Hellwig <hch@lst.de>, Eldad.Zinger@dell.com,
 Leonid.Ravich@emc.com, Elad.Grupi@dell.com, chaitanya.kulkarni@wdc.com,
 james.smart@broadcom.com
References: <20210207162028.2959778-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9c19e150-add6-a6c6-0b2d-4f0758d75826@grimberg.me>
Date: Mon, 8 Feb 2021 15:44:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210207162028.2959778-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_184432_243148_B37E878E 
X-CRM114-Status: GOOD (  10.42  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
