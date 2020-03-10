Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA555C10F25
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 03:12:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFA02465A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 03:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b485lddl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXOMCfYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFA02465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kKBHCpL6R6UcGeQcxFFdChn6HgdJdGU5oOW2GdBOC8U=; b=b485lddlXVEK6r
	/qLb8w9lD1s7fVWwfamwdL5vqTUYonwDKuCJ5fSOWIO7QhpN0Cw/lcWRqp0X8I1cPO8cqQ0AzlHH2
	tz0Qf7XVCc69t+V1eUojGMAHm0+sb5kBjBZDdUmoEaNXLZHkMl9d/jirA44o4iz1lRHKgjvndnr62
	JGRAiWRO+cyfNqG6nTC39pZv6HJWPoANPsg0T13VG7Tu1AbJGRrXXIqurlSG2CqHoHLTPsWG6Xfhc
	uKeeJQto0D6UOPQ43DhgqJCGQbEr0R09r/0a4e0o45ZU5l07C/7EO1d1NxjGp9f8E2m0mLIgRnYcI
	2xO5p2O/O+SA2yZiPtrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBVJI-0006nk-GS; Tue, 10 Mar 2020 03:12:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBVJG-0006nP-IS
 for linux-nvme@lists.infradead.org; Tue, 10 Mar 2020 03:11:59 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F05F42465A;
 Tue, 10 Mar 2020 03:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583809917;
 bh=iLnZrAa2WT89cthntTPGB55RwHnG23jGA3i/Izm66bI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EXOMCfYDhz6uQiLgj51Nntv4aBLwoSSA/KhFvuZVTT0kR40GdHDwIA+0sIVEZ2cIo
 w+7zNMefFI2zEYMTpdqV2yrVYp0+lq6PhTGdmfouDBA2QLjrxfiGYwbaisGWVqxSFL
 mjaSVt5cbbpzRf06hZlaove3UGRU+5JIR8eqrEmA=
Date: Tue, 10 Mar 2020 12:11:51 +0900
From: Keith Busch <kbusch@kernel.org>
To: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Subject: Re: NVME is not using CPU0
Message-ID: <20200310031151.GA15996@redsun51.ssa.fujisawa.hgst.com>
References: <CADS+iDV5S+QyfhE4M+fSwXuczx4WCveU+UyhKpx7HY6pfHfc6A@mail.gmail.com>
 <20200309015524.GA4567@redsun51.ssa.fujisawa.hgst.com>
 <CADS+iDXQ4HtyXSTETPqQdJS=1tKdd93vCBtAbqwXEfWt3w7GBA@mail.gmail.com>
 <20200309141629.GA5446@redsun51.ssa.fujisawa.hgst.com>
 <CADS+iDVTaAViuKRvcSxyL3TngMWMjpvALEWhd1+Sfi_X3nZomA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADS+iDVTaAViuKRvcSxyL3TngMWMjpvALEWhd1+Sfi_X3nZomA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200309_201158_634860_7626E3D4 
X-CRM114-Status: UNSURE (   8.93  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 10, 2020 at 12:29:38AM +0100, Yaroslav Isakov wrote:
> Keith, thank you!
> After some debugging, I've found that kernel is setting 8 queues in
> NVME disk (which is, BTW, Samsung 960 Pro), and trying to create 9 IRQ
> vectors, but it looks like device supports no more than 8:
> > lspci -s 02:00.0 -v | grep MSI-X
> > Capabilities: [b0] MSI-X: Enable+ Count=8 Masked-
> So, I wonder, if this Count is hardware limit of device, and cannot be
> raised (so, cannot be changed via SET_FEATURE 7)?

The MSIx vector count is PCI property and it's shipped that way from
the manufacturer.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
