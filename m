Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D04C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 09:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+weIgB6pep4zE9EM8YrsNldACn7DGcCOmWKBeVdyDPc=; b=SPXrU/S5QqrJcgey/+JbZ8imDn
	dwqj6sxZM2er3l29ciNyR8dcTm+68WT0MD/vUnls9sWGWWJe2N3tEuQaJNM9bOciB3OKmjxDIoDuh
	cTOIcZIN57WTrXUmQjCE0VgaNEL22UJZXbuSiWpJn14BIeC0bUivrLsgAa+3820ZpK+4xTTu+G1rq
	ar7tgZBSP+DcvPCH4s7BFApA0P0Mk9JE8lPGjjaAVLSu12gkCvGPn7OudS4jLE+QZ68diRsubHVTd
	Fgif2rKHMTTKls8ZCLtrp7UuZFcSLs67vwod+JD1fQkbpuZyv7C64RtmMB1wITvO2lpRLuioimvxA
	xHF4+YZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZBr-0026Wu-0c;
	Wed, 24 Jan 2024 09:04:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZBo-0026W3-2T
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 09:04:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2CA7F68BFE; Wed, 24 Jan 2024 10:04:54 +0100 (CET)
Date: Wed, 24 Jan 2024 10:04:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, sagi@grimberg.me, linux-block@vger.kernel.org
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Message-ID: <20240124090453.GB27760@lst.de>
References: <20240116232728.3392996-1-alan.adamson@oracle.com> <20240118072419.GA21315@lst.de> <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com> <20240123090506.GA31535@lst.de> <7d7d7855-8a37-4de1-a32b-2edf0b53a05c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7d7855-8a37-4de1-a32b-2edf0b53a05c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_010456_942740_A12623CB 
X-CRM114-Status: GOOD (  12.07  )
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

On Tue, Jan 23, 2024 at 09:25:51AM -0800, alan.adamson@oracle.com wrote:
> I get it, but there is already an injection framework in place for nvme. Is 
> there no plan to improve it?

Injecting fake I/O error really isn't the driver job.  For block
I/O we could do it the block layer or DM, but that's not something
to add to random drivers.  Error injection makes sense for testing
the driver itself, not applications.

