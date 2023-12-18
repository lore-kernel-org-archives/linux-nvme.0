Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45E3C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 09:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oxM5yLVr0n6IOGhTNsfrXoT6lqo5lAx7H6S1jy8rfks=; b=3jZVgWim9+WMjbP/XAS90bbttZ
	WTHtQq8mwygAQM9Y90ijgaeN7JUyJ91pbU5MKuadc5obpiCqd8xvJD8fsLLaahiIuL5ttcXRQ5lEF
	x3R1HeoVfhSQmq9zwOGSudNiY5u+WhWa0dvv/uKfOIBJB1mErkTLCLyrdTp/RHEImlXObHFGYGn85
	6ya7ZaFqP+MeUilu3zDF7aiibtYme8RHnWeZ/yFERDXEis+d3jbvYBfndU/h7+6mdAbBI+jXGIc1k
	zUSkv2Fb0sGvqMIE50xMcNqoYerwsEfNCowdw3rqHG1nKSnYZAi35i+8ikj5tWN4FONui6Xye3AsR
	Z9e/fAYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFAGM-009ixI-0B;
	Mon, 18 Dec 2023 09:50:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFAGI-009iwp-3D
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 09:50:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4F69160D37;
	Mon, 18 Dec 2023 09:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2461FC433C8;
	Mon, 18 Dec 2023 09:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702893010;
	bh=kliH95p4M6Xr4U/JBggiZ+H3u6I+liKEwWc2N1aGs18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FjXofiJhW9jL1rJtTbtwM+I1TO2JOPuwQLWysbLSk8VmfoJOporitqoAdo9zgM4tg
	 KebfTmvh2aktzrLEqFs/N0kl0uX4DvMaJgNWC5QM13PqxOrnSgLHN1nqp1uAZO8aBo
	 7JeNjhm1+aVR3evMPZK7qGpZIohwlWocUFheFK/AptmYfRw8IxPGb+DpyXqm17UJf9
	 wnuJBeilC1v2AgUTB+kvoBQeW3XHlcSMvr9hL2xfyetrXq63JhRlMZaNt6WyUy3gVx
	 cvhYq19/9JgtCumFTXIsxg1N+G7htDR9zvV6CTBfugqodVINZSHaYzg9bz+6On7/xx
	 yTtMD2cAMlOqQ==
Message-ID: <816f252c-191f-4517-931a-3d7b14dac654@kernel.org>
Date: Mon, 18 Dec 2023 18:50:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] block: simplify disk_set_zoned
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231217165359.604246-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_015011_079343_A7568BA5 
X-CRM114-Status: UNSURE (   7.80  )
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

On 2023/12/18 1:53, Christoph Hellwig wrote:
> Only use disk_set_zoned to actually enable zoned device support.
> For clearing it, call disk_clear_zoned, which is renamed from
> disk_clear_zone_settings and now directly clears the zoned flag as
> well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


