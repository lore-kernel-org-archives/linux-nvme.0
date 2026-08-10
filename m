Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D6AC5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 17:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sqa+CzardFgcHM/fUT7Ot0ptfGnY6xU2WkYf7CKr7V8=; b=JEtCIihsjIPdM6MFREcc+VBXm+
	j0yJymvolrwOl64HBlhRg6lkcN0d2NcN0RGdt10Etyu5cx0QWVJAFemty7zxfDKVOE8S0Pie8xfaP
	9BqkJytLd/YdKleDJ7Ipr4dFBNyjKA/XBhExMVTbAeJsLJO0LPnEMtmELLLMEnII/eoRER+zg7sNE
	KlCSLzVcZzKewu//lQWZjEueJeBE+o8E4gfXbFRMU4VAH3lYJ1Dcaw8VxiBQmomDfRVr3aAXhz25l
	5+KKPoFdjnrh1tSlVCnBCqGucObN8EGZ3FGfVh3WrHSTkSXHzKueYGtKeDy6x9wp/3Z19KekT6HZv
	BtTrz99A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtTtV-0000000CXJs-0p1L;
	Mon, 10 Aug 2026 17:34:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtTtU-0000000CXJc-03Tz
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 17:34:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 37DAB600C8;
	Mon, 10 Aug 2026 17:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AA91F000E9;
	Mon, 10 Aug 2026 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786383274;
	bh=Sqa+CzardFgcHM/fUT7Ot0ptfGnY6xU2WkYf7CKr7V8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I1gdsBt06QDRjinAEnXGUKyCR6grbaV+2av9cLHJB1BsErwQ7cm9PZ9L8KexFTZjV
	 842+C0MvL5b79Edq3pzN3V2ui03bBleJPfWhPHz3mu9YP3/ZihHdIBTqfvEnJEZn8e
	 xZ8pXzodOLnxUmMQ/1B8qfySOpT4J03RSxWMfs8I3/P3UGrbJOhbTQaVyiljMe2AXr
	 754GlY6Id4XYJwvh+4v3nUguxvd786m9wgRQKCNOHHAIs+6qm1vFjhns1IVkqVYELk
	 3c12g+6fa7Cmh1r/Zszov5OVYejROsjSoJ5toXVUTpNobNdLHr/ODWnXrDH8MqiQJm
	 P0rVqYI3D81cw==
Date: Mon, 10 Aug 2026 11:34:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: bound SGL data length before allocating
 command buffers
Message-ID: <anoLqGHdyesTN0IM@kbusch-mbp>
References: <20260709132533.44195-1-security@auditcode.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709132533.44195-1-security@auditcode.ai>
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

Thanks, applied to nvme-7.3.

