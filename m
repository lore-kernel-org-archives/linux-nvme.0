Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E023C7EE25
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 04:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=MvLAjRUvJL5kTSjIv4i3GhYBJA
	ONyTBUmhzqrehmvYH7wZm5W70Oo+nrYEfRRcs6bxe+j5/XMWH0qepZfhu76sOjktcMo5im7Omf910
	vS5a9qdP/NdLIIX98soKcr5RpwPKSipW1dXOVyFvIxjeY2OljGaykTZTjaCSM+TIs1S55gwZFvFjr
	3hGCOzARvG++Ih7663d5A+6yYOQdjs0Nps1FbOPCkmnOU/qtWc90ZZeR/TIR6T/6CXvCmWYc7a4fc
	TB/77I7ycPwxvGu08SGzdo/stVYqd1v9kPsm4Ol0yibhipe4CuTaxPqzKAQ1s6PiUi8aCxFa7d+Xh
	aIl5p98Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6lFQ-004Lsa-1j;
	Wed, 07 Jun 2023 04:58:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6lFO-004Lro-0X
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 04:58:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D92C68AA6; Wed,  7 Jun 2023 06:58:11 +0200 (CEST)
Date: Wed, 7 Jun 2023 06:58:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, kbusch@kernel.org
Subject: Re: [PATCH V2 4/4] nvmet-auth: use correct type for status variable
Message-ID: <20230607045811.GB19819@lst.de>
References: <20230605064434.45233-1-kch@nvidia.com> <20230605064434.45233-5-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605064434.45233-5-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_215814_348067_6B407CFF 
X-CRM114-Status: UNSURE (   8.22  )
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

