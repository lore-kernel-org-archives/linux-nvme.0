Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAFFC25B7E
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 04:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bSvpoSqCY3G+hzzTlubTN67W3/MmqxmMj9cVCEKg4lo=; b=3h9uRSiijWAJqg9SMOicKfM01T
	DWQz4IziTzEiUM/RILb07V2bQtXDA/O8fw9WLYVRK3OcZ87vKAsyV7HRcsIkin/NGisdI/bjyBKWa
	eRPKwahG5ESs/PoLYJAL3LYfCjz4v/6wcOQ2PYaEsuLmcH5AYiwQZuav5JpskEby4zh+iLJZB6o8+
	8FZsPaNMqkI55ZpnuzhQTg8xIPB8SSRvdDleelwCSbda5u6SD7kYbD+bIT5KGGF4DAx7SE9DrwR/3
	3Dk0zA8Zyla6Mj/UhHeTuIClsN15kPdLJrtwn1rb2XPQSxXZ+HQHtW6yFRx7muasTVES0YT/wRI1Z
	dRWQvvRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELia-00000001AU7-33E1;
	Tue, 04 Jun 2024 04:24:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELiX-00000001ASg-2iv2
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 04:24:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E98D568D13; Tue,  4 Jun 2024 06:24:10 +0200 (CEST)
Date: Tue, 4 Jun 2024 06:24:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	mlombard@redhat.com, hare@suse.de, shinichiro.kawasaki@wdc.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH-RFC 0/5] nvme: fix initialization memleak
Message-ID: <20240604042410.GB28748@lst.de>
References: <20240603230524.3854115-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603230524.3854115-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_212413_850262_9B11B8CF 
X-CRM114-Status: GOOD (  10.52  )
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

On Mon, Jun 03, 2024 at 04:05:18PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The pci driver is the only one runtime tested. Everything else is
> compile tested, except for apple.

The highlevel flow looks good to me.  FYI, TCP/loop and to a lesser
extent the other fabrics transports can be exercised using blktests
nicely.

