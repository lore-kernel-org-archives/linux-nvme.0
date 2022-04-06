Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045BEC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GSUbj9Gf9FOIWdsnEiZsTH0/bpW5CEaHPPGqvt2y17k=; b=rArDdiRtxOJsME8Yat9kw/f+5I
	aZIS2gX/ZUicMW1zJBqt0MgFec/gKpYAM63gWdLvRVEdXR/6yGXy5ZjQCqM6wgJcmegRgX1UxpkaC
	krpl4LfjI+Z7LQcI0Ub6zV0ETVDc0Uex1Gyuj111Gez621S46nmIUJ2wU180tIuv0nSHBrgm8Rz5M
	gop/Rt6lzDzHDuEQwdSykQ5KiVMkJosWfDYxX5rXPaIQvJJ2E0oTeVH/rHGYvyguMKia9kyOpzZco
	NzDgnP7HaK/w0VDVs6AKlx6V13mOr5oq+0I1x7ey+tNA1otrb9VVZsS+n0PT3VHEJ66ppwjpUzPlg
	g3q8aUvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nc9YR-007ODa-Ca; Wed, 06 Apr 2022 17:34:51 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc9YO-007OCI-4H
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 17:34:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D5A64B8252A;
 Wed,  6 Apr 2022 17:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52264C385A1;
 Wed,  6 Apr 2022 17:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649266485;
 bh=GSUbj9Gf9FOIWdsnEiZsTH0/bpW5CEaHPPGqvt2y17k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZIEOgUC2u9aWQEKXbppla69SklVJXD963RilamV9sBx5gwp8dLT9DGuGscMWIAfIl
 1cxR4jSpGyDtKRnXSK2G155IqICZu38nip/QFi16S8kMwQSWRGLzAGqTstGhmVXzBk
 S65K3FEZQ4gNg5PfWQ074WR7uVe6nRintysxuKQAl0P8h3uQHvlqh3hGW0Dtoi4JEZ
 xPKyWrCcRqFwGoM+vwhGCa3nNqn1AeVuaHa75XkjXdWVOjLG0UAf03b3mclGGIbykz
 5w76rct2p4ygFTSK5s0pZRxhcSz4j0/mQKBVj+1JLxoH2NYtOZeaa5psgaf1AlVQVr
 26zqRjKJneOuw==
Date: Wed, 6 Apr 2022 11:34:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Message-ID: <Yk3PMiM61eLgDq7N@kbusch-mbp.dhcp.thefacebook.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <4A24C337-5EF9-4C3A-A112-BA75934AC78B@oracle.com>
 <Ykskv/gp2s6PWiHp@kbusch-mbp.dhcp.thefacebook.com>
 <4a97859a-9b9c-da39-3dca-76811f67b4a6@linux.dev>
 <YktVVG+WSXzYWjGR@kbusch-mbp.dhcp.thefacebook.com>
 <17ca93bc-3cb7-46d6-559e-e2dc0e3408bd@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ca93bc-3cb7-46d6-559e-e2dc0e3408bd@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_103448_349107_2BA55507 
X-CRM114-Status: GOOD (  14.53  )
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

On Mon, Apr 04, 2022 at 06:43:01PM -0600, Jonathan Derrick wrote:
> > Or maybe since enough people have been concerned about *this* specific
> > identify, maybe it should be restricted to 2.0 devices where it's mandatory. I
> > was reluctant to do that at first since the initial device I tested was 1.4,
> > but it was a prototype and we should be fine without the non-mdts limits
> > anyway.
> Well I'm not sure about that. I'm not honestly sure what this specific
> identify is, but (I know you know) NVMe being forward compatible allows eg,
> 1.4 compliant devices/targets to support 2.0 features.

The command triggering the error is the NVM CSI Identify Controller (CNS=6),
which provides the recommended limits for commands that don't transfer block
data (write zeroes, verify, dsm, etc..). The driver sets it up in
nvme_init_non_mdts_limits().

Here are two other user reports of this triggering smartd warnings:

 http://lists.infradead.org/pipermail/linux-nvme/2021-July/028009.html
 https://bugzilla.kernel.org/show_bug.cgi?id=215763

The identification only provides recommended limits, so it's not all that bad
if we skip checking it for <2.0 versions that don't require it.

