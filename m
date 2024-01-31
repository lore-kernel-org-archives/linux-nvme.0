Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00008C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 07:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=MBkwYhaJFGrWwhAYRVBuDnpzok
	tFE2u0JbKt+0xnjIvUU8nMy9pJ02OeKATAwe8HCXsaVOcat41H4ibuYep5aAzsYJdWxmSX0jFU+De
	vaHloIxrfL1JVlPikmdfUUX1MssCQ4Wy8aECgKbOr1uqw0mvV+YFbfBIALZeMes3qqKpQiE0eSqDQ
	XQTdzGsAnHmu5S9a8BruJ3h7C0Xqmz03ieOR/iYqZC1DZ3l9mDPFc/AU0Z23j5wjysHXgc9Htk2WY
	2uNUcrL2Sd1qg7HtL/I9y4hKvv1Vj0Chs/ejmcCjZoZC/Y6F0+WB5S28vfxYZ7kuACDfcWUxSmHL5
	aFaGEfXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV4pR-00000001l8u-1iDy;
	Wed, 31 Jan 2024 07:16:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV4pP-00000001l8K-0DR6
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 07:16:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5A40C68C4E; Wed, 31 Jan 2024 08:16:08 +0100 (CET)
Date: Wed, 31 Jan 2024 08:16:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH 1/3] block: refactor guard helpers
Message-ID: <20240131071607.GA17498@lst.de>
References: <20240130171206.4845-1-joshi.k@samsung.com> <CGME20240130171923epcas5p4610296779861b362ef98f3b6f819a060@epcas5p4.samsung.com> <20240130171206.4845-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130171206.4845-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_231611_239177_1F23ABC5 
X-CRM114-Status: UNSURE (   8.34  )
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

