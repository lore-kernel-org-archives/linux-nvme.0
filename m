Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5AEC4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 06:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hi5kv2ysi51++scfT82rvI+jO9Yz8/XQsIqgrQ4C2Gs=; b=OKXQKHvtm/GhzUaSyVDyhXuyoD
	+0M+gLNKSjGEKfmAHQ7s3mADv1Z/IUrH+XtS/bRVKS9HCdgZ4PIr9UGtqxQRvXUEBstz+V3MFaBVR
	Agyke1434YFBILY9Mr8uscA1WqCPT+c9WsViKWCdeSyB/9uVSei+IW5ASwjBDfNIGAjvoCDPvnRei
	wpqsF6RzQaccd9nRVaqUmcplVCPEVDNry01i1TidzLfppK08RBzdes1Dd2zLNj9FnMNpCXwVXnicm
	CsWBSZaDwhTy9MWCJMxkAEVdlqs+pcXzFcTqrNTTuZGGpzOyFMxQM8DOJhaX3zsWR9p9K5NxadIU6
	1xAQz8Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQH4-00000004RkV-0Buo;
	Mon, 12 Feb 2024 06:58:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQH1-00000004Rjv-1qlX
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 06:58:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D2BA1227A87; Mon, 12 Feb 2024 07:58:36 +0100 (CET)
Date: Mon, 12 Feb 2024 07:58:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH] nvmet: remove ineffective initialization
Message-ID: <20240212065836.GA17561@lst.de>
References: <20240209083935.5094-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209083935.5094-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_225839_640419_03A03FEE 
X-CRM114-Status: UNSURE (   7.56  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

s/inefficient/superflous/ ?


