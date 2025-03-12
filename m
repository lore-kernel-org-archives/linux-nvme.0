Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61447C28B2F
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 15:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jCMKibseP4KFSn0ywhPyrWZOEKM611o1ZzvPtJMJlW8=; b=2Gi6+TpcM8JLZR6qx9U15MVivy
	eJ9F4/wNHTM0v5BmICHUfvSKwbKi0ag7fBR58l0utHsMVN/I2e0idpu/5NtiIknrgYCtccScsDA0d
	ZqNyiW0vBIZATJtlILO11eYVP0d+bthpkz5PcTWisuezF+2e1uBZvnX9cfI0a2mQU7uRUEi3KLq1V
	8MqXmBr0vdSKlflFLhb5fbAoKdpVjPI5esJ1ZQsOG+DZDq9qbznOsbpkapVBeq1Ry+dylD55GJUht
	0ERmM3usCZXFkumF5lxhIs9dIHC2xrS98xTntDwNutp4maQl56AepyRVWzfYDFas/sS49HgaGS3Nv
	JWhdu/RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNjT-00000008nbp-1oif;
	Wed, 12 Mar 2025 15:10:55 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNhu-00000008nLt-3CA3;
	Wed, 12 Mar 2025 15:09:18 +0000
Date: Wed, 12 Mar 2025 08:09:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Hannes Reinecke <hare@suse.com>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Networking people smell funny and make poor life choices
Message-ID: <Z9Gjnl5tfpY7xgea@infradead.org>
References: <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
 <Z8cv9VKka2KBnBKV@casper.infradead.org>
 <Z8dA8l1NR-xmFWyq@casper.infradead.org>
 <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
 <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
 <f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com>
 <d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz>
 <7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de>
 <Z8iTzPRieLB7Ee-9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8iTzPRieLB7Ee-9@casper.infradead.org>
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

On Wed, Mar 05, 2025 at 06:11:24PM +0000, Matthew Wilcox wrote:
> Networking needs to follow block's lead and STOP GETTING REFCOUNTS ON
> PAGES.

The block layer never took references on pages.  The direct I/O helpers
that just happened to set in block/ did hold references and abused some
field in the bio for it (and still do for the pinning), but the reference
was (and the pin now is) owned by the submitter.

The block layer model has always been that the submitter needs to ensure
memory stays allocated until the I/O has completed.  Which IMHO is the
only sane model for dealing with memory lifetimes vs I/O, and something
networking absolutely should follow.


