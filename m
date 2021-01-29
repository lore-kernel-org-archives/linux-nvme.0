Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B57C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 00:07:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C5264DFD
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 00:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C5264DFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DI9sCA/YMVlZrUCV3HAcBp8Y6kbZiJokIGu5ApQhwI4=; b=VGfVgtQ1PIZ260pk2jqaYUVHV
	4HEiMhr1KrGITN6yK5QsjrTZfm0mlaWh92sfyCkZCT7cxpF/THQ5ZRfosCLbH087tR4VXiwJ/0YHd
	7fbbyI1/jP+nrsaI/ADHx8BRVHMwHuhIlgob6O+MtlmTx3gvaEwVOeA5h/2vTV5P76BUiLuyV30HK
	5+amxmc27fSKnOBDvT+2fJ8FuOkVrXo4f4xJCldQEPyYYS+0m32Qwz5qokwmXp73emcNvpguv9JuP
	tfmhn5FfSCsyqxrzTvBYFMlMtm/D/OK1zG0UHlBbjdJFSgBCwJnjiew16CQY0yn5YlXBcX2vSiLj9
	08RXRvUkg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5HJv-0003La-Ho; Fri, 29 Jan 2021 00:07:27 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5HJt-0003L7-8n
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 00:07:26 +0000
Received: by mail-wr1-f54.google.com with SMTP id 6so7151880wri.3
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 16:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qFcP9lKbPVbRWdCdJ76bNgYUpVhBWqkZyfsResOusyQ=;
 b=aBVc2X1saBaWqlG1Wst2NP+ApUbSgWiZw80vYZqnbkwY8dNNgfw/v+/uu2jCtwnbBX
 g1k6DxR0kk+DjemznmrzFgPS0hiynhIOPtI2JgKdSbjv59Ly7Li9XQ02c8T9H9JrXq3i
 HrLvmwMJ77wLunrqhTu2Pp2ohgNgrNcqStu++qnVVgK1RDkE2kUHMF7Rww8n8cYMzvM8
 FcyCZsEkq+COP8gBTchJXBzTmQ0++cLSdDC8v+gwBf7mi52w+IXK6TxdasjTmiCsuBep
 7OGF6GTWmTcSd19bTY5zaxuEuNO3aB6/HarBrBwy17SFmDC+l+H6BTwjGpFgG8Cq0LR+
 ZIdA==
X-Gm-Message-State: AOAM531bpLFEPTGVs77JhQMKVJati6WPWMDvjpdUU4aPaTpq0/KGbIto
 H3CWM1Lx38Qmpk48LLj7fQqL7T3d5Bg=
X-Google-Smtp-Source: ABdhPJzWRbsVsNKuV53af2eQvuo/cesx/Tui0okkoUVOCBmYw9qEVgvg4CPAFi2vw8sJ09wzWAOM5Q==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr1626340wrq.132.1611878843815; 
 Thu, 28 Jan 2021 16:07:23 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id p15sm8988130wrt.15.2021.01.28.16.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 16:07:23 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
To: "Grupi, Elad" <Elad.Grupi@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210128152758.114112-1-elad.grupi@dell.com>
 <2c2a3aa6-ca43-e9b0-7928-28c6962ea1bc@grimberg.me>
 <DM6PR19MB40113530FCB4DF6F52E8C752EFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
 <9d974783-dc05-61b1-902e-a0cbe13199f0@grimberg.me>
 <DM6PR19MB401116F68376949D24B6803AEFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
 <53c6c0f6-99f7-ca1b-c205-05f7a03c1785@grimberg.me>
 <DM6PR19MB4011CDB6E299B8EB3F25AC0AEFB99@DM6PR19MB4011.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7d9dca89-c57d-73f3-aacd-97262f6b27ad@grimberg.me>
Date: Thu, 28 Jan 2021 16:07:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB4011CDB6E299B8EB3F25AC0AEFB99@DM6PR19MB4011.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_190725_349436_DB428D86 
X-CRM114-Status: GOOD (  10.18  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> That's not what I meant.
> 
> My concern is release_work races with accept_work.
> 
> nvmet_tcp_alloc_queue is called from accept_work context and still accessing the queue struct after setting sk callbacks.

I see, we can move the queue_work to set_queue_sock then.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
