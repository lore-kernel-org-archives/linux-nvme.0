Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA83BC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 10:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DLydF/y5Xk9aJKR8wDr8K5R0X92tsvPCjM9a2uF4YlI=; b=jvKJ7JGhnci1DuMB4iTosm2mhJ
	HzLGuhkvDmsMPBJijTTJYl0hwH7jjahelFzc9aFyZftJYY5nNsmb7XbWcbn2kfIrTfSRiiUDPUbYm
	yma5J7uc7qQxKj0/p/xpk0jQhq8QUe1AU7C8oT5fVxRWJgR0Vn4wy4/3zdOlimRTybRBvcOFqy5SH
	fZPuggATY8dRvaVPjftDxLbKIpfkoyaHQvRkUha/4K1E4QaPUf4/mwwchMR5yXiISkeTJ0Y9kTojO
	btpy/zrf+ZoRz6SS7SwLRfHNzCl4TRJIL/uEe92yZ4ALjoDpZs5u5yNL2rsXdb7uRiWoilmmJD/1B
	e3OaZr6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1outMt-00A3mS-Oc; Tue, 15 Nov 2022 10:40:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1out1C-009ome-U8
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 10:18:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E56267373; Tue, 15 Nov 2022 11:18:06 +0100 (CET)
Date: Tue, 15 Nov 2022 11:18:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, gost.dev@samsung.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/1] nvme: return err on nvme_init_non_mdts_limits fail
Message-ID: <20221115101806.GA27559@lst.de>
References: <20221102171708.3303614-1-j.granados@samsung.com> <CGME20221102172043eucas1p226576ca0e881424e65d2e0b8c19d060a@eucas1p2.samsung.com> <20221102171708.3303614-2-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102171708.3303614-2-j.granados@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_021815_174483_F91B9512 
X-CRM114-Status: UNSURE (   8.31  )
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

Thanks,

applied to nvme-6.2 after dropping the pointless goto.

