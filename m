Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6E8C433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 15:54:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9AF92065C
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 15:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZfpTl5ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AF92065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=meQdtnDjHBBY63t2Nh3UgVxRddlBsqUNLXjoceuM2+I=; b=ZfpTl5ubt4Ybj7rnTqDfqGayD
	JtJm2UGb31tFRk0O49LhTBYaPcrASexg6MrEAGsXurLQmT3dS30g75ASJ7+jrmd0KPBodh5FTUBWj
	gNFjoNPSQtrDpmYxRuyjqDb7PRzaEh3877q8hd9r39Qm7JRnOkZHxRolEmOnp35/tOlfUjrGQI5O5
	gUZC1syDCUJiEPn8kcufbjkU/sNx9g2zJWGnuA1Gm2UWrFRyKr4yTS5m9GSvh7ZbHi1yMGm9jEOKA
	lgDjUc16CJnZR3H9VwDWG4/sU/z1WGwSqQuuMTt5/tl7x9qBXsUCAQdATaxyxnem8xDdmTRwBQwWJ
	mCDXIk8Aw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Rvt-0007L5-2C; Tue, 28 Jul 2020 15:54:25 +0000
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Rvp-0007KA-Th
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 15:54:23 +0000
Received: by mail-pf1-f170.google.com with SMTP id w126so10988779pfw.8
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 08:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PuvyQKl6IN0K1xUvFJPL3tjF90uWhHuXGiow6Yt5hho=;
 b=i2YDJVGm88+0Oe/fDVf0vAiZlQkslVRjgI7NPfFtwPa0VnQki667pM5axWDzo9t57n
 m1ubDBf+6osucew9xiC8TE58LZ7gAvnCkJVUV0T+mIFk1qIosnz8r6iUP+ce690XeNPZ
 sZtHnEaOHus1OBfFPYCWEftYoG19OCFkwtX3GbzKzpdT7rcU4ALqOnlDZhQ/6y3zeDPJ
 1TVpWpWsFH28FY48tV8XDttD58bzLxmxnvzC8ohzXLQ1H3LwLiCOtzMDgTcQzP0vnxdy
 8lYoXKHl6IunaArvX7t86I1Aydx9bwB5I+EIpUCrQn1NE8ny/xfRV76aXupFOMh9eLGO
 DihQ==
X-Gm-Message-State: AOAM532zsgqMCeI0332/mgvFI31jAada/qBg08fZTsi0OGNCnTI8IGbL
 FeXfmzI1S5AJfkKRRdd4j5w=
X-Google-Smtp-Source: ABdhPJwVx0Wnxh6BshbpWcWLGDPZ6R+UDvlrm/5lFjVEdYxP8IrhsUvn6yYDelqKjFg6Y0Vh8E/wiQ==
X-Received: by 2002:aa7:988c:: with SMTP id r12mr24796197pfl.194.1595951660726; 
 Tue, 28 Jul 2020 08:54:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id n12sm6783846pfj.99.2020.07.28.08.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 08:54:20 -0700 (PDT)
Subject: Re: Hang at NVME Host caused by Controller reset
To: Krishnamraju Eraparaju <krishna2@chelsio.com>
References: <20200727181944.GA5484@chelsio.com>
 <9b8dae53-1fcc-3c03-5fcd-cfb55cd8cc80@grimberg.me>
 <20200728115904.GA5508@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4d87ffbb-24a2-9342-4507-cabd9e3b76c2@grimberg.me>
Date: Tue, 28 Jul 2020 08:54:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728115904.GA5508@chelsio.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_115421_980712_A575F94F 
X-CRM114-Status: GOOD (  12.05  )
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
Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 7/28/20 4:59 AM, Krishnamraju Eraparaju wrote:
> Sagi,
> With the given patch, I am no more seeing the freeze_queue_wait hang
> issue, but I am seeing another hang issue:

The trace suggest that you are not running with multipath right?

I think you need the patch:
[PATCH] nvme-fabrics: allow to queue requests for live queues

You can find it in linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
