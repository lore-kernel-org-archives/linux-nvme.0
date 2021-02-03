Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271FBC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 15:57:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB2864F65
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 15:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB2864F65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xCvM2eRDmBnduo/syeYQSknABCTpfYO9DZ4lz6yvO3o=; b=SsE6HSnHphK3ojyDc1K7Pc3kz
	bcU0jKHmU2Ni0wQoAON8/KWU4dpuF0bS9geGxnlT68RmERir9G7E5hSPM/0B+qPvpSIltH5eQAdgf
	iz+UfR6+n+vsQOXpaNXL6oX7gqJTX/HWiER+Ihc/ixUJsDzBkWILSAVx4sTwxYc8sM8mWK2QtYz0c
	izIUVTaFFhvUGL1YO8/apisespmX3Lb4cI8kq97ElNctNf6XzZu95hU3dRm9gqJkpAEcmioHADtbf
	YbCPwRnd5F7ZPDCNppPm4HJqmLUvLA7Tietw1VPtudf7pusAYrdkerYeUjqCKuAA60HRifgjyXBoP
	ywjfryM1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7KXD-0006kk-Tb; Wed, 03 Feb 2021 15:57:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7KXB-0006kA-9r
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 15:57:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E8F5468C4E; Wed,  3 Feb 2021 16:57:32 +0100 (CET)
Date: Wed, 3 Feb 2021 16:57:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet-tcp: Fix out-of-bounds access when receiving
 multiple h2cdata PDUs
Message-ID: <20210203155732.GA2785@lst.de>
References: <20210203092025.437839-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210203092025.437839-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_105737_491610_C74ADCF9 
X-CRM114-Status: UNSURE (   7.78  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme-5.11.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
