Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1D8F8E4B9
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 07:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=dM/iuEi3CLuwJXSQcn8KWNnGt/
	j53bpZVS2foPNUy+iQ0la29DV1lhVkT6Ulbq0CcvyEGn23EfwJa5eFWs/8F7avf8HhZt1AAYJdbXi
	aoxJiszUU97a+1pnFu8bBnz9AGndVle0iXuJ+4RP/kprE3C8+Qg2VoEU3saYeeZR0XSHbTneBsol6
	GrSN91d0ouFjFbop1vmxgIOSd8oYSmrGbMs3RQO1BsPCwaIqA1HqmsmLxr885S/d1EOIXexuEs1DP
	UieBJoUVMTjsmHpJr7o6hkFGjvv9lQd9ytBxCqh7C1KMHza4HhXn4Pv4G7w8a5JjJ/mKV5D9A2do/
	J958ZppA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDe19-00000003d8W-3x7w;
	Fri, 17 Apr 2026 07:53:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDe13-00000003d5c-40mX
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 07:53:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 64C4E68C7B; Fri, 17 Apr 2026 09:53:27 +0200 (CEST)
Date: Fri, 17 Apr 2026 09:53:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	kmodukuri@nvidia.com
Subject: Re: [PATCH V3 3/3] nvme-multipath: enable PCI P2PDMA for multipath
 devices
Message-ID: <20260417075327.GC31524@lst.de>
References: <20260416212633.72650-1-kch@nvidia.com> <20260416212633.72650-4-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416212633.72650-4-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_005330_144560_7484A7D7 
X-CRM114-Status: UNSURE (   7.95  )
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


