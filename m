Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5B2E77180
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yJeysie/jKNM1eNuhHBrQNE2J1h2Vu9UV/DBC/48LBU=; b=D8c5J8Y6awISPtR4Pv2oEjdltN
	I1nMqFIS/+SaGIRu8TLK5p4Fj5rna4X1EfhtVZPmn/3bbLxfmndUSDDDYjgd12UU5iDkTRU023mZN
	qpy2tP1CVqENlkVTHayI1SKneCyJouqLa3yANh18ezX16YT5xmaERPGdubarl450//pdy/VBEMkOj
	Eu7WTb/5dB++E83ZPmT6yTLCy8dG1NTbcvTHqATBkK0FKpB8Hh89iqaIifxp/+AKWERykO4vlsl0Y
	ahRR8InQtAm2DYSysH32pZ6LKmbbOkgDDMCWzhL5jam82i7DTQL59F11mQkhq53m8kCmgWTo9oy5Y
	GS1v2yxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKgec-00000008Z1Z-30yG;
	Mon, 09 Dec 2024 16:30:38 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKgdm-00000008YnD-40N4
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 16:29:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9D28FA417C6;
	Mon,  9 Dec 2024 16:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE57C4CEDE;
	Mon,  9 Dec 2024 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733761785;
	bh=s0ZJKQcRZlj/F3HdodiOs2sWsKd6fLpep2dSp6CdnhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkqQkahtR+OmH6AYMvoDAEUl+Sxxv/9Yi2/J37SmxMHZTnEjV+gen2QtnJpgwY06J
	 VwhQ9zg5T5nGmX68lVpnmrlUF+Tq9VrWvkWT+7kNO2LTuxvkHU/628o5v5qsonc0no
	 aJUKkk6jt6xIOzV24qEu+xM0yo5lQmiCYKw22dTe8sdb96Nl1lXL4kblijQJY47zom
	 1+x/MDCib3CjopldXPfgFMkWCiWZr+fvyZNlBImKU95dVhJcpw6mY2KiTRAeO8M0ra
	 1fDQgEyCSnvX+MoBH0mm7n+hmHRXs1jHxJiHx7Daagpb+TWAp2tjnU01wMHYOBF8hq
	 vI/Iy7x6ZpgcA==
Date: Mon, 9 Dec 2024 09:29:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	sagi@grimberg.me, asml.silence@gmail.com, anuj20.g@samsung.com,
	joshi.k@samsung.com
Subject: Re: [PATCHv12 11/12] nvme: register fdp parameters with the block
 layer
Message-ID: <Z1ca9liGKpasQ-vG@kbusch-mbp.dhcp.thefacebook.com>
References: <20241206221801.790690-1-kbusch@meta.com>
 <20241206221801.790690-12-kbusch@meta.com>
 <20241209131819.GA16038@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209131819.GA16038@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_082947_055720_510FD505 
X-CRM114-Status: GOOD (  19.61  )
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

On Mon, Dec 09, 2024 at 02:18:19PM +0100, Christoph Hellwig wrote:
> > +	n = le16_to_cpu(h->numfdpc) + 1;
> > +	if (fdp_idx > n)
> > +		goto out;
> > +
> > +	log = h + 1;
> > +	do {
> > +		desc = log;
> > +		log += le16_to_cpu(desc->dsze);
> > +	} while (i++ < fdp_idx);
> 
> Maybe a for loop makes it easier to avoid the uninitialized variable,
> e.g.
> 
> 	for (i = 0; i < fdp_index; i++) {
> 		..

Yeah, okay. I was just trying to cleverly have a single place where the
descriptor is set. A for-loop needs to set it both within and after the
loop.

> > +	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
> > +		ret = nvme_query_fdp_info(ns, info);
> > +		if (ret)
> > +			dev_warn(ns->ctrl->device,
> > +				"FDP failure status:0x%x\n", ret);
> > +		if (ret < 0)
> > +			goto out;
> > +	}
> 
> Looking at the full series with the next patch applied I'm a bit
> confused about the handling when rescanning.  AFAIK the code now always
> goes into nvme_query_fdp_info when NVME_CTRL_ATTR_FDPS even if
> head->plids/head->nr_plids is already set, and that will then simply
> override them, even if they were already set.

I thought you could change the FDP configuration on a live namespace
with the Set Feature command, so needed to account for that. But the
spec really does restrict that feature to endurance groups without
namespaces, so I was mistaken and we can skip re-validiting FDP state
after the first scan.

