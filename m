Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3039AC44516
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2026 01:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y0JmhZ8pROCmk2R5GBPaMFv77g2uucL9m80QATOf3sw=; b=PrmpSWrq3j30oY93sYZ/qtqUTY
	IpANmd3J94G/DF2GJXrE+0tvZCCBJZrl6CeGJE/2umTinYPwD1Kr71F5fVcd2l35fSBbVV+nZjy2N
	tg1kF6o3LbF8DXaz92BWO0YaJeh3PNVL8Wgb0mX1kiQgwNHz3td6ZxNxrMEGXhf/jsiv87LWr5+Xe
	ZM4AeZXKlRRPr8XyJtwHWG9yIoyhR44Gvkr1MM5dpGC+0PjEHV0cAXhaSou962PMameXY66vmbdIl
	2Q3fBiOOdQcTMbJU+SLTJZZsJE+oat9dsa4clYnTlIfIQHObmrWn7AtEfB1u4IP42ikA2TrPHzPM8
	f3iP9GVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkXWR-00000000uYj-2eAL;
	Fri, 17 Jul 2026 01:37:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkXWP-00000000uYP-3TwK
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jul 2026 01:37:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 894B440B72;
	Fri, 17 Jul 2026 01:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300ED1F00A3E;
	Fri, 17 Jul 2026 01:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252269;
	bh=Y0JmhZ8pROCmk2R5GBPaMFv77g2uucL9m80QATOf3sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jnz6qrwi3DFi3ZS7rV1dBwOFqqXGvR3y8uLRZveMwa9VOGI3QcN21MsaWuO1x8g6m
	 7880yH2flSdFn7cqBZ+1AJxboZOIGHUcqJZex3S/CpGsv5BX1jnO9Imuv0J5K7jURD
	 0ssLVLgV2e4wlLhOF+IyBy268zVVu05ivKba0+lsQQnTYeHgA8ZoT1XB9D0zcL8soE
	 Uu4Y9M5ZW/ljIfP+sp6KsIRVL4tMJISkP6nxht/HHrFOa9o56sbKZuz+nBUQ4oYp2e
	 hBIF9KpEuSJYf3UhTJ21xptmUtnctlhLbu57KWwbM4Lnr2tN7rErzZAfu+uRPQbwnF
	 GG8JV5khTPUug==
From: Sasha Levin <sashal@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Roger Pau Monne <roger.pau@citrix.com>,
	xen-devel@lists.xenproject.org,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	stable@vger.kernel.org,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH] nvme-pci: fix parameter order in nvme_free_sgls() call
Date: Thu, 16 Jul 2026 21:37:29 -0400
Message-ID: <20260716232340.0002-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <alYfV2l-7p4Y3eX-@mail-itl>
References: <alYfV2l-7p4Y3eX-@mail-itl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On Tue, Jul 14, 2026 at 01:36:55PM +0200, Marek Marczykowski-Górecki wrote:
> I think this wants to be included in v6.18 too, as it also has the
> faulty commit. And indeed, I do hit this issue when running 6.18.38.

Nicolai Buchwitz sent a 6.18.y backport of this, which is now queued
for 6.18, thanks.

-- 
Thanks,
Sasha

