Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864EDC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 16:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=RsbQoABie3UAE90QomMFKPPqmU
	QLcU2/WGJkQF6dYONsEnMxOblplLwrAfoyhfZAWJPlDe7UHNNrPwU9k/3bOwlF4BkCHnCcQWHuRdB
	ty5djqMhaLd80PHPxBu/C9akEinFZgeZ4j9Fg3dzEYCtZf9rthexv5FhlX0TCY/R5mxWTd3Cwwd/O
	t1VA6D1FZ4ggTw4Oucz6J6yW2lovfsH9jLK9tcE/C2CsyXLthPY35+ua40IMRV7SzHWnZKWTVzuxn
	Xi67ASkhle4CbmdjF2niIBKtM3FQp2Un75NNnmPKc0yyfKLYWhE3mStrtU3gfgwMMaQlDLN6HbTW1
	zNj2yHHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncVDk-00D9tJ-L2; Thu, 07 Apr 2022 16:42:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncKq6-009Zog-9m
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 05:37:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1528B68AFE; Thu,  7 Apr 2022 07:37:39 +0200 (CEST)
Date: Thu, 7 Apr 2022 07:37:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Ariel Elior <aelior@marvell.com>, Anna Schumaker <anna@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christian Benvenuti <benve@cisco.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Bart Van Assche <bvanassche@acm.org>,
 Chuck Lever <chuck.lever@oracle.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 Max Gurtovoy <mgurtovoy@nvidia.com>,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 Michal Kalderon <mkalderon@marvell.com>,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Nelson Escobar <neescoba@cisco.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, rds-devel@oss.oracle.com,
 Sagi Grimberg <sagi@grimberg.me>, samba-technical@lists.samba.org,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Steve French <sfrench@samba.org>, Shiraz Saleem <shiraz.saleem@intel.com>,
 target-devel@vger.kernel.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Yishai Hadas <yishaih@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v2] RDMA: Split kernel-only global device caps from
 uverbs device caps
Message-ID: <20220407053739.GA13500@lst.de>
References: <0-v2-22c19e565eef+139a-kern_caps_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v2-22c19e565eef+139a-kern_caps_jgg@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_223750_517986_C1C5DD72 
X-CRM114-Status: GOOD (  10.44  )
X-Mailman-Approved-At: Thu, 07 Apr 2022 09:37:59 -0700
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

