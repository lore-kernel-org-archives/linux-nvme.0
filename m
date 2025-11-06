Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1A0CCFA05
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 02:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OG+i2PSnxXsVino4gbEh1rwdNoPZRJl+fsMyv2Cjax4=; b=MHWaE10NG8uLePnq+WvhKAi0O3
	I+h4D4wqj4dm3uNx3a1ITCev58ZHXEJVXI0HyFfc0oT1XKyAqHESFVLQvE4KexMomgnm/xJ4Zv+Cv
	2mPhgUtDySnTFqf/1a5qAkG6FLvzTmBibaRAMudOVqlbt2qxHVoL6/AdP77jtqcG41mBJcpA3AzXt
	W8G9fklYOFeYoKvetVNVxit7J6X34Qo8Ovccpq6flG7+ObA8+lOD2DFYWDUPgztLP5OPLClXb1bFB
	cP2ZyEeQiNpdR5eIg5R1/NSUHrYZN8Hp+nSEV8udpRDN0fhOnDgKb28GwOTsdxL4lpsw+1zSYiffH
	yRB4OL5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGq8u-0000000Emw9-2wqV;
	Thu, 06 Nov 2025 02:54:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGq8t-0000000Emvs-2RtJ
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 02:54:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 908FE60051;
	Thu,  6 Nov 2025 02:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09C1C4CEF5;
	Thu,  6 Nov 2025 02:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762397670;
	bh=OG+i2PSnxXsVino4gbEh1rwdNoPZRJl+fsMyv2Cjax4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VG1xpaPuOEWQYdPlIalnYT+rE6gHGPrUWKKdNalni4/4YCWhSVBBRg6XA2JlOoShf
	 A6YlSWKiCvySlhFDqNnj8Fkht+43mS+4u+xLi8SvAvtdN/EqMzZxLAzZlCq5Bh+R+0
	 q4vgGz14pmx7HU2+/093E3kEJK4JZ7m3F4mlctNI5PhbvmlyF9PRsBv6GB3WPmzGsp
	 iddz5nPCHAlvjy4CwjiF1fhlfdU72O8nEY84miBsp2F5qWeZIUaik/bmk8UTOVlKAh
	 2zzoOBzIO8OqoWcMUrutPLnQ137qSDB8jMzzQTUPt40Ex5tb1LHJCfViDMOxOprlrS
	 0ZIkQqVZ+S4YQ==
Date: Wed, 5 Nov 2025 19:54:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com
Subject: Re: [PATCH 0/1] nvmet: add basic in-memory backend support
Message-ID: <aQwN428CyJXeOjRB@kbusch-mbp>
References: <20251104080610.183707-1-ckulkarnilinux@gmail.com>
 <c705eebf-bb76-4bcb-8630-99907b1b6ac6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c705eebf-bb76-4bcb-8630-99907b1b6ac6@suse.de>
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

On Tue, Nov 04, 2025 at 11:36:36AM +0100, Hannes Reinecke wrote:
> We already have at least two other memory-backed devices (brd, null_blk)
> which should do the job just nicely.

nvmet also supports file backends, so we have tmpfs as another
memory-backed option.

