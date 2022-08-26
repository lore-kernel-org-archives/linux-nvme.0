Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B288ECAAA3
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 19:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m0ufRTG0uVMqYJLr8AsEIZ7dinDtnoxSFLhw7XuBgcY=; b=p6WCmwfG7NGkxCcAjcAKUk4L1w
	o0GcXdPoIzbagOCq0aTTZcES0lNCAs6lA0KqgDJpRazajhU8vlOIJ6NOt8T3YB/+2gHGyUPwHIZpn
	D9CZNyKKcxRs2mlVQqdQb60VzFJdc0LAZziSW/GOjOwdmHn5TUnFhvMnq9ZmGyLKey+yzXSXLSrIi
	VdYAxO3OXsVLV39I8z7FjnZNlEUd2z165Bejurnmy2DA5fMQVkVHso+2WxwdZrzjpe5Dy88IJE3e1
	OU5pgH2x/9u50kJa3tY0KdPu2VCmSikLv3sP6u6QaGlnkJNYymuB/s4yyTdkEo35GD53Oh0sq1bKv
	Os9McncQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oReZA-00AJ5s-L4; Fri, 26 Aug 2022 19:00:29 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oReAl-00A4uB-En
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 18:35:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id CF934B831BD;
	Fri, 26 Aug 2022 18:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C483FC433C1;
	Fri, 26 Aug 2022 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661538912;
	bh=4HUfpEyIMPwZm9Or4pnF3GVjJGYp1+pAFmXsSIh30bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rz/BkQsdEAmhdTTQza5Ci8Es3mjzFfX887yxuqUhW52uNbRLBj+/v2yv3MTwOMbHp
	 75lF3i7rTvblIAzVVe9C15I8Z5jYCUWvmQeiBFaRB2/o8nN2yXoo4qlQhbno+dciXY
	 57CrqHke+Iz4k9bF5RwQ7blldARpTNhTUJk6N0p9L369vHEmyqbTTSodVZjNG1b3tv
	 y0Uc4HcBmCtLoBX1Hym9BsjeFV7E2Hy3vnj5OqXLHc9Y41tZfm9/+FdUvoL77LZs6h
	 m1vGjZEDowAtgPvWae6X86jGkwbNKDIjWHrqyqYS++xLeTwFmPF8wtFmsl4qFle59+
	 cTF5uA/PDGUIg==
Date: Fri, 26 Aug 2022 12:35:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <james.smart@broadcom.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come
 from HIGHMEM
Message-ID: <YwkSXZtO+i+36pXI@kbusch-mbp.dhcp.thefacebook.com>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
 <20220822142438.5954-2-fmdefrancesco@gmail.com>
 <YwVjpTW6vWvdVQTK@ZenIV>
 <2887364.VdNmn5OnKV@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2887364.VdNmn5OnKV@opensuse>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_113515_871009_B46EFD23 
X-CRM114-Status: GOOD (  29.97  )
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

On Fri, Aug 26, 2022 at 08:16:59PM +0200, Fabio M. De Francesco wrote:
> On mercoledì 24 agosto 2022 01:32:53 CEST Al Viro wrote:
> > On Mon, Aug 22, 2022 at 04:24:38PM +0200, Fabio M. De Francesco wrote:
> > > Therefore, replace the kmap() of sg_page(sg) with a page_address() and
> > > delete the "nr_mapped" field from "nvmet_tcp_cmd" and instead pass a
> > > local variable to iov_iter_kvec() from the call site in
> > > nvmet_tcp_map_pdu_iovec().
> > 
> > I'd suggest looking into switching to ITER_BVEC...
> 
> Hello Al,
> 
> It's interesting that, for the second time in a few days, I've been suggested 
> to switch to the use of BVEC. Christoph asked for first[1]
> 
> I responded to Christoph and, in the same email, I also asked Sagi
> (the author of nvmet_tcp_map_pdu_iovec()) if he wanted to add something to 
> that discussion.
> 
> As you may have already read, I'm so new to kernel development that I still
> know very little about many subsystems and drivers. I am not currently
> able to tell the difference between BVEC and KVEC. I could probably try to 
> switch from one to the other (after learning from other code), however I won't 
> be able to explain in the commit message why users should better use BVEC in 
> this case.
> 
> My task is to remove as many kmap() call sites I can from the entire kernel, 
> and this is all I did in nvmet-tcp. After doing many tens of call sites 
> removals or conversions to kmap_local_page(), I learned to not go deep into 
> those details which aren't needed to accomplish the task I've been given.
> 
> However, since you and Christoph suggested doing more (I suppose in a separate
> patch), I did some research which seems to confirm that iov_iter_kvec() may be 
> good for what it is supposed to do.
> 
> Since you are talking again about BVEC, soon after Christoph did the same, I'd
> like to understand better which improvements do we expect from BVEC and why
> and when should developers prefer this or KVEC.
> 
> Can you please provide further information or links to documentation?

This kvec/bvec talk is a digression from your original goal: reduce unnecessary
kmap() usage. If anyone wants to take on the bvec optimization in this code
path, then by all means lets do it in a separate patch.

