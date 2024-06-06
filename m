Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7DAC25B75
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 05:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ffD1lgUoDYCgIS35w84l6DzQXjLfmusVzC7kcHaTZxI=; b=mzRf92sWh4Sr8hD8Xrtxlv+2xz
	H6y7gO2Bm+GdzoMUhilgNJXw/QFxgnKHiC6g3Uzwb4IRZ1l5hb2uvQsvfb8EPpNhAfdeZ3qbxOEwz
	W9CEsDWIdsSlXcmy0EHDhyGjOSeHBLD89H8hkcW/q7HfT+5VeXIFHqoXEC5hQOZIgCd+4TYuZEBbf
	5b2Hf/ZrCLJlo5HjU4aoAVTEQEADQ/SK7utu7MrKoldtPdaMhPiRnJ5pYbLbNFY3mLwsRbhh0e13b
	qoxEfjoHtu9sBfTyNTYg5drz81tkKU0clvcJxYqGeFgUoU8WIuVJvHZ6ZcY7PO1IuYJWLeDUhVSxx
	RExcf1Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF5vM-00000008Qk9-3lYg;
	Thu, 06 Jun 2024 05:44:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF5vJ-00000008QjK-3mfa
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 05:44:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 82BB368CFE; Thu,  6 Jun 2024 07:44:25 +0200 (CEST)
Date: Thu, 6 Jun 2024 07:44:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
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
Message-ID: <20240606054425.GC9123@lst.de>
References: <20240602140912.970947-1-john.g.garry@oracle.com> <20240602140912.970947-5-john.g.garry@oracle.com> <749f9615-2fd2-49a3-9c9e-c725cb027ad3@suse.de> <a84ad9de-a274-4bdf-837a-03c38a32288a@oracle.com> <ee20a47d-3131-41c2-a2fc-39017f535527@suse.de> <76850f4f-0bd0-48ae-92f4-e3af38039938@oracle.com> <20240605083245.GC20984@lst.de> <09907144-45ca-4a48-8831-2f98518cbca4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09907144-45ca-4a48-8831-2f98518cbca4@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_224430_090212_81740924 
X-CRM114-Status: GOOD (  11.63  )
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

On Wed, Jun 05, 2024 at 12:21:51PM +0100, John Garry wrote:
> I assume that you are talking about something like 
> queue_limits_max_zone_append_sectors().

Or rather how that is passed to bio_add_hw_page, yes.

> Anyway, below is the prep patch I was considering for this re-use. It's 
> just renaming any infrastructure for "chunk_sectors" to generic 
> "boundary_sectors".

Looks reasonable.  Note that the comment above blk_boundary_sectors_left
could use a line break.


