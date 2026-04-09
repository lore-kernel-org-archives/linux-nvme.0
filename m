Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5563CE98FB5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 06:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=CzMeXKqyC6NvG8Th1aK5+Hr91w
	zIw+N5LOIe+EumVVAoEqaLMvYI02KeLLXoFGcJrcJfVr6KlmdH4CfIXp5IFhYOznaKYPtJTiB6kFR
	NaNsiMQupHwWbiw5PpHVkmMDSlTDn+IJwmpT2x5HdDx2nRXCdD/6MCmxzTu0fMSzXDKVDNIpKWV+9
	UVhXj5ZXtEqg3HfFaQlR35GPDd9Rc5t2XGDcUv429QjMRXbZpnmOZhYiCPBJch7t8vCfxqfjnh9KY
	Baqm2ZrzypOkNuhygJKOvOTisNrc0LrjM7I48JJsNNwpttSvq1I0KABWUWZJI49o1YJQoLJ+aePwJ
	v0YwQk/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAiak-00000009kVy-3OQn;
	Thu, 09 Apr 2026 06:10:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAiai-00000009kUQ-1eB4
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 06:10:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF1E068CFE; Thu,  9 Apr 2026 08:10:09 +0200 (CEST)
Date: Thu, 9 Apr 2026 08:10:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: sagi@grimberg.me, roys@lightbitslabs.com, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: avoid recursive nvmet-wq flush in
 nvmet_ctrl_free
Message-ID: <20260409061009.GA6470@lst.de>
References: <20260409005647.112289-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409005647.112289-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_231012_655800_0234ADF1 
X-CRM114-Status: UNSURE (   8.13  )
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


