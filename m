Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D22C3ABDD
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 07:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D+ihGTgUFJzllZ/tVjd1xPZ4KjlprXQB4zgnYGbWYKE=; b=qjUS66S2SR4Z8p/XnX0GDWwH49
	ELE1yfzjLYI7SzYf93H8vUl0Ju6RD70OQR2WeHgN3uFOwdAVNnbV1jIjqHApdZ4aSwwuSJOxXB30A
	lZNCBJrF7iTdzWqDdqxecVZl0z3WNRu5TYMqXrl8B5vQV5B07y6VEIxzppaXFV3pc05ms2adMnXBA
	3kVVxFzFPb+ePQDuJ9muKGqQR4gOkfA381kOhVY8RP2QFdyiw1MpzoiJe2DqbepUf7CZ+uj+IVjfE
	qEYX5me0hN59+CTJtRUbqSUT3NnZ/x5UYNz87gc8EdBgIaK27QXMikRAOVjOhZD71yzPUI7kGoUWp
	yrsu7+Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFpIM-00000002e0v-0Vuk;
	Fri, 16 May 2025 07:15:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFpIJ-00000002e0b-48wM
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 07:15:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D273E68BFE; Fri, 16 May 2025 09:15:41 +0200 (CEST)
Date: Fri, 16 May 2025 09:15:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shminderjit Singh <shminderjit.singh@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@fb.com" <axboe@fb.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Junxiao Bi <junxiao.bi@oracle.com>
Subject: Re: [PATCH 1/1] nvme-pci: Add quirk for Samsung PM173X with
 Subsystem Vendor id:0x108e
Message-ID: <20250516071541.GA15458@lst.de>
References: <20250516063059.3456399-1-shminderjit.singh@oracle.com> <20250516063059.3456399-2-shminderjit.singh@oracle.com> <20250516063632.GA14830@lst.de> <CO1PR10MB550564E355727779E441B7558393A@CO1PR10MB5505.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR10MB550564E355727779E441B7558393A@CO1PR10MB5505.namprd10.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250516_001548_168930_2B1D6780 
X-CRM114-Status: GOOD (  13.08  )
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

On Fri, May 16, 2025 at 07:13:47AM +0000, Shminderjit Singh wrote:
> Hi Christoph,
> 
> This device is widely used both within and outside the organization. Applying a firmware fix is not viable option. Since this is firmware specific bug, I am adding a flag for OEM specific devices only.

The general rule is that for enterprise devices we expect you to fix
firmware bugs in firmware.  And skipping all IDs suddently for an
old device also seems like a really odd bug report that you did not
even manage to explain.  


