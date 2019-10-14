Return-Path: <SRS0=0xMB=YH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DC2ECE587
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2019 15:05:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A782133F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2019 15:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lACwmkym";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnSlCbWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A782133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UDdSUVii+xIxsp/AeuZtEbFJtDa2QbAjg+MbvgpFMgU=; b=lACwmkymT9IzTk
	uSRWT6UKTXSJ/7QIu5Hi3PufoynZWKMryW4zNFm6A5mCL9nzvGBa7LZASOECeVB2odjnpXWUjp58X
	hQLFaTLvt/BLAS+7hHG/w6gIZd7Cz8mYrQMhAMj6bLZo/f450pgMXP/diOOyMLKMAUxzmJEChyNeU
	1VZmVb6d4wCwCGhH3LbWdOaxaOUNICAA1Tjc+/VV4cSk3EO7IZi+VDytOhXJmq/0FeD6dFVY/ejn1
	0tdXNopxmG+yCuPJedrAL50W8NyE4drvauQWPHl3dsfJvwMAz0Uol5pctToprX3fZiTSmMOZnnR+T
	rl/aEe2czjHzYVNKpX7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iK1ur-0008Ff-Hn; Mon, 14 Oct 2019 15:05:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iK1up-0008FM-9x
 for linux-nvme@lists.infradead.org; Mon, 14 Oct 2019 15:05:44 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 457662133F;
 Mon, 14 Oct 2019 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571065542;
 bh=nxOC5dvsMTgD0ttkPf8iBduFG+tDMaGm4cPAM8KUjlg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JnSlCbWpQKHg6C+QnSHIFhfWV8xnErNshBy2n1DGTgWcU48DmQCgFmY8RSxaEBgTO
 ZoJ5vgIwhWG4iLFxqvbf3onefKwbRYx3yevTHPyZUs/Yp6n+5zB0g81aAAzKV+dmMg
 StOaAqkYCEJya2CFFuuhuDg0kGwgypJT7QnRo4ps=
Date: Tue, 15 Oct 2019 00:05:33 +0900
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v2 0/8] small NVMe cleanups/fixes
Message-ID: <20191014150533.GA6142@redsun51.ssa.fujisawa.hgst.com>
References: <1570985858-26805-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1570985858-26805-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191014_080543_361941_9AB388B1 
X-CRM114-Status: UNSURE (   7.88  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, israelr@mellanox.com, james.smart@broadcom.com,
 linux-nvme@lists.infradead.org, shlomin@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Oct 13, 2019 at 07:57:30PM +0300, Max Gurtovoy wrote:
> Hi Sagi/Christoph/Keith,
> This series include few fast-path and code readability improvements from
> IsraelR and also few memleak fixes and new status code introduction from
> myself.
> 
> This series applies cleanly on top of nvme-5.4 branch, commit 3a8ecc935efab
> ("nvme: retain split access workaround for capability reads")

Thanks, Max, applied to nvme-5.5.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
