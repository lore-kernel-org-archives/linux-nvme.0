Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD65C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Nov 2022 04:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pxM0Tai1NwFg2mqAJQ1nSkdVi+JTmOQz5Ac0dKx9+yk=; b=RBJlCqVeo9RsUBQjEWe0Mk+Isv
	wgwudr4ootJoWgFHkZutAtjooaaeQe3dbyBCGVMMPh7RWuLZFOzsU4FmCs0zC3xO9juKPAttczCYg
	MsfTTHz6PplNLPoNIYhRo7t2jbtpQMlAfr/fQRRD/OhcP/CS8D8fPEokl2JpInRKP/YrtRwy5kLl0
	bb6uOi3sLJw3sODYQExHgYS1uGjIi2KeCvdlSKxKS7UHh7f25WXjs1HoUR2yCWWavBzB0VBsl5rkt
	8gfsRDbT2LbVsFnq+GVaM5gRoPkRlnuxIxHrcZJPXE6ooDfg17GOq4DUOKkKrFTdCOy+QDq3M1wUf
	pzJmhBJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyQAl-00Cfrd-8V; Fri, 25 Nov 2022 04:18:43 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyQAi-00Cfpr-SF
	for linux-nvme@lists.infradead.org; Fri, 25 Nov 2022 04:18:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pxM0Tai1NwFg2mqAJQ1nSkdVi+JTmOQz5Ac0dKx9+yk=; b=taGO1ATiA5q4QgCU8nnvoBtIcc
	lO9tlrR7Y/phz7gCl0S4yEi9UyLuDogzERxdHX9JqxMx7QNxr0xB2EhdUMJOdDgEyHWEEp5DDWN9u
	l6Gzx6ztvsZLRESGJpoB6+OUFikQQXY7cjlOv796YW8IR5gYUYdrkSTQ1rzAWyIzqZdM96Z0MOFAh
	OiUvYtMAfx5zuGD88T9ju9s/hCqn2q7fdDoZUXY/GEnTjJzKS2dwZkaYWZxZpBR6zT3XXo0QMw1vZ
	izeGgBxcMCN4zr8t1TxKibzgwAf91BD4KL+Z4b7yozfju0WMWwTJUD1dHKmLwOqtq1C74L5M9SCfu
	eN4qXCrg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1oyQAK-006aa1-1q;
	Fri, 25 Nov 2022 04:18:16 +0000
Date: Fri, 25 Nov 2022 04:18:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, axboe@kernel.dk, agk@redhat.com,
	snitzer@kernel.org, dm-devel@redhat.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, james.smart@broadcom.com,
	kch@nvidia.com, naohiro.aota@wdc.com, jth@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 10/10] fs: add support for copy file range in zonefs
Message-ID: <Y4BCCB9U10mkiehu@ZenIV>
References: <20221123055827.26996-1-nj.shetty@samsung.com>
 <CGME20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c@epcas5p2.samsung.com>
 <20221123055827.26996-11-nj.shetty@samsung.com>
 <729254f8-2468-e694-715e-72bcbef80ff3@opensource.wdc.com>
 <349a4d66-3a9f-a095-005c-1f180c5f3aac@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <349a4d66-3a9f-a095-005c-1f180c5f3aac@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221124_201840_934330_0161ACAA 
X-CRM114-Status: GOOD (  13.42  )
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

On Thu, Nov 24, 2022 at 10:47:55AM +0900, Damien Le Moal wrote:
> >> +	inode_lock(src_inode);
> >> +	inode_lock(dst_inode);
> > 
> > So you did zonefs_copy_file_checks() outside of these locks, which mean
> > that everything about the source and destination files may have changed.
> > This does not work.
> 
> I forgot to mention that locking 2 inodes blindly like this can leads to
> deadlocks if another process tries a copy range from dst to src at the
> same time (lock order is reversed and so can deadlock).

Not to mention the deadlocks with existing places where fs/namei.c locks
two inodes...

