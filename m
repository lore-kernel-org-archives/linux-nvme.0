Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A836AC83F2C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 06:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AFOKMChVhBIj1VicUH1wEEU7YxIIfdxoaLOnhIZ4Zuc=; b=Znurtl3oxoTSp91xMKYrbnVzqH
	p6NDcOEQ+gLU9KqalGnMznbmJAPU4JP+5pFwydbM5G7JK++oJa+kJmEQnr+tHcnzKi9jZM98tCOHu
	EYWW5MgAGVu7w4nXDgN7u0wIuqnHQdXcF4j8be/+Yy/c7tZPZpnJzwi3oH+7b5OIEHXF+eQz6kfQW
	1JDDHNoTFwKKH/a8qUAEfMSdOtxVqy/mJ1TvhtEjgkLPZMNzhjQPATV5S8wnbEXAgAlH+wWemmaPY
	EqsOKyL2hIHlI+dgZUsGiRcs8Q1KpHQY6+USetm04XmP7rCnd73W6H992MEsqwrrfbHWHPghQZ6k6
	GLgHAc7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdPua-005MCY-0m;
	Tue, 05 Sep 2023 06:51:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdPtT-005MAR-0H
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 06:50:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6703D68B05; Tue,  5 Sep 2023 08:50:32 +0200 (CEST)
Date: Tue, 5 Sep 2023 08:50:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Message-ID: <20230905065032.GC19701@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de> <20230829091350.16156-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829091350.16156-5-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230904_235035_269840_4EE4AB0E 
X-CRM114-Status: GOOD (  19.65  )
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

On Tue, Aug 29, 2023 at 11:13:49AM +0200, Daniel Wagner wrote:
> The port entry binding might not be existing and thus the req->port
> pointer is not valid.
> 
> Reproducer: nvme/005 with active system nvmf-autoconnect systemd service.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/target/discovery.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
> index 668d257fa986..fc113057cb95 100644
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -191,6 +191,15 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
>  		goto out;
>  	}
>  
> +
> +	/* No port assigned, portentrybinding is missing */

Double new line above, and I think a missing white space before
binding.  But I'm still confused how we can get here without req->port
set.  Can you try to do a little more analysis as I suspect we have
a deeper problem somewhere.

