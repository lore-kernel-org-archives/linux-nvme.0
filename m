Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3CCC83004
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 03:37:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389DF206D9
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 03:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bvs3yd1h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2C6grf4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389DF206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QxCpCRmP8dhz3bgFdlL21HYEIOouH/RKL//npNbLJPA=; b=Bvs3yd1hmjDeDR
	gaw9aEgTGTSDZaHuwFNGcJl7J/9bHDuOvpDerFksNzHyMW0BLoF8vIuF9F6F7xgJhc7mDWdU6tdCj
	+0rw3exOfe8BHnlVRoVOsUtqJ8AyFd7/OMNqLPFWjdmcywoKHiQuVAuy6vR0YhTPGFpefy2IFGpg3
	m67xQ8+qRrQUF9saszGytKLJxp0D15BlkNViY/j3Yu8cPJEej8rjYDZqrZKVIVKRIsbo8CM7bI9Yv
	ukchaT/g3xWUxfxW12sBTha8OCOoudElAHvyRKBb8+lTPOz80L070YbfT1osJ3OsyQbpUWPk8Uest
	stKgl5tA0L5o82oj9KJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTH3k-0008PY-BB; Tue, 28 Apr 2020 03:37:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTH3i-0008P0-Fq
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 03:37:23 +0000
Received: from keith-busch (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A9D36206D9;
 Tue, 28 Apr 2020 03:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588045041;
 bh=v9eFiobOpoDAWCLAyLnQK9hJvFUVVX796NEexuY0JxU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2C6grf4PVeWztUQBTehhw0giH8TuhR8pItE9jvU0CE/wsuQhanBvhA4nXOqW8t0KK
 3JXzrp8GLKtcLLuEz2Oa7Gs2i2HyvPUi3/DYmVlHRdDNOfwJNtiFqILZQsnX0h3dUB
 IMyKBzQyKdx63arOBoeYFrfkEGfjF/uPAL7MZJuw=
Date: Mon, 27 Apr 2020 21:37:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jeff Johnson <jeff.johnson@aeoncomputing.com>
Subject: Re: Pinning nvme interrupts to a single cpu?
Message-ID: <20200428033718.GA5085@keith-busch>
References: <CAFCYAscnovJyA0cKeHVxS20+zGgMj4P5ECb95aZE8=o=Wh+5bg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFCYAscnovJyA0cKeHVxS20+zGgMj4P5ECb95aZE8=o=Wh+5bg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200427_203722_548510_F56B8911 
X-CRM114-Status: UNSURE (   8.29  )
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

On Mon, Apr 27, 2020 at 05:10:47PM -0700, Jeff Johnson wrote:
> Is it possible to limit nvme interrupts to a single cpu, rather than
> spread them across many?

The managed interrupts provided by the irq subsystem that the nvme
driver uses doesn't allow altering the cpu affinity. The only way to
have all interrupts handled by a single cpu is to have only one nvme IO
queue, but you don't get to choose the cpu.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
