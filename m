Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76BFC27C4F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 20:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k2KcOchs4iMySFC8+wcG1fm8qAAbzDydIHg/A63hps8=; b=Y64SYZpJGtBBQc4DgKIomXj04A
	U7v37TG7q/Bm5mgMT6cKEC+mccmnB065KRq0SaEUVTxW0B821KTT1neNLacQy6gcYrlc3+SxPuap5
	JT+pteo0tIHw7fWc3AZP6CDrWMeU9+tsuBF1uOSA6bYoULGb60zN6gmgydMgogW6B4owgxpiTs4WU
	RjP+1ODm8DHtmOj5vtKZd/SHCBWpiTtOoUthaM79LqQEXSg1VCJkAsCbYlLvtcBCXdkZ8OTkqlS9c
	7mGXTmKke4XbCVEIlX6eeFiTaPC63ytOX9CseaoNu4VNMB9u/aIaKpKSWFVVl2nJRbLoGH8H5Itqq
	i8EMEutw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD9Fj-0000000BQUp-1DEZ;
	Fri, 31 May 2024 20:53:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD9Fg-0000000BQUM-0URB
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 20:53:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3266462A98;
	Fri, 31 May 2024 20:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5B1C116B1;
	Fri, 31 May 2024 20:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717188806;
	bh=u0IZvBzvgsXx4FQSLkYUrLM1SRdnxJAQRVUUMCnhr6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjknRjQFBo818f7GAJ5/tfN9LKPPI1hHYJBHjZNF7FB+aTQM6pIooNa2wssLxGhN8
	 jJnsEBRTl0kxAOPt07Rmwl+23KDPkSVAgplodZ3qgxjtDZKgRlNKtdXYx4BXDzEpf6
	 uzyucgjvC9+9UlF0SGCTzIK+n+oy48t0XzzJhWglVwKBp5CEoLH6MpTaA4FdEIwVcv
	 fZ9IUTsAqjTqvBSSmb888y/BZt2/vG90tbDaU4HQnwo0/KP362F6XkKMlFyhvRYAK2
	 BTMqQIB1opKvquviikN+KRxvitGMlLVcpKjo/xVOq3P3D4a8xqILFzSk508jwi6zsx
	 QeLFT81X1lATg==
Date: Fri, 31 May 2024 14:53:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Weiwen Hu <huweiwen@linux.alibaba.com>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v2] nvme: fix nvme_pr_* status code parsing
Message-ID: <Zlo4xLAPtYNdvS_k@kbusch-mbp.dhcp.thefacebook.com>
References: <20240530061646.52167-1-huweiwen@linux.alibaba.com>
 <20240531081650.GA19765@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531081650.GA19765@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_135328_417887_A5956A07 
X-CRM114-Status: GOOD (  12.40  )
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

On Fri, May 31, 2024 at 10:16:50AM +0200, Christoph Hellwig wrote:
> On Thu, May 30, 2024 at 02:16:46PM +0800, Weiwen Hu wrote:
> > +	switch (nvme_sc & 0x7ff) {
> 
> Can you use the opportunity to add a NVME_SC_MASK symbolic
> name for the magic 0x7ff?  We should have done this earlier
> with already 5 occurrences, but better now than never.
> 
> Otherwise this looks good to me.

Yeah, I suggested sending the minimal patch first just for the
backport-ability.

