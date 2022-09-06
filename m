Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB078ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GmOju39ql7HAJFwpUo4KznTlyCzWoxpz9anlvvBTAYc=; b=1qJHDUMu13pplpxrTyE/58MKhq
	50WXoy9k+ClVwQNjQOXqafIfR6rRiE87L0eyU7HQzSJBFTjsftmuCGMGGODoV9xMniEb/w/hdbQFc
	v6lHUt6ucJomQZxXrZLg5+BrsvB0q3WiqYefE0irZ/t4vx4TKd6Lzn3fSyljiLdPGL0IE6DVcsO3I
	W+tKiLd7Z9dTJGvSZxli5sPH/4QlU2WS1nH4UwY/HYrfyyIOpEI7HJ6LDR00KCY2Sqpxd/5y422cD
	DHq093tk/hc3gnwZRMqIW2zM8IpVuoIfG0FbW5uOXtTEy9+2k8RREgemhCf97so5UFtvzlCTCliXp
	QoAgno3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVUzd-00BuEu-OY; Tue, 06 Sep 2022 09:35:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVUzZ-00Bu6X-4s
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 09:35:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F8F968AA6; Tue,  6 Sep 2022 11:35:28 +0200 (CEST)
Date: Tue, 6 Sep 2022 11:35:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
Message-ID: <20220906093527.GA14205@lst.de>
References: <20220829081256.24570-1-lengchao@huawei.com> <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com> <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com> <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com> <yq18rn6qxgl.fsf@ca-mkp.ca.oracle.com> <289da5df-e988-f0a9-95cd-2c437327a043@huawei.com> <20220905063759.GB2092@lst.de> <79f9829f-3337-6582-7ea7-6de5c8afc69b@huawei.com> <20220906065903.GA2345@lst.de> <42216010-70a0-e0ef-2b4f-b25072792f36@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42216010-70a0-e0ef-2b4f-b25072792f36@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_023537_385574_A7809623 
X-CRM114-Status: GOOD (  11.89  )
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

On Tue, Sep 06, 2022 at 12:34:13PM +0300, Max Gurtovoy wrote:
> Maybe we can extend the spec and say that for Fabrics only we can use 
> IP_CSUM as protection for "host_buf-------->host HBA".
>
> On the wire we'll use extended LBA with CRC as defined today.

Please read up on the concept of end to end data protection again.

