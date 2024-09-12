Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A022EEB57D
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 09:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f/Ky1qRo/bBl5XpPNJ+b1s2pFw0Z6N57XaTz54sWdm4=; b=UtsNEYswZqkQJZtWJswsrfSsZi
	35GASFcPzYqm+MnKLc/KYJ0TN9M+HJlTuZielCtBY+U+qEKpHUv9wJtKYN0HrMN8B/+D67JAT3g6J
	ndcL9jRBdMgvAClq2qawqAON4SaWfMm+fo06dF8D75yM91/9fUo1XMnggq+s/0uRcKX+SGhfIqJjJ
	ENcb7lrmYww9QfiFYP8ejXoHm28FjoDBtnJXnWPjIA33ZUNDT7ckZP+Hjej2anHLVNH92KMldcMVL
	f1wrIbB/sx/rwoqHlM1cnGceWoO4VK8H69Vusp0jmkbP47wVM3Q0BJMu7HQHGhvZWJo+lw655bEoX
	VyC6Hkzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sogJT-0000000CZhn-3KH9;
	Thu, 12 Sep 2024 09:40:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sogJQ-0000000CZgy-2oQc
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 09:40:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 979D7227AAF; Thu, 12 Sep 2024 11:40:20 +0200 (CEST)
Date: Thu, 12 Sep 2024 11:40:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yihan Xin <xyh1996@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Force ns info updates on validation if NID is
 bogus
Message-ID: <20240912094020.GB13465@lst.de>
References: <20240910095006.41027-1-xyh1996@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910095006.41027-1-xyh1996@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_024028_871936_047DDCEB 
X-CRM114-Status: GOOD (  14.05  )
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

On Tue, Sep 10, 2024 at 05:50:06PM +0800, Yihan Xin wrote:
> When validating a namespace, nvme_update_ns_info()
> would be skipped if nsid changed. However, this
> happens everytime the in-use controller is
> reattached if NID is bogus, causing nsid not being
> restored to the previous one, eg /dev/nvme0n2 ->
> /dev/nvme0n1.

What do you mean with restoring the nsid?


