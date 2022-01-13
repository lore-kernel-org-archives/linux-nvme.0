Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80895C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jan 2022 16:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hgoFditSQKgNnt981HkB3zsyAWEq05Mo66KpI0MGXLA=; b=0gsp++DJ9ky+owVGK6DfHhH3s/
	aDdogTnRWe1kw5rF8EhOz9fOlroTnXq4YBmIyDaPJqOfVHA3srVtxTAI1RiAJS1Iaoxzenp431Lld
	Lbquxa6JUfI6G83yO3F338X2JN09SMmHB6PqF258Q9/Uqm5ARRtTVBJk8i3N/zkUm22e6B/cLi6J8
	CesZ0kTDuQLQs7tb347VWNyiV1eEkIpecZm6Xc3A98Awf3udSc9TJlZGWoJ7z0dPGPYuk0tbpMBfi
	grFzA5QWXs/IckMSBFgDqJnp60O44JgAtHcwEpSBTURSdWG8L4PFZTRiQ0T7GVP1uSMN9b14sAcQY
	azaP2eUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n82qK-006Yzp-EX; Thu, 13 Jan 2022 16:20:52 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n82qH-006YyN-Pi
 for linux-nvme@lists.infradead.org; Thu, 13 Jan 2022 16:20:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6C39CB82306;
 Thu, 13 Jan 2022 16:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58F0C36AEB;
 Thu, 13 Jan 2022 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642090847;
 bh=tiAhnscHwbLWOtnBm+DXRH/redKBi6T3uOmLyMNRuwE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Zx5Es3408C+xW9g2SsJ7GSgHMTk2faVtXfvdNnJL0ncUkCnDUH2qj4B564tHUw0dc
 TtpN01jfqDLQFaWd1HR12dzheD3jRDbKm5NNKOae5tzhwZIKW27KeIwelyUV9N7JP5
 iS8uZ5i3u6Ij/qRlr+6cjBiTdSujRG2FVG9A3cC7MM7JXcHxjkM5KfYIvfZgv284cI
 /go17EmgPvP2hvh8oxsuF+bt6r7UhaS+0sfuONFudwM5nzLMh4Akr7XW/9odALPafR
 dPFKmVrzGg/GQGEfJRVwaUQP0Q7PEJqzPZ1HBRibxacEo45O1hwwlkbBgdJ3Fr9Zis
 t3A3tq7ysV7CA==
Date: Thu, 13 Jan 2022 08:20:44 -0800
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 3/5] nvme-fabrics: use unsigned int type
Message-ID: <20220113162044.GD3230285@dhcp-10-100-145-180.wdc.com>
References: <20220112062101.90102-1-chaitanyak@nvidia.com>
 <20220112062101.90102-4-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112062101.90102-4-chaitanyak@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220113_082050_013243_1F24E5BF 
X-CRM114-Status: UNSURE (   9.01  )
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

On Tue, Jan 11, 2022 at 10:20:59PM -0800, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
> 
> Loop variable i will never have a negative value, so use
> unsigned int type instaed of int.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Just IMO, I do not particularly care for this kind of change. The driver
and kernel use 'int i' for loop control in so many places. Granted,
'unsigned i' is also used too...

