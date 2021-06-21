Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07255C49EA2
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 06:50:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9D561153
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 06:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9D561153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mNONhistHLfmRV+Z8cMN/tls7ZYZMRmmoJ1lbfjdtiw=; b=PHgrJN8U4/s4ZC
	X6qk9WlfDXTdsUaMsdS4LFQhalh2KYD55wrnI0s0lHPId0SyfchvnjNNyJm3lrttcmiLs6if5eWGi
	TKJNhEULYhuE1ssdz4qzofSCnZap0oaeDMmeiCcPLpbUh61IkYGw77zqGF+HIbWrcravX7ln6qvr7
	c0saWzShylyTAWJb5TJncQad56uDDKG4YKXb9JoeTOD/uMX8YVsOPyOANei42gqXOnh99onrzKTFw
	G7UTl87DMOFsPlO4weVI5/STuRgke1gRSSyoXTQ3cqZ5+onrP69xxp2i5NATGOSwVlcJPezwwv6uL
	KEmFgfuy8IIA1SdLmZIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvDlN-002PKW-S0; Mon, 21 Jun 2021 06:50:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvDlK-002PJO-OY
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 06:50:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D4CF168BFE; Mon, 21 Jun 2021 08:50:24 +0200 (CEST)
Date: Mon, 21 Jun 2021 08:50:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shai Malin <smalin@marvell.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, davem@davemloft.net,
 aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, prabhakar.pkin@gmail.com,
 malin1024@gmail.com, Dean Balandin <dbalandin@marvell.com>
Subject: Re: [PATCH v2 4/8] nvme-tcp-offload: Add device scan implementation
Message-ID: <20210621065024.GB6019@lst.de>
References: <20210621051046.28783-1-smalin@marvell.com>
 <20210621051046.28783-5-smalin@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210621051046.28783-5-smalin@marvell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210620_235026_991573_EBD18FAD 
X-CRM114-Status: UNSURE (   8.76  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jun 21, 2021 at 08:10:42AM +0300, Shai Malin wrote:
> +static inline struct nvme_tcp_ofld_ctrl *to_tcp_ofld_ctrl(struct nvme_ctrl *nctrl)

Please fix all these overly long lines in the whole series.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
