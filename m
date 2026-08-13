Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD9CC5B572
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6RWm508gShMozYVDbPaz9SAH7eFAAcFz7i/f/OmBrAI=; b=YYWn/rJ3uTbWFBUiRx2TRbaiqB
	W4ltNQY42oAek5panPR+ug1CG3y5PMiyEclcYpn8y/aZwnjIUgPvBeG4xSqwKdAIE/Riz0rL2xPD7
	P2CbUM0JB5LYDwK5b90uzlFGFlclGFSoJ6pdMNXXUOD0SZ6fhgy282Q6Cv7JvGE1VD6viaJ2gFqYy
	eTDYVL3VKpBcnb+4ls4FnmrKffYa6yYyV/zSYh2V0JAqnjIrbZTsokASxFQ31/nPeexeKPHZLyUWO
	wFOlNHwrZRRkEp5An0xMeIbTFcwdmVwDWtmPkNeHXXhCkHUGQXyRuBFp7ifSX5rm5BgwvMpjmIQH9
	rpNV/IcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYDM-000000019J2-1KFJ;
	Thu, 13 Aug 2026 16:23:32 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYDI-000000019II-2ZVT
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 16:23:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A8D2C600AF;
	Thu, 13 Aug 2026 16:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE081F000E9;
	Thu, 13 Aug 2026 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638207;
	bh=6RWm508gShMozYVDbPaz9SAH7eFAAcFz7i/f/OmBrAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nOoJpeUDp4MRM/+uDg4q7WbjWeVj0qlxKU7GTUvpHxyhiT94y0vdo6vnxCiseUEJw
	 u2D/ryUgguHKH9OyL2Ji0pEdrY6hIDYx/kP17DpntBkLnVIoShCqEsVjb7tJjgo7pP
	 K5x8Ei31IYbUb0nC2P4W3F0M8O+e5WJRIXZ5NY9Ft8b+4JEQPsUgszSdFftYeck2Y7
	 P2DRiuUoW+pNR9z68f9rIv1qx0f7vC8m/ySgZ3mdh2FKqsdxCK0VcnJT8oczRFvbrm
	 w0iAVuCF1P4WWw/CPc0PrHjdPGqXTjWySU5CRJImEpVxmCFyskVNHENJuHOX7yoONq
	 n7ltlK79MqppA==
Date: Thu, 13 Aug 2026 10:23:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Ewan D. Milne" <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, justin.tee@broadcom.com,
	Johannes.Thumshirn@wdc.com
Subject: Re: [PATCH] nvme: nvme-fc: Fix nvme_fc_create_hw_io_queues() queue
 deletion in error path
Message-ID: <an3vfXo6hRiNkz3Y@kbusch-mbp>
References: <20260513192551.892309-1-emilne@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513192551.892309-1-emilne@redhat.com>
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

On Wed, May 13, 2026 at 03:25:51PM -0400, Ewan D. Milne wrote:
> nvme_fc_create_hw_io_queues() will call __nvme_fc_delete_hw_queue() for the
> last queue on which __nvme_fc_create_hw_queue() reported an error when deleting
> all the io queues if they cannot all be created.  This is incorrect since the
> last queue did not actually get created.
> 
> The most recent change to this code was commit 17a1ec08ce70 ("nvme/fc: simplify
> error handling of nvme_fc_create_hw_io_queues") which moved the cleanup to the
> delete_queues: label and changed the loop bounds, however the code was not
> correct prior to this change in a different way.  The original commit
> e399441de911 ("nvme-fabrics: Add host support for FC transport") had a
> different error which called __nvme_fc_delete_hw_queue() on queue index 0 which
> is used for the admin queue.

Thanks, applied to nvme-7.3. Sorry for letting this one get lost for a
bit there.

