Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EB5C61DBD
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 16:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KMZYSoVPpZijmrMcPGBY3UxppQNFJKfh/3dyzCJWHg4=; b=HyXqV0QtNxLiK/8sxFoFmUBEMv
	QNbwzfQHN3CTxc7Oh4LCWwTzDkNQrmDIj43KShm8OH1SrTmoI/g5sfCr4nJqe8tjP0/siVxk4U4Dt
	aaM9d101dBUtvlPB49o8nlkvGC++HOoVpI3gU1WFmOrjUL9FTqeLVtppif4QBit/EMmeu0AzmubZF
	3nIUzASY2uUWsetOAXbt6gwnFxrV5XyN91esMGSR4h2gGE7WuGPmof+88ejCh2gZxZsjJjeVknSIQ
	4ULKrR3wnXHv3H0XFPCGNxgVsKUWjPJom3/WDfMCY0jvxO9GIrMP6kaKjQjfLsyPimALuQ+uTxVdf
	c5PxsU3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzGc0-00000002lC0-1jQg;
	Wed, 26 Aug 2026 16:36:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzGbz-00000002lBu-03fc
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 16:36:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E1D0618AC;
	Wed, 26 Aug 2026 16:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CBB1F00ACF;
	Wed, 26 Aug 2026 16:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787762185;
	bh=KMZYSoVPpZijmrMcPGBY3UxppQNFJKfh/3dyzCJWHg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IVvyU4IxPwg3b4YxS6ie7TZCk11JZsJDdBX8HTkL6ZD8ezHX8BpV3sCLUC230ZAa4
	 E1jN4vwzFWE4IEnEhRU4AtQksko6hsRXCS1AJhz5/gejEvmE2J4RscY8Y0BmcMlR3c
	 9bOtxsqKGsV6RGjNudJMKUT2Z0qtYzvYydc63Zry8qSIfqh2M+rkhkr8Zp+lCiepwg
	 X3My6jqJgum7d29XwhVWmyor6ndf5E0KjEIPhsu7rZ0Z59tLdQea05n/uHIA65EXjw
	 DNH+6TSp5v8XGq7J7LVBWO4RfytxFAxIk+3iFPFlOnyd+ivTX5SMOs32NYCLWHO2an
	 RSUb5DNvg7m8A==
Date: Wed, 26 Aug 2026 10:36:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
	gjoyce@linux.ibm.com, wenxiong@us.ibm.com
Subject: Re: [PATCH V2] nvme: Add module reference counting for multipath
 devices
Message-ID: <ao8WB4Ywz_akBEdR@kbusch-mbp>
References: <20260812223206.720363-1-wenxiong@linux.ibm.com>
 <d3cb6438-f1b6-4b46-9f96-56819052bc02@linux.ibm.com>
 <dc9af96205cfff939f96d7465a50eef1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc9af96205cfff939f96d7465a50eef1@linux.ibm.com>
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

On Wed, Aug 26, 2026 at 11:18:16AM -0500, Wen Xiong wrote:
> On 2026-08-26 07:40, Nilay Shroff wrote:
> 
> > Also, since a multipath head can have paths through different transports
> > , we should not take a reference only to the transport of one
> > namespace/path
> > found through nvme_find_path(), as was done in v1. Instead, when opening
> > the
> > head, take a module reference iterating through each controller
> > reachable
> > from the corresponding NVMe subsystem. This ensures that every transport
> > that can service I/O for the active multipath namespace remains loaded
> > for
> > the duration of its use.
> > 
> I will look into iterating though each controller/each namespace from nvme
> subsystem.

This is not viable. You can add and remove paths to a namespace at any
time such that the transports counted on open are not the namespace's
transports on close.

