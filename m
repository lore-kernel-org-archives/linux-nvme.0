Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FB5CD11C2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 22:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mqqt3O5CMVOhP6KJ0RUdsxRDGEHT2Fm8gtdzEX2uSXA=; b=R9PBx17QDOgKfIuthKU2qLgFSV
	DO/lZ240rTEafUH+MCw3HWlKeIeEFQHe37v80xI3qGC6TVGkRQukh2CIxHGkzbIIJFkCorFCRY3af
	oMF7BZt/OowPrOIFW1KRXFwbju1UfJ+wFFKq7iUOecdp5FHbnC4uvXxROtkX+BaM0a+kDeF0QFnFG
	5fP+9OFgKeGW46JnwIU5NHOAF8ltaluycKYoQFaa59iRI2E3xcYoRxYgFTM2F9yIdCONPfkRl5DiZ
	2qaAM09hAGkCa+5DV4tZ5wTFnTp49UqyQ+EqXRkt49zO3/lZLfnuUki46kAJ+64soB675Hh7jUorx
	r2VSwf3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rugtN-00000009MHz-49gz;
	Wed, 10 Apr 2024 22:58:09 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rugtL-00000009MGy-3r8e;
	Wed, 10 Apr 2024 22:58:07 +0000
Date: Wed, 10 Apr 2024 15:58:07 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org
Subject: Re: [PATCH v6 01/10] block: Pass blk_queue_get_max_sectors() a
 request pointer
Message-ID: <ZhcZf4qLLZi8v0U2@bombadil.infradead.org>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <20240326133813.3224593-2-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326133813.3224593-2-john.g.garry@oracle.com>
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

On Tue, Mar 26, 2024 at 01:38:04PM +0000, John Garry wrote:
> Currently blk_queue_get_max_sectors() is passed a enum req_op. In future
> the value returned from blk_queue_get_max_sectors() may depend on certain
> request flags, so pass a request pointer.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

