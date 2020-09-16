Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75734C43461
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 07:12:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20752206C9
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 07:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U5Hi4+Wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20752206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FOxpD5HKGO0jkTh8Neezoftf7MP4giwohcuQk6M/hUQ=; b=U5Hi4+WxFan+r3qLxlrCMDDF5
	Opd6JSDo8iRh5Bjh8jVNQI6rfrIqFj6ADdyU5OAsM1eGoDJ43LowAgEIEqtEA/vEC/m+FMz6uxVLb
	eUAKZxmVQUNhqUSp9rorWHB6sIRQJKmR9oB7veluhZBjMTo1Df8WOq6bqFMCry6pjrtCHuKaSZ3sY
	/xIfKncDvHVBMT095HVHZII1K2DyO0FZj0vI5k/w8t2EmYByixbOYzeRZ2Qxs+Smfr4q/eGWEaHvP
	wOnMbg04pWHvEwEmYM6zKQ0kCDnWrNuEi/4MjUiFWY/E+wUWjNBFYk4V+l9DnSAw35jVFyhGDZShs
	h0rQFpnFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIRcV-0005YG-3T; Wed, 16 Sep 2020 07:12:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIRcS-0005XR-Rz
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 07:12:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4A67068B05; Wed, 16 Sep 2020 09:12:43 +0200 (CEST)
Date: Wed, 16 Sep 2020 09:12:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 7/7] nvme: use consistent macro name for timeout
Message-ID: <20200916071243.GC9592@lst.de>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
 <20200915215118.3934-8-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200915215118.3934-8-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_031245_012980_7B330276 
X-CRM114-Status: UNSURE (   8.15  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>  	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
> -				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
> +				      NVME_ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);

Please don't add over 80 char lines.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
