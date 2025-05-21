Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367DDC3ABC9
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 12:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kTn3sODyYpJcLIy9xN/sIjbyPXUhOGN0hq2uMvPSNs8=; b=JSQWzmMMJA0HKCrclKWz4Lkv2x
	DscLSaImxoh6DwjjzeS1wqIytrnetOXIPYb4vQAQMyswPJIr/AdaQDsrRbpRZ+jlvsrkwflVOSixx
	gaancQehONJf/2zBnR+xrgPgcUoCzbDAiey2/fXOeznpA3Ry7fMNFcZwu5tOTEUR5rMZiSq6dkggZ
	JpDSbRhLUntsv/oM7skFXF/zMTR40RqVYHwTllY92iQ/PRe979v8/mwqWN593qN+dWHp172g6PCwg
	SEopdsrCwdhBFvlhMosMIi/gZ2V0vjWoVeja1SE47Byon4tt2EEuHztEGqr4Dsocz7PXPT9eqIRZ2
	HK3HW+gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHiso-0000000FpBB-1IcM;
	Wed, 21 May 2025 12:49:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHisT-0000000Fp57-1nsE
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 12:48:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0C9EF68B05; Wed, 21 May 2025 14:48:52 +0200 (CEST)
Date: Wed, 21 May 2025 14:48:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
	kbusch@kernel.org, sagi@grimberg.me, dwagner@suse.de,
	gjoyce@ibm.com
Subject: Re: [PATCH] nvme: avoid creating multipath sysfs group under
 namespace path devices
Message-ID: <20250521124851.GA30983@lst.de>
References: <20250521124137.99939-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521124137.99939-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_054857_612888_CFFEEF1D 
X-CRM114-Status: GOOD (  15.39  )
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

On Wed, May 21, 2025 at 06:11:23PM +0530, Nilay Shroff wrote:
> The multipath sysfs group should only be exposed through the namespace
> head gendisk node. This is sufficient, as the head device already
> provides symbolic links to the individual namespace paths it manages.
> 
> This patch fixes the issue by preventing the creation of the multipath
> sysfs group under namespace path devices, ensuring it only appears under
> the head disk node.

Yeah.  Looks like we should still try to rush this into 6.15?  I'll
tentatively queued it up because the pull request needs to got to
Jens tomorrow for that.  Any expedited reviews would be appreciated.

> +static struct attribute dummy_attr = {
> +		.name = "dummy",
> +};

The double tab here looks wrong.  I'll fix it up.


