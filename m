Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCCAC54E60
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 12:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DVmXcraop818yaoh+0AlYJydGzVxTP2muI+aPDGQ1+A=; b=oRPi6ooFwtIJ5qxvKlaRr4ZLS0
	fws3rb08x3bgzwx6F8BTpzFgmzCBkUvtO+pP6lGJGui2U3k/YX8UwekZClfN3OR/9lmQd3mOsP5Yc
	RCxOw5mkL1YiMcUX5wF5j72diJoxjZstxBqRkRPkmNzsNcgdfuWekWJa6bkTEllZjqxeLwfMJpQAq
	VenFntEd/+wEZ9TBtGUqgf9brrri+OojIkvHhIXqiMIaTIyXgJc4JzAoEnEmWBpbnPYO5gld/KBha
	d6+ATFWdV7ohB4fN2Ty3zClRlGZ3P8hXisIT2jWdmLetrCjDUVOYq/3q0k/mZN+fFGEaPQQRyndNj
	Xpxb19sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk1Iw-00000005kiO-3hKg;
	Tue, 12 Mar 2024 12:32:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk1Ik-00000005kdy-3DKd
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 12:32:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1215367373; Tue, 12 Mar 2024 13:32:12 +0100 (CET)
Date: Tue, 12 Mar 2024 13:32:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: use nvme_disk_is_ns_head helper
Message-ID: <20240312123211.GB26641@lst.de>
References: <20240312075310.92594-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312075310.92594-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_053216_000934_705812D2 
X-CRM114-Status: GOOD (  17.43  )
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

On Tue, Mar 12, 2024 at 03:53:10PM +0800, Guixin Liu wrote:
> Use nvme_disk_is_ns_head helper instead of check
> fops directly.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/nvme/host/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index f2832f70e7e0..ac8d622b5fc0 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -240,7 +240,7 @@ static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
>  	int ret;
>  
>  	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
> -	    bdev->bd_disk->fops == &nvme_ns_head_ops)
> +	    nvme_disk_is_ns_head(bdev->bd_disk))

When using nvme_disk_is_ns_head we should also be able to drop the
IS_ENABLED(CONFIG_NVME_MULTIPATH) check.


