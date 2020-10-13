Return-Path: <SRS0=D3oK=DU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6763EC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 22:23:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA7221D6C
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 22:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ikQQRmnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA7221D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=ikQQRmnf+UaUaJ8//uMlduQu1
	/S9nRwwQW3FMcH0WdRDcx7BdhhmVBSdrm9iuyUr+aicSyUZ+7DOcIkblTKQaVmjzOv4GnVJx0T7Q2
	NML2aYp0fdlGAtJgjTg8mDryjQ/Z7B3Y2kXLItjoZQ3BYnPNQAEiexeZ8VWW6S39/W0edCSsRmKo1
	TKH17N50RTVhJ2l6aggYF+pnibfu0vdGmYussxZGXfB6aaapvnHR2qv5YL1rMa6kMFTcZun4D1OCS
	B7QtSCiowS5j5KMRfAIl3zgC7QzrGCjxrABq1ZqI0BwgrdmGmQO2G9xu7muVel6N9VUvNOFg6TVH+
	k3KQa6Qeg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSShN-0001Wa-19; Tue, 13 Oct 2020 22:23:13 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSShK-0001WD-Lq
 for linux-nvme@lists.infradead.org; Tue, 13 Oct 2020 22:23:11 +0000
Received: by mail-pl1-f196.google.com with SMTP id 1so682251ple.2
 for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2020 15:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=qqVQpVvxqrMmd3SsEe/7ujisjsTOfakrTrZgtEQToTb0C+ENFwyJosup/Q5BpsehOc
 53De1DiVM0HqSA2ojArCERrCjeyr15rn4XfISZ89GsGsbt3CLLseKuW5WMu4cTN2L5pQ
 El/mTzko5V2O5Shjl1pcpQ0ehXWezer9jhgxEj1PNnO7EbPnDuVo9IxH1j6qked5oR/L
 seIUPdK92Rcw1kYZeOkt08Mwo98Z4G7wHKlcUZualjG963uKb9guJjIt+vsF4tNCQT7Q
 WpE6uYMZOtm7WDId3tn5Mcr3Xfx9Ba9yRvoBf6bfMxpxUPaCuPItnalFHn5a5Md3/HXf
 ZkQg==
X-Gm-Message-State: AOAM531TAs6QLPszLrwq4tzhiF4AJvn8yGHtA4M0n0Rw2cbi6PwEDisY
 8x6AIDvzXpnv4L2AA6FQ1Qc=
X-Google-Smtp-Source: ABdhPJyHyEBIYgutMGh5hfDPkON+kFZlfoPXqjViBHybT/a496uxnp3BmpoLkh98ON818zg66Dq7bw==
X-Received: by 2002:a17:902:9347:b029:d3:7c08:86c6 with SMTP id
 g7-20020a1709029347b02900d37c0886c6mr1748163plp.84.1602627789232; 
 Tue, 13 Oct 2020 15:23:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5a09:2d7:19f0:1ee0?
 ([2601:647:4802:9070:5a09:2d7:19f0:1ee0])
 by smtp.gmail.com with ESMTPSA id p19sm659553pfn.204.2020.10.13.15.23.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 15:23:08 -0700 (PDT)
Subject: Re: [PATCH] nvme-rdma: fix crash due to incorrect cqe
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20201012085537.2599-1-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b42c0b68-c1fe-1e14-e887-d157a919510d@grimberg.me>
Date: Tue, 13 Oct 2020 15:23:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012085537.2599-1-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_182311_030388_B5A45CAC 
X-CRM114-Status: GOOD (  10.17  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
