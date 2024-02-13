Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A261EC4829A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 06:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WN4BIVJVQ8J+UF1eyPr3SOW9e23Ch1OGwSNZkQfIET8=; b=jp+ETftbd1AavlSaazlRENc5nm
	y0zlnAUMwvaNzRPZZ78fgU12FsAMvgHUUMxNBATQw/G/l1BGdRjVSEe+APTP6YYio0V7+MZJV5GNU
	eBm6ZA99P4rcRiIDZWIs7qpn1PWq+IOaaEbpzvGcpUXwHH3rwjN1QemiMxI6g1dqhyiiqq9kXQghm
	h2HJOcdBLMgly9SZRu8vEgYKmLDr4R0zvKIU3EasMujPASB6fVkQ1bBC6QMESUiIKxVndrcYHEO9t
	VpantB+1i0LMikBb9XKbDKzWuLAaxRnx/l+j8iBLQ8h/dd9yv4oYYYF3UxAkGSrI6drAmeJfuggVd
	sb9ZT3KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZmBs-000000087KK-0d9y;
	Tue, 13 Feb 2024 06:22:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZmBp-000000087Jv-2Oky
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 06:22:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D522227A87; Tue, 13 Feb 2024 07:22:40 +0100 (CET)
Date: Tue, 13 Feb 2024 07:22:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 01/15] block: Add atomic write operations to
 request_queue limits
Message-ID: <20240213062239.GA23128@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-2-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_222245_776611_170576A2 
X-CRM114-Status: GOOD (  12.32  )
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

On Wed, Jan 24, 2024 at 11:38:27AM +0000, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Add the following limits:
> - atomic_write_boundary_bytes
> - atomic_write_max_bytes
> - atomic_write_unit_max_bytes
> - atomic_write_unit_min_bytes
> 
> All atomic writes limits are initialised to 0 to indicate no atomic write
> support. Stacked devices are just not supported either for now.

Can you merge this with the next patch?  Splitting adding limits vs
actually using them seems rather confusing.


