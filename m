Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB65C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Nov 2023 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z08apI8JoIKCBbBvFMANTe9imXmNI8+WKJ7C3UhvmZ0=; b=xrxkSJ7XxJbRyL2uIS/yLjw52c
	FHm/E8lvm5LpFz2Gr0x6FO1cVB5ER7T1Bvrx+gx68bKeRPZeoqBa3YgnEvlH8ldaGsHKkk4859mW2
	+AE2vF8Vo2CBFysDeTkANmPY4+hd08G3AEymfPBhLp2Y3RDztYClISM5+qzwqK9FSyW+5H/VfNbWF
	uNrtVVohu7KRbxWGROQdQXCXh0iTfSw11xUI2SAoKzRCSGcaRhP3jF4SCCdVgwV6g3ceIDHUBR2m1
	LHG3XS+2vTKmYGg/7FEag/9oCw3xFqDF2bNBP7+hwszJLSjyeFgivvlX8yZaZquGzsbziDEeKoxIP
	/LFeasxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2u11-00G7HM-1r;
	Tue, 14 Nov 2023 14:03:43 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2u0y-00G7GQ-2l
	for linux-nvme@lists.infradead.org;
	Tue, 14 Nov 2023 14:03:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DDFA2CE12B9;
	Tue, 14 Nov 2023 14:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6C7C433C7;
	Tue, 14 Nov 2023 14:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699970616;
	bh=VwyVitZmnvF2yKyndNpE7YwjfmVnzCjouoVRNc1Ifo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZeXtCmFDrV0jWqhGNpdy1DFPiXEh1lyeFU1d18MD5ZofPB9DU1Pul3KvKnwNy1Ag3
	 fpMyYBvOVywhkcnwJzktuakWvQ+EAhwD1s5EzxWAiklMOEQyaAssMuYmvYB+pv6ZVW
	 22hKtzduvDj/ZwODf0VCw3SNiRfZddOcTdHAwrKpsouckfjnE2UxIxFpsim8BRVlJL
	 QKC9NaLOZ31+PHoLcmLPHgj0jCdnS+QACtXoxkxKKZcQaAqckn4o5fFeIxyxASoBHV
	 lFmbOuZYX/l+z+mrPIO4PU4xs90H6nP3FPxVLQWYcApFpWkxmuR7u3zpBm4yavhmD7
	 7iwqokDap0+xg==
Date: Tue, 14 Nov 2023 09:03:33 -0500
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: catch errors from nvme_configure_metadata()
Message-ID: <ZVN-NaRh7-f4tKzu@kbusch-mbp.dhcp.thefacebook.com>
References: <20231114132701.49048-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114132701.49048-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_060341_062920_0B9DF342 
X-CRM114-Status: UNSURE (   9.96  )
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

On Tue, Nov 14, 2023 at 02:27:01PM +0100, Hannes Reinecke wrote:
> nvme_configure_metadata() is issuing I/O, so we might incur an I/O
> error which will cause the connection to be reset.
> But in that case any further probing will race with reset and
> cause UAF errors.
> So return a status from nvme_configure_metadata() and abort
> probing if there was an I/O error.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Applied for nvme-6.7, thanks!

