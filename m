Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1CAC8303C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 15:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EIvTsutl8deZYlildXdukB7Zqzo7Azdoq6G919OJYf4=; b=1KmI8ua9+AUdF+pbxDOjkK6Ja0
	kBqrzLrWEis02PN4cavy0CXHZiBDy7ZkvZX0aA8b3BEBKCq2uI2FCfvfMbmkIPehsGXVe2V8Oh7+t
	LmV/zIbzvAjfIb6ePRPxe7aQMttna5K2rcQLacDCw8PH/Ovl+gDlt5paSRTUb5MvkZGfVejBkh2iJ
	isyRZW2+7X7E169U1xuLjyDqXf5ypMTwLVPuZzDFLSGG6Ap9OZbsRlnObCVM8I24PSLmVrtRYrCwd
	AaHDoTYpX81UpYAiC57UPvtudvyB2Il30BqotY9D8khdLuqXOrgxw/OHB+mnxwnjM7a/HS8OUogkm
	SN6khOPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYoDC-00000002wP1-3wwn;
	Mon, 07 Jul 2025 15:56:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYoDA-00000002wOe-1DMO
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 15:56:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B56685C1986;
	Mon,  7 Jul 2025 15:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014CCC4CEE3;
	Mon,  7 Jul 2025 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751903815;
	bh=K4TsgEfbZBCaB5T+UtpxvoxOzf99yOdPJVsE+Cw+Y0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5AcbnHd8RRLiGwhKyQCEKRiHwDNnLOxKiGli9/0YhEm80kN3aq/ruts5qIlYk5A6
	 6LpG+1G1+nv05A1Wxr2wUxcViszbUUm6gRJ2PqKzMEPDftjSXMsLAnPx0t/HtgU+st
	 aqb4rtSXW2NfYnQuUwDRBiTdswIlRVJchl73ewkVGZ+x5/szVxEYKqT3RhUV5sw1pF
	 R6nLYOibtMPyw1r6GIReKmpLlJCUhkTQUuSks/bAkErPer/csYqicOpJusESYU0MBH
	 v/28k6znhy+zdn7NhyN02dMIM1MVXWXuUzUAXgK81kQxg1bzeeefYX5fR8CSVJrZ7d
	 5OAt+Oi6Olaxw==
Date: Mon, 7 Jul 2025 09:56:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGvuRS8VmC0JXAR3@kbusch-mbp>
References: <20250707141834.GA30198@lst.de>
 <aGvYnMciN_IZC65Z@kbusch-mbp>
 <b2ff30b5-5f12-4276-876d-81a8b2f180c1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ff30b5-5f12-4276-876d-81a8b2f180c1@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_085656_370724_3E00FC19 
X-CRM114-Status: GOOD (  23.79  )
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

On Mon, Jul 07, 2025 at 05:26:46PM +0200, Hannes Reinecke wrote:
> On 7/7/25 16:24, Keith Busch wrote:
> > On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> > > We could:
> > > 
> > >   I.	 revert the check and the subsequent fixup.  If you really want
> > >           to use the nvme atomics you already better pray a lot anyway
> > > 	 due to issue 1)
> > >   II.	 limit the check to multi-controller subsystems
> > >   III.	 don't allow atomics on controllers that only report AWUPF and
> > >   	 limit support to controllers that support that more sanely
> > > 	 defined NAWUPF
> > > 
> > > I guess for 6.16 we are limited to I. to bring us back to the previous
> > > state, but I have a really bad gut feeling about it given the really
> > > bad spec language and a lot of low quality NVMe implementations we're
> > > seeing these days.
> > 
> > I like option III. The controler scoped atomic size is broken for all
> > the reasons you mentioned, so I vote we not bother trying to make sense
> > of it.
> > 
> Agree. We might consider I. as a fixup for stable, but should continue
> with III going forward.

I think the NVMe TWG might want to consider an ECN to deprecate or at
least recommend against AUWPF, too.

Just to throw AWUPF a lifeline for legecy devices, we could potentially
make sense of the value if Identify Controller says:

  1. CMIC == 0; and
  2. OACS.NMS == 0; and
  3.
    a. FNA.FNS == 1; or
    b. NN == 1

And if those conditions are true, then the controller and namespace
scopes resolve to a single namespace format, so the values should be one
in the same. The only way it could change, then, is a format command,
which means there couldn't be an in-use filesystem depending on it not
changing.

