Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08153C432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:50:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB622071E
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JX0T0MeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB622071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4MAUxs0smjoodsf5IV+i4NdNQ3hFyBAEt3B6xmYsRnk=; b=JX0T0MeTHhAxWn
	FrrvArNIeradw0cyIjhCm/alU1pU5f+6SsbspJhvQZmuBsPvAQJPrDzbgF88NOeWzr0tI4KH/VkR9
	wPyiqWX3SkbPk0mrkBmr5DrXL37Bab1WJTOFNmJyzPxhKCl2i4tSJJvKty88hA99/Bx85rwzMUpgb
	xIiYmpf3rTb1mJTNuKoSqFnFj85v8UYm+/WUQV3onNUXWKoBaYlkaSo1CdG1tl/5aiJQss+8VDTwt
	r22PLw+B9QPV/BfcC9qrcNaZlnuDiXhUrT/9SdoQGivdJ4mcQ2keILRbL4rfNyL3388YhoUeXrt9+
	gwHXhMY4kWF3lUFfqsMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZe2X-0005UN-EH; Tue, 26 Nov 2019 16:50:13 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1iZe2V-0005U4-KO; Tue, 26 Nov 2019 16:50:11 +0000
Date: Tue, 26 Nov 2019 08:50:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: check sscanf value for subsys serial attr
Message-ID: <20191126165011.GC10487@infradead.org>
References: <20191121203142.537-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191121203142.537-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 21, 2019 at 12:31:42PM -0800, Chaitanya Kulkarni wrote:
> For nvmet in configfs.c we check return values for all the sscanf()
> calls. Add similar check into the nvmet_subsys_attr_serial_store().
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/configfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 98613a45bd3b..cc1fd36bf71e 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -853,12 +853,14 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
>  					      const char *page, size_t count)
>  {
>  	struct nvmet_subsys *subsys = to_subsys(item);
> +	int ret = 0;
>  
>  	down_write(&nvmet_config_sem);
> -	sscanf(page, "%llx\n", &subsys->serial);
> +	if (sscanf(page, "%llx\n", &subsys->serial) != 1)
> +		ret = -EINVAL;
>  	up_write(&nvmet_config_sem);
>  
> -	return count;
> +	return ret ? ret : count;

So the problem is that we've already possible corrupted subsys->serial
when an error occurs.  So I think we need a local variable to sscan
in, return an error if that fails and only if it succeeds take the lock
and assign it to subsys->serial.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
