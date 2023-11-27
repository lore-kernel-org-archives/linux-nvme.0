Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922D7C07D5A
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 18:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A1PpNtdBImkzeODYZiAdcGuZw6cwms+82GS4BsmUzsU=; b=zJqKU2lB3BmcK3PUPP36o1H9JY
	dTjpCwu1QOspNOlda+Ae7EFbnHaB8lcoNyAoyCYh1ThtWDYIyTMAJFTUChqbILuCYCwGjM+ubDdsh
	GRDVk58Mg6UzXf9t4J3Bpximk9fS5yifqxmEKi3TODQHgYNxVPESKOZDy/BstDCRorJYLXmMY0OEk
	jUaXBMvjYPuZ/YMfbBVMVk9iftjTmd1FYvqyLWYaDKcsw4N1ntKXp7bMzcGlL1I/RUJe7ioD6xhzj
	GPKJOBjTl6CEDDgJtWVU3+p07mloj8fVXC5dAGH2+j0AqlJsTX2EW7xW0HOLlgm+1mznB6KGTu4au
	k3fX3XQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7gLH-003ESq-31;
	Mon, 27 Nov 2023 18:28:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7gL8-003ERW-2A
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 18:28:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1D6046119F;
	Mon, 27 Nov 2023 18:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E18C433C8;
	Mon, 27 Nov 2023 18:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701109693;
	bh=A1PpNtdBImkzeODYZiAdcGuZw6cwms+82GS4BsmUzsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KaZb2CEJYoixhHKDThGpqB6fr1ifr+9M9JlqykhmcD988oXFfIaI6+FCd3G4SAjBj
	 u5+tL8hKK0BWo0+GP5MZ5hIFmybklJAShm29WnMtf54/kKiPgkGCRESR95Tz5Vj8xP
	 LfYYkZtQIgrwOlTwL6aQUdiFeZoGAGDerQzeoYB8NAkpHCLnpokAFR2iEn6E9zuDHE
	 t62+7eH7tFNiJIUXWvo68Zi79aa9pj2V0UvZM5q1v0W9HDWbkiCHGrJIe5my2/Q5Po
	 EXgH1+RdZomDenTDy4DSArLDkF31akBhevG9rq/Cpxc5Tx4/tHk4bGZJgI4nisN9ah
	 tjOVu/yfBUSww==
Date: Mon, 27 Nov 2023 11:28:10 -0700
From: Keith Busch <kbusch@kernel.org>
To: Mark O'Donovan <shiftee@posteo.net>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, hare@suse.de
Subject: Re: [PATCH RESEND] nvme: fine-tune sending of first keep-alive
Message-ID: <ZWTfupMR9IPjB5ox@kbusch-mbp.dhcp.thefacebook.com>
References: <20231124205659.523248-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124205659.523248-1-shiftee@posteo.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_102821_387153_BDE3ED4D 
X-CRM114-Status: GOOD (  10.12  )
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

On Fri, Nov 24, 2023 at 08:56:59PM +0000, Mark O'Donovan wrote:
> Keep-alive commands are sent half-way through the kato period.
> This normally works well but fails when the keep-alive system is
> started when we are more than half way through the kato.
> This can happen on larger setups or due to host delays.
> With this change we now time the initial keep-alive command from
> the controller initialisation time, rather than the keep-alive
> mechanism activation time.

Thanks, applied to nvme-6.7.

