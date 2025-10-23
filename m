Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F535CCD1AB
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 00:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xlqUzaO1ernO+0ZZ0uDdbA1rALnpe2ZKuGEu9nr32XQ=; b=ShaPMt/y+eK81CVLC1oX2+AUQ/
	sMKk6sV25xoxwOq6ej5WdIg8I7tux3dqsgKRcHACV41PlCNPik8pIGh/q38fty/kEH1PAxspDNdqV
	/4tVdF7AbeUJF1JD45vTDbNnIB14ArIbMusoYHL9PTjgtL+HqjDX0W6483o3YtO56arfWrpXMyEFw
	8usZNydn/JKYHruuw5LqBr06Ho+IPlHChBW0PeCkp7/IxXajI3wxx0LYDfRcTVkSsfjl+1iYycTs3
	Z5NG8GM5SaJsI2opmjdTzAKrUYEtdcDajm6cpXr7H5dmDTTXMVjgE2uFBMZu2qtEPzob+Iuh9R089
	OZVQ989g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBjLU-00000004gU2-3AYe;
	Thu, 23 Oct 2025 00:38:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBjLT-00000004gT0-1XqD
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 00:38:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3531A457F0;
	Thu, 23 Oct 2025 00:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3059C4CEE7;
	Thu, 23 Oct 2025 00:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761179902;
	bh=QsKV5cUM/JGvoJLKuthdh7XT5Z1w6tkd9NwuiSj1/U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIaxwZNBz2r6bgAfkdPTmpWdonLqBokcwctW/K75wBRG27Iws7eW5FweRG7NJbrLK
	 ichynfZMCVagaDMvSWbYbJ6k+VWYGk+UxoKHxhnaTP5OKj/YYixwfr9WDXDYmq4kMB
	 1Ni94uaR/598ePueVyeecmVK4FCDUhcsYQtLFJBD0BcLGUkHqQWGzQVbsgETi9m2Xa
	 prx9oodfiLJu+GUIeMw4yLbSDLapgC0DQejV1XBrTZUcpsers7B+os7psG+b3XGBrh
	 GbP8pJ73VxBpRJ40ioIcRLFirxxXnUVx476qmgKOLBoYZoTd3008gVBzp7+lc9Y0IV
	 kadMAd1a04+Mw==
Date: Wed, 22 Oct 2025 18:38:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvmet-auth: update sc_c in host response
Message-ID: <aPl4-6WQ940kUso7@kbusch-mbp>
References: <20251022075924.117162-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022075924.117162-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_173823_421615_1D6D949D 
X-CRM114-Status: UNSURE (   8.67  )
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

On Wed, Oct 22, 2025 at 09:59:24AM +0200, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> The target code should set the sc_c bit in calculating the host response
> based on the status of the 'concat' setting, otherwise we'll get an
> authentication mismatch for hosts setting that bit correctly.

Thanks, applied to nvme-6.18.

