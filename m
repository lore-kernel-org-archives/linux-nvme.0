Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFA4C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 06:25:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD7C6512A
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 06:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD7C6512A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=55pmJlWOpQEKUb3tauKtezQWGf8YprHiiPMpoHQRj6s=; b=AS2hIAvpXnKFtSQ4Tv7KA+d6o
	Y9xgEJ6aLnLuhK3IY5sAmXS45YjyJ+P8/AdaNqYaH7HDEPPgCp93lkEkiTJVM3iABJjJyjbkBzn/a
	qJpC9NfRy6CZ9sKTs5M5un5c7/02gXqh6oXr/PR9Q8br2xuBsts0v54ZSY19XFau/YK16Nk/5iLwg
	2STcdnPRwf3tbH0zle3VzKVe4QBstu42rTcJ3nyX6A14QAUPcUqU/+7f2la568dNxzgXYfvbPOM72
	Vm22oVFiRplTxYdlxO93A14wkrWfgFA8OntK3+uIL2Dd5YL7TQzywlxCgdiNVkgmjiFfjsh5eyGBu
	4/ESbvK3g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM38l-00HWN9-Lh; Tue, 16 Mar 2021 06:25:15 +0000
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM38g-00HWM3-De
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 06:25:12 +0000
Received: by mail-pl1-f172.google.com with SMTP id z5so16473711plg.3
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 23:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Oki2GfJKqKRENCr2h9Az2XkzYNX47g6g3fCktpCEJQw=;
 b=P/mcp4mct9heK8Zw0gH2iZnr8+mXhO3d5g1JmsQeFL0X1bUrnjMZn+0yfjlhE7oIdq
 nzfTEuzxg37FRJRvQQ63kG26vI/xVWT5V1ztEUxHAuAGt/FOVfcGtEunO3hYWW8Wztsb
 XMrd/E7fhdgfTgRFScMdZteNHN5HT/S6kBB0m+NYZXzGOlciuJw0gA+BHwC57v2u92WY
 HKeIw81Q75YXH3FGVr2rbJaNFhOH+qQ/Lkg+g6X3O9bqoHWAiXvPKMH38DHhUndNqodE
 7hhoCnlbUe5+m+uJjU/nT/hO3jTDml6mnK+rjtSKhT/T5Bf8//VaIlDeZLCykb9YOn4o
 2Gxg==
X-Gm-Message-State: AOAM531fLJvWX/zWZiOozVsJEj+dSwfyaHMBdQSamzNWREIH4uw5g64h
 y3/y7YUFquZTH80GpDeH3BM=
X-Google-Smtp-Source: ABdhPJyoPf75cZSg4/uIth3U8j3Fwq/Fcqs2VyvRlf+/sdvbbWee6LyOOyl168nGRWFHRDwoMvT0Tw==
X-Received: by 2002:a17:90a:c08a:: with SMTP id
 o10mr3174717pjs.67.1615875908882; 
 Mon, 15 Mar 2021 23:25:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:52e4:89ef:d916:a3a6?
 ([2601:647:4802:9070:52e4:89ef:d916:a3a6])
 by smtp.gmail.com with ESMTPSA id r1sm1610861pjo.26.2021.03.15.23.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 23:25:08 -0700 (PDT)
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <7d552635-6f95-fca4-b0ca-709967465495@huawei.com>
 <3a172ebf-eeb8-b7a0-4eb2-099fa74bc1c6@grimberg.me>
 <c4df11c9-8d93-add1-396d-b8380d050a08@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b3094a96-85a8-ef92-9fc3-daecdf683c42@grimberg.me>
Date: Mon, 15 Mar 2021 23:25:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c4df11c9-8d93-add1-396d-b8380d050a08@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_062510_514698_4241DAF9 
X-CRM114-Status: GOOD (  12.71  )
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


>>> We also found Similar deadlocks in the older version.
>>> However, with the latest code, it do not block grabbing the nshead srcu
>>> when ctrl is freezed.
>>> related patches:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/block/blk-core.c?id=fe2008640ae36e3920cf41507a84fb5d3227435a 
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a6c35f9af416114588298aa7a90b15bbed15a41 
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/block/blk-core.c?id=ed00aabd5eb9fb44d6aff1173234a2e911b9fead 
>>>
>>> I am not sure they are the same problem.
>>
>> Its not the same problem.
>>
>> When we teardown the io queues, we freeze the namespaces request queues.
>> This means that concurrent mpath submit_bio calls can now block with
>> the srcu lock taken.What is the call trace of ->submit_bio()?
> The requeue work or normal submit bio?

Both.

submit_bio_noacct will try to get the queue->g_usage_counter
(blk_queue_enter), will fail because the queue is frozen, and then will
block until the queue unfreeze will wake it up to try again...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
