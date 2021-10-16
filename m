Return-Path: <SRS0=EQPQ=PE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAFCC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 00:22:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D1360232
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 00:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27D1360232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Djw7+mmoMij4LmnvjxaAZrf0oLj7Xy4uKIKta6o2aVU=; b=HF2sQjQb52/oRKjOpclZ+Bv94E
	XRJqt4DmqzmyKwBkUAUSzw7TjutzVwOhj5BBa2ZqGPIrYQC+c5l0vbr0SIesYGEkFtn7ThdVYyBHl
	b8/uklNqENaTSn2m5obDCSpOm17JcRbnA5mCJKtqwwJcwT8L1NEy40wT2WUCHD/H0OAHiM1SBCM5T
	jnfzD4bMO5oM6K3Z7df4+Zd+CNCccjNAIrwgVk6PHuu1jq3SOnRTzMdRDICnP5clWopn05xGED6sZ
	/7PU0JtXE2eLVs8EnjmCwtDLtw+ZfLL429hMTH73rP+IAMM3ICS8b/Nj58nJLTrbGB4aycSf3r5Qs
	JRukJ+4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbXSs-009MGB-9b; Sat, 16 Oct 2021 00:22:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbX8d-009FrR-7E; Sat, 16 Oct 2021 00:01:24 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18BA3611C3;
 Sat, 16 Oct 2021 00:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634342482;
 bh=zERYufNJ1MZk5CclnMi+gL/h2WeGYYoy9Om0aXiHGLA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lAd5BhR7dX0bhUFdgALWUXGCQ+v5W0tvJIwfUWbRKvGKqR2h6V0I6ukKcRF5Dj+Nw
 0dFWCYUmBg7S2Rodk9yCf0H1+kehM9Vr5MyDW3E957s4BJA3cyS4uAhz4e17bCP29s
 II0rzTuzcoBkDSvXr4ZGRWsUKw8yktjg7TyZT5pwSjCguTcC1658+kFky8M1STBicA
 7fLq43tAQkTcs+sDRgIw1Gv5v7j5U3hjGyPw8mDDVxsn00Q51dQWLT/IESbUsSNm65
 nxOHSWjB0mZ+Ve03BmVAuGYwTgnYAMB4qLl+33yxh5AlIshuEdLL26zAeBOF+sdd/j
 wOOh/LnbCmJTQ==
Date: Fri, 15 Oct 2021 18:01:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, geoff@infradead.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
 minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
 richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
 dan.j.williams@intel.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, ira.weiny@intel.com, hch@lst.de,
 sagi@grimberg.me, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
 nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] nvme-multipath: add error handling support for
 add_disk()
Message-ID: <20211016000118.GA50317@C02WT3WMHTD6>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015235219.2191207-3-mcgrof@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_170123_334676_728661C0 
X-CRM114-Status: UNSURE (   9.55  )
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

On Fri, Oct 15, 2021 at 04:52:08PM -0700, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Since we now can tell for sure when a disk was added, move
> setting the bit NVME_NSHEAD_DISK_LIVE only when we did
> add the disk successfully.
> 
> Nothing to do here as the cleanup is done elsewhere. We take
> care and use test_and_set_bit() because it is protects against
> two nvme paths simultaneously calling device_add_disk() on the
> same namespace head.

Looks good, thank you.

Reviewed-by: Keith Busch <kbusch@kernel.org>

