Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F0CC43331
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 08:33:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 172B8206F5
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 08:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EyD4W3rI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172B8206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ajhiEygqklJGtURHehnjhz1QOLcVcg2aQ5oo1nZkMZw=; b=EyD4W3rIcJ02md
	WmrT1fqYo8OMF9LnJlQikXk1lk/ctQlx8mZz7mFwZjzUTdmg36i/RlQKy+R6M2EG5RcwzvrfNz8OS
	jlqf2FHbd8WGAYhbhuxhUfTI4LkIdlr6V7+zm9oSh7/hIbAQ5qa0CICJQoOLdP8fJMNwuBp686yPn
	YxZNyMP2F4he3DM5M41Xb/QYCj8czIVHeC8gUHoZpx56VePAPwSuPGAy4RKzu9GrtwVHtuxmVLDl+
	2DPNkW/w9Bg9DWB3bei2aFIVgOtPe53yRHf1qph7CDmAZsVOaHMCC7rmqbMV2kaON7UVtAwLe1sCu
	wqnNJJU6dHRuW7YwwLHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJYo7-0002BU-3I; Wed, 01 Apr 2020 08:33:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJYo4-0002BB-JD
 for linux-nvme@lists.infradead.org; Wed, 01 Apr 2020 08:33:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4E53768AFE; Wed,  1 Apr 2020 10:33:01 +0200 (CEST)
Date: Wed, 1 Apr 2020 10:33:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v4 1/1] nvmet-rdma: use SRQ per completion vector
Message-ID: <20200401083301.GA30082@lst.de>
References: <20200326181512.58053-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200326181512.58053-1-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_013304_785227_03C49C95 
X-CRM114-Status: UNSURE (   5.11  )
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
Cc: bvanassche@acm.org, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 jgg@mellanox.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme-5.8.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
