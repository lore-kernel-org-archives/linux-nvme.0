Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA93C77B71
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 05:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=W72i4xV28E+u2r7Z2Rq7AsM6Cf
	iB4XuWfuzrEQqeLzxFmnGFfEI8i39h0aikZSuf5pzD/Xw7j2RPiQCAHzrKC5wmJkXIZGmy3vQmO+z
	LICweL+hEvoVBDoXx/C7kzmRabF+ldpnY8kBUeFJEKt2WolZhGRzOAqnO7umV9v9II3g+SdtGyt/V
	UDr8anScSf9j9goozNBf3K8xCb2DuLqt3r85zEFJHLFZUbMXQ0sMcEosudSj6XKUEiXNyDkK0FZVT
	9viPmtYb9l8y7Yx/o7oEM4DOZjN0YpzXBPKc0Ek0cOaNOgAYa0aIvQcBTZskbc+yhEiColBZpwxaD
	KT8jm3+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm6fs-00GTN3-0J;
	Tue, 11 Apr 2023 05:36:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm6fq-00GTMR-0j
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 05:36:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8327168BFE; Tue, 11 Apr 2023 07:36:07 +0200 (CEST)
Date: Tue, 11 Apr 2023 07:36:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, kbusch@kernel.org,
	target-devel@vger.kernel.org
Subject: Re: [PATCH v6 16/18] scsi: target: Pass struct
 target_opcode_descriptor to enabled
Message-ID: <20230411053607.GF17645@lst.de>
References: <20230407200551.12660-1-michael.christie@oracle.com> <20230407200551.12660-17-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407200551.12660-17-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_223610_412888_BAAD6916 
X-CRM114-Status: UNSURE (   8.35  )
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

