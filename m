Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CECC369A8
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h4jugw2842L8FhrzoYhpukdsAftq2C3LkIR7a4jbZG0=; b=DIs4xo7kZDqI5isRcoc+otH3Np
	VqWPsfnVRLSa1jfDTNrtPX8JhYQNrFfF06E9y0jFH6YDuFDWJwADxo1t6+M21in09GQTpDy20kwhe
	gvzjkAC3yIx3+aOvZHIcDLOhGdioz+qfO0sRDgDgTx6KZb3Tx+ySvDfUwc9+aKRweMlZnRWMR7KGr
	vlnOcPsvZyr4bd1l3KViwpSZOyt+Inv6K39uAlmxt3ZnL6fSco9xT8dPB6+o7nzt89GR9BEbzUPcT
	UuCElkDNfEAqiBk4NvixjByUYymYyE/6DmNXCjcZc8KC5TIFWeiSkxOvCvVikUArq3gADXNPwGzB1
	wEim6Z9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2ptW-0000000ACIq-2D0j;
	Thu, 10 Apr 2025 11:16:30 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2o2o-00000009uRM-2sbo;
	Thu, 10 Apr 2025 09:17:58 +0000
Date: Thu, 10 Apr 2025 02:17:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Issue with AWUPF when using multiple controllers in a subsystem
Message-ID: <Z_eMxjUjUW2JJzH-@infradead.org>
References: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
 <Z_Y4TFTqriOTxXsO@infradead.org>
 <23d2c5c3-0832-4b62-a151-74a021c63201@nvidia.com>
 <Z_eCIQ5dtv9oKd9X@infradead.org>
 <Z_eKSrfAsjT94hZD@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_eKSrfAsjT94hZD@kbusch-mbp>
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

On Thu, Apr 10, 2025 at 10:07:22AM +0100, Keith Busch wrote:
> You'll get different results depending on the non-deterministic order we
> enumerate. Can't we just change the stacked limit to the smallest
> observed value as we go?

That means discovering a new controller could lower the limit while
a file system is using it.  Not a good idea.  That's why I suggested
only supporting the namespace variant ASAP until we actually grow
users relying on it.

