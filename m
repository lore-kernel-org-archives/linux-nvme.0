Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E6FCF34CA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 22:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NwbQcL4HrIAxr3qHisxlC2m2/0wQyR2YSSmnbD3EmKA=; b=mQH8OtXgjOHLf3OciLPBSfW1vR
	Ke3ROD39ql4IQ7Bz2biDGASDuR9w6zPfX9RzeC1vvgjDwEu904s7Zl4pYDZCCQsbZQTlLHwqfmsCe
	2w+Tmcq+tO4g2U3TFZkmlSMHcl5v2A3Dur6v5VneXemBcZBwL4YHZYttTHCVmFJWw3/JivqY7ddFS
	FT6FNeQ6BrmnyLDJK4sfFWz8UDucHRzNqflPkvVegLAz2YSLvOYlOeGd3+NJTClv36ZDVfGBehM37
	ivVMqoIQiZZN4aiiJsvO9zxd3dmUBpC8lG/YqIrTbpJIFA3WAm4oVhtqtE1ccjZ6a1QtBs5CpAxTV
	CvjXoQ5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swU8t-0000000AV5C-1YpP;
	Thu, 03 Oct 2024 22:17:51 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swU8q-0000000AV3p-48Pa
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 22:17:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9C280A433CB;
	Thu,  3 Oct 2024 22:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CFDC4CEC5;
	Thu,  3 Oct 2024 22:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727993867;
	bh=0TbLr7PEK0+8ZHCM/bRv8RnmYwcLf2s4vLPJ99IQmwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d1QLLbA/9L0fikcnrZuItErUo72FCpOtJ1AUJZu0xdB7zk59VRLak7TX2g+Ld//z/
	 ieXkpFk2+O1ssw5HSZtcP3bJqe+f2eQR6n2k2yV1NAQm9akg+1RKaGGu9Okqyy4XpD
	 rASUEd4PDE7ceib6Xh89G+Hsrn5ikYgx3hon/QOY55JaRr51jqTwxjxnerlh74oyct
	 5wjLPn0N2nyGCxdhtn4PTqm7vq4pkcqoQ0G1U7SII8IZ44D4aOD2Rmmqxz0lyC7YIe
	 SkMdyc2rZptHXgzrZQ8DkaQBHbMcH7NEqaXMgAES4Lzs4PECYFQAVPqWO5lBXg4TUz
	 BA/EVoIza/ckg==
Date: Thu, 3 Oct 2024 16:17:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
	hare@suse.de, sagi@grimberg.me, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <Zv8YCFhJJZ_UtKOQ@kbusch-mbp>
References: <20241002075140.GB20819@lst.de>
 <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
 <20241002151344.GA20364@lst.de>
 <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com>
 <20241002151949.GA20877@lst.de>
 <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
 <a8b6c57f-88fa-4af0-8a1a-d6a2f2ca8493@acm.org>
 <20241003125516.GC17031@lst.de>
 <Zv8RQLES1LJtDsKC@kbusch-mbp>
 <abd54d3a-3a5e-4ddc-9716-f6899512a3a4@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abd54d3a-3a5e-4ddc-9716-f6899512a3a4@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_151749_111196_07B565F5 
X-CRM114-Status: GOOD (  20.38  )
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

On Thu, Oct 03, 2024 at 03:00:21PM -0700, Bart Van Assche wrote:
> On 10/3/24 2:48 PM, Keith Busch wrote:
> > The only "bonus" I have is not repeatedly explaining why people can't
> > use h/w features the way they want.
> 
> Hi Keith,
> 
> Although that's a fair argument, what are the use cases for this patch
> series? Filesystems in the kernel? Filesystems implemented in user
> space? Perhaps something else?
> 
> This patch series adds new a new user space interface for passing hints
> to storage devices (in io_uring). As we all know such interfaces are
> hard to remove once these have been added.
> 
> We don't need new user space interfaces to support FDP for filesystems
> in the kernel.
> 
> For filesystems implemented in user space, would using NVMe pass-through
> be a viable approach? With this approach, no new user space interfaces
> have to be added.
> 
> I'm wondering how to unblock FDP users without adding a new
> controversial mechanism in the kernel.

I really like the passthrough interface. This is flexible and enables
experimenting with all sorts of features.

But it exposes exploits and pitfalls. Just check the CVE's against it
(ex: CVE-2023-6238, note: same problem exists without metadata). The
consequences of misuse include memory corruption and private memory
leakage. The barriers for exploits are too low, and the potential for
mistakes are too high. A possible h/w solution requires an IOMMU, but
that's a non-starter for many users and only solves the private memory
vulnerabilities.

Passthrough also skips all the block layer features. I just today added
statistics to it staged for 6.13, but even that requires yet another
config step to enable it.

tl;dr: no one wants to use nvme passthrough in production long term.

