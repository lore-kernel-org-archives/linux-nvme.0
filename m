Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776F6C7EE2A
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 06:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ce2rZuTOIiUfkOYOF5i+V6mlSLG61fiLuBF5tCoqLw=; b=ELk+EUKEWdSwc5Cl1ieMNfDQ36
	mlQgt15c4ioBVp532gLE7HwdUxhWWv4S7cVnKQEoPB2UeaPE92EbqZHB7ViFoEp7/JC8MfG4imA2g
	NmPQ5ueEKkzhfiCWOlB67dWmzVR46r7SJdhlSDgjUxC11KmQ43QO+daqiMDMPeaOabc5GHxyDy2EC
	mrfs4d5fhA29XXSBUWDY6L2McGqgosVsCkHYyx9P+NwUarb2IdooqfzhjV+TLDOMYToHBdqjuHTHJ
	Tl/wVOb4mTROeJ3rhbmMmnfs+trc4XPciGLy2j1sCTjhbEEVzun2xvfAk+feH8n2x6CSk0sZO0xAY
	Foqu0LTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW87t-00000001Lg5-46u6;
	Mon, 30 Jun 2025 06:36:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW87s-00000001LfF-0E28
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 06:36:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E36C468AFE; Mon, 30 Jun 2025 08:36:19 +0200 (CEST)
Date: Mon, 30 Jun 2025 08:36:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@yadro.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: fix memory leak of bio integrity
Message-ID: <20250630063619.GA29641@lst.de>
References: <20250625114533.24041-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625114533.24041-1-d.bogdanov@yadro.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_233624_232333_A883A2D8 
X-CRM114-Status: UNSURE (   9.67  )
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


Thanks, applied to nvme-6.16.

I fixed up the commit message to include a Fixes tag and drop the
mailing list reference.

