Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E223C4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 06:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=gyAKAOV355uDsLA2Px/hsmcJ+/
	G0Op71+T7gCQ9q6rY0B+Bbe2ymUE2NKGaGYRnKZtje7ofoBlKjuoZ2KO/0YtsLQ8AofQzx7l1oafP
	ZwtcC31KChzgdw+AMPB9+/AVxtMVdkZSidI7IUlPanGYYr1BMTreakKWm8xESurxzd6uoWv6fFqIP
	TwY8pu4x1kPUXBECR1il67k9IN0qPtnvn4SwFpNI4qiKqgqaRGsW9gj86MJHaQ3JCbYN/0oykFRp5
	cv267k2A7aawlQ0VRihzsJPFdBb2etRBT1XV6GN0zsZxracDjMz0Aer/xMWN9IyM+P7S6ADbpSiJ0
	YvaOBEvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQFk-00000004Rcc-2RN7;
	Mon, 12 Feb 2024 06:57:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQFh-00000004RcK-40om
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 06:57:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 51725227A8E; Mon, 12 Feb 2024 07:57:15 +0100 (CET)
Date: Mon, 12 Feb 2024 07:57:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH] nvme: move passthrough logging attribute to head
Message-ID: <20240212065715.GA17481@lst.de>
References: <20240206175040.553999-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206175040.553999-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_225718_147632_45007C17 
X-CRM114-Status: UNSURE (   9.00  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

