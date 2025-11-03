Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA54CCFA03
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 21:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E5xs2P6ZbQJnuc8Ku36RunxmB2ME7Rzu4NsrZP5p/aM=; b=14p54uaMqStPUQ5+tpNi6orjHF
	V29h1sAJD4eWKfE4zZjHHj1UKUYESUPSspx3QMZP3NaVIJJWGHkQlvVCGmNGoE4y+/mns97trRyUy
	ZCJhgCumzL2fnAuhvjoJfaL8g8fW0lo5iIBkjZtiRtduryBMy8/bw0pUUb4IcEeJ0PcNE8BgEFdCL
	Qo3NK/OI9fOVV5EPoThMYWb/hbd28lCDLqap8qdaWeG8vPVCkZC55J8MMhr9gzS2zK7aS1psyZXF4
	tjtV7j109dBxwgr1JM3VTdvVSvaVgmroU7Iru8uN/hoiBkW+hkQquVj0ycS1bZbwdyZ1QRfyCAmMn
	EkY+5eTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG1qb-0000000AdVo-2Uih;
	Mon, 03 Nov 2025 21:12:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG1qZ-0000000AdVb-2c0w
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 21:12:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AE4DC600AC;
	Mon,  3 Nov 2025 21:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21843C4CEF8;
	Mon,  3 Nov 2025 21:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762204334;
	bh=E5xs2P6ZbQJnuc8Ku36RunxmB2ME7Rzu4NsrZP5p/aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AexXf0vzgBck4u9vqdslOQc5a/nANDeKNpT6qz4B0+OT9bVU4MGm4QR4vvrM7eZ48
	 vcJIx5COE1iOgjfUSDLmAYBpsistvTkZefIwLmvbMZ++jyDTBcQNTYuRAJnDt/Yf8P
	 3Ixb9CHMGPNbDyUwRX3q9GJ1Jr1UMsbu83hHiBeWIwICyslaDhCoJhT+rN75oX0ita
	 l0MCm2o6BbYXuHWOfpzYakGX6ihQVJo8bWDKCCMbtznwQCq+Y4A21ad/oXpJc5uNXV
	 WJFRotdoJBtHBzV8WDElj+IGCK8qcXQXLpVupmMJPP+LJ8jn3vujV9d0+KTlAYEH2G
	 9KnlAd9mhEi6A==
Date: Mon, 3 Nov 2025 14:12:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"hare@suse.de" <hare@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-auth: use IS_REACHABLE for nvme_auth_extract_key()
 declaration
Message-ID: <aQkarDAUJwoZn6_3@kbusch-mbp>
References: <20251102031742.69984-1-ckulkarnilinux@gmail.com>
 <20251103114621.GB15280@lst.de>
 <aQjCQKiN5mzw2oY3@kbusch-mbp>
 <3bfea609-ad1b-422a-b070-9e9604777a8b@nvidia.com>
 <aQkNims4uAaUKcyJ@kbusch-mbp>
 <ade91e2e-be74-4070-9226-a750e3eba32b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ade91e2e-be74-4070-9226-a750e3eba32b@nvidia.com>
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

On Mon, Nov 03, 2025 at 08:28:35PM +0000, Chaitanya Kulkarni wrote:
> ohhh didn't know that when I sent this patch error was there ...

https://lore.kernel.org/oe-kbuild-all/202511012300.eAcEQQP5-lkp@intel.com/

