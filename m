Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9CFD12678
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 10:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GOtHMIKOXrOe/tjWV6j3DoXFt/LnA+glAEEjJs6wJBw=; b=HX+ye5iTom6ts+2Hza2kT8JM+j
	AK1JAgaUxcudjGIx2RnEiOm89c1cUqYX/QKWnQt8R4NojfnWsXpKS7oFIo+ztkyxl3h5OlrMIsNGO
	RxNm3Ui4ML0h/7sBoWRJ/4eeWSDBX+ezq133WO6WWUN91T3bp52KXsXEXLAsfp4n+M1+p+tdzD11V
	QpYr96NYjINLSN+wMjs64ZiNVTIK91KUCVEEd+n5m2bGbSNJ//Oo3KQ8h0Jn2ijO+XESFbcV8fIzT
	uITw17KAvuG4yHZPsaN9qegL3SvhrHeDIeKcNcIn7eMZq/cKfZbwNuFETytvGKe4VYxhGkG8C3n6M
	PNht/8MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8GRX-0000000Gcc1-3pqy;
	Tue, 05 Nov 2024 10:05:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8GP2-0000000GcD2-2Qhs
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 10:03:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13978227AA8; Tue,  5 Nov 2024 11:03:08 +0100 (CET)
Date: Tue, 5 Nov 2024 11:03:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 02/10] block: copy back bounce buffer to user-space
 correctly in case of split
Message-ID: <20241105100307.GA650@lst.de>
References: <20241104140601.12239-1-anuj20.g@samsung.com> <CGME20241104141448epcas5p4179505e12f9cf45fd792dc6da6afce8e@epcas5p4.samsung.com> <20241104140601.12239-3-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104140601.12239-3-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_020312_786176_62BB0E7A 
X-CRM114-Status: GOOD (  14.92  )
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

On Mon, Nov 04, 2024 at 07:35:53PM +0530, Anuj Gupta wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Copy back the bounce buffer to user-space in entirety when the parent
> bio completes. The existing code uses bip_iter.bi_size for sizing the
> copy, which can be modified. So move away from that and fetch it from
> the vector passed to the block layer. While at it, switch to using
> better variable names.
> 
> Fixes: 492c5d455969f ("block: bio-integrity: directly map user buffers")
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> [hch: better names for variables]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This shouldn't really have a from for me as it wasn't my patch
originally.  But if you insist to re-attribute it, my signoff should
be the first as signoffs are supposed to be a chain starting from
the original author to the submitter.


