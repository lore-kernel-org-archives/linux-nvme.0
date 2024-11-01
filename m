Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31A7E6B27C
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2024 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8QuOOkyJjV0IldbHVjSmL3fGP7YxOfaxqPaWkckJ/sE=; b=GVahaAAdSsYB8TNRRZCSztgI2/
	+DkD5XEO+tw/SGmNCp4Ni86oLHz8pRcMxxg0PA14zdmXZCtZV6RKxmKEeimf9wPUSypPD5X4LIfI/
	GJyzu+nUEFhLquMesL9it64EN5qjxz6cfhFYa5MpkuJ4S7W643+vw8GR9K+mGN+XUc9gvgymbdGwP
	nUuX2a3+9zh24qtEk2UIwfDpACy2LbNprDlvCViG1JMLAfMRgJ1HU3/6lqIGPBraXeEa1gKjfkN6T
	RxMMr2bf+c4MHDr2fshRgVKeyw7BsIveGG/ywvpS650CdE3z8LcZYnbVqQY7AeFgNE5v70Ul0yt6r
	krXtY0pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sCo-00000007G9X-2MKD;
	Fri, 01 Nov 2024 14:00:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s4k-00000007Eou-1uvr
	for linux-nvme@lists.infradead.org;
	Fri, 01 Nov 2024 13:53:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6A36D5CAC62;
	Fri,  1 Nov 2024 01:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65631C4CEC3;
	Fri,  1 Nov 2024 01:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730422985;
	bh=GVhdOyG4D9/kWSaCeNbk3Uqcva6Wo8dt9xAKwhBgsQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alh1FPiEhXxMuq+r1IGkC39v7wVLcBLb3xiRdeL0NgBnSeoFRcp8deeAVVURw33HZ
	 LUjt2airf+wAWeUkPKo2YKHf4UmLSgGWEeuwgiT4QzG4eHGWI8ENj62SSEa3L1hl8B
	 VrstlZ41MKrZSvjTQHlxBRu5CiaI5Rz+LuN4cG/HGOsIzvEe51pSkU8SzgIuRJSAmP
	 6FYmeVlVa3OrPmekhvaG00TB0WfjpQFwrzCnYJjhkvMFO5lCS7CZVDC+l9WH2aZd+O
	 ByiOaNfTJ56wvQKtvVf1Zu4axyEunyhk3GO9EImk3q7NN3kIOZHM9KZoaxRtgoBnXd
	 pBDah45ha5P8g==
Date: Fri, 1 Nov 2024 01:03:02 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com,
	Hannes Reinecke <hare@suse.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <ZyQoxnwnI75Hi9vj@google.com>
References: <20241029152654.GC26431@lst.de>
 <ZyEAb-zgvBlzZiaQ@kbusch-mbp>
 <20241029153702.GA27545@lst.de>
 <ZyEBhOoDHKJs4EEY@kbusch-mbp>
 <20241029155330.GA27856@lst.de>
 <ZyEL4FOBMr4H8DGM@kbusch-mbp>
 <20241030045526.GA32385@lst.de>
 <c9c2574b-b3be-47ac-8a82-10d92c5892bc@acm.org>
 <20241030171450.GA12580@lst.de>
 <f644c6b2-7549-458d-8a24-07aa44c4b4ee@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f644c6b2-7549-458d-8a24-07aa44c4b4ee@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_065230_632724_0F904C70 
X-CRM114-Status: GOOD (  21.04  )
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

On 10/30, Bart Van Assche wrote:
> On 10/30/24 10:14 AM, Christoph Hellwig wrote:
> > On Wed, Oct 30, 2024 at 09:59:24AM -0700, Bart Van Assche wrote:
> > > 
> > > On 10/29/24 9:55 PM, Christoph Hellwig wrote:
> > > > For the temperature hints the only public user I known is rocksdb, and
> > > > that only started working when Hans fixed a brown paperbag bug in the
> > > > rocksdb code a while ago.  Given that f2fs interprets the hints I suspect
> > > > something in the Android world does as well, maybe Bart knows more.
> > > 
> > > UFS devices typically have less internal memory (SRAM) than the size of a
> > > single zone.
> > 
> > That wasn't quite the question.  Do you know what application in android
> > set the fcntl temperature hints?
> 
> I do not know whether there are any Android apps that use the
> F_SET_(FILE_|)RW_HINT fcntls.
> 
> The only use case in Android platform code I know of is this one: Daejun
> Park, "f2fs-tools: add write hint support", f2fs-dev mailing list,
> September 2024 (https://lore.kernel.org/all/20240904011217epcms2p5a1b15db8e0ae50884429da7be4af4de4@epcms2p5/T/).
> As you probably know f2fs-tools is a software package that includes
> fsck.f2fs.
> 
> Jaegeuk, please correct me if necessary.

Yes, f2fs-tools in Android calls fcntl(fd, F_SET_RW_HINT, &hint);

> 
> Bart.
> 
> 

