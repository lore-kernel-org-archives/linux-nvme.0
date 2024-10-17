Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BCBD374B6
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 16:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fBcNJteJn+ifBhyY6LTZ2Yiy0GB4q8HGFoIU8AKaGLI=; b=W/5xLzEUoNjsiawCCPLEcZjg0V
	se8WMyiv3V1+KNJ3f1cf+HnKH1sQYlC1p5GcM/at1XA3FTlDmW+AM1kJHRoQC3uZTbO7K8ljq0O03
	Ln/4813qmca5I71tlNiBIJZcq6TMM8LOl/J7bChzWfF0sj8FQADlKt4hfdyggvklXXD6GWagkHCs2
	Gp9BZoh55Owv9M3ijZVcqCS4jJ9X5gU/QAyvFcsUOPaxG188z8mHkhWDKu7qYZQFZVNfbiajLeyZd
	V+4SoEXBren5G+BruqVLF7khxaC8/EfsHoJL4qV25aXWtCVIA7EMdwP2q11d0u2yD9c1dHIs/AUfG
	P1g7IYGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1T1U-0000000FPoL-30BN;
	Thu, 17 Oct 2024 16:06:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1T1R-0000000FPnn-2pIA
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 16:06:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8E3425C5AF5;
	Thu, 17 Oct 2024 16:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481DCC4CEC3;
	Thu, 17 Oct 2024 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729181204;
	bh=sxLBVfVgG6T70/qpBvtsFGUgrJ9BQHiMs+QBb2kssdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gffDCd6jUTW1l1kOMeBrkIvTn0E+ToGcq/Xm+HdcLQ1Oza1utr/Oy1QbQxYgsjrWW
	 Z7r4Uc3GEa75Q+ZWX5YvKzBQcAunJCXuuNFfw8pZYvYStMxzWjb0pen98HU1Qt8/xk
	 kuhJg8Jf1aMhbmD1z03D7B2TVVa+YT5eNXGQMuPQXG6nuwimwzsPQuRa88P38+N5Ow
	 odQsIJrRlEiimxp1+3f3+nYrosWSNuWt0bvGwiyJ+bdSWrYKrqSfK73R+7UmJXGdu8
	 BXoN2+6XEeSWIUUo+d7LAiROz/12437PYHGbxV0iDZ4EliKp+XqaM/B2+R/nPJv9TO
	 H1z6YF5t/E7Xw==
Date: Thu, 17 Oct 2024 10:06:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hare@suse.de,
	sagi@grimberg.me, martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <ZxE2EeZYKN1ZiSuT@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com>
 <20241015055006.GA18759@lst.de>
 <8be869a7-c858-459a-a34b-063bc81ce358@samsung.com>
 <20241017152336.GA25327@lst.de>
 <ZxEw5-l6DtlXCQRO@kbusch-mbp.dhcp.thefacebook.com>
 <20241017154649.GA27203@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017154649.GA27203@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_090645_777750_4E13E4CC 
X-CRM114-Status: GOOD (  14.37  )
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

On Thu, Oct 17, 2024 at 05:46:49PM +0200, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 09:44:39AM -0600, Keith Busch wrote:
> 
> > We can add a fop_flags and block/fops.c can be the first one to turn it
> > on since that LBA access is entirely user driven.
> 
> Yes, that's my main request on the per-I/O hint interface.
> 
> Now we just need to not dumb down the bio level interface to five
> temeperature level and just expose the different write streams and we
> can all have a happy Kumbaya.

I'm sending a revised version of this patch set that attempts to address
these issues.

The io_uring hint is weird to me, so that part is simplified just to get
the point across.

