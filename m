Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA24C2BA1B
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aAGH6wXWlMjReL4o/YCxuqo4duzKHhTue85Li1ws6yI=; b=MHxNhwbrpIv59rkT9v7H2Bud3x
	Ro2ddscPPHIA4LRyip2nMx4IVI6kBh8EpohwUpP6Kc8ltScjeG5H+DPuPJb54ivmHxs12gW9ooRyZ
	LwB0JH4ExAv8IWyoR5+bh0rBQ3VFUb0u4OG+DV6B9as5idYfma1ttBg355VtNyOFlZ02E9XFKWRSW
	wq06upfHjS7p53FqpMcIliMjsgmZFEaP6P4lLfHyiH5m5G32eZsCWMf+/azE8giOnKmwUDQuq5qE2
	EIWkfNKpN+gOAQkVSydYY51hQ8dBEDHQebp39EtD4vyMPYJt7fj0ry0qW22sx0N5dgjs2Dvxkra2h
	atJv0SUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsQNb-00000009Ca3-1kLw;
	Wed, 12 Mar 2025 18:00:31 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsQME-00000009CDu-1qYb
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 17:59:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BAC74A47160;
	Wed, 12 Mar 2025 17:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB43C4CEDD;
	Wed, 12 Mar 2025 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741802345;
	bh=Nhe3kXCMhs0V3Qxlf+bZ9chva2LNccUSEVkWWtw5Y30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUathdsXbD3y3s+/El3DlxZd2umXGcSIQuUUFVPwWQkZeDMM2xC9GAaYfisXGLdd0
	 gUYTWBGdwIJsY5GsE/3zDDMY0pbB2/jNgRlIofCKmHGtv6YlYivI3Kw8XJjcn/a04A
	 9JzLGTz2H6XxXfQGsBkLhgnXjvb+273z0Wtw6sdUdzqync3rqVGrss9q1Nc5rbAToF
	 XmxpebJsnwpqGk3lboC1u3V9Iaxo9l7K2gmcE1rJQwFE+EPCHiJqfDWxKceDaPv/QI
	 KXex5Bw50MppsUZ9YC67kOIPa5vfC3vimKNE3c3mcA0RLSwXhJnKSahJ8I8qvbhc2I
	 t4MmvVhPTOtMA==
Date: Wed, 12 Mar 2025 11:59:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: james.smart@broadcom.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	james_p_freyensee@linux.intel.com, jthumshirn@suse.de,
	zhanjun@uniontech.com, niecheng1@uniontech.com,
	guanwentao@uniontech.com, chenlinxuan@uniontech.com
Subject: Re: [PATCH] nvmet-fc: Remove unused functions
Message-ID: <Z9HLZukL5iMPKHtD@kbusch-mbp>
References: <E2A54BF9E5C050B5+20250312050650.1793024-1-wangyuli@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E2A54BF9E5C050B5+20250312050650.1793024-1-wangyuli@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_105906_543058_AD39F6B6 
X-CRM114-Status: UNSURE (   8.35  )
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

On Wed, Mar 12, 2025 at 01:06:50PM +0800, WangYuli wrote:
> The functions nvmet_fc_iodnum() and nvmet_fc_fodnum() are currently
> unutilized.
> 
> Following commit c53432030d86 ("nvme-fabrics: Add target support for FC
> transport"), which introduced these two functions, they have not been
> used at all in practice.
> 
> Remove them to resolve the compiler warnings.

Thanks, applied to nvme-6.15.

