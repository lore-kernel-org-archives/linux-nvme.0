Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E7FD75E30
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kx+yGyOMjuQrJhft75ULOxtWv9ZxMvWqfl/eZLGQsIU=; b=RjaHafi+PnAGjwtWMH3IjRNwA+
	4WDvcAupyQvpVE2AOVsaMxjXMlyQcH8q6tsGzMgTw9AGmGstO25nFRwkA9jb7DSwF60mhOGeOIu50
	oh9kUCjMI9mQlS0wsDDy2v+QfS8/zH4E7lcmF6++xTz3dWcVCMoimoXlau+qtXOdlSqMxsjr9a8/h
	zLk89GWGUAH7cXdFpx0qT0mbOgc0h150+vcN9UJR77jUUAFlk+EM8FVk1zBJ7rnyWBN68wecDlcDD
	JTYieUIaoglMJp4qODED43xPPdFUm3Tz0nbxnAG7hRZdExXknnBEFnnZETn9Cq4DBQK5QFNbd935+
	mGrUiQjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tESSo-00000002Q2P-3iWF;
	Fri, 22 Nov 2024 12:08:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tESSm-00000002Q1f-0pkk
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 12:08:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C82368C4E; Fri, 22 Nov 2024 13:08:28 +0100 (CET)
Date: Fri, 22 Nov 2024 13:08:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	chaitanyak@nvidia.com, yi.zhang@redhat.com,
	shinichiro.kawasaki@wdc.com, mlombard@redhat.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH] nvmet: fix the use of ZERO_PAGE in
 nvme_execute_identify_ns_nvm()
Message-ID: <20241122120828.GB25707@lst.de>
References: <20241122085113.2487839-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122085113.2487839-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_040840_381766_28E525F5 
X-CRM114-Status: GOOD (  16.91  )
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

On Fri, Nov 22, 2024 at 02:20:36PM +0530, Nilay Shroff wrote:
> The nvme_execute_identify_ns_nvm function uses ZERO_PAGE
> for copying SG list with all zeros. As ZERO_PAGE would not
> necessarily return the virtual-address of the zero page, we
> need to first convert the page address to kernel virtual-
> address and then use it as source address for copying the
> data to SG list with all zeros.
> 
> Using return address of ZERO_PAGE(0) as source address for
> copying data to SG list would fill the target buffer with
> random value and causes the undesired side effect. This patch
> implements the fix ensuring that we use virtual-address of the
> zero page for copying all zeros to the SG list buffers.

I wonder if using ZERO_PAGE() is simply a little too smart for it's
own sake and it should just use kzalloc like a bunch of other identify
implementation..


