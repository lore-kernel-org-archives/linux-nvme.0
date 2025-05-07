Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0D7C369DC
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 07:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2aiSSfTARXLXB+2b6Ug2v7LTxgYSipXgqDvEptgUSWk=; b=IB+4dXNMujZCr9u/5u2yCHDw6D
	ed3L20baZYZFUQqN4Z0LE5GNX1EDXUnsxbg0tZAOELqQTUJnrblhAD/h2YWG3FliQeW0++iYlH4LK
	z4RX89PLadWFrFdeIEU9/wQ43Qewm5Fr9H4w0O1P0p8cbXt7AGMUX+bOIQkDpRuUwqdvUc88CtZMg
	A/ltQBUN4kE5VFhwmJk08AS0YG6/9JYvo5oUxYunFOTUlAi84H9/k7qbqa4wPi2TohiTzadEgwu3n
	j2uUxIEUhL9fup1gNweuc8uqt4x3+iw5DNP+/KX2dRCc/DySo0ojnsgbB8ITVn0kM0rB6kJa5+45C
	oJ/lxQnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZ1A-0000000EU7j-0uuQ;
	Wed, 07 May 2025 07:16:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCYnP-0000000ESDt-1dik
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:02:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EF20E68BFE; Wed,  7 May 2025 09:02:18 +0200 (CEST)
Date: Wed, 7 May 2025 09:02:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] nvme: unblock ctrl state transition for firmware update
Message-ID: <20250507070218.GA314@lst.de>
References: <20250502-nvme-fix-fw-update-v1-1-cd7a9f3031f7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502-nvme-fix-fw-update-v1-1-cd7a9f3031f7@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_000223_565071_25CE89A7 
X-CRM114-Status: UNSURE (   8.87  )
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

applied to nvme-6.15.


