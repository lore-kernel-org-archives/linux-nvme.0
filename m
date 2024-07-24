Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D889CC3DA61
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jul 2024 13:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hrQt2G9liBqFBpgTUCYyqsHiDikHFaSYrCKgCrw7u+Y=; b=h3I8wyyXH3kSmjmGduZu1p68BJ
	++az7LikZu+2VkTp72v0BmQ+WTIghrSWAaeowvcEhCnzT1zFSAZ9Ow1ZRJlOha21HeyPyjp9FzvUz
	C1rosbXrg2cHAumA399ACKvAYoUXWXEFvFbvLdmosZJvnW/drvAiup5hTMX4dHyjZlUhmyjoXv+0O
	+vXLgXAwjEn5YIoglOuPMiwy2we7bIM2v1e4dmHJ7I1LbRdM0eq0eXN/mSgR2Mg9MmvR//WQuUErQ
	GQwfnuYzAA7dxbNhMfyjMyEXfFnCb7H1ayKip52QFTpsjlqEJemNvJMmjC6C4TpMR7OKRk2DPOFdy
	Hs/fwP4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWcFj-0000000FTmZ-1msj;
	Wed, 24 Jul 2024 13:41:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWcFf-0000000FTkc-3SPr
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jul 2024 13:41:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E753E68CFE; Wed, 24 Jul 2024 15:41:52 +0200 (CEST)
Date: Wed, 24 Jul 2024 15:41:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH RFC 0/1] Add visibility for native NVMe miltipath using
 debugfs
Message-ID: <20240724134152.GB12516@lst.de>
References: <20240722093124.42581-1-nilay@linux.ibm.com> <5nwflcpqoyknrruzdlvgnt5bpcoxh6nrirjwnjes4oazkr7nai@uwsynbuduibr> <831af264-7f8a-495e-99b0-51f294e0948f@linux.ibm.com> <dpwafli2lwjlita6pcxwg5ilvxbqm4c4tckjcawhzzwfqywpow@o47xxyrwcmmw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dpwafli2lwjlita6pcxwg5ilvxbqm4c4tckjcawhzzwfqywpow@o47xxyrwcmmw>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240724_064156_034872_A200EA0C 
X-CRM114-Status: GOOD (  13.49  )
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

On Tue, Jul 23, 2024 at 09:40:55AM +0200, Daniel Wagner wrote:
> debugfs might always be available. IIRC when lockdown is enabled, debugfs
> is not available or parts of it.
> 
> I'd suggest going the full way and add expose the relevant information
> via sysfs and extend libnvme and nvme-cli. But this just my take on this.

Yes, if we want to do this properly sysfs is the place to go, not
debugfs.

