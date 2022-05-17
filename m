Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFABC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 22:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+WD0lycb2QpQTteZPKsLkxLeNCln2dUwE5vUU5oWe88=; b=ln8orC+qc5FsgdPC/FE6HkrNd9
	0BuXgdlLrefi08NYJ8Wb4yU6jOecAYTTvsjpE87t0oX8iEK017t35r0AUmEwQqCDBhtF5IOY7Qd6v
	Qfp4nnMj8fThLYIcXIjg4ltB12Hn/2Q9UhBEr1hYLVT20PBmzJY9isrZfcqIAmBwq0Mm1Oqh9Tr5W
	ZD/MV+MP38IXm2e4rjfdoTxJRInculmyMxBkCb8RVjwHkoMWQsgUnyp8QUIHkev+SWipWdH8KttXY
	5VY3nzFRCZFY+4Yblr8VWTQnrmIdN/LvamHNv5HdEJnN+w2k2CaA08XySHZ5Z53VJVM+Gg8zfrlnr
	8DuSYrVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nr5vw-00G9SQ-Sw; Tue, 17 May 2022 22:44:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nr5vu-00G9S6-MG
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 22:44:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3466361182;
 Tue, 17 May 2022 22:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315B1C385B8;
 Tue, 17 May 2022 22:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652827488;
 bh=+WD0lycb2QpQTteZPKsLkxLeNCln2dUwE5vUU5oWe88=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Sy5uJgPEILoTmbeXGhmYS4Ruv7QVM02dsZjsvuZ0KYtYuX5Sg9ZoZ0bRiMSLJySMT
 pwuN1nS55pPzmw8PTmW2XiIcfQANR84jDJ4IUpzoAB03i8W4VhmKiKFlr0bUMCZ0Ym
 225opwLTcEvGCyk4MoCjaZdN8rcjrY0rCeFJauLiZ4yP5lob1t/EdoBiGzQno+Y7GR
 DqGCjNSdL9tRzpwOIxEXfxLI00AX/wVsWRcV1NXBSmtVQa3I47ZbMSR8cRNEsJuLU1
 RoAgfYa8hlEiQ83ag0pQWlTH8y76+rdp5CImMG/n/0Xqk9iYcmVKlM93zUf8CZ7gdW
 fgmd3FMgV3BQg==
Date: Tue, 17 May 2022 16:44:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme: set non-mdts limits at I/O queue creation
Message-ID: <YoQlXXvNCQIRT3yc@kbusch-mbp.dhcp.thefacebook.com>
References: <20220517055312.50331-1-kch@nvidia.com>
 <dd46fded-d213-6956-8f0a-69a70e0107d5@grimberg.me>
 <955bc8aa-dc88-68a9-c656-51e52fe589f6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <955bc8aa-dc88-68a9-c656-51e52fe589f6@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_154450_800952_32A160D3 
X-CRM114-Status: UNSURE (   8.43  )
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

On Tue, May 17, 2022 at 10:41:54PM +0000, Chaitanya Kulkarni wrote:
> Also, this patch groups reading ctrl non-mdts limits right before I/O
> queue allocation for each transport, since these limits are only
> used for I/O queue allocation.

Maybe just check that 'ctrl->cntrltype == NVME_CTRL_IO' instead?

