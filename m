Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3B0C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:36:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D2892075A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="piKrBMAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2892075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=piKrBMAEntJX5Ofs2AKhWGT0A
	2E1wvuFNrz47/cj4XmfpAypQEXLDwCCl9NCVOwruWrL2pputc7MmGhQc0IZluLRRnNV/HGAeHRIBo
	yhN5vXUxy5PYjEjJQWaYCuRtJUxQfXSe5lU6NoSEWW5+gWFydpeoN2TWOCDDoJTA7yUmmmrMVN/4C
	axqp5L3UIuKgdjooam7InEJCg+FtDcdgl/YKOWac11rUnxaanwHj1UKhjH3UTxUqpzkynHBpgReBc
	RYYSOumU7vHtUnxn3JhguurdGR3sCEBVd1I2SypiC5zQdKiplSpCmQ6uZCx/nN2klada1W4BYjVfv
	WkaSVxdew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNB7s-0005Ka-GF; Tue, 29 Sep 2020 08:36:44 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNB7c-00057a-6E
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:36:29 +0000
Received: by mail-pg1-f194.google.com with SMTP id d13so3278207pgl.6
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Wob+QFrocgyTHmIrLtjYZ7uJD6XeOaWWO5J/SljQ68NBUcJkCoi/cJw1bh24HyxN0O
 rs+2ZQKo16Jkm1bxzGjdnhZniEOqiQzaU3/yKnV+Rffkxu+2TUBCNMQDxgE9dds36uKz
 lBWecatqBYIMIxnjkKv9EXpD3TD5sukiAXUD3WPyAKYIOaYwPjj1mpDW0a6V5OUX+q9q
 t5tjve83u+7qIoe2MAfumO8eTGSh+c2CYQ+iuaCK47YCp3Ef8GhT9ri96jiM9mkL49w5
 E4Dxa1PGzgtldZjAWJRUcLMONFc/U8fViFQQNQVU9aigmJ+cIi6KJZa1df7obPD4K7M4
 iPIw==
X-Gm-Message-State: AOAM530aQT/VxYo9oZGaj+reFuLMa5llZ8OLvd1/fSqKKtDlpL4SfFW6
 mb/6g4Kl7ygu6sK2mCRCrrw=
X-Google-Smtp-Source: ABdhPJyGYhkChghXBtUd3ZpdFQ55a/lxzFC4Twcu/9ul4yxttNuNDjVXzTasKPsQh9gB+aQSJIe7pA==
X-Received: by 2002:a17:902:b189:b029:d2:8ce6:f4fb with SMTP id
 s9-20020a170902b189b02900d28ce6f4fbmr3400521plr.70.1601368586780; 
 Tue, 29 Sep 2020 01:36:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id bb6sm3733175pjb.15.2020.09.29.01.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:36:26 -0700 (PDT)
Subject: Re: [PATCH 07/20] nvme: lift the check for an unallocated namespace
 into nvme_identify_ns
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-8-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8574c225-e849-2827-d338-29375bf6cd02@grimberg.me>
Date: Tue, 29 Sep 2020 01:36:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928123502.435373-8-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_043628_268348_895FEC31 
X-CRM114-Status: GOOD (  10.65  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
