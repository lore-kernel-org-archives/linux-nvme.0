Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C009C47DDF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 09:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rc9G4DboBCgFV8eWvbk/gP3OjU60Uk3SdiGMpXl31qA=; b=CW+7925f6Z4GG6uyeq+VHpL99r
	QfMxgtA45LggFuLwc2qY3V2pgymvlAZ5tz1C/ls/56Vx5FAtVmE3FBR+dw6FKvCJH7RG66zym/GC8
	bmIx3JfiRv8Co3bYE9mH1vTuzD3BFjz7rfLsdWaeHPkBXgJPdVd9UA/gqe25oY5/wOX41g0/1OHOo
	wyTtVI9w5hqir9/Il9pec5xXio1A2E7KLUpsdJnQsCKNzAPClcVFWEvvIplvfap3YI4uV8VqLupKw
	ocnmhIs54Yj0Yj+X3724psl0br8brQOnBsCoXm4VG86Jomtc1gjRYYZeY+IIkcQLvGdyW7fNylEOE
	2VcX3FMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZs7-002Kkd-0L;
	Wed, 24 Jan 2024 09:48:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZs4-002KjL-0J
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 09:48:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4631368AFE; Wed, 24 Jan 2024 10:48:32 +0100 (CET)
Date: Wed, 24 Jan 2024 10:48:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, oren@nvidia.com, israelr@nvidia.com,
	dwagner@suse.de, oevron@nvidia.com
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Message-ID: <20240124094832.GA31289@lst.de>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com> <20240122145659.5574-6-mgurtovoy@nvidia.com> <20240123090231.GD30773@lst.de> <f168e3d8-ddec-46cd-a032-2ca771b6cd23@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f168e3d8-ddec-46cd-a032-2ca771b6cd23@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_014836_275456_6F15A884 
X-CRM114-Status: GOOD (  12.69  )
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

On Wed, Jan 24, 2024 at 02:47:30AM +0200, Max Gurtovoy wrote:
> for example if a the PI was supported on the port before re-connection and 
> wasn't supported after the re-connection.
> We must first identify the namespace format/identifiers before kicking the 
> old requests (otherwise we will get IO errors).

Why would the namespace identifier change when you reformat?  They
should only change when the namespace is deleted and re-created.


