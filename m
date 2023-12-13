Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3FFC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 08:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=a0iSUV3xA9Jc97qVx8KVPFlqXX
	maeSlgJY/vHaGF+Qs62Kk5FlA0Zb9tSp/nlMBXEanjgxVgdZE9TISV7tEFOv0klF0w4/7THfY5Q4D
	QEc7NYsCrt5wZvceyqzTXIgyFLS8sAEmeTzpAWoeLAebSR15fmdPfn8i1AwKdQmxGdCmJ970TNdIN
	i+7D5JjprlaFiruosnUmYzTSmwh3LLMN6hGIikffJ6FuK0sge4VRN6V/27IKt8XjDU/hEDUOgXMox
	YGi2pDnUR9poKk6XoirG/kwI/aW5GjHrvKvhV8Z7t9iByXCtJVeycRpjALCp2sss2YejzaoflwHiZ
	0UWt1QBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKqW-00E4DD-1S;
	Wed, 13 Dec 2023 08:44:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKqT-00E4Bi-0U
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 08:43:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8189468C7B; Wed, 13 Dec 2023 09:43:54 +0100 (CET)
Date: Wed, 13 Dec 2023 09:43:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/5] nvmet: remove cntlid_min and cntlid_max check in
 nvmet_alloc_ctrl
Message-ID: <20231213084354.GD6184@lst.de>
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com> <1702449172-8920-4-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702449172-8920-4-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_004357_352802_5DC4BC7E 
X-CRM114-Status: UNSURE (   8.87  )
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

