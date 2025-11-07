Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEFFCCFA05
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Nov 2025 01:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AkRJ7qCKOJE1z4cjg+sw+LhkhUhfH/LD2bP7dD0kNOQ=; b=hTJvS5L4kulXo72XYfIqhZ/PuU
	/eqcgoPK4o/OkIOvJcKuDcHiH3GS9JtC9bTqY1s3limj4v/vCjv0WP2FdrpwFabQfxP4XAqx9471v
	LzYjdGRRfvpR6DcMtMsBIJMtaT7NKmR8CB9ixOGE5DAuN0WrGvsxrA6cRLC3Sf7ppsys9f8pplvPe
	gVy36ci+aSde8XlU7iDDA+53BmBIvRL0F4uqKn1O2YBvUE8N7IdohCthhn/EdL/F0a1EplZgY4Ejg
	B3X/KhAo7EIhRXz2dM8hnq82Ng9SzuRD7+G1aN8C6bLgLzP6987gp/hT8sz1avPLSOJpPwQLzjJzM
	dT+kXZVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHAtF-0000000GTwk-0tUP;
	Fri, 07 Nov 2025 01:03:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHAtD-0000000GTwO-1shX
	for linux-nvme@lists.infradead.org;
	Fri, 07 Nov 2025 01:03:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 335854080E;
	Fri,  7 Nov 2025 01:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C3BC4CEF7;
	Fri,  7 Nov 2025 01:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762477422;
	bh=+HhYARz3EZwNGGVtjHrJkFBc1gkDphzYvlM37ezBWVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcXEaAbM67bQ9ftQvYheZdHMja+IMJzw+G/+jzaVo21RLLNXyINXhlTw3tNXCrEMk
	 MkwTk93K9tAMHBEBG1+CuLo9v5DsfMsRKyWFn3QE62+FJTHUSqQbIbEayua6k+EMDY
	 EiD0zC6S1gJjFuo6zRmuR1WBPy+lOJXkzOyzwAOQRDWqa74lgDcIc86dJSBK9DO9XH
	 D7I8fIX4OQghNWZiAHE78JZ+GQU+pRcmGDDhkKO4S5Xbumog28fVUIsHNws1dSHmjX
	 mFndmLEzA1Appzv4CtxWki0oMf5tvqaQNBJQCN8UWFDdcJ6LDwSrTbVeiqgMOpCS6e
	 Tq3aO3XwKir1g==
Date: Thu, 6 Nov 2025 18:03:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [PATCHv5 0/2] block, nvme: removing virtual boundary mask
 reliance
Message-ID: <aQ1Fa7hPssIFOBLg@kbusch-mbp>
References: <20251014150456.2219261-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014150456.2219261-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_170343_512489_ABE2AC06 
X-CRM114-Status: UNSURE (   6.64  )
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

On Tue, Oct 14, 2025 at 08:04:54AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The purpose is to allow optimization decisions to happen per IO, and
> flexibility to utilize unaligned buffers for hardware that supports it.

Hi Jens,

Did you have a chance to consider this one? Thanks,

