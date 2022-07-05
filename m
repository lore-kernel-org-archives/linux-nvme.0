Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C121C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 08:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JWB31PmJw69iMcUSkAYBcf6hwHi0oaY3ywspIB5IkiY=; b=r6Bd87Jxvt9UrUqAnsOIb9TvRV
	S6dQj31qfQ/KckA5NO1GPLeOUVpyH3ehKnEVdCfA3nGI2X1hg8iUCZ48XjwvJrq8ZR+rlT5hRbq9r
	PeNgDfBKel4C9ATPh6PPOY8ILtWH4kEezLfB7aORCkMSXxNtI1ESGGaRlhLFr9eiV071n2SYdQIsk
	mi+W/IKx70H4S6nYXu6SRz+IcWDECK16HBeUj+wW0yPVgGmR3hQm8B1UkK8rJzRxDItgJZWSz9g3E
	3qI/rPMIlWJ0Zahm+UPFXXGJDRvNQYFg9Yk9WM6cxN2Ylu7EjI5FKBKUJEVvYKIks5v9qrgvGU7ao
	CxZYL2Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8e4z-00GGVR-PD; Tue, 05 Jul 2022 08:38:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8e2I-00GFEx-Ec
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 08:35:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F68468AA6; Tue,  5 Jul 2022 10:35:55 +0200 (CEST)
Date: Tue, 5 Jul 2022 10:35:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, agk@redhat.com, song@kernel.org, djwong@kernel.org,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	javier@javigon.com, johannes.thumshirn@wdc.com, bvanassche@acm.org,
	dongli.zhang@oracle.com, ming.lei@redhat.com, willy@infradead.org,
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, clm@fb.com,
	dsterba@suse.com, jack@suse.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, jlayton@kernel.org, idryomov@gmail.com,
	danil.kipnis@cloud.ionos.com, ebiggers@google.com,
	jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 4/6] nvmet: add Verify emulation support for bdev-ns
Message-ID: <20220705083555.GC19123@lst.de>
References: <20220630091406.19624-1-kch@nvidia.com> <20220630091406.19624-5-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630091406.19624-5-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_013558_661522_CEB3AAD0 
X-CRM114-Status: GOOD (  13.82  )
X-Mailman-Approved-At: Tue, 05 Jul 2022 01:38:36 -0700
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

On Thu, Jun 30, 2022 at 02:14:04AM -0700, Chaitanya Kulkarni wrote:
> Not all devices can support verify requests which can be mapped to
> the controller specific command. This patch adds a way to emulate
> REQ_OP_VERIFY for NVMeOF block device namespace. We add a new
> workqueue to offload the emulation.

How is this an "emulation"?

Also why do we need the workqueue offloads?  I can't see any good
reason to not just simply submit the bio asynchronously like all the
other bios submitted by the block device backend.

