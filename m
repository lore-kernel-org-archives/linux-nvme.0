Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08646C19F2A
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 14:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bc9/3RFQ3/BYv5GKcvhxJWM/+fz93rvd/+K14B4oPhk=; b=QzJmdEPq5E7QSu7PbegUPrcSVO
	ZZGAQ2ckBXdHWEsMNbltL8xUGT/SfB8SI/C9jbVSve7XjX04Ros8kX7fFG/kcQJT6vG44Tfebc8ve
	b1l+9BCN2jc+ATzSnu/4qjhMdka8qAJPOQuMjzeGP4n4oc39zJ992MAyNylNsij8SlFnB7RzCcDG2
	Gv5Yq0OcQrO2uPAcsesaAyvt9lIbM3GpCi8rMTQ6zfJR/x4UYPR+biHXahJSqXterU5TQ9R/tPFv7
	6CQWwQvqOvVDM06aAH+I3mt+Z/MSJrt39f+LIgTnwqoi6V/L1rzBHW6KKJ7vBWoJV2QN6WIfzbJS7
	6TV5LEqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLmcB-00CH3G-WF; Wed, 10 Aug 2022 14:23:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLmc9-00CH1V-8T
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 14:23:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8407068AA6; Wed, 10 Aug 2022 16:23:14 +0200 (CEST)
Date: Wed, 10 Aug 2022 16:23:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fabrics: Fix a typo in an error message
Message-ID: <20220810142314.GB25801@lst.de>
References: <9cff69b6e880387a420b848b7248dd6e6ad3739a.1659816888.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cff69b6e880387a420b848b7248dd6e6ad3739a.1659816888.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_072317_467267_B29C7392 
X-CRM114-Status: UNSURE (   9.73  )
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

applied to nvme-6.0.

