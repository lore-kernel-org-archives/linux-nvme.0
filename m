Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2FFC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 14:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3cJod1ou8YCdr369JrL+1zfK4SWoA1vnDNAhDp5Ok8Q=; b=YEAt51Yl/ly8UAkjqsuc1JQ7aN
	VzqojL/VN7zCAOwqSY+upVogt4/lrVElhq4qbF9UidiIwxyqNVnEBLaUrrK2ScwKIRf9d6OGS62Ve
	GhcSl++3XLobh2+E1gpHKAH4ZSa2WIBBWauhHr4nwktSEKSUwsMzn4iR9MQi/TuG8qXxJ7G/o25TG
	i+sv9bp36Uqe7CyA3oUjf5vOX3Ua8RNMgd8vTrXVagUVkDGMMltjPugzoTMgKuK83rsUrz/L5W3e9
	X0HFFHeuVnVLnSghMbKvy5+vYvg4uexkGZyV71YIMASb00eaEZ1nJd6mBoC0hA6Yavif4iKgJXSHN
	IIIkxFJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6YUQ-00CRs6-MM; Wed, 29 Jun 2022 14:16:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6YUN-00CRn2-LL
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 14:16:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 21E2868AA6; Wed, 29 Jun 2022 16:16:10 +0200 (CEST)
Date: Wed, 29 Jun 2022 16:16:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH v2] nvme: Add new clear_ids attribute for passthru
 targets
Message-ID: <20220629141609.GA16855@lst.de>
References: <20220627232543.73967-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627232543.73967-1-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_071619_922301_8FE7DC82 
X-CRM114-Status: UNSURE (   7.94  )
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

I've added this to nvme-5.19 with a Fixes attribute.

