Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C899FC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 17:44:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966A620768
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 17:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fZWWRXYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966A620768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8DrWrynXLE6PDysWwRPdisrpOVFLELn6EjI1Dk24jAQ=; b=fZWWRXYg8+mjK3mPCkbZfnWXG
	HpTGtg+kDrMSsS0g5bueGBf7m2yczDSfXzB27r8yKITpH7VJsPCxMByDDrzGA/1vajDQDs0/r3Rp8
	h1WRsMYeOS5b8yjucsS4PuCpkmvUUoh2jCymIeXQ+GjxqQAbCUSsVZn7Gwv2ktWf05c+dyKFYqxLk
	JdvFY2xWh8lyuQRDbbliofBhzK8tRYdqqzORmPwWTFzcgkUL4DI3Uou1gCmRgrjM/B4uqwGaAPtvt
	PTPo77gZAxcV63LMGc75SqG1St0UfgVGoicD4aISbu/HnZ9tygRzmIYIpKtjSIpwPL/0RP/dO44q2
	Rov5JGtVA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6dkX-0001z4-FF; Fri, 14 Aug 2020 17:44:17 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6dkU-0001yh-V0
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 17:44:15 +0000
Received: by mail-pf1-f193.google.com with SMTP id d188so4895031pfd.2
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 10:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fWFuYTJqC9rkuibyrHJcQDAS3jyBCGpQV/kBCTUIe94=;
 b=a4eNXDGL/Jt/it1Tr07ft/uviC4Sglo4JYrzC9s/0mpTuSLDHn7Pbp5BhGhvE4AMf8
 gnJqRNYvJzVQ4a2L9Cn8pwV8749szkPdfvZWeo8NOTvOXotW3RZcDHVvdbUnbI5j1Ns7
 Py8xcrMERK9A6kbH8/ypdDvQq4VamlbcLflkPOiEIizC5UupHA7+vZoiAd7Okb9ZhU0N
 0vfSOM8q2pOIdG6UiMaLd6UxriAgR2MH1DQrb7vVUSYjlx21zHBr6V6rsu32g0WJgMD4
 tkhIvptKyGqNgbNOQlbLsT2yAMwpytVMoXy2g24VThY0qX06AZVubYVZkZbNW4uJYQaV
 xftQ==
X-Gm-Message-State: AOAM5304dZJXKEbnZFTVr4W7TdaiHFXSiUBFC4cqK7qy1HFmsCKNDrzz
 za6ctRV+L0NE+n569FjkAxo=
X-Google-Smtp-Source: ABdhPJyPZcRJpy5TouzY8bBa430UZwwaPvWb3BbW9kH1Ug1Asy+9ksUce8bOyKs1QFgTwKp/2yay3Q==
X-Received: by 2002:a65:538d:: with SMTP id x13mr2461766pgq.33.1597427053869; 
 Fri, 14 Aug 2020 10:44:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id h24sm8778658pgi.85.2020.08.14.10.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 10:44:13 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: Use u32 for nvme_dev.q_depth and
 nvme_queue.q_depth
To: John Garry <john.garry@huawei.com>, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de
References: <1597419265-68122-1-git-send-email-john.garry@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fd418829-251e-9ef6-d121-98556df9300a@grimberg.me>
Date: Fri, 14 Aug 2020 10:44:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597419265-68122-1-git-send-email-john.garry@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_134415_058916_A8C8069C 
X-CRM114-Status: UNSURE (   9.95  )
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
Cc: chaitanya.kulkarni@wdc.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

queued to nvme-5.9-rc

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
