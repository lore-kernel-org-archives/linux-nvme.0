Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F9EC3ABD8
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IrrzCPZUmYF16w7TR1bpGSlelKAPh5MvrwGP5jqyCeo=; b=5Dz89g8V8xoew4cpfd5k4wcjXF
	JQjJrBEfceWZM05rhihV1KUyn3mMAuyWwi6bJrxyEHx2XNok/fKZQEnEzJ9j4u/GWzyrBo2y9Odip
	B/5as36UdW5BhB6gG4xZB4zWbvvPvMUK6Nsd6QhoLgxGQIUSW1mmYSjDmA5MqB/wdKIsA20rsB0A8
	t0e6gizXSe6YnzWtGKWw2/abS4s61RgvMB9dPkLTpJOLdSrnuLvxz8u6i9h1YwbIazojUvqlQGyNG
	DlMUsZURgpRxM4/6DzEIM372D2osHqWSXSDFQpbFSSSHyJw2LztHRdqiBPYvZc+oubcQzqKJDnWzX
	FXIngZbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFxmB-00000003zr3-3733;
	Fri, 16 May 2025 16:19:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFxSr-00000003wwe-0W1V
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 15:59:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D2ADD4A8BD;
	Fri, 16 May 2025 15:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFAEC4CEE4;
	Fri, 16 May 2025 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747411152;
	bh=rZbD0gKwAexJUBQ3Tv/hHUqEanqIb1dDi+bNgW1/+vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUYVDeQ9lqJWMToTsDSqS5skZrJ+35/yBhR7PC4sGUsl/tVaFO758AP920h4fonof
	 ZF9gEyph3AlYl2q1AliGIpzw4lSbah3EvSHBezeI8uKdrDqFS+Vp+lCHiIV9azmz8m
	 W6McpUAUtH4oSaKVnW9mMlCEmBNhBJFCiOV9KxRPQtFdG1cXvLMNv82x8da6S0aIFE
	 +bFw+8YwgnTbvhYM0qInD5uKDwRMBVlLTat57WYnLpnOkgkY2JWFlDg0GSIJhiZWTb
	 TmPOMWH0RQIB0PoWHeUDL0F9C3Ytca9yh2UGwYnxOlNgbWi9P/RI9366upFKTLYuG5
	 KHPyFO5lNif5g==
Date: Fri, 16 May 2025 09:59:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	bgurney@redhat.com, mlombard@bsdbackstore.eu
Subject: Re: [RFC PATCH 0/1] enable quirks via module parameter
Message-ID: <aCdgznvTZAJiPjM0@kbusch-mbp>
References: <20250516155025.44958-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516155025.44958-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250516_085913_177619_F599DF50 
X-CRM114-Status: GOOD (  12.73  )
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

On Fri, May 16, 2025 at 05:50:24PM +0200, Maurizio Lombardi wrote:
> On some occasions, our customers have complained about misbehaving
> NVMe devices. We had to compile and provide them
> with a test kernel just to see if a quirk could resolve the issue.
> 
> What do you think about allowing users to enable or disable a
> quirk via a module parameter, similar to how usbcore does it?

Can't we already do this for pci using the "new_id" attribute of the
nvme-pci driver? It takes up to 7 parameters, the last one being the
"driver_data", which is what we use to setup the quirks, and you can set
that value to anything you want through that interface.

