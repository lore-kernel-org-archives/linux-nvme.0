Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72496CCF9EE
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ijSKHOfM7pb43YDZrmHrfT+AQ90LdZtwyqnzHfuQ6DM=; b=gtiq5OAtN6CXceI0BB7exsL+WP
	3XU6m004K8RckvDAayxx0lDdtD8JyruLKCWG3YKbRIDRt3xsPttGPsgZMg9Na9y1XIoMQQ8rCBdq3
	vu9Ly3xwaYSYaDogBa4ErupsYlAOOv5iL8/xhypZOMO20eTGoRhTyNn7U/Vh0ho0Qaj4W98Bjxrth
	cg3bVS3/Uj+ZSrE9V7UIYDxvvHrrEflapJk7THFGi7bU0/7yosH/Zs73FauZpgq1b10wIdqaV2Edk
	f1Z8woqfun9oQsTv7puJNP5vCxxFMI2087gmlVCMtxBn8vnau3yVhHvENh4vr+wk9xfdJga9+Y2n4
	PT1CjtWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE1up-00000000NbL-06mn;
	Wed, 29 Oct 2025 08:52:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE1um-00000000NZs-49ZS
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 08:52:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47C66227A88; Wed, 29 Oct 2025 09:52:17 +0100 (CET)
Date: Wed, 29 Oct 2025 09:52:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] nvmet-fcloop: check all request and response have
 been processed
Message-ID: <20251029085217.GC32307@lst.de>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org> <20251028-nvmet-fcloop-fixes-v1-3-765427148613@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-3-765427148613@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_015221_168157_30D920F7 
X-CRM114-Status: GOOD (  14.21  )
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

On Tue, Oct 28, 2025 at 04:26:22PM +0100, Daniel Wagner wrote:
> When the remoteport or the targetport are removed check that there are
> no inflight requests or responses.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


