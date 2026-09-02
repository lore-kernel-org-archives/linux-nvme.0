Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967D0C61DD6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 22:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sL1z3cpxV0fED0g7sNCVHBMWzAM6oSO31BW4c89DvCM=; b=YhOLQugAg0WSARfCIARLd4E0Y9
	asKHsvNdVfNuWByRIT8/aX8LHQgOmGv6pFU9LvUeoDNBr7ILdsEpMl2dHSG7UJT3rOAmg3Avbsbfp
	CUDf0Uo3RV4HtURLXDwQkQi+0GAyPXp8+NyID3fk04dgpyjvjfTq0W0lV2Je7L/s0cFwohIUHiywu
	yvm8aPZwTFgH+tLS/KQ1gd7zkqfZKlLn1emXpw78QB2rSvjZBieNC0iYMcBGXVf9V9rm8s6sVpmlx
	nWgN9d2vsjGeTqjue5krtWGjmsOjy+XcRndkVMMTEfSBAPv2LrNzkdMd6qp0MYTz1eCGWCa3uaaZD
	v2FOAYZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1tUk-0000000G0xE-1I0c;
	Wed, 02 Sep 2026 22:31:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1tUj-0000000G0wx-3hld
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 22:31:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2570141592;
	Wed,  2 Sep 2026 22:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64431F000E9;
	Wed,  2 Sep 2026 22:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788388309;
	bh=sL1z3cpxV0fED0g7sNCVHBMWzAM6oSO31BW4c89DvCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CIVArlsZlF0R90V4RjeKtgNgRubxWT/sIqGW0qSSWDmQ+nTBXaGkx3WsSqJB5jnSM
	 0HAoivk65EtRM/fm5a0L2h7HQuluhmj5IxJ4gn4fbm+vH13kAIMZkQNtk9YflCiTjg
	 Hy6pk8pa6P4nVfGWo6SklnN1ZJ355U9qPDiumFVvskuhysKtAKpn9krgLN6anle8RW
	 EKfAvoKZQlY1sGL07q0v16rsc6IjAi7WsTsdIwSaMJgfy7sBZIml37XrS5647dlBxE
	 Wa1d8uDFiIW05G6F7rx0uOYFp1EDnIrS5QrsgM/03Tgab3A2LtHZ0Ihhy+66vd3jRk
	 3Vymz1DAFhFNA==
Date: Wed, 2 Sep 2026 16:31:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Seokgyu Choi <tjrrb0313@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	syzbot+f613f9f010ec98eb9d86@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvmet: reject namespace enable without device path
Message-ID: <apij0z23z93gb3jX@kbusch-mbp>
References: <20260827075221.312935-1-tjrrb0313@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827075221.312935-1-tjrrb0313@gmail.com>
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

On Thu, Aug 27, 2026 at 07:52:21AM +0000, Seokgyu Choi wrote:
> A newly allocated namespace has a NULL device_path until userspace
> configures the device_path attribute.
> 
> If buffered_io is enabled before device_path is configured,
> nvmet_bdev_ns_enable() returns -ENOTBLK and nvmet_ns_enable() falls
> back to nvmet_file_ns_enable(). The latter passes the NULL
> device_path to filp_open(), causing a NULL pointer dereference in
> getname_kernel().
> 
> Reject namespace enable when device_path has not been configured.

Thanks, applied to nvme-7.3.

