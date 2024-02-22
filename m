Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF75FC48BF8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 20:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dK/oWYHsu389pItb/WRDwEP5EEBQLBg2MRWyrcmN1NI=; b=QaiiuN0XyXlQW/DnT7Y9VKS+xJ
	GeJnuGgOA00m0kC9fLZxStyr6PFPTSMo1lL7x0vB459/Fo8RmttSXAKBi236MAv+njMCOtyR/auRQ
	VjJfP76+XaOFnF7HM+/hO/Fd5xBOB4RnDy4HMKyWNGRjwWiQfL0Ph9xT2TbDEpcUCn3jeZR30gMFH
	WI0g9K7IzPTc83DqxIybby5iwXanVeEkJ5kZSWbg27jeXSXhj2cCvO2ixqlIZheoVNHYbPtK3pNtU
	A60bQtQ9NYv65ElHkm5r9oC0x+94qMLa274p6Vd+Mt+cmgCPaV2b2PYUO8s+cX5HkwyUKmJ8GxXEv
	CDk8u4Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdFNR-00000006Ron-3sWR;
	Thu, 22 Feb 2024 20:09:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdFNL-00000006RoF-0be7
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 20:09:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B0C3D632EA;
	Thu, 22 Feb 2024 20:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08E1C433F1;
	Thu, 22 Feb 2024 20:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708632537;
	bh=ODDgjF35NrPnOPh5UsQdm3X39Cv4Un/MqteXmplihbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGZlahkURajbySZDKt0JTcONpb/baq3R5TlEo+BM8oc5nkaRHWZWkc86XHHbSHmRi
	 IsnYpdQi+yAJvSOc34fziXx/vY8IuN1uvbBM/4UEiprg/PAh3T/4sZ2ZI2+XWfLfro
	 CZMASoar3AhHiJxj+R9AYzamkaZ5+Kih0n/YBjE8eGLo3gApeVjeafId4y5fKJgWHo
	 pWyYz/B6SSmtMFhVO8ZOboXFyAF+XH+SKQiHHF5zinDqN5EovCMPNU+KcFMUVqwvs1
	 ZBNQ4vPw8l/c5ly1U/iBDLwctAa1LhKbdNnsTJ/Oz8MY49CackDKqsUwmhaZ7r7zyb
	 m2rIx7ZwNXpiQ==
Date: Thu, 22 Feb 2024 13:08:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, josef@toxicpanda.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Message-ID: <Zdep1jEY4kFFxxk8@kbusch-mbp>
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
 <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_120859_258825_414A603E 
X-CRM114-Status: GOOD (  23.15  )
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

On Fri, Feb 23, 2024 at 01:03:01AM +0530, Kanchan Joshi wrote:
> With respect to the current state of Meta/Block-integrity, there are
> some missing pieces.
> I can improve some of it. But not sure if I am up to speed on the
> history behind the status quo.
> 
> Hence, this proposal to discuss the pieces.
> 
> Maybe people would like to discuss other points too, but I have the 
> following:
> 
> - Generic user interface that user-space can use to exchange meta. A
> new io_uring opcode IORING_OP_READ/WRITE_META - seems feasible for
> direct IO. Buffered IO seems non-trivial as a relatively smaller meta
> needs to be written into/read from the page cache. The related
> metadata must also be written during the writeback (of data).
> 
> 
> - Is there interest in filesystem leveraging the integrity capabilities 
> that almost every enterprise SSD has.
> Filesystems lacking checksumming abilities can still ask the SSD to do
> it and be more robust.
> And for BTRFS - there may be value in offloading the checksum to SSD.
> Either to save the host CPU or to get more usable space (by not
> writing the checksum tree). The mount option 'nodatasum' can turn off
> the data checksumming, but more needs to be done to make the offload
> work.

As I understand it, btrfs's checksums are on a variable extent size, but
offloading it to the SSD would do it per block, so it's forcing a new
on-disk format. It would be cool to use it, though: you could atomically
update data and checksums without stable pages.
 
> NVMe SSD can do the offload when the host sends the PRACT bit. But in
> the driver, this is tied to global integrity disablement using
> CONFIG_BLK_DEV_INTEGRITY.
> So, the idea is to introduce a bio flag REQ_INTEGRITY_OFFLOAD
> that the filesystem can send. The block-integrity and NVMe driver do
> the rest to make the offload work.
> 
> - Currently, block integrity uses guard and ref tags but not application 
> tags.
> As per Martin's paper [*]:
> 
> "Work is in progress to implement support for the data
> integrity extensions in btrfs, enabling the filesystem
> to use the application tag."

