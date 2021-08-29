Return-Path: <SRS0=NAJj=NU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BB8C432BE
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Aug 2021 07:51:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C063860E73
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Aug 2021 07:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C063860E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGDXQKRtd3fHBC7EopqP0+XQd2umwl98ecATJKqbdyQ=; b=yZyfp6PfSecSXI7aUQeSHMGeb7
	WJ8oCn3rRCtgR8Licjb4ysaLK7kopkRqwFuJurxlw82Gyg5tjFX1V7TpUdtOMwaltwKs8V0CC7Fif
	uOm33VeAcaEvPPQu3cr389HDqDCgO03bZmv0r4U6OpXa0fj3BklkcdcvMJ3RwO6lXFDDISgU57Xvo
	/T+wq87nwI8WiY2VzK/y010nx9FNi8krXj6DVGyBxf7d+IVRRj9ptqWep2QEMSskm1EL6oLlzZPng
	obBThNh0pYncAQKFP3rGq3f8SFEvG99NIk057ewb/M/SIMnPq+Dz4GGisnuRnEN7CFpZNq2/XtuHO
	gq7RWKhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKFbG-00FFPq-LG; Sun, 29 Aug 2021 07:51:30 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKFam-00FFP1-1y
 for linux-nvme@lists.infradead.org; Sun, 29 Aug 2021 07:51:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 30EC12001C;
 Sun, 29 Aug 2021 07:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630223456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73J2UE8Czy++p+oC2c1YQ/nI6lCZX18/T7xzfmn1GQM=;
 b=U/JTwI4r3UueWPSbL2BXG0B/1O//PhaHiI20X1CFPhvqcKVCPcipBO2UjcWjYYOYezDHsc
 jz+dY5JD+n47H2SRr9A44KhZB4Wor9uJqqtN7Qc6hIlEktbVPMVYm6O6BTv5kEv6tb9Crr
 SZLxy6G82g8to2hSA7W15AVvHpWWETo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630223456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73J2UE8Czy++p+oC2c1YQ/nI6lCZX18/T7xzfmn1GQM=;
 b=MpYnVtu9WN8URWUoLPwSo92l76vQxZyq4UzwCv00Idt0AlLalqJbPnZZrNzWkIueaKk2T9
 6+2V/KTFaZfEzEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2FD0139F6;
 Sun, 29 Aug 2021 07:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gOd5KVs8K2GGHQAAMHmgww
 (envelope-from <colyli@suse.de>); Sun, 29 Aug 2021 07:50:51 +0000
Subject: Re: [PATCH 02/10] bcache: add error handling support for add_disk()
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: xen-devel@lists.xenproject.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
 kent.overstreet@gmail.com, kbusch@kernel.org, sagi@grimberg.me,
 vishal.l.verma@intel.com, dan.j.williams@intel.com, dave.jiang@intel.com,
 ira.weiny@intel.com, konrad.wilk@oracle.com, roger.pau@citrix.com,
 boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org,
 minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org
References: <20210827191809.3118103-1-mcgrof@kernel.org>
 <20210827191809.3118103-3-mcgrof@kernel.org>
From: Coly Li <colyli@suse.de>
Message-ID: <59a4ce06-22ee-7047-487e-621da3f7c507@suse.de>
Date: Sun, 29 Aug 2021 15:50:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827191809.3118103-3-mcgrof@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210829_005100_312344_2F4FA49A 
X-CRM114-Status: GOOD (  22.32  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/28/21 3:18 AM, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
>
> This driver doesn't do any unwinding with blk_cleanup_disk()
> even on errors after add_disk() and so we follow that
> tradition.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Coly Li <colyli@suse.de>

Thanks.

> ---
>   drivers/md/bcache/super.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index f2874c77ff79..f0c32cdd6594 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1082,7 +1082,9 @@ int bch_cached_dev_run(struct cached_dev *dc)
>   		closure_sync(&cl);
>   	}
>   
> -	add_disk(d->disk);
> +	ret = add_disk(d->disk);
> +	if (ret)
> +		goto out;
>   	bd_link_disk_holder(dc->bdev, dc->disk.disk);
>   	/*
>   	 * won't show up in the uevent file, use udevadm monitor -e instead
> @@ -1534,10 +1536,11 @@ static void flash_dev_flush(struct closure *cl)
>   
>   static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
>   {
> +	int err = -ENOMEM;
>   	struct bcache_device *d = kzalloc(sizeof(struct bcache_device),
>   					  GFP_KERNEL);
>   	if (!d)
> -		return -ENOMEM;
> +		goto err_ret;
>   
>   	closure_init(&d->cl, NULL);
>   	set_closure_fn(&d->cl, flash_dev_flush, system_wq);
> @@ -1551,9 +1554,12 @@ static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
>   	bcache_device_attach(d, c, u - c->uuids);
>   	bch_sectors_dirty_init(d);
>   	bch_flash_dev_request_init(d);
> -	add_disk(d->disk);
> +	err = add_disk(d->disk);
> +	if (err)
> +		goto err;
>   
> -	if (kobject_add(&d->kobj, &disk_to_dev(d->disk)->kobj, "bcache"))
> +	err = kobject_add(&d->kobj, &disk_to_dev(d->disk)->kobj, "bcache");
> +	if (err)
>   		goto err;
>   
>   	bcache_device_link(d, c, "volume");
> @@ -1567,7 +1573,8 @@ static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
>   	return 0;
>   err:
>   	kobject_put(&d->kobj);
> -	return -ENOMEM;
> +err_ret:
> +	return err;
>   }
>   
>   static int flash_devs_run(struct cache_set *c)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
