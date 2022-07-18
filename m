Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5A6C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 20:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jilJhmhD1/IzvuIKJSKTpmtdazkWf47kSqKZvLUcaaI=; b=BTrd4YGI3sCZLDZqPxAUttB1kY
	Hn6zWTRwDIbm1TVYv3JWh9hq4vYpiprGDX3XLjYkzaNFPMtjZ+edaEeIMIq28hPdeJ0BRj4odOcJC
	rcuMWayjkkWRhmr2Nz+gC8bw3nzpTCorPDOW0RkQ1+8t1kjxcMK+dZBogUzaOstt9sbjVyLnI4foR
	PgB7Kz/yB3zam6bofRPG0soCMrCk6nPEk9e/fG2ddarcee12NydEeT+eTSTxvhNPYAf3+6QRrJ+W/
	EGv1t9mhkKWFBlT7/JmjXfYS17gH0gEPlkrtbAJur/FdJNtcNS6x4RDRze64903dLTyOGMZRQEgFJ
	DdTOhp8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDXB6-000jMl-M2; Mon, 18 Jul 2022 20:17:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDXB4-000jKD-8S
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 20:17:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CDAAE60BA8;
	Mon, 18 Jul 2022 20:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F37BC341C0;
	Mon, 18 Jul 2022 20:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658175430;
	bh=jilJhmhD1/IzvuIKJSKTpmtdazkWf47kSqKZvLUcaaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bGvS0FAmwIb1yRZ6XPd4tMJBpSCGeSis4xJs6JY/T4pOTQnkwDKKxX4JgrUJIw5jV
	 GGv7dY9UvUbKR/HmX3HYFfN5nh/T4zc+H5/5WgjRL4LdLZKuyALTsGR4+BahA4PKz7
	 CqtXvp2SBG8wLgbOqD7klClHzV3+O802Y/ztSsTHecyhCu/7RYyWxHr5MNPbFgVy0K
	 H1hoMmGhNiFxjOlaS0pjPhiol3+ZTNpgO44bwHpMB6vFatzg/yAB1VHBT5dKEtXaAt
	 gANvg1WxOFpWHFPqWHVSMOZaLT6CJTiRhifXYl/+5fTNeXQGkaqFwMzy+Ev0nNBpLG
	 4vYj+E0TYTDKQ==
Date: Mon, 18 Jul 2022 14:17:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: print the command name of aborted commands
Message-ID: <YtW/wf4po4NXZNmI@kbusch-mbp.dhcp.thefacebook.com>
References: <20220718051357.232697-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718051357.232697-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_131714_375428_6F71971E 
X-CRM114-Status: UNSURE (   9.54  )
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

On Mon, Jul 18, 2022 at 07:13:57AM +0200, Christoph Hellwig wrote:
> To allow for slightly better debugging, print the command name when
> aborting an command.

Good idea, looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

