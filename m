Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9EBC4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 13:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NTiKrWE/vb9jNd9eBpDak343KIoS7Dt+ulb2yiTZ0hM=; b=F9j2FxwXe1JSBeZdTGuD44RmWG
	4HIW/KSRdyUYL9IDubGqvcn2aQkn8SNCiE/E5C32YxXmQZLUm/O4+KQOHPFzxe0SZaB5TiYoQ6828
	RE7uIYQWs/cg3Aa485u1zVQnG9rOa+hzu7P/gQMcOhudRVnwMYmjf2hWAI3155YMyGeeq95q6o1cy
	y8X6FHPv10XlqH/467HE24Bpp5db2ddAZLOO5lSeN/yj8y5vxLKCfRJeNMGc1MonzEabhRkgKUQPJ
	GRHNy4cmRTXpmQNhEnNRuwxp30GRIloLvZSRPTkRSa/HqE4hFFV3LIBE76sH7HlC85Q2AIIyzbCLT
	dgmtQZIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00en-008oZk-0L; Tue, 29 Nov 2022 13:28:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00ej-008oYK-Sj
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 13:28:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF80A6732D; Tue, 29 Nov 2022 14:28:05 +0100 (CET)
Date: Tue, 29 Nov 2022 14:28:05 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Christie <michael.christie@oracle.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] block/scsi/nvme: Add error codes for PR ops
Message-ID: <20221129132805.GA13061@lst.de>
References: <20221122032603.32766-1-michael.christie@oracle.com> <yq1o7sumo0c.fsf@ca-mkp.ca.oracle.com> <538bcade-c453-e6f8-4530-808a9bf2140a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <538bcade-c453-e6f8-4530-808a9bf2140a@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_052814_089263_EF17925A 
X-CRM114-Status: GOOD (  10.16  )
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

On Tue, Nov 29, 2022 at 04:18:19AM +0000, Chaitanya Kulkarni wrote:
> > Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
> > 
> 
> perhaps a block tree since it has block/scsi/nvme ?

I think Mike has SCSI work that builds on top of this, and reservations
ar originally a SCSI feature.  But either block or scsi is fine with
me.


