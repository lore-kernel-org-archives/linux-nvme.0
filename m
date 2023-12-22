Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01332C46CD2
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 15:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K4h3y9RLdDXoV2ORCa7QwrDaDTIoSA8ARwOJuQ2fKSI=; b=34kgC4ABifIviBCtEVfHmSGeuU
	9TBUkb05Vlmvc6CG+nfPX90D0BMzMAd9VWubLOH4EFQF8VebzuS2cLC9UWyGnTWdyZ5mtw28lPqp4
	oBsYokdA6xTz9fyw1yVsdGjQ339PR8J2HPhOspwofn3c6bCjvgzreMJ69vipFZaNCCb/AXesameCx
	nBkJuuayYZheuw1GCO8DAx0wQzULVd3CK8d/lCLlLVHyd/XbAi2crBB2YMDk9FKsEzvAmdET88Z0S
	wgAILU/7iJmgcYlJI3t4mkIunWjUOQaKcXcw2nZlU01X6LhFqyuSoEAVYkLrtKABFa4pG8J0IZobQ
	tLIsssVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGhB1-006CCr-1D;
	Fri, 22 Dec 2023 15:11:03 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGhAy-006CBa-20
	for linux-nvme@lists.infradead.org;
	Fri, 22 Dec 2023 15:11:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 64309CE20A5;
	Fri, 22 Dec 2023 15:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BE1C433C9;
	Fri, 22 Dec 2023 15:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703257857;
	bh=jj2Z4UzDBfG4TrpZAn+WY65WDkHUYpWkxVo4G50GhjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IN66h3fddKRYluEoG8tMXspnU52/OIoPT8qyGxpDlX7QZplgwPhbNGKhyDYVB+ba3
	 xfS+rS8Pbl0d4WyiJU6jtf5wUjxqbY33nnLOM/l0KfLJGcuJwXDw4TOs/G2D6LO+nN
	 lI84IPiWYg6Q55aXY91lD9zWpSnBAWW9o7UsKcpvFWC5KvifnsjStyMJvLYvnI4TSU
	 Wca1GQlsm4cd1tEDt1DV6MOyYXxYYJsM4DHt/yhC71QsefXtoX0B7rautzn7uU7fok
	 3GubVzIH6YP1eiulSfcywSjiiIRVcyZT93OzPjbGTie+ClXeTgK3B16e0dSXVB6eiX
	 Q9pDkFv2myIqA==
Date: Fri, 22 Dec 2023 08:10:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>,
	lsf-pc@lists.linuxfoundation.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Message-ID: <ZYWm_tMtfrKaNf3t@kbusch-mbp>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <BB694C7D-0000-4E2F-B26C-F0E719119B0C@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BB694C7D-0000-4E2F-B26C-F0E719119B0C@dubeyko.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_071101_007216_5327F261 
X-CRM114-Status: GOOD (  28.51  )
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

On Fri, Dec 22, 2023 at 11:23:26AM +0300, Viacheslav Dubeyko wrote:
> > On Dec 21, 2023, at 11:33 PM, Bart Van Assche <bvanassche@acm.org> wrote:
> > I'm interested in this topic. But I'm wondering whether the disadvantages of
> > large blocks will be covered? Some NAND storage vendors are less than
> > enthusiast about increasing the logical block size beyond 4 KiB because it
> > increases the size of many writes to the device and hence increases write
> > amplification.
> > 
> 
> I  am also interested in this discussion. Every SSD manufacturer carefully hides
> the details of architecture and FTL´s behavior. I believe that switching on bigger
> logical size (like 8KB, 16KB, etc) could be even better for SSD's internal mapping
> scheme and erase blocks management. I assume that it could require significant
> reworking the firmware and, potentially, ASIC logic. This could be the main pain
> for SSD manufactures. Frankly speaking, I don´t see the direct relation between
> increasing logical block size and increasing write amplification. If you have 16KB
> logical block size on SSD side and file system will continue to use 4KB logical
> block size, then, yes, I can see the problem. But if file system manages the space
> in 16KB logical blocks and carefully issue the I/O requests of proper size, then
> everything should be good. Again, FTL is simply trying to write logical blocks into
> erase block. And we have, for example, 8MB erase block, then mapping and writing
> 16KB logical blocks looks like more beneficial operation compared with 4KB logical
> block.

If the host really wants to write in small granularities, then larger
block sizes just shifts the write amplification from the device to the
host, which seems worse than letting the device deal with it.

I've done some early profiling on my fleet and there are definitely
applications that overwhelming prefer larger writes. Those should be
great candidates to use these kinds of logical block formats. It's
already flash-friendly, but aligning filesystems and memory management
to the same granularity is a nice plus.

Other applications, though, still need 4k writes. Turning those to RMW
on the host to modify 4k in the middle of a 16k block is obviously a bad
fit.

Anyway, your mileage may vary. This example BPF program provides an okay
starting point for examining disk usage to see if large logical block
sizes are a good fit for your application:

  https://github.com/iovisor/bpftrace/blob/master/tools/bitesize.bt
 
> So, I see more troubles on file systems side to support bigger logical
> size. For example, we discussed the 8KB folio size support recently.
> Matthew already shared the patch for supporting 8KB folio size, but
> everything should be carefully tested. Also, I experienced the issue
> with read ahead logic. For example, if I format my file system volume
> with 32KB logical block, then read ahead logic returns to me 16KB
> folios that was slightly surprising to me. So, I assume we can find a
> lot of potential issues on file systems side for bigger logical size
> from the point of view of efficiency of metadata and user data
> operations.  Also, high-loaded systems could have fragmented memory
> that could make the memory allocation more tricky operation. I mean
> here that it could be not easy to allocate one big folio.
> Log-structured file systems can easily aligned write I/O requests for
> bigger logical size. But in-place update file systems can increase
> write amplification for bigger logical size because of necessity to
> flush bigger portion of data for small modification. However, FTL can
> use delta-encoding and smart logic of compaction several logical
> blocks into one NAND flash page. And, by the way, NAND flash page
> usually is bigger than 4KB.

