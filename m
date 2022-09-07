Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC05C38145
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=paZ03eNN5gax+JhvCcNXMylxzv63TC81qXOSRPdOKqw=; b=ZFnW0M5qX4h4BNF9WjWezBxH5Q
	lgNTTaB5qo+tTRWbb9aK0U0Miky8NQidV7RmfIASLUpHYT3L4cUk3BTn1T+hDrzc9ZFmgGaLyjcoI
	i5fNmfBNGKJDPcqPALQUTXLpYD4VsKbT5ohdpZ3UXb65JPisVPHY+LepvnbH5Zw8XuMNBdNzBU8L8
	JnV2PGc+6kmnn3qWscVPCzYkpOAK4QSEOI8VUw+10cps1VqUD8kS3dQRMlhmLcEEn6ruVZQCuGbD+
	gM6nVs/vXmB31M6ojR5DwpVfrlgnteQWUtxWgPUsoG71wWPLOG3/d4dh0I+3IhnTBPxMAMk/xITGt
	/kjsW9Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVysO-008Ek3-Gq; Wed, 07 Sep 2022 17:30:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVysL-008Egl-KJ
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 17:30:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1324C61879;
	Wed,  7 Sep 2022 17:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B781FC433D6;
	Wed,  7 Sep 2022 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662571802;
	bh=HcpuT1k8vIRFDlu19npUOail7FyeszHBKFkYe1UKWHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ot52I5qoqmjJaG9iItngoInoRS5pxivCftukAq9o7AMz4EFyNU8NHZ4MyjtVVAf85
	 BSw98jzK4qcKQcGrj8blEeiCfKkkZ7dfAoBaLUDLl5KzdzMtkwg1pu6lS6hVoSsp6H
	 ua03PZEMBScgqVIWHwxXDSf+JakopcCBPjRnHkPRq+2VX+/dRo6g7bqvg2LuiA7+QR
	 TzKdEGvX/m4WgYHL6GILUnwBrmEBSrDYr54mL6UKeqlF2t6ReUjLAS2KkRW3SZzNPw
	 XizAfy0Q9W1kB6Q+yUYNdbpDaufuMpBfIS0eHXhGA2Pan8dRMtXzh8Scwaagnv4xUR
	 UfHuMDi6reuLA==
Date: Wed, 7 Sep 2022 20:29:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Patrisious Haddad <phaddad@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Israel Rukshin <israelr@nvidia.com>,
	Linux-nvme <linux-nvme@lists.infradead.org>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a
 QP moves to an error state
Message-ID: <YxjVFZYMLh19vwNR@unreal>
References: <20220907113800.22182-1-phaddad@nvidia.com>
 <20220907113800.22182-5-phaddad@nvidia.com>
 <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me>
 <YxiTxJvDWPaB9iMf@unreal>
 <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_103009_746364_E88B36B5 
X-CRM114-Status: GOOD (  22.28  )
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

On Wed, Sep 07, 2022 at 06:16:05PM +0300, Sagi Grimberg wrote:
> 
> > > > From: Israel Rukshin <israelr@nvidia.com>
> > > > 
> > > > Add debug prints for fatal QP events that are helpful for finding the
> > > > root cause of the errors. The ib_get_qp_err_syndrome is called at
> > > > a work queue since the QP event callback is running on an
> > > > interrupt context that can't sleep.
> > > > 
> > > > Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > What makes nvme-rdma special here? Why do you get this in
> > > nvme-rdma and not srp/iser/nfs-rdma/rds/smc/ipoib etc?
> > > 
> > > This entire code needs to move to the rdma core instead
> > > of being leaked to ulps.
> > 
> > We can move, but you will lose connection between queue number,
> > caller and error itself.
> 
> That still doesn't explain why nvme-rdma is special.

It was important for us to get proper review from at least one ULP,
nvme-rdma is not special at all.

> 
> In any event, the ulp can log the qpn so the context can be interrogated
> if that is important.

ok

