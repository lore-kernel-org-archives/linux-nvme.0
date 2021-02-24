Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8326C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 20:29:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1BD64E20
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 20:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1BD64E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rg8HK/MqmHb5qPn0yfdqgYiU2JV79bXJMGNaUvcN5v8=; b=ne8sYgnfHfj7WWvHRjkVEpWI1
	C2C5BhlFPYKOECNdB+9LLJhJBaen0qON/mKEDP5ycJDbSdTTsZErvTd988BNS+m/zDH3c+QbtmfFW
	ZHrI1ufJSIdsTx66TAU2pFtol1uGeQnv3JFf58+G9rQRqPJf17hYpOWVU0fbbfWVfP7oYIS3FMd8t
	8w3qxLkGci8wGmKM8oMAnQhFEcoyJZvK53Z2RCf8FEi3usMlEK70tw76PJc9PScTusU0kkjLxNxJZ
	eLrpWyNSIK7aJBbwi6Zh63LwV/EEJoa461d8aB8lHlUtaEyN8DCO0yGvDfS9GicfYH3j8rrm0jdMX
	0tAJkYC8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF0mC-0005N8-Ph; Wed, 24 Feb 2021 20:28:52 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF0mA-0005MN-2o
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 20:28:51 +0000
Received: by mail-wr1-x429.google.com with SMTP id v1so3123685wrd.6
 for <linux-nvme@lists.infradead.org>; Wed, 24 Feb 2021 12:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=m1IpK7yU5BzhpwN3PH2LaUmGjgI0MX55nsoHz2Oanwk=;
 b=PQg0nEgiPbJqV4p0ayQroaiTNmERupFumGeqTXFVhXbf0jozxj8KUYTe9SxgpWSDQ2
 UELKClpWyCT3NBdC1nnPpN1ur6uX95av0XFSkG9z2nws9oZIvpKHUIOOWmr96/GAnSRF
 HePjeG0hwDOeGq76CKjUHtXYzeVLG6OabOvKh2lyjG9ViFcUJ6DoAmPCBbHExr+/h7RG
 NLKkMZDSOZpVNAIHY1WJ+c9E+n9FfbVv/xMpEF0vy890u/KnMyqAnhnMT2F3atjthqrs
 K/dxlIjdGtSavKQ1nQuESgK7yvVlPaGZCwAakqHDZzBXsJf/w1QUcz4AE0Do0I5P6sUI
 YdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m1IpK7yU5BzhpwN3PH2LaUmGjgI0MX55nsoHz2Oanwk=;
 b=rp2Hc3jUy1urgd3ldj6d+zJDvF96TOe3Ul1GnZ3CpnOkvuBGXxr7uSXtI9K5w6/Pvl
 vrWQYMBhR1R9PBOaWmXW3aoVfpwfoxZ5jcJqQLBrbHQExJ3kn6IPZcUN9wklbC4TbS3/
 m0NZe5234gsfYugnPcYC3MHebpWTvCu+O3v0mW5jTglIFPO9EzTyEnZpFoaltthuefhB
 GsFZkgytlpkRk5KjyvGx16dNBCG4FFAoR5Yu1TCNnWEZnCX4yNaMd/5BuhN57XQx5ri8
 57FAAbHIn/elEXds4fvgiRkGz5hh5RcOzvU+gjOlsHiiQvIsYtRiAHzcG1ns26AGKSq0
 g0hQ==
X-Gm-Message-State: AOAM532p5u9Xv6hB/bqHdHFVXC937eac5RbOvmNHktMxIuqo0Fx2QJJz
 GPNW2Mrlw5pO0E1NuZTduKV55PiBZKGGjzuc
X-Google-Smtp-Source: ABdhPJxpLrsJ7DPmn1iln4ByKTUgVl4ugGswSie3vQNAOxM2zIn82FT5f+IfXJMaX3lFxRASD+InFw==
X-Received: by 2002:a5d:4a44:: with SMTP id v4mr25482429wrs.236.1614198525920; 
 Wed, 24 Feb 2021 12:28:45 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id z11sm4531166wmi.35.2021.02.24.12.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 12:28:45 -0800 (PST)
Date: Wed, 24 Feb 2021 21:28:43 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 1/2] nvme: enable char device per namespace
Message-ID: <20210224202843.glv4c7uaifxzknmw@mpHalley.localdomain>
References: <20210222190107.8479-1-javier.gonz@samsung.com>
 <20210222190107.8479-2-javier.gonz@samsung.com>
 <20210224164443.GA11338@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210224164443.GA11338@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_152850_245922_BBCCAB1A 
X-CRM114-Status: GOOD (  18.71  )
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

On 24.02.2021 17:44, Christoph Hellwig wrote:
>> +static inline bool nvme_dev_is_generic(struct device *dev)
>> +{
>> +	return dev->class == nvme_ns_class;
>> +}
>> +
>> +static inline bool nvme_ns_is_generic(struct nvme_ns *ns)
>> +{
>> +	return !!ns->minor;
>> +}
>
>What does is_generic mean here?  In doubt add a few comments..

Will do.

>
>>  	/* some standard values */
>> @@ -2241,6 +2270,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>>  	return 0;
>>
>>  out_unfreeze:
>> +	/*
>> +	 * When the device does not support any of the features required by the
>> +	 * kernel (or viceversa), hide the block device. We can still rely on
>> +	 * the namespace char device for submitting IOCTLs
>> +	 */
>> +	ns->disk->flags |= GENHD_FL_HIDDEN;
>> +
>
>The out_unfreeze case also handles all kinds of real error, so this needs
>to move into a better spot, and probably check a specific error code
>or even explicit indicator.

Ok.

>
>> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
>> +{
>> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
>
>> +	struct nvme_ns *ns = container_of(file->f_inode->i_cdev,
>> +				struct nvme_ns, cdev);
>
>Maybe add a little cdev_to_ns() helper?

Ok.
>
>> -	if (nvme_update_ns_info(ns, id))
>> -		goto out_put_disk;
>> +	nvme_update_ns_info(ns, id);
>
>I don't think we can simplify ignore all errors here.

Sounds good.

>
>> +static inline struct nvme_ns *nvme_get_ns_from_cdev(struct device *dev)
>> +{
>> +	return dev_get_drvdata(dev);
>> +}
>
>I think we can keep this in core.c.

Perfect.

Will send a new version.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
