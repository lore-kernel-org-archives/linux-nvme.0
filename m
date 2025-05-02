Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457E7C3ABA3
	for <linux-nvme@archiver.kernel.org>; Fri,  2 May 2025 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+qCAMKnV//dUbW+Ni1trzjHVw6NA0vr67chOouckyBE=; b=ci6FvDpuD7rq07TJD1KUd5utb8
	UtEAyxm44ufMaKatIQPxaC6kr1ueayM0vk6BqaxO/gFZpfekmcHZva+z9lCgreHDDgrEJHdqX0Dh9
	mDST3GJZ91HxndkthIlFk5zGMP/QjJXyABjCsEJ0cpLF1AD8Fke9Xur3dvyv1dpGywj90xpIQ++CK
	LFV4UyZhLepbTTVhwfF+fG8SFJSC8GD12dkW5zvue1f9+h+pLJXe9lgDxvaAtzWhN3C6EzVuGzj1R
	DHhyu0JRLOb7ejMvnCm6uRQ2gZfZcv8WFE9CAr08Q4XnMsBkLvKvq2vjKnHxjJh02IYBcTYCIp/Sp
	3E4rlNFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAnhc-00000001b8m-1ZWx;
	Fri, 02 May 2025 10:33:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAna0-00000001YdR-3FTW
	for linux-nvme@lists.infradead.org;
	Fri, 02 May 2025 10:25:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F86C68AA6; Fri,  2 May 2025 12:25:06 +0200 (CEST)
Date: Fri, 2 May 2025 12:25:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Judy Brock <judy.brock@samsung.com>
Cc: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	"hare@kernel.org" <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"wagi@lst.de" <wagi@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 0/2] nvme: handle partially unique NID value
Message-ID: <20250502102505.GA13055@lst.de>
References: <20250414090959.2015-1-hare@kernel.org> <20250414111916.GB13225@lst.de> <3e6fb1f6-d6f0-4f33-9389-dff37daae7b0@suse.de> <20250414114128.GA13822@lst.de> <PH0PR84MB1358448342C273E7C7BA808898BC2@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM> <CGME20250502082359uscas1p1e2a9858dcc9200ab1d1d863c4495fc0a@uscas1p1.samsung.com> <eee8de0a44074dd3bfb0fc6ec425b647@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eee8de0a44074dd3bfb0fc6ec425b647@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_032516_952505_0691581E 
X-CRM114-Status: UNSURE (   9.60  )
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

Judy, stop it.  HP could have trivially asked Samsung for a firmware
update and gotten it in the time they used all their commercial channels
to fight actually having to fix their intentional stupidity.

If you are a supposedly legit enterprise storage vendor and ask your SSD
vendor for a non-standard data corrupting feature you have to admit your
failure and fix it.  And I'm amazed how HP is trying to flex their
commercial muscle to get around not having to admit their failure and
fix it, and I'm also really surprised how little spine you folks have to
play along with this.

This is very disappointing and does not make you a trustworthy actor.


