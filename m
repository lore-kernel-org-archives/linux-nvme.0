Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12F2C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 05:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=xyb3keOkc8AvPKXE7kG0mDFRS1
	hXfT84160pDxA/4zYhmzKg9SKYaxhsZoRZksBVdOBTJ3jdiUVKumxnQY0XShME30lo3B9YzMsRkPz
	c2Mzb1HmXMnmmtDkhKuYKD5FhhRWpzg41v5CkFQkpaww4Tt0KRz79Wua2K45y8JnuPt78VBirQkuL
	Uh1Ac52v7YmvDGVcvs6InAKFsOHk2Nd62QYk+hX2UC0WybgaFVwrtdTM9f7jO5UgaNLGQxuZhje14
	pXdJmeMa9U+ndpCDbFHRaMDz1Haz/htOCUas2ecK6TAqsZC6oOuBwvGuc9gCr4I98OcjMB1odYdc2
	3RsVAb0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3ARy-00GNDW-6r; Mon, 20 Jun 2022 05:59:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3ARv-00GNCV-9u
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 05:59:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F18668B05; Mon, 20 Jun 2022 07:59:44 +0200 (CEST)
Date: Mon, 20 Jun 2022 07:59:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@huawei.com>
Cc: axboe@kernel.dk, damien.lemoal@opensource.wdc.com, bvanassche@acm.org,
	hch@lst.de, jejb@linux.ibm.com, martin.petersen@oracle.com,
	hare@suse.de, satishkh@cisco.com, sebaddel@cisco.com,
	kartilak@cisco.com, linux-rdma@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH 4/5] scsi: fnic: Drop reserved request handling
Message-ID: <20220620055944.GC10192@lst.de>
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com> <1655463320-241202-5-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655463320-241202-5-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220619_225947_532734_2FC7287A 
X-CRM114-Status: UNSURE (   8.29  )
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


