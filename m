Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145B3C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 06:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ryYqY1CLbCGsMHJ6kkQ1iGNgc+KQ+PrdQjZhcc2dR8=; b=L5uA8wS3LeNMLsDPFCM1gqJRhV
	czbquEOAsv5ypKgS+/DZtnHiK5STlnD+TL/jYqrNJMyTXkZyabqC7PcrGFd5DqEnXbhjWcHv5OjiK
	MFaZsyequc/hCapzIzzMBzUAeCaf72e/jJJ1+Nn6wBpRWvsK4YLl1NIGCVAEOoU75kGi1PJ4jGJH7
	pizB09nXCB3vcDEdiIvhi9kGnQ7XNSFIRCJdjtkmOHO5W4XujZDtq73FWbDyZo6Ps0/M6+hXbQNGx
	7j9qb+zANYp2DpngCAWSSWOWFT5u7FLOchGCXi31e1vo/0zhRZQMr3xZFZCbMNjY0tN3+2ShtFpx9
	0onhTR8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nGxnm-009BEY-CQ; Mon, 07 Feb 2022 06:47:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGxni-009BEB-T1
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 06:47:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A11F268AFE; Mon,  7 Feb 2022 07:46:53 +0100 (CET)
Date: Mon, 7 Feb 2022 07:46:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Warren Chartier <icebalm@icebalm.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: PROBLEM: XPG Gammix S70 Blade PCIe Gen 4 NVMe drive unusable
 in Linux
Message-ID: <20220207064653.GA23286@lst.de>
References: <1897892278.92.1644177774073.JavaMail.zimbra@icebalm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1897892278.92.1644177774073.JavaMail.zimbra@icebalm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220206_224703_132139_C5CCB229 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
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

Based on the warnings the drive seems to have rather broken VPD
support.  Did you check with the vendor if there might be a newer
firmware available?

