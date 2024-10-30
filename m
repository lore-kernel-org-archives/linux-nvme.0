Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A126FD6B6B3
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OCC2qjpZa2ZZADluQJ0hoPPsIvbrfUok/uaGM4W0Jdc=; b=ShBndPdi2d44lt2HP9faWpqnRg
	1iNJM5Tv5UJydl4+Nxl5K3fdLdGXueyBrfhlJ673PRERn1Pp2oZfTsnmSk4rE7lCQwTyPqhcPGSSy
	JyKXNrHH0T0JlGjuFaURV6D7VY4E9NKQZz1Zktdtcotkl/YTS5nc4fxxqdXFMIJ6lVvdbElkSSabV
	JRJyA3MjdF3tQmuH89yoQiFq7J0vtvLv2m+iCZG+dqzvzBBHL2vhQqJopLrZyzCI6aeXvMomV59h+
	VO2pWJPPwb5/KXDGXsFD0vwx3mOuPiSHv61t8DSTBC+C0hdtDqmT/Kyua6BesA5G7Opkc0v7U7Ep2
	BpN8MLkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6CIk-00000001EQT-0DKe;
	Wed, 30 Oct 2024 17:16:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6CHV-00000001E6S-3sA3
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 17:14:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 634FD227A8E; Wed, 30 Oct 2024 18:14:50 +0100 (CET)
Date: Wed, 30 Oct 2024 18:14:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com,
	Hannes Reinecke <hare@suse.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <20241030171450.GA12580@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241029151922.459139-10-kbusch@meta.com> <20241029152654.GC26431@lst.de> <ZyEAb-zgvBlzZiaQ@kbusch-mbp> <20241029153702.GA27545@lst.de> <ZyEBhOoDHKJs4EEY@kbusch-mbp> <20241029155330.GA27856@lst.de> <ZyEL4FOBMr4H8DGM@kbusch-mbp> <20241030045526.GA32385@lst.de> <c9c2574b-b3be-47ac-8a82-10d92c5892bc@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c2574b-b3be-47ac-8a82-10d92c5892bc@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_101454_127748_A10D1CE9 
X-CRM114-Status: GOOD (  13.93  )
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

On Wed, Oct 30, 2024 at 09:59:24AM -0700, Bart Van Assche wrote:
>
> On 10/29/24 9:55 PM, Christoph Hellwig wrote:
>> For the temperature hints the only public user I known is rocksdb, and
>> that only started working when Hans fixed a brown paperbag bug in the
>> rocksdb code a while ago.  Given that f2fs interprets the hints I suspect
>> something in the Android world does as well, maybe Bart knows more.
>
> UFS devices typically have less internal memory (SRAM) than the size of a 
> single zone.

That wasn't quite the question.  Do you know what application in android
set the fcntl temperature hints?


