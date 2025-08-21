Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B5ECA0EFA
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 19:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8KQndD7edtSKl9quZNdXMg54A4/bafXXnKw8tQ3d5G0=; b=SyqRn3cgzZH1Y3/Qw1ejI98D4H
	0lEeshDPu2meaokdWneW78wWeVTahbVMnUEl07EMVDGgRyhVM5T0wUBsVeOJnlg/OZKGeAV1brQcG
	fD49DhdaxI+4v6Uujt9PQrIQjuyRf2IBW0cPOJOxHkiR9xFKErWPO0R5CU/1W4uMmWkHJfSXN/AEW
	WBOaBlTxcjFHzZqhEpV1ExpO4BYjFcII7KP1PJfIvUbirw0s9CShqdPZ6jZEnlvzaB26561JgSYRW
	at+/de79M2nbWulNL3KqWsVS5E5qeus+jCD8jjaB9vypuNYDfKPbpIffM4lVd0krJEiE0qHXRoNsl
	HIC/UGnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upAhk-00000000EL7-0oQH;
	Thu, 21 Aug 2025 19:12:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up5Yt-0000000H60I-3yVh
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 13:42:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A43575C6B64;
	Thu, 21 Aug 2025 13:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0809C4CEEB;
	Thu, 21 Aug 2025 13:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755783758;
	bh=pilO4jUangUTqQdAkiK4cWGSMK4Xy1+X18LLgCwRYNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQvdyDt9lzQK+pQNTFgZuzvHiKKUWyubxQxAbJoDgR8mAI1atF+0gJN1VTzanJFfm
	 TOFwv7bNK2omxdx3Y3YtLVxw4gCjhdJLWm1jil4yda2sTrclDuDelyFbN48tEfdPAK
	 Z213AkAq7WcJDhpXA0Ma4xObdw3cG2kcNkxlqa3wQr0PEOq2yVXuZ+hJnDvcQ5y3Hr
	 eUGxSr4XExvJJmNdOOVZXiuPZFesguUu9G05zYUr10flws6SdqMmmjw3Kw/DmWatxc
	 7JeWjRS/JWfRH8wLRlaPmhtRgH/r+oILWgB9s/H2Jip4k4jtub374ODzjOHQeTfwQv
	 5Rw+8Ima2t3UA==
Date: Thu, 21 Aug 2025 07:42:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	martin.petersen@oracle.com, djwong@kernel.org, mcgrof@infradead.org
Subject: Re: [RFC PATCH] nvme: add an opt-in to use AWUPF
Message-ID: <aKciTPKiL8wRWmHA@kbusch-mbp>
References: <20250820150220.1923826-1-john.g.garry@oracle.com>
 <aKZDRrfUTxJoFA1m@kbusch-mbp>
 <b8156bb1-b7fe-4036-9dbb-98fdcec3ff65@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8156bb1-b7fe-4036-9dbb-98fdcec3ff65@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_064240_028729_5289161C 
X-CRM114-Status: GOOD (  11.52  )
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

On Thu, Aug 21, 2025 at 10:55:31AM +0530, Nilay Shroff wrote:
> On 8/21/25 3:21 AM, Keith Busch wrote:
> > I tried to list out conditions for when I think the value could be counted on here:
> > 
> >   https://lore.kernel.org/linux-nvme/aGvuRS8VmC0JXAR3@kbusch-mbp/
> > 
> Regarding the checks you listed, they seem too restrictive. They only support
> AWUPF for single-controller devices and for disks that either have only one
> namespace or support formatting all namespaces together (i.e., do not support
> formatting individual namespaces).

Being restrictive was the point. It constrains to 1.0 type behavior
where things were much simpler. I am just shocked vendors went through
the trouble to implement the complicated features but couldn't be
bothered to do the trivial one that makes it useful.

