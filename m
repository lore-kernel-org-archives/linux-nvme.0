Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D82EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 05:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iFaYrvl53g8+4klWT85A1o0GNr1utPChVdOG2EDpvSA=; b=scISkt/gl4qy0+50Cav0xJm2Px
	EASTjupXMvIL8jRLX4V8poBJJ3SY+89hQAcd0qlOT1Ra9W7fKjp62Q9KMMvRr8lH4eqg55w9t0zZ6
	C74Fhly+CsUGrYHGBlVngZXlupcFNNR7yQDeKlbo+9EZXcgFtZ8XAVdSGfsEPeKaVrJYlf+0Lwks6
	sMO8GLBR515qnqT5JXTlx7wkvMLe/9Ookp56TnGXPVXtgilYginsUtsYiiaESyZPRMYeG0nksSIsN
	nSp/WCIqBF9C6my/z1q7MVvuxNNmrabtkxY8WaQjDGTKXqxbbCTipE8BCW1MjzlGKUSfHZOfgqzVM
	jLsMkkpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEk7v-00Hat0-2z;
	Thu, 29 Jun 2023 05:23:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEk7t-00Harm-0V
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 05:23:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B38A67373; Thu, 29 Jun 2023 07:23:26 +0200 (CEST)
Date: Thu, 29 Jun 2023 07:23:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	ming.lei@redhat.com, brookxu.cn@gmail.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] nvme: disable controller on reset state failure
Message-ID: <20230629052326.GC16819@lst.de>
References: <20230628145814.1068653-1-kbusch@meta.com> <20230628145814.1068653-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628145814.1068653-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_222329_343455_D6AD991E 
X-CRM114-Status: GOOD (  13.39  )
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

On Wed, Jun 28, 2023 at 07:58:14AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If the controller is not in a RESETTING state at the point of reset
> work, we have to conclude the controller is being deleted. Go to the
> cleanup on this condition to ensure proper pairing of request_queue
> quiesce state.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

