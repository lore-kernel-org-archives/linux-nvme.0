Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122E3C3ABB6
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4APg6yVz6kgCDi8Roxi56DKotyt2hsl1mO8Xu/bEAlI=; b=OrM8XLkmNxQ9ae1L3ZJlYzthIk
	WyUTTcp3dvLTjSEnlxaVAm1GOeHcN1qfZ/tbQMn3pxYB7fi3CbqyCanGodVNYk0CzpVRw2BTy9fEn
	RcDBf1ymS2ylMpAGmlZIQVz1J05bx6LKjFdTXKoMj5RKHtchD/MZjMPtQsSegxxKJHVl6g2sYmFFf
	eJ98A4lMw241n6DKK42R/a/5TU5Yc1AUFnDS+85oVqi7+HCUWmaAk0/5lbkPY50z9xfnAFlcF3pgP
	AGKXQznaOHzMM3gMMIgbwcKEFSrEB1RLP5c4iPBCfnYAOaI2TtOeR5fOLCBH6lOdQ4YaUWBXLh4Et
	7EQZ9F2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZ35-0000000EUWI-2RyH;
	Wed, 07 May 2025 07:18:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCYwJ-0000000ETDA-4A7w
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:11:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0626C68B05; Wed,  7 May 2025 09:11:30 +0200 (CEST)
Date: Wed, 7 May 2025 09:11:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv3 0/2] nvme: restrict authentication to the admin queue
Message-ID: <20250507071129.GB913@lst.de>
References: <20250422091556.145494-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422091556.145494-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_001136_171581_7CBA34E2 
X-CRM114-Status: UNSURE (   8.99  )
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

Thanks,

applied to nvme-6.16.


