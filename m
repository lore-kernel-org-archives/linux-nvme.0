Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13795C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Dec 2022 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eRLNZnCLutC5QbiKat3V/lk5WT1a9UYylPu3y6FvSSk=; b=ki1+gvTzeucwfrdya95gkqWayI
	OyVvbUWtPIyJ2Zoj7ecdRf8GQBDHIsL6NyATpM6QcwPGBquc9xA4X+tVayzl/hLlSm9qR85ElQVrA
	UGFg9UrIKwBsmi+dWEwJSFVESfztf7QY1XBOB/CRTT4R3u3is6zdmYvpy6I/oTlIf5SzYF7c1O7LE
	f/4TRnzw2C5qW2nNBFxqd9u2/gtYmoGCScRDyetwvutkMP7jA35eG/G5OlyMtEjTGh1JLWssbqKkZ
	2QE+xXIOhW/o+L09hCGSsaQ6K8HfASB/hzKlwhM8xwNTcz0QiVMZafkjLStYNLVmUfdEmW7LB2Q0a
	a9LRpatw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAbya-007X06-Jx; Wed, 28 Dec 2022 19:20:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAbyV-007WxU-Pm
	for linux-nvme@lists.infradead.org; Wed, 28 Dec 2022 19:20:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4151E615B1;
	Wed, 28 Dec 2022 19:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDC4C433EF;
	Wed, 28 Dec 2022 19:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672255226;
	bh=byjRKyCkmG+R/LgaZ53yvVf3JrFbMfH2qmP9nL0pJ+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGp8Enn9/tXn3lklqOG/faCMJkl/lgwh2GqDzWaePMpyzP0cNTlJyl2ITM1q/67+7
	 t/PJytYbrB8SxlWb2RbkEV4+ppA+g6jAnGI0tiPJbG+4LMSmhHvuxHqPbKv6VYkyeW
	 HPAVUYRXsH1iqoznhuyQH3nSlT4jzFq2ZCrAsQKSRt7vU7fm0tE/Rm9Hlpb8M/vlcY
	 S2zNJJlaL44Z11yJwOmjV3Wzsz5oqqiVv8qVZPj4oI85jHnid7R1m5X+wTR/6pbLvT
	 jjK6CItIU3QH61ruOYWDbcZ5xOvgeHrHXL0EVTv2hgZBDOSAgoJrWwwE7UJ7GFsvbI
	 QerOU9Yq98Bnw==
Date: Wed, 28 Dec 2022 12:20:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: user090909 <fuckgithub@riseup.net>
Cc: axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
Message-ID: <Y6yWS8SfrouPyeTY@kbusch-mbp.dhcp.thefacebook.com>
References: <ed916236ae7f2823aeccc8a85230abe5@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed916236ae7f2823aeccc8a85230abe5@riseup.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_112027_918911_EBC32ED2 
X-CRM114-Status: UNSURE (   9.48  )
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

On Mon, Dec 26, 2022 at 02:15:39PM +0000, user090909 wrote:
> From 65e5a06268a4510f2858cbd182dbc60caf7003ff Mon Sep 17 00:00:00 2001
> From: user090909 <fuckgithub@riseup.net>
> Date: Mon, 26 Dec 2022 17:12:54 +0300
> Subject: [PATCH] Add quirk for ADATA SX6000PNP
> 
> Signed-off-by: user090909 <fuckgithub@riseup.net>

The sign off is required to use the real name of the patch author.

The patch itself is mangled with line wraps.

