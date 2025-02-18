Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ADCC02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6b++hp+qnjJR0ez2dLHBKIaVA93WeeFSyXk1yt9LCI=; b=N6Uc6+Zt4sOuY92YIh6gbQC7Fb
	1ekrMkSvlaRAM/QxXvKqeEvgIuELGRu6y07vPvJO2CrsW96QfnsWWT382pvO4GGGOivxMR21ZKLXM
	1mhLLO4sX2BM4Y7L60M8g+fubdNSPi7DjLwKSz4zooIuXkN7KvfIfDd4rzxYzlcJsfuAaqGy1OYrJ
	13/wQEKtewh8WRvmhM1SAJLP00uOw/01DmZGLHsJRMCEtskK77x2RMjLrS+tAfYz+W51SBZ4txYJG
	jj7oTPwp7HEqO2gYZDm67W03Oo1whYXbZ/NnwUk0DJRYWNIFSunw382PyeUCti6UagTaVxf/7k0f7
	8PcOguqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkJFj-00000007LdK-2u7a;
	Tue, 18 Feb 2025 08:46:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkJBV-00000007Kg2-117c
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 08:42:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3726F68C7B; Tue, 18 Feb 2025 09:42:18 +0100 (CET)
Date: Tue, 18 Feb 2025 09:42:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christopher Lentocha <christopherericlentocha@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix two Acer FA100 SSDs from interfering in one PC
Message-ID: <20250218084217.GA11129@lst.de>
References: <71ea150b-9ea0-3e49-6195-ebbe761bacb1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ea150b-9ea0-3e49-6195-ebbe761bacb1@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_004229_423392_F1698655 
X-CRM114-Status: UNSURE (   9.36  )
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

The subject line should rwad something like:

nvme-pci: quirk Acer FA100 for non-uniqueue identifiers

and the commit log should be wrapped to 73 characters.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

and we can probably just fix that up when applying the patch.


