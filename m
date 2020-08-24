Return-Path: <SRS0=kA5W=CC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ECCC433E3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 18:30:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85383206BE
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 18:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r8c4k11e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85383206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Cv5mblkdlmJ0rDy0c7xfbB4zMQL9foEdO3xQLuUPi4w=; b=r8c4k11eqIB3fwMXzauKSuo90
	q0Cq6hvKLrCyxMtfXqhZgV59hXEPkXEzXfII67pw8jgHpgVDjIoObigMu0lamohqDzTX6aGQLeU75
	O1s/eOXM8N/iQrivzO+Hr3xMqzTxgSniZ05VAzUAK8XN5knfTobcsA01Q/Q9TDftJs32iVVEUZiRi
	pon2EJR+mSCrURZdUgIQeccqC++6Cq5qMR+RqyW1DJqRLE+rZvFQnCa2A2MH3fK59Z5s1dgV9ozjG
	HLoWQSQ19J18vAdjWt18FPcC8rjFdQE0KGm5b0mvpA3n2FRLxoDo1M7DNzDOZTbTsSCzzr1p4w2n4
	WyexU8PyQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAHEJ-0001aR-Ff; Mon, 24 Aug 2020 18:30:03 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAHE9-0001Za-2a
 for linux-nvme@lists.infradead.org; Mon, 24 Aug 2020 18:29:53 +0000
Received: by mail-pf1-f194.google.com with SMTP id m8so5289513pfh.3
 for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2020 11:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y+PlZp4x1Qv64r5fKC5sfqFMPylhns024/I3WvDzcUk=;
 b=SmzZ69jK62nDgSGhxvNqLsmVEbjhz+SLH8RvtwO4e1ZtFxsaJsxEFyVPonxzw6DMRx
 h3ZMa5vncvcPhIoWchDZuoOXvKRyT9jDEXPOmrdcYOZzoMihPWJdjL6NJj8T8T40QLM5
 Dbm5j0Iw42nxwldma2TqAAakth6+kc/j/MMcCv6+gjaFoP1ivqKRBFtqej0PXGOiR6DT
 sJVc2px49tqbcCDIbmKYDLbhQqT3zrBqF43I+y14MBIYDjTIjoq2uUKkEoHMmDwHQeZb
 rabfnDZcOtbrVe2A3Jo05U2hu05+4vZzl5DrgpGROI/HQo585n/Iqmp5aZY8+vFMCUOV
 6ELA==
X-Gm-Message-State: AOAM532eRCZ20PVOHkXxIGCFfKslH337a230U8TsxnPDcHfill25D9ks
 bOa3dyMzYOva/aRNiAc5bYg=
X-Google-Smtp-Source: ABdhPJzUjhS15TYmRUTgNM6HYnzsG0c1eWzcprRhfkS6aUgTMUlbzpkr2AKv6YEu17udq5ZxccOrHA==
X-Received: by 2002:a17:902:b402:: with SMTP id
 x2mr4449005plr.97.1598293791966; 
 Mon, 24 Aug 2020 11:29:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d?
 ([2601:647:4802:9070:cda6:bf68:c972:645d])
 by smtp.gmail.com with ESMTPSA id a66sm3920274pfa.176.2020.08.24.11.29.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2020 11:29:51 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] fix possible controller reset hangs in
 nvme-tcp/nvme-rdma
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
References: <20200820053651.197057-1-sagi@grimberg.me>
Message-ID: <5490be43-8be1-3c98-de3c-40b5323c10ec@grimberg.me>
Date: Mon, 24 Aug 2020 11:29:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820053651.197057-1-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200824_142953_200609_2C53B068 
X-CRM114-Status: GOOD (  11.77  )
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

Guys,

Given that there is consensus on all patches beside patch 2/9,
can we get all the rest in and specifically take this one as
an incremental step?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
