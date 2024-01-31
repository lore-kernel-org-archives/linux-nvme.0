Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB95C47DB3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 17:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=P9KeXpGyhGzsw7yx9WXEth3Wrp
	Ikn7Rqmo/IeBtbIwkfZxw4tO9wWFQtTqtoQ34f6a8gGOgOopFOyg1mKh9ffxnqN+nB4IT645cqZZ6
	PC+0jdc3Xm/u2a68SfVqoaL7AN1kKchjj14XCHE2uC071wnvHvCsVfBG3EaeUAc6hIlTJj0fcJbNq
	pTDUUzGYI3SdWTt39Rdkg0glK7SjotrOemJ39bQpLoDr/TxvBsDSFbm92IJ0jT8749IUCtZOdBJNT
	RvBHF2BL2makYvbPk1zTetn3kK2oXRK3sdI5G48/5o27kQ5wyWd+Ao7PjrwjshEB/RXxRrYXl2Nat
	BNFrlHBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVEUH-00000004rp6-3EJC;
	Wed, 31 Jan 2024 17:35:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVEUB-00000004rkW-41fx
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 17:34:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 59F3A68AFE; Wed, 31 Jan 2024 18:34:53 +0100 (CET)
Date: Wed, 31 Jan 2024 18:34:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/5] nvme-fc: log human-readable opcode on timeout
Message-ID: <20240131173453.GI31567@lst.de>
References: <20240131164315.160042-1-csander@purestorage.com> <20240131164315.160042-5-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131164315.160042-5-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_093456_232881_C19505F5 
X-CRM114-Status: UNSURE (   9.98  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

