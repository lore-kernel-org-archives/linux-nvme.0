Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DD4C27C6E
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3e7qh7hlWO577P+noCBo57Uh9i8p67MsKrYVYF/P7f0=; b=0iyavNdPxxlD9yAu67KV43/7mo
	EHmupMfA7H4+iXKKWC0liWvq1VZb91K1WeMdrEGhVA7jsIWJuSDR73ll6EvIq8mK8ANxm5yqarLy5
	2LxQ34evB7upe/FTLXim5yc2r1eyzlCtVmVt8tM5zFDOZxZ7TZS2UN+4rg4MG87GSRUq/brDSjHZT
	iuxMyb+NURtYV9AelLspcIwQDo6RwnCHppHvVJ9+cdGCe54x+mxYo5Aoq2gKG6IIymBHCQyC+pJwY
	LPSDOL8nNDOsFVuHQ/XQ5tpZsyKv+YJlrGD9Yw1BqCEMfw/7SUqyTxQDrvmhuPt1zmWmYCTe7JzTu
	zD5yp8ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFaxP-0000000EWtY-29lf;
	Fri, 07 Jun 2024 14:52:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFaxG-0000000EWmX-1EHs
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jun 2024 14:52:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6CD7F68BFE; Fri,  7 Jun 2024 16:52:21 +0200 (CEST)
Date: Fri, 7 Jun 2024 16:52:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 11/11] block: move integrity information into
 queue_limits
Message-ID: <20240607145220.GA7073@lst.de>
References: <20240607055912.3586772-1-hch@lst.de> <20240607055912.3586772-12-hch@lst.de> <8cd46b95-bfdf-42a4-809f-36ff88062322@suse.de> <1c4e6c61-fc39-4f59-a103-761984d98b18@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c4e6c61-fc39-4f59-a103-761984d98b18@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_075234_644862_295B94DF 
X-CRM114-Status: GOOD (  10.75  )
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

On Fri, Jun 07, 2024 at 09:35:02AM +0200, Hannes Reinecke wrote:
>>> +?????? if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY)) {
>>> +?????????????? pr_warn("integrity support disabled.\n");
>>> +?????????????? return -EINVAL;
>>> +?????? }
>>> +
>> Why is that an error?
>> Surely 'validate' should not return an error if BLK_DEV_INTEGRITY is 
>> disabled and no limits are set?

Look a few lines above, we'll never get here if no tuple_size is set,
which is now the indicator for metadata support.


