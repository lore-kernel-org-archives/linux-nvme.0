Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB0FD1CDA1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 06:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lfBoMYEB4g/sFrXbLKisl4NtwVnJb6lg1S7T+bahiA0=; b=T0w+wgR2R2L17NyyYyZv7b4KRz
	9zkHY4213/o2Fq+aVAfnuGTZ79cahp6slOoPOFsooo+cR8V2kdXemyPblnkgwyBL81MdFeru1MWbu
	KH2svNY8i0NxlHgGA64u9+x+kcXG46UMkhZpEGxVyamhOZidCnvKiEriHmJZBq+4VYdDEkPNwO4H+
	bIWDW+2hwlk0NGKLWhmh3ZLo7oJZUq2aZ02/71OwVxvibRMlIyQ6cUf8NBT4rxzPUyWi/dV4eROTD
	DaFm1gBf1hRhUkxh7jIhBmavkM/t5PDeTTTs7CUMV3GvxqfMiYL16/cYtF5xV6eFytPNewg6QOFNQ
	fm8MS+UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t380o-00000009kL1-1M8E;
	Tue, 22 Oct 2024 06:04:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t380l-00000009kKD-1k7F
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 06:04:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A37FB227AAC; Tue, 22 Oct 2024 08:04:51 +0200 (CEST)
Date: Tue, 22 Oct 2024 08:04:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de,
	kbusch@kernel.org, asml.silence@gmail.com, anuj1072538@gmail.com,
	krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v4 04/11] block: define meta io descriptor
Message-ID: <20241022060451.GB10327@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113741epcas5p3b90adb3b43b6b443ffd00df29d63d289@epcas5p3.samsung.com> <20241016112912.63542-5-anuj20.g@samsung.com> <yq1h694lwnm.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1h694lwnm.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_230455_616562_2904B898 
X-CRM114-Status: GOOD (  19.12  )
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

On Mon, Oct 21, 2024 at 10:11:35PM -0400, Martin K. Petersen wrote:
> Glad to see the seed added. In NVMe it can be a 64-bit value so we
> should bump the size of that field in the user API.
> 
> Not sure what to do about the storage tag. For Linux that would probably
> be owned by the filesystem (as opposed to the application). But I guess
> one could envision a userland application acting as a storage target and
> in that case the tag would need to be passed to the kernel.

Right now the series only supports PI on the block device.  In that
case the userspace application can clearly make use of it.  If we
want to support PI on file systems (which I'd really like to do for
XFS) both ownership models might make sense depending on the file
system, although I think just giving it to the application is going
to be the only thing we'll see for a while.  Maybe we need a way
to query if the application can use the app tag? 


