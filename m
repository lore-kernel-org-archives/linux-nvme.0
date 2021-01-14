Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE89C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:15:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E0D22ADF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E0D22ADF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wD47QmP3aZC54V0VeuyiSIWgizymzlQRIqht6JrlamQ=; b=OxIMufH3kIqm7ICClzBV7pNMm
	YWDmPHHkJuAFY+EJu9WfSBokz74qcEVCUrSoyCzyuAHsdY+ZkIB2Uldt50Cmd2OSQds6dOjIBtZEd
	xj9giXfOdsLOV18H5Nlr9yESr8nPPVcmAVvmzGXYVhlNAGqs1QspERa05JGIPEAAh6mWEBVpyLZfT
	rTbtALgFWDBfIlP2m6UCZ4qgW00HRvpXKz9DO/uFiiOAOaBEUC2spTl8PUehJbQ94Q5tKd6p4bISq
	jhN/IZkOFAhnbiMEpmEZnXD2kpnDJh6qq/BsQwc3JCBdR2CpCmJ1pdVBV5SCCtl4r5pX7SF9xuIgo
	km9GkNKXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzrES-0005Qf-A1; Thu, 14 Jan 2021 01:15:24 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzrEQ-0005QF-AF
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 01:15:22 +0000
Received: by mail-wr1-f44.google.com with SMTP id 91so4070640wrj.7
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 17:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HpDa92VyY+NpVo3LDCW2e6BPIh0kPeop2rbu7VPSth0=;
 b=Bfu2AHLch9wBYHya/464J8eyqQg2+T9OGuX7gwB4OuItCTckSufOGviVnm90txtMaY
 VJQ7gpNg4nSyVJghpqcH9P6pHdZtmwLnVORQvY6SiNrJi8jp4LC1LJLrmyiJqlgdVqk4
 /YBeg++0cwSK0vV1JdRrxPKeaQBElPB/V3p4vl/WeJnYgPNxLOuT9hxGwtPEEFNt9/45
 hlTQ1Um1JLiqxyWdcILZmjtPu+z7V10P8MCep25KL/xd272m3RDQ7MssjCempJtkl1cg
 BaI9NCCbvlXD1ao7FAq2x7R59r3PVF/KDGdudDO3LiTlibRdx4sIMK3GWehwCrnWEswJ
 kAnA==
X-Gm-Message-State: AOAM531wdJGBoO0tATxRDEtM93Dk4ORyukgP1bk89v8RAKN6qEs3YPEU
 /iDMcQ4jj83NCq6zcTGfX/Y=
X-Google-Smtp-Source: ABdhPJy7eVE08zfP4yYI4qZFLQ+UqhJ+iB24PMC7fz2KyBEXVUI8D88NJXG+EDOJCym/2bgy6BBsWg==
X-Received: by 2002:adf:a551:: with SMTP id j17mr5097079wrb.217.1610586921308; 
 Wed, 13 Jan 2021 17:15:21 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id r2sm6073472wrn.83.2021.01.13.17.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 17:15:20 -0800 (PST)
Subject: Re: [PATCH] nvme-rdma: avoid repeated request completion for
 concurrent nvme_rdma_timeout
From: Sagi Grimberg <sagi@grimberg.me>
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210106063635.7452-1-lengchao@huawei.com>
 <002e7d37-433c-f8fa-f460-bfb2447d6bc0@grimberg.me>
Message-ID: <8a5b4b58-98be-4da1-a769-dc173d2a3be0@grimberg.me>
Date: Wed, 13 Jan 2021 17:15:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <002e7d37-433c-f8fa-f460-bfb2447d6bc0@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_201522_370466_7B262888 
X-CRM114-Status: GOOD (  15.04  )
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


> On 1/5/21 10:36 PM, Chao Leng wrote:
>> A crash happens when inject completing request long time(nearly 30s).
>> Each name space has a request queue, when inject completing request long
>> time, multi request queues may has time out requests at the same time,
>> nvme_rdma_timeout will execute concurrently. Multi requests in different
>> request queues may be queued in the same rdma queue, multi
>> nvme_rdma_timeout may call nvme_rdma_stop_queue at the same time.
>> The first nvme_rdma_timeout will clear NVME_RDMA_Q_LIVE and continue
>> stopping the rdma queue(drain qp), but the others check NVME_RDMA_Q_LIVE
>> is already cleared, and then directly complete the requests, but the
>> rdma queue may be not stopped and the request may be already completed
>> in qp and wait treated, the request will be repeated completed.
>> Add a multex lock to serialize nvme_rdma_stop_queue.
> 
> This looks reasonable to me,
> 
> Mind sending one for nvme-tcp as well?

BTW, I'm assuming you mean use-after-free or double completion when you
are referring to repeated completions? I think it would be easier to
understand if you just say that completing request before the qp is
fully drained may lead to a use-after-free condition.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
