Return-Path: <SRS0=E+1U=ZL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98857C432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C293222ED
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FWRDQ+eN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C293222ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j8UHSgp7N23IeBwRVsKtt7R2WkRhIwkYwmLRh1zBlGY=; b=FWRDQ+eNfu45Gr9UP02SIvhK4
	sawabc5hISq2Q6osU/14zFHukirLslEGRfJuf7nPpdD/RDAsCbb4U5z41tI/z0nqrRzRiRzP3tCKt
	oSa+Vj0fSo5jlgR8GbK/FLkleu18NKNhqL1imybcWIYYEGh/js+skZx5MZVPkeXLHI0kE+ZRlETr8
	pfqevua4DVX4bkOiat3RJByzZnf81Z0fpUeKZcv4FCkTCrp2k8scNKskx4Z1inIht7GSkEvOFPcMx
	AOGyT0Dq+gMVDTmq1LmDPcjIXz5iw82BBeplC6dpIMGRJb0Yn72RxMvtesUNytA4cqP+cEdTAp0H/
	FBsrJsHJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iWsYj-0003GG-BF; Tue, 19 Nov 2019 01:44:01 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iWsYh-0003Fs-0p
 for linux-nvme@lists.infradead.org; Tue, 19 Nov 2019 01:44:00 +0000
Received: by mail-wr1-f67.google.com with SMTP id s5so21870459wrw.2
 for <linux-nvme@lists.infradead.org>; Mon, 18 Nov 2019 17:43:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R/rkDjn/1gGzkg9uVfMR4uDddpNXolTiDd83cfXEc8E=;
 b=WlEhYqOF3VBuyLQ8w3KAjGlWQZX/n7AGtX/ZeKcJQzwPABJp04BE19xPSNliPjNQdI
 6tyvlHDetPrj/OKrz924bW5CYFuxcI1LBJunD7F7JozhcBWC016kmLLEwdlHC1RE82JC
 1L9d8Y9I5rt/A1XsJJggsr4v1hX1Aw6FaCGpQ2UQdvdkvrQxlEqLxFj+DRiQ8/mW7cdJ
 WyS5aqH7tI4/qI2zsKJCmM00Qw/4POl3yAp0Q+jn6/JbC8quMKM0QSRbZc/Qu/vCRZX6
 Xtx42NNzwCH8qaQOiAq7F//XIjaqk+g/9xRGMAaNX8Ng1o67igngxr7ZhfTcH9ucPRpy
 uU7g==
X-Gm-Message-State: APjAAAVO8ZWfRGYPZQabkFE/AVLClIz0iPJV7z8+c7/RuT3FTiIvaBAn
 1rdL1yz9AP3EZEZ9CflYVjs=
X-Google-Smtp-Source: APXvYqzWIpTvyfkqRjcxqWlG/w/0JPDMIGwWb0GvTK0Thn7HtXph0DJt65qBwqX0cs6KD1vwGXxuOw==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr32384686wrw.395.1574127837391; 
 Mon, 18 Nov 2019 17:43:57 -0800 (PST)
Received: from [192.168.1.114]
 (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
 by smtp.gmail.com with ESMTPSA id j2sm25535546wrt.61.2019.11.18.17.43.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 17:43:56 -0800 (PST)
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
To: Keith Busch <kbusch@kernel.org>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
 <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
 <20191119003437.GA1950@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bde9741b-ee3d-7ba7-1fe9-04c919960412@grimberg.me>
Date: Mon, 18 Nov 2019 17:43:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119003437.GA1950@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191118_174359_063040_DE0E050A 
X-CRM114-Status: GOOD (  12.13  )
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
Cc: Jens Axboe <axboe@kernel.dk>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> I'm starting to think we maybe need to get the connect out of the block
>> layer execution if its such a big problem... Its a real shame if that is
>> the case...
> 
> We still need timeout handling for connect commands, so bypassing the
> block layer will need to figure out some other way to handle that.

Which is why I said it'd be a shame :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
