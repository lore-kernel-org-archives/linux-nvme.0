Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447F4C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 08:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lxpLXdra+9pecKklrCgmBSLbVAd/IGLWXeR6ZOSOT6w=; b=DpfXMYWjL4u3Bj4xGYkpZHEgb7
	WmYGZmywgwmcMO2RphhR6jgUwJeP8vDZEiEtY6JzjyPHwf7JrzE7c6aDCvgY0+mnrgx4GDunBZ2xC
	qIJ81W2pS+nrW24EhY4ZB/NgIvZo7mWnHtGK+x9XP2n5+3ZFPBCxuazQpscD6YJoxAD0Zl9A1MFvC
	KOLvyKkJBMGuObL4iodTnPTrStwQ6DzChSfNy7kZTrlixtZm6zU20qHW3tKKk72KZE27cSHiLFL4c
	8u+VS9ER6AZ3ZihPHKFvKAzYj3KaLta+8RRNiql59zj+JYE3p4zaSJnS90u7gT6jzMK960Mf22DFD
	MCn1ldeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEm3f-00000005Diz-1jh6;
	Wed, 05 Jun 2024 08:31:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEm3c-00000005DhW-2AIG
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 08:31:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A2C0A227A8E; Wed,  5 Jun 2024 10:31:41 +0200 (CEST)
Date: Wed, 5 Jun 2024 10:31:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v7 4/9] block: Add core atomic write support
Message-ID: <20240605083140.GB20984@lst.de>
References: <20240602140912.970947-1-john.g.garry@oracle.com> <20240602140912.970947-5-john.g.garry@oracle.com> <749f9615-2fd2-49a3-9c9e-c725cb027ad3@suse.de> <a84ad9de-a274-4bdf-837a-03c38a32288a@oracle.com> <ee20a47d-3131-41c2-a2fc-39017f535527@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee20a47d-3131-41c2-a2fc-39017f535527@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_013144_738211_C7A7AF7C 
X-CRM114-Status: GOOD (  10.85  )
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

On Mon, Jun 03, 2024 at 02:31:04PM +0200, Hannes Reinecke wrote:
> We currently use chunk_sectors for quite some different things, most 
> notably zones boundaries, NIOIB, raid stripes etc.
> So I don't have an issue adding another use-case for it.

So as zone as a device supports atomic/untorn writes you limit all
I/O including reads to the boundaries?  I can't see how that would
ever make sense.


