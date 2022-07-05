Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4640EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 08:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jO3k8ty55d6cDhK6/FBmv4t5p3LNB/AU6VXwB6R2WXY=; b=bg+SaHqlPz0EgWnD9bkENH3Y0P
	is/uX8gLEOzD1YOrdhj/iBgrVug1lZbVr6YP80Sn74mnl0gS4M1djQResWqd4YERBAFWuYuqqD1ah
	xCI740hVLHmMBb3Raijqu+MwIon/EsfDgii2HBhEvSLdbaYMNDbY7gmHdbXOfCFTdnjU1SNVSokxQ
	lbB3uNY3iClIcJubSmJD62dGW0y6Y9g2z788vQHmuXI9Rs0sKpkJBsLhDgXu5eKTzsuSPHaPiF46u
	YUA11PGfMdENe4Jn+7OK7FdJWNp8CrG5rKZKJqAsY+FiTUmOTDvB7JpjInB5wg+Sh86m1etHzmsOk
	b087vm1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8e58-00GGYy-KK; Tue, 05 Jul 2022 08:38:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8e4N-00GGMf-9p
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 08:38:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6823468BEB; Tue,  5 Jul 2022 10:38:04 +0200 (CEST)
Date: Tue, 5 Jul 2022 10:38:03 +0200
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
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <20220705083803.GE19123@lst.de>
References: <20220630091406.19624-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630091406.19624-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_013807_549034_E102A5CD 
X-CRM114-Status: GOOD (  14.66  )
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

On Thu, Jun 30, 2022 at 02:14:00AM -0700, Chaitanya Kulkarni wrote:
> This adds support for the REQ_OP_VERIFY. In this version we add
> support for block layer. NVMe host side, NVMeOF Block device backend,
> and NVMeOF File device backend and null_blk driver.

Who is "we" in this patch set?

> Here is a link for the complete cover-letter for the background to save
> reviewer's time :-
> https://patchwork.kernel.org/project/dm-devel/cover/20211104064634.4481-1-chaitanyak@nvidia.com/

Well, the cover letter should be here.

Also I don't see how an NVMe-only implementation.  If we don't also
cover SCSI and ATA there isn't much this API buys a potential user.

