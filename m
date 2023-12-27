Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BBCC46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Dec 2023 19:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=aHaCdyhRQ8DF8IlMJf67DrQVAuB0E8uSyDpcpP3bSSM=; b=XXjOzNAn5SbAIQ
	ODXjMftt+p24FHA2CiOW7bCDd2zo0Lgs5SUYTcJ9mCA77p5mU2Qwp391E19IiPvl/d9E9hC0sTkMF
	YgHZnVluqg7qzMmOuxMAcDJdcFltm6uxD/0VQoYCAuoSdLVjBi0529fUWSSV8LZXjuQE5kBxel/qB
	quLAQzGL7jxGdbL4hJLvhQb11J3uzPW6OjhIDR+PiIPdzHybmrgWGYXwq7VgmCxJH4MnOBDyfutLq
	HqoTighj2UyHWnosGXJqzgVoyJ+fLs88zoxgP1YgaIcj23gRMyCmEa3tvms+8Pl23n6/MztOWzFoL
	hXpYpNCwbGUMZGbioa9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIZf4-00FO2l-16;
	Wed, 27 Dec 2023 19:33:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIZf1-00FO2E-2T
	for linux-nvme@lists.infradead.org;
	Wed, 27 Dec 2023 19:33:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0664F60F25;
	Wed, 27 Dec 2023 19:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B993C433C8;
	Wed, 27 Dec 2023 19:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703705626;
	bh=cqKDlP0+3VjaeXPgIzArqs+8mgSYk99+ivwv+HRUe7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=snImRjRNg628uXb7vJdWx2m1+H33KXHv0XREP24Jv0s4cnXpfCWOWXm1LJrTDl/zv
	 9rmJNG2x1C0DU2EZ14EHQ4pICYFf8nl0+VHm1F2JfSEDWgNwz0gOvQXTSUBnWZaPqe
	 r74ArqiZQQfmoJtO7+53NqfMhYQhZvDGnaHZ5TfJ8lVP66A58QTqjZfbrSu+Ovr+Ph
	 +ETN2mUDfcvZyFZenT3m+MgyHv2c1spYn/PBHzkwCwVEjb19QisXlfIXcq2gQEUAqt
	 dfRJK1XBFPzK3NLLJY8sHxf0wGXrdsJKdjFNWFY6EdTQcByIxI5Phqsdp/vxXgH19h
	 YtYISnDxyHDkg==
Date: Wed, 27 Dec 2023 13:33:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/4] Change 'bool shutdown' into an enum shutdown_type {
 NVME_DISABLE_RESET = 0, NVME_DISABLE_SHUTDOWN_SYNC = 1 }.
Message-ID: <20231227193344.GA1509800@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221172257.2234320-4-jallison@ciq.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231227_113347_846889_0313ABA4 
X-CRM114-Status: GOOD (  13.12  )
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

The subject might be overly detailed and doesn't match the "nvme: ..."
prefix convention of drivers/nvme/.  Maybe it was intended as part of
the commit log?

On Thu, Dec 21, 2023 at 09:22:56AM -0800, Jeremy Allison wrote:
> Convert nvme_disable_ctrl() and nvme_dev_disable()
> inside drivers/nvme/host/pci.c to use this
> 
> bool shutdown = false == NVME_DISABLE_RESET
> bool shutdown = true == NVME_DISABLE_SHUTDOWN_SYNC.
> 
> This will make it easier to add a third request: NVME_DISABLE_SHUTDOWN_ASNYC
> later.
> 
> As nvme_disable_ctrl() is used outside of drivers/nvme/host/pci.c,
> convert the callers of nvme_disable_ctrl() to this convention too.
> 
> Signed-off-by: Jeremy Allison <jallison@ciq.com>
> ---
>  drivers/nvme/host/apple.c  |  4 ++--
>  drivers/nvme/host/core.c   |  6 +++---
>  drivers/nvme/host/nvme.h   |  7 +++++-
>  drivers/nvme/host/pci.c    | 44 +++++++++++++++++++-------------------
>  drivers/nvme/host/rdma.c   |  3 ++-
>  drivers/nvme/host/tcp.c    |  3 ++-
>  drivers/nvme/target/loop.c |  2 +-
>  7 files changed, 38 insertions(+), 31 deletions(-)
> ...

