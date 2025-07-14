Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85D9C83F1B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s6auRUxxROMcVS8bl+tz2bEBNZXC6UaUWMqnNU491RM=; b=1HdBgcqrWFeqO9vgBGZC3OKiX8
	/dSFMY7UidYnRZlvA5h3fEKcJNtD+rH+/lEhu4HIuoTpLJIgpgk5GTJ/a3dNrvbLFaWQ4iAbWQbTi
	3AMNy76OvgwQx2uVkmV55tQpuEx0NB7KpUtU+5iql97vNQanw07hrHCKaCeVcTV1qNmKxduU//a8a
	W6ZQgnQvjzqkSPU1g/Oc9N7CqOB6jNvdDJGzp6tZEAwxZhF8XJEq8bqvjsKyVY/9jRTV4dFHHCHpR
	rFyQM0Gg3PCEVgXaBZZ7dRglhX6ej9+2iIL2WMbCgEDyCYRPOoY85KeK57RbLEL7tOXIdwafn3yex
	bJPzYlRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJfM-00000002Nr8-1fA6;
	Mon, 14 Jul 2025 13:56:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJbR-00000002N55-3H1c
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 13:52:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B98E227A88; Mon, 14 Jul 2025 15:52:15 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:52:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, alan.adamson@oracle.com
Subject: Re: [PATCH] nvme: fix endianness of command word prints in
 nvme_log_err_passthru()
Message-ID: <20250714135214.GA11944@lst.de>
References: <20250630162153.4040149-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630162153.4040149-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_065221_957181_1AB94B3A 
X-CRM114-Status: UNSURE (   9.83  )
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

I ended up applying this to nvme-6.16 - it is a trivial fix for a
tracing path and waiting out of past 6.17-rc1 just increases the
chances it will get lost.


