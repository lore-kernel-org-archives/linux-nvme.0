Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3035C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 20:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Gz59KWSTFKDWCyBEVoMZzQt5wXm+47O36G5iGD9m4Q=; b=gDI/ozN9oju82E5m/9XfW43L6M
	TC8YWMI4ptmUiUlMpiNA4klg7gpiX32ejU1rvXS3sfrdd7W9Zf5xpFmNwBOyvPS5wEfREFzcerUmv
	MAhsoKIp/jawwXUoTm0LftVpWzrwLR8+HWrGAe6O9jU2DFl/wyANvzAjwLlk0XjyGlOIDrQSJqB9R
	D3bh7TNFfgbniQVdEllQ4Q98MOm/LUMQMSePRH0150U/wxagncgAU9X6qD9xYKcSpMBtolqx0BKyV
	x7zkKSRChYj8kDU5tjHttLr8Xlj9TfW1WwEZ76SJgeUNJRykmtKFRhBHxjH3sGWWHiJ7HEo3SAle9
	c7tg5mrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nC5pP-0057U3-M3; Mon, 24 Jan 2022 20:20:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nC5pM-0057Sc-As
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 20:20:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E1B99614EF;
 Mon, 24 Jan 2022 20:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63326C340E7;
 Mon, 24 Jan 2022 20:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643055635;
 bh=5n3Ej/dZgPQUZCgBUOhWo7itpLA3D6evXmkJlYN3hPg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tbjrBBVB+YdovE9XVUjRuiOCTrPFZLUNQ6LGfQTh1+H0zbDhUQQgliVEESAHs3j99
 m0oBlnxF0dbJGgWjmNfoKhWxBvwZCKR0vSEJDsSL9hbHLAFjTeY0+WxCyIYY841juA
 AC+/JU07I31YvwCaOJOmcbwNQ1Tx9WiZPURiUev+nsy1FK287wIhUFs4ATOkM/UxQX
 NxwsMhcsxyH9lVVWzQX4K/trfB/XWmAwOCi0LZvgsBF66PG80D6yiQYLmkRRuFqyKH
 C9MRuOJgRyoirUoy1m8t11hx5rPkSiQ6JgkqXasPnJtHOxKrEaD9KqDbknD807pYew
 F2T2oVkBAsgdg==
Date: Mon, 24 Jan 2022 12:20:33 -0800
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH V4 1/1] nvme: Add verbose error logging
Message-ID: <20220124202033.GA1683949@dhcp-10-100-145-180.wdc.com>
References: <20220124185144.53810-1-alan.adamson@oracle.com>
 <20220124185144.53810-2-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124185144.53810-2-alan.adamson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_122036_449807_A7E2A461 
X-CRM114-Status: UNSURE (   9.95  )
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

On Mon, Jan 24, 2022 at 10:51:44AM -0800, Alan Adamson wrote:
> Improves logging of NVMe errors.  If NVME_VERBOSE_ERRORS is configured,
> a verbose description of the error is logged, otherwise only status codes/bits
> is logged.
> 
> Verbose logging examples:
> [  183.333734] nvme0n1: Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR
> 
> [  227.767945] nvme0: Activate Firmware(0x10), Invalid Field in Command (sct 0x0 / sc 0x2) DNR
> 
> Non-verbose logging examples:
> [   41.280509] nvme0n1: I/O Cmd(0x2) @ LBA 0, 1 blocks, I/O Error (sct 0x2 / sc 0x81) DNR
> 
> [   77.249153] nvme0: Admin Cmd(0x10), I/O Error (sct 0x0 / sc 0x2) DNR
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

