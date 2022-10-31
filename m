Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C8AFA3741
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IPJ03AS9cUBXJsGmp9m2fbGly2B7cMFWzb4prN7WHBY=; b=BNV7xYQL14myh9eKuxOm0eJwRu
	8KRzU1l2XhdX+++TXD/wFYPuGqbOwCQkPtha2e+e++/791pkY0uqrbgpUia1ocCRK0vVSjiOSWWri
	j5eNnMZ3oKsL86JHc+VWVS5rn9BbzeZXLAxGbMHilkm0Q0hJy3xMNByp3P0X2vyENAJK9HVDha/L0
	rju+O5Whd5f03wmXW8MeqpoaczmmEsQrX7xbADS01TTWVWRmXn10xtVJWf2pqsKH21IFhkGj0S1mL
	UWUHWYWbtZybnl/80g6ZQCeaLmXJNNYP0CogixEDxHol6JyxfKzuUuJ5odwAXvzPVI3vfmSBnhrhb
	uPXYziWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opWOI-00CTu3-96; Mon, 31 Oct 2022 15:07:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opWOG-00CTsx-31
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 15:07:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B710D6129A;
	Mon, 31 Oct 2022 15:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4087C433C1;
	Mon, 31 Oct 2022 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667228870;
	bh=40UC4EJfB7lusUddnoy224BB7xS5uZt8pCblB8sUMUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IB47liWW8kmjvVKXd8IMYb23p3PKnLGxUyB48oc9vIgq9b/dRhKOIMyujebhXDnAR
	 GLjS7Jq9uaOHiY/C6E7tqBXv1oApCcIQ/jbFk73eKt+ZZTqP92I9mf2SFm4hpjNfY0
	 0PJr5bFwesvx5pcaUdC8SULsldShWVoLOW9OnShQn6A03tseHPayHLxlS16QgfIJb0
	 ZyOVwl7WdCOAmKFyETf24bg5zKWE1RjhIhAq06ijQ4GRVbT90RvZ9Ek5yGW9mEvp2T
	 P2xdi5kf6xqdeauWnXUM09tjGeTzhpe+TI+ZGE+K+WmhPWz1wyNsI+44Pg/x113eff
	 YAaV/3KeTiCVQ==
Date: Mon, 31 Oct 2022 09:07:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: implement the DEAC bit for the Write Zeroes command
Message-ID: <Y1/kw75JaNsnt1iy@kbusch-mbp.dhcp.thefacebook.com>
References: <20221030162906.3390-1-hch@lst.de>
 <yq1cza8qc6o.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1cza8qc6o.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_080752_207495_B257021B 
X-CRM114-Status: GOOD (  12.35  )
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

On Mon, Oct 31, 2022 at 10:54:40AM -0400, Martin K. Petersen wrote:
> 
> Hi Christoph!
> 
> > +	if (!(req->cmd_flags & REQ_NOUNMAP) && ns->dlfeat & (1 << 3))
> > +		cmnd->write_zeroes.control |= cpu_to_le16(NVME_WZ_DEAC);
> 
> Shouldn't we also verify that DLFEAT bits 2:0 are equal to 1 to ensure
> that deallocated blocks actually return zeroes?

The device must return all 0's for the range covered by a write zeroes
command no matter what. The controller shall not deallocate the logical
blocks if it can't guarantee reading deallocated blocks will return 0's,
so I think it's okay to skip checking the lower dlfeat bits.

Minor nit on the patch: I think seeing the dlfeat value as an enum would
help.

