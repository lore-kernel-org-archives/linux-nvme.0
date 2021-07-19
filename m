Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E0EC12002
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:57:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB2A6108B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB2A6108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yJD51oIanRjoHQ2dhjvsvn6b4KGitXnUAGcnTBe3XK0=; b=mCMO1Vru3CqaD+
	YrBA8tzGO1OT/xPZOLniLK5TZZBHg06/QZ6AA4OhommcLrGwEsPFwZGs8zpbvyCPeEXf5xMC5urOG
	UHKl35cYNpRnaYaK3RvVeSKQFS1mDJ7fF/pMDo8Hze1EhaiGFnMtHIk6m/VsUOj/xTEb3gYyoGWIp
	1ckBn/b03Sp58L7AG0WvsMmWeX7fdu6DOi85rp3W+isDUMsxMAL4U5i2tN4gggRv2Gv/BwjbxWbrA
	IAxYxLPYPxFywPkA+QWm7wcQ0TaQDo1IgaP4w7oIN2OAF+PHuf8eFJvKJOxL9XTGt0AA6Hng437g6
	zuPJLtLaNUog5Sh900sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5Q1O-0099QJ-Pa; Mon, 19 Jul 2021 09:57:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5Q1L-0099PQ-QZ
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 09:57:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 526F367373; Mon, 19 Jul 2021 11:57:03 +0200 (CEST)
Date: Mon, 19 Jul 2021 11:57:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org,
 hch@lst.de, james.smart@broadcom.com, oren@nvidia.com
Subject: Re: [PATCH 1/1] nvme: introduce nvme_transport_sgl_desc structure
Message-ID: <20210719095703.GA1880@lst.de>
References: <20210719095309.7777-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210719095309.7777-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_025708_034911_D45F41EA 
X-CRM114-Status: GOOD (  10.98  )
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

On Mon, Jul 19, 2021 at 12:53:09PM +0300, Max Gurtovoy wrote:
> Currently the tcp and fc transports use nvme_sgl_desc structure to
> describe transport data blocks. Replace it with a new structure that
> describes the Transport SGL Data Block according to the NVMe
> specification.

What is the point?  Note that we should probably still clear the
reserved space anyway.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
