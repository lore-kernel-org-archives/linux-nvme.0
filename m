Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00C3C83F27
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 06:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PPAyovCfTVge4QutQxVaKQQDTGhN0+tsgi0FBh7izzI=; b=JMXBlFvPHm9lTSS49esELBqJI1
	O13dtpPyarDJPDJGm0GNLyCH91+sjkPluIMVnQmffK/JDqt4aIg1sh3s+aqNS+NDGKRhNnPxobPEq
	yf8H7b0z5sXaJ9HedO76+EtxuGwJg5sULICqTAW3OCAxkJ+sUust2c+NA1NDeuCY94Sl00tF6SHIW
	oJkcAg3cq8tnnEBIFuhHsksa4HbS/nqtSSa6adbbhG7ftbmTECC0HILyhcAGYj/b0bxmsL91tTwqF
	6yVvfVeQ6DKFaxFtFie26k7hmGOwtLsbzgUIHb5+sqTrkR4UCYqxuHrzhnAtpVdSushYnTxbv0EOf
	X0It+/ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6W6-00000001QjU-0yJm;
	Tue, 22 Jul 2025 06:30:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6W3-00000001Qj0-2ltD
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 06:30:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8FE7C68AA6; Tue, 22 Jul 2025 08:30:15 +0200 (CEST)
Date: Tue, 22 Jul 2025 08:30:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kamaljit Singh <kamaljit.singh1@wdc.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v4 2/2] nvme: prevent admin controller from smart log
 fetch (LID 2)
Message-ID: <20250722063015.GC15013@lst.de>
References: <20250721173700.4153098-1-kamaljit.singh1@wdc.com> <20250721173700.4153098-3-kamaljit.singh1@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721173700.4153098-3-kamaljit.singh1@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_233019_843134_E14B1F3B 
X-CRM114-Status: GOOD (  13.88  )
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

On Mon, Jul 21, 2025 at 10:37:00AM -0700, Kamaljit Singh wrote:
> Similar to a discovery ctrl, prevent an admin-ctrl from getting a smart
> log. LID 2 is optional for admin controllers to support.
> 
> In the future when support for the newly added LID=0 (supported log
> pages) is added, GLP accesses can be made smarter by basing such calls
> on response from LID=0 reads.

Umm, as pointed out last time, this log page is prohibited for discovery
controllers, but optional for admin controllers.  So I don't see why
we want or need to skip it here.


