Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C01C4167D
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Nov 2023 15:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GBurSBGxdLLiMX/APIaPYsZIMLOpbv0GK0RliNNdCoo=; b=t74NogNG4NnQdXkjSPvvePNSWM
	I5nctxbgwIN8vJ48KiU4gYmDmKQ3dJtcmlxIgJOuoEVcPT2uhk2xUxz9sGmOkP6KuEed7+nI/pRic
	FLtLxBEKRuosPpN1R744x6b6THOiXNaaHRsG8gNd+Tp2Vva/bIqhfhmNqX2flAF+LfpduOLEq2E8R
	cHroixW4R3k8/9qn/T91B/TpHwg0LajXW9a7jFhxLNT5ljYLTOJI++c/pOxwTKo3d/rqm+5cD7eQl
	sPOZwOes8HK8aYsfFEUl7cqDNQ6SEH4dZ11n/EARVRQSuuwwhLWzjpx6l9su3r/S458lneasFtfrF
	zbi0tccA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r16kw-006Z7U-0C;
	Thu, 09 Nov 2023 15:15:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r16ks-006Z54-1H
	for linux-nvme@lists.infradead.org;
	Thu, 09 Nov 2023 15:15:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FC6967373; Thu,  9 Nov 2023 16:15:32 +0100 (CET)
Date: Thu, 9 Nov 2023 16:15:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Message-ID: <20231109151531.GC32432@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-4-john.g.garry@oracle.com> <20230929224922.GB11839@google.com> <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org> <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com> <2c929105-7c7f-43c5-a105-42d1813d0e29@acm.org> <yq1r0mctv2d.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1r0mctv2d.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231109_071538_579696_BA081E3F 
X-CRM114-Status: GOOD (  15.70  )
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

On Mon, Oct 02, 2023 at 08:28:04PM -0400, Martin K. Petersen wrote:
> 
> Bart,
> 
> > Neither the SCSI SBC standard nor the NVMe standard defines a "minimum
> > atomic write unit". So why to introduce something in the Linux kernel
> > that is not defined in common storage standards?
> 
> >From SBC-5:
> 
> "The ATOMIC TRANSFER LENGTH GRANULARITY field indicates the minimum
> transfer length for an atomic write command."

I would suggest that we don't try to claim any atomic write capability
if this is not a logical block as such devices are completely useless.
In fact I'd add a big warning to the kernel log if a device claims this,
as this breaks all the implicit assumptions that a single logical
block write is atomic.


