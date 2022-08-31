Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44589ECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 04:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bc9/3RFQ3/BYv5GKcvhxJWM/+fz93rvd/+K14B4oPhk=; b=tdo7awS5As0wTwqOlFACFegDIb
	KmpMgg457D8l3O2fzuFWDNBwEpOkANM3qhjztY6aoVGRqmrRWj5u+PMsdeKQpdEnDSlqxvxyMG5X9
	a+dPxrJT9vT3PV11hrIgNKZ1pHddwLzmcawxdY4rgKyfz4GsovV0N5j/KxbvSHUr8x0qeZvt9ZMLI
	CQdL2IbWWICbOZpTtMdDkq2lOyPmZ5WYZqa9AuCA7xMf6XkypYM+FxT6LL+NbtFV+Wy2gKRo3h1tl
	K5cpJ5e7cLnQgCThZCw2aIy2Xf3U0Ez73hE+NMdVxicjdTgg5FS1E+6On8+XqJNPyk2Sbveusjzmw
	88qHsBqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTFon-003oDt-LQ; Wed, 31 Aug 2022 04:59:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTFol-003oCa-Lb
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 04:59:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 002B768BEB; Wed, 31 Aug 2022 06:59:08 +0200 (CEST)
Date: Wed, 31 Aug 2022 06:59:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Tal Lossos <tallossos@gmail.com>
Subject: Re: [PATCH] nvme-target: add missing goto in nvmet_setup_auth()
Message-ID: <20220831045908.GC18042@lst.de>
References: <20220824072316.44389-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824072316.44389-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_215911_856287_FE37F7F5 
X-CRM114-Status: UNSURE (   8.81  )
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

Thanks,

applied to nvme-6.0.

