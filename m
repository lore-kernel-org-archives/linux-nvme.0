Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A467C28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 05:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=zntDZyta7F7/J9cEjfUq1knFx7
	GVIrL3V5DWowdWkArGvoy0I78MEWBTr4GySpfOZJRfkfJhxhVhcZLpAiLeCbitXg14ZxJ5SGLgftG
	YodKIbfdUkJlKrOKBTIey8x8OmGTS3+OSbY8gw4Nudyuuj3viZpDUUvmbmCPhUYfng/ZLZz3mYBHm
	jIQxh5PbXPbmR6UsqrYVybQwGg0/botT3IzClHCxX7kGbd8RsA4wp5EUy4Db8eonTcnOx+/bzw+xA
	+KL5FfLfnu9ONiScY7gtMQC/bPh2lnos/25ConccScJ/Yl7TpjsZIzjiZWVThuKOY9jwjrkl1cnES
	6o3657og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsEa5-00000007WGt-1icL;
	Wed, 12 Mar 2025 05:24:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsEZO-00000007WDk-0WKx
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 05:23:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3CFA168B05; Wed, 12 Mar 2025 06:23:50 +0100 (CET)
Date: Wed, 12 Mar 2025 06:23:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: WangYuli <wangyuli@uniontech.com>
Cc: james.smart@broadcom.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	james_p_freyensee@linux.intel.com, jthumshirn@suse.de,
	zhanjun@uniontech.com, niecheng1@uniontech.com,
	guanwentao@uniontech.com, chenlinxuan@uniontech.com
Subject: Re: [PATCH] nvmet-fc: Remove unused functions
Message-ID: <20250312052350.GB11864@lst.de>
References: <E2A54BF9E5C050B5+20250312050650.1793024-1-wangyuli@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E2A54BF9E5C050B5+20250312050650.1793024-1-wangyuli@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_222354_296589_5E9AA9A5 
X-CRM114-Status: UNSURE (   8.42  )
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


