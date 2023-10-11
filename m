Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD8BCD98F3
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Oct 2023 05:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OJDb3m383yTWoEHaNTniUPrJlgoZAbNfYy1+9czXBJI=; b=WKuWWolPG0fGYLbjVBi/P0t2V0
	iU5SPlHKsMELCtAm0oxC3YjJWk9rLMONEduaPWo/KRVxMKnmvUhiiXZgVd4vzJm07L0o9GeQbQekm
	D9F5VCY5pbBY+GsPq4nUGD/q+b3E1JKf69sExV9w+kFDe7gJZHSv7EMLQI/jXSeRzPmVZMmxqPGme
	cBuV0BluBrUKvH7qyWDrwkryTQQ0E1XpZzUI/VBl9VVB7QOxV4CcJEW7/PJFMhL6Uu3LnzS1Vucoq
	yRoA2eTLI62RnT41R7IqhGdgJOA8Sue5w6DlD3bHUMYKG201JAm3RIBYAkkh0sodnMDh1xbSeZ4XZ
	cjwBQhVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqRNH-00Enwm-0I;
	Wed, 11 Oct 2023 05:03:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqRNB-00EnvV-1b
	for linux-nvme@lists.infradead.org;
	Wed, 11 Oct 2023 05:03:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 559456732A; Wed, 11 Oct 2023 07:02:54 +0200 (CEST)
Date: Wed, 11 Oct 2023 07:02:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, cpgs@samsung.com, stable@vger.kernel.org,
	Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231011050254.GA32444@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de> <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_220305_692943_CD4DC2DE 
X-CRM114-Status: GOOD (  24.72  )
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

On Tue, Oct 10, 2023 at 07:09:54PM +0530, Kanchan Joshi wrote:
> The case is for the single interleaved buffer with both data and
> metadata. When the driver sends this buffer to blk_rq_map_user_iov(),
> it may make a copy of it.
> This kernel buffer will be used for DMA rather than user buffer. If
> the user-buffer is short, the kernel buffer is also short.

Yes.  Note that we'll corrupt memory either way, so user vs kernel
does not matter.

> Does this explanation help?
> I can move the part to a separate patch.

Definitively separate function please, not sure if a separate
patch is required.

> Yes, not io_uring specific.
> Just that I was not sure on (i) whether to go back that far in
> history, and (ii) what patch to tag.

I think the one that adds the original problem is:

63263d60e0f9f37bfd5e6a1e83a62f0e62fc459f
Author: Keith Busch <kbusch@kernel.org>
Date:   Tue Aug 29 17:46:04 2017 -0400

    nvme: Use metadata for passthrough commands


> > > +     /* Exclude commands that do not have nlb in cdw12 */
> > > +     if (!nvme_nlb_in_cdw12(c->common.opcode))
> > > +             return true;
> >
> > So we can still get exactly the same corruption for all commands that
> > are not known?  That's not a very safe way to deal with the issue..
> 
> Given the way things are in NVMe, I do not find a better way.
> Maybe another day for commands that do (or can do) things very
> differently for nlb and PI representation.

Fixing just a subset of these problems is pointless.  If people want
to use metadata on vendor specific commands they need to work with
NVMe to figure out a generic way to pass the length.

