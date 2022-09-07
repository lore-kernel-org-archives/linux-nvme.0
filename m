Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EEEC54EE9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 12:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F6/hQwiPPVV0hGzU1EHvHZ10lMt/9QGO9wMiu2QcCpw=; b=RR/iOin3rfA7W8YR56Kd1hEhaU
	5nGcBItTFjKg2bAhypG9A9lMButM+n82q3H8FXrsjpBuGsj6lg4je5OTNcwpyY3BdytyecXJQnwUu
	oEhgXe7tMiv5n5eut0rAgyfz5AVl3yl7q6ljzqPuozpaAONkW7S9la30+zJ7pq6XZ5VeytM963qGL
	ixIVoM30UhEBPllHCvzSv/Xa9vHJoG+dOCP6fpWKoPAPj8V3Rb403z/zYZaGuSkDrCmVcRYN2z7mA
	xP2+pzJIqFw1W2a3ImRk/yMrHH7u8Q75pfQNykhv60tL+zGWzhDk/mkFaCKHoGIAoe+2xXwGlgWFI
	A9X/IJ9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVtkv-005vm2-GH; Wed, 07 Sep 2022 12:02:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVtks-005vjQ-MC
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 12:02:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5824967373; Wed,  7 Sep 2022 14:02:00 +0200 (CEST)
Date: Wed, 7 Sep 2022 14:02:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Patrisious Haddad <phaddad@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Israel Rukshin <israelr@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Linux-nvme <linux-nvme@lists.infradead.org>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a
 QP moves to an error state
Message-ID: <20220907120200.GA12104@lst.de>
References: <20220907113800.22182-1-phaddad@nvidia.com> <20220907113800.22182-5-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907113800.22182-5-phaddad@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_050206_888796_9B18E9BF 
X-CRM114-Status: GOOD (  13.12  )
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

On Wed, Sep 07, 2022 at 02:38:00PM +0300, Patrisious Haddad wrote:
> From: Israel Rukshin <israelr@nvidia.com>
> 
> Add debug prints for fatal QP events that are helpful for finding the
> root cause of the errors. The ib_get_qp_err_syndrome is called at
> a work queue since the QP event callback is running on an
> interrupt context that can't sleep.

What an awkward interface.  What prevents us from allowing 
ib_get_qp_err_syndrome to be called from arbitrary calling contexts,
or even better just delivering the error directly as part of the
event?

