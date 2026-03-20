Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014CF1093187
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 07:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6xKbm0cEn2SfiOEekS5So+OL7BJuAGcqKdJ+U82OGMc=; b=O6IotxlZqIZwKOz9POp2uuEhSo
	m8MjEYLaG3e0psN60N4kIO8x0NNtgP4FbIgyCk2DAtGk0qPKX/sbOiP7QNtCeL/wy3KiL3wxmGfrK
	Mvn1aXwfSFNXn0IaGLhern3ed2PFWDfpcxTO/7Wl2NyKMxYb1WKX5MKfgAMtcJOUPDpZW1ovXwKgn
	eI+owttKEKzdZS4vmjXTLQT/zczVcYSIVJWmUKD5HSeRtzyoiyHQ1w8DcaBplYzSDyeon0ykH4xbU
	LNt54REfsH6dz3I/r3GckXjwVx8A6zOeFlQk369kH25Pqr9U1EJ8NyB5qUEpH+75bt3trjfuvStrC
	GSUvbKeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Ulu-0000000CIuY-0hby;
	Fri, 20 Mar 2026 07:59:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Ulr-0000000CItw-2kFU
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 07:59:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 039936732A; Fri, 20 Mar 2026 08:59:49 +0100 (CET)
Date: Fri, 20 Mar 2026 08:59:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, kch@nvidia.com, gjoyce@ibm.com
Subject: Re: [PATCH 1/1] nvme-loop: do not cancel I/O and admin tagset
 during ctrl reset/shutdown
Message-ID: <20260320075948.GA14895@lst.de>
References: <20260313113856.1366774-1-nilay@linux.ibm.com> <20260313113856.1366774-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313113856.1366774-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_005951_833879_69DF0416 
X-CRM114-Status: GOOD (  13.32  )
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

On Fri, Mar 13, 2026 at 05:08:48PM +0530, Nilay Shroff wrote:
> Cancelling the I/O and admin tagsets during nvme-loop controller reset
> or shutdown is unnecessary. The subsequent destruction of the I/O and
> admin queues already waits for all in-flight target operations to
> complete.
> 
> Cancelling the tagsets first also opens a race window. After a request
> tag has been cancelled, a late completion from the target may still
> arrive before the queues are destroyed. In that case the completion path
> may access a request whose tag has already been cancelled or freed,
> which can lead to a kernel crash. Please see below the kernel crash
> encountered while running blktests nvme/040:

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


