Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD978C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 18:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D8hIfR+r3fYx71BoJvauBCD7AIDIdk6V+t3YQ2y3sEQ=; b=xv8QjLLmRM5bv+DAW/FYzAo23D
	5ULefDfgIscIMge8Kpz4gAFE026SXIhSG1Xa0gymYs+VtEu0ZmFajUpBEFCEbmB2/o1gEv1v5N8Di
	Pg0xoYxG8aO/Rv9xatRIEQ3J/a4gdqYmaO420rC0EkW400jPbq3Nvx8F6Ynl9xuD9KSTleopJI2JK
	MSy76zH2L7ac1G30H5FjxEg+LaCG/nbjvUQGkPVWBJ2CCnQIySK4noN76TSOaHXbQwGoV/OH86Ssx
	SnhykwaPESwGrwK7ZurfA1Wjf08NXSghMPN8FAoomu85GBapz0uWP8++fVLUJ1un4W6Pqx8oqFkPx
	IR2fzDcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoTM-0000000DOAJ-1Udy;
	Mon, 06 Jul 2026 18:55:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoTK-0000000DO9O-2XQj
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 18:55:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4F7F843A01;
	Mon,  6 Jul 2026 18:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10601F000E9;
	Mon,  6 Jul 2026 18:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783364114;
	bh=D8hIfR+r3fYx71BoJvauBCD7AIDIdk6V+t3YQ2y3sEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k2EqaADhQ6jweBqQGHJpS/h0AiVq/zFDIuqU/l2dggqZb3PSwRUIRQ+ewmzb1P47X
	 QRghmW4oBdeRJCGsck2RJjCjcR1exmHFhR7blsBLbFyau4QmqZ2/QSOCjDRe7TF8yI
	 7RH1aTYbkKMK3bbwQgGgFlW9EbSI7JXkB0soMJq+0hwWEuZ9rs948cazcy6mOnrb8n
	 j7KMbBim7kCqp2oGpD0O8tqO5O02VVoF6M00/Z3XKhAa1Fid/tjJe0dif9D/WWuWmY
	 NnX9ljTMiqIJ3TW97kjn1CGkuWFoWqjecFC1QLBnCMI7ZSX1iaZru93am9kLEoDxiU
	 jjZgj8o4iHftw==
Date: Mon, 6 Jul 2026 12:55:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvme: zns: cap zone report nr_zones by DMA buffer
 size
Message-ID: <akv6EIeaTyeufNN7@kbusch-mbp>
References: <cover.1782280420.git.liuxixin@kylinos.cn>
 <cover.v2.1782280600.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.v2.1782280600.git.liuxixin@kylinos.cn>
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

On Thu, Jun 25, 2026 at 10:00:00AM +0800, Xixin Liu wrote:
> Hi Christoph,
> 
> Thanks for the review.  Split the zone index logging change into its
> own patch (2/2).  The nr_zones / buflen fix is unchanged in 1/2.

Thanks, applied to nvme-7.3.

