Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DA4C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 09:16:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8153238EB
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 09:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8153238EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UYnpUy0yntE6mm538ugAFh6G0usfPhvxqBru44A70N8=; b=JRdko4oQ+mowAKBJt061y3LGI
	oAQ0Muk26vdPFH+Uq235K9vxNBqjleI/Javfm3YV2aoOCIF+4nLmB7SfZT8DqG7quGbYBFwcGYACt
	blXSooz4+IsnNqy5r4qcTwaECZsRdkfQOHHsR3pFn3c9KOkNN6c6SeC3Trnjl4TWooyW5v/zKlw0b
	qeNY8YsxEd2SY6WRtlNGygfmPLncr9SAeOGod4dFKKjWC00GRYvGSwpxj2Cyq5/ZuXwukSpI4zY22
	BlewSPy2+i3JQIhhP2GR00TcrxHygnBCmQJs90y2bwc7bNJaQauszAU6arCVfOStt8D2sNp1LCPJV
	jRUJZkbfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmvaY-0001Bp-1Z; Wed, 09 Dec 2020 09:16:46 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmvaV-0001Au-Ie
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 09:16:44 +0000
Received: by mail-ed1-x536.google.com with SMTP id c7so749987edv.6
 for <linux-nvme@lists.infradead.org>; Wed, 09 Dec 2020 01:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=udImeOyopR6lKcri/5XEEUcYqPTE+FQlxvMzQAlhsfU=;
 b=vKk2LJLVoo/f7CceJHDSRilhBANlh+e/wINNi3QCldXHlHeXQqbabWeoOPIJg56Pie
 /iY1I6MxINZ/+727sMSvyjb6SCu2kLXbOIRkOf6x8RXlzt6NwuE2x2yCqecCZXqf/nL5
 mVsEQnq3CEwWGhq443jayVBtta1KjNpGNBatvm4nfZ6bNjF4Ctlk85P4UWjHxjOvmQVO
 W+gBjwCW5hCxIm0SYc/Qgkm6Bq0XBKDjWrftKvO8TO5pRZ7e3HHj4jFVpUgmicmtnbUm
 8AK+yMYd6k34jocVoElM1JLAQFYn4IhOZ668G67fbvTg3yrZQxApWpt80x6wMlZpnEKS
 yCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=udImeOyopR6lKcri/5XEEUcYqPTE+FQlxvMzQAlhsfU=;
 b=P3Z4umqZSnFNPKNYajZbNqFhzAFoldtIJ0nxD5NpGP9nDlww++SqRxv7CsCGTx0Bwj
 5lSiVGCSUsiygwtg4r3n1CzCUlzlCqMmsSoQ26+DDqezDX0uhxi9Les57a9IOCpkiWVZ
 0ayBuV8qH6qxWvtzl1e+IlyknTAgzWNm5nm2UeR2EaYv6eQjbKwVZIzbewHlKapmF/ke
 JAwCq32D2nB6h+sE+e7QYj147ZpptRCbY8PD+3oWxsuCPBuf6YlHulV6H+W1R7pufz/4
 GQm1xFVsZpR0OX7dALNWuiFvzSrFBvEIiHQfCwW8kvlRuexG93w/thvGiuT5sW7qspQK
 J/GA==
X-Gm-Message-State: AOAM532fSarQM16ucXgTtUHJM/jfqpVTSHuNIHKkEuqJCSqZ0WCkwpkd
 q3pVS+sQBaq2yXvTPWEa0XzLMw==
X-Google-Smtp-Source: ABdhPJy0H5iRcjQAbbMA5JxnGNd1eAPAnQfg7wbllmKdUB4JqkBOK+CIIgrkHlPxfH07M/Tbwvu/gg==
X-Received: by 2002:aa7:c7d8:: with SMTP id o24mr1127552eds.328.1607505397434; 
 Wed, 09 Dec 2020 01:16:37 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id h16sm882131eji.110.2020.12.09.01.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 01:16:36 -0800 (PST)
Date: Wed, 9 Dec 2020 10:16:36 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: nvme: enable char device per namespace
Message-ID: <20201209091636.5jrexhqmjmqwyqaz@mpHalley>
References: <20201208132934.625-1-javier.gonz@samsung.com>
 <20201208142151.GA4108@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208142151.GA4108@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_041643_774342_98021412 
X-CRM114-Status: GOOD (  28.84  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org, minwoo.im.dev@gmail.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 08.12.2020 15:21, Christoph Hellwig wrote:
>A bunch of nitpicks (mostly naming as usual, sorry..):

No worries. Thanks for taking the time.

>
>> +static int __nvme_ns_ioctl(struct gendisk *disk, unsigned int cmd,
>> +			   unsigned long arg)
>>  {
>
>What about nvme_disk_ioctl instead as that is what it operates on?

Sure.

>
>> +static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>> +		      unsigned int cmd, unsigned long arg)
>> +{
>> +	return __nvme_ns_ioctl(bdev->bd_disk, cmd, arg);
>> +}
>> +
>> +static long nvme_cdev_ioctl(struct file *file, unsigned int cmd,
>> +			    unsigned long arg)
>> +{
>> +	return __nvme_ns_ioctl((struct gendisk *)file->private_data, cmd, arg);
>> +}
>
>No need for the cast.
>
>Also can we keep all the char device methods together close to the
>struct file_operations declaration?  I just prefer to keep the code
>a little grouped.

Perfect.

>
>> -static int nvme_open(struct block_device *bdev, fmode_t mode)
>> +static int __nvme_open(struct nvme_ns *ns)
>>  {
>> -	struct nvme_ns *ns = bdev->bd_disk->private_data;
>> -
>>  #ifdef CONFIG_NVME_MULTIPATH
>>  	/* should never be called due to GENHD_FL_HIDDEN */
>>  	if (WARN_ON_ONCE(ns->head->disk))
>> @@ -1846,12 +1859,24 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
>>  	return -ENXIO;
>>  }
>>
>> +static void __nvme_release(struct nvme_ns *ns)
>> +{
>> +	module_put(ns->ctrl->ops->module);
>> +	nvme_put_ns(ns);
>> +}
>
>nvme_ns_open and nvme_ns_release?

ok.

>
>> +
>> +static int nvme_open(struct block_device *bdev, fmode_t mode)
>> +{
>> +	struct nvme_ns *ns = bdev->bd_disk->private_data;
>> +
>> +	return __nvme_open(ns);
>> +}
>> +
>>  static void nvme_release(struct gendisk *disk, fmode_t mode)
>>  {
>>  	struct nvme_ns *ns = disk->private_data;
>>
>> -	module_put(ns->ctrl->ops->module);
>> -	nvme_put_ns(ns);
>> +	__nvme_release(ns);
>
>No need for the local ns variable in both cases.

ok.
>
>> +static int nvme_cdev_open(struct inode *inode, struct file *file)
>> +{
>> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
>> +	int ret;
>> +
>> +	ret = __nvme_open(ns);
>> +	if (!ret)
>> +		file->private_data = ns->disk;
>> +
>> +	return ret;
>
>Do we need the ->private_data assignment at all?  I think the ioctl
>handler could just grab it directly from i_cdev.

Mmmm. Good point. I'll try that.

>
>> +	sprintf(cdisk_name, "nvme%dn%dc", ctrl->instance, ns->head->instance);
>
>And the most important naming decision is this.  I have two issues with
>naming still:
>
> - we aready use the c for controller in the hidden disk naming.  Although
>   that is in a different position, but I think this not super intuitive.
> - this is missing multipath support entirely, so once we want to add
>   multipath support we'll run into issues.  So maybe use something
>   based off the hidden node naming?  E.g.:
>
>	sprintf(disk_name, "nvme-generic-%dc%dn%d", ctrl->subsys->instance,
>		ctrl->instance, ns->head->instance);

Perfect. Sounds like a good compromise to still keep the original hidden
disk. Keith is happy too, so we have a plan.

>> +	/* When the device does not support any of the features required by the
>> +	 * kernel (or viceversa), hide the block device. We can still rely on
>> +	 * the namespace char device for submitting IOCTLs
>> +	 */
>
>Normal kernel comment style is the opening
>
>	/*
>
>on its own line.

OK.

>
>>  	if (nvme_update_ns_info(ns, id))
>> -		goto out_put_disk;
>> +		disk->flags |= GENHD_FL_HIDDEN;
>
>I don't think we can do this based on all the error returns.  I think
>we'll have to move the flags manipulation into nvme_update_ns_info to
>also cover the revalidate case.

Ok.

I am working on the multipath part. I'll send a V3 with all these
comments and then a follow-up patch with multipath.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
