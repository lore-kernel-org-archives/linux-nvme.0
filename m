Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054DFCD98C5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2026 08:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l0D5ye04N5hl3R9x1nVg+j3qp9XoJIqVn/SbHVLp/Q0=; b=dkZLWwWI/WGQ2u5iIEdpS5hJrZ
	6/a/+1Tb3kwdAc2/NSk+leDIWMkXaw6htETWKJouGv2ad7c28JoTaqmAEoKMsHVNJLIOiQYLYAW+z
	8pQNv2B0MezvAiOMHJtFaBtqN7OTqtN0+JW3VwLbj/Ndo9pkvlmBYK04BkHOxmFrMI3QTACw031i3
	LSe87eMsU8hDPIw5TN7Yf6AF4RZtRNmed4MBqQMQ9j4MzPS8S7Cj+gws7FLx8g906i9eSASUyEl5i
	PP2J+JMgFcgD0Cuu1YSI3SlS8uHyIGj/ygoW1GEYg0vGmHx+hOHqFi62P752k83CpRAE8e1f6QhK9
	EMjn5frw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ2JL-0000000DppG-2z0Z;
	Mon, 15 Jun 2026 08:04:47 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ2JH-0000000Dpmu-3pqW
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jun 2026 08:04:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=bXfv8euhbjk6za
	74BeUNep0GlzLJaBBDzSOTW98hp0o=; h=in-reply-to:references:from:subject:
	cc:to:date; d=arkamax.eu; b=a/8/CWHyJ5bjDNUuAPoPW1cXG+WX8YLKRKtByoBcNo
	HPQtD+N+mTukF1CEjyJs7kYNkoukU8k7Swqbow6UkwTttbYwAh1gCM4zXPLjhCIL2eo7KM
	d8bG7LvFHPl592JrISY1RF5YGw75Qk0oS84ZXuIj1XG/bo9AV4wMxlVhgyS09IXcqCv9fT
	ePacl5QI5Q6eVd80yFmGVAlZjXYb+cpp4h2Kg/n45qyUgC3HY3vix+2Hs5YgnFnnnhZr34
	UEG5tHoOMPZX49vTUlNuiaOSTSbaKW3RBsgVHBSyFP4GkuiST5jxtKm4W26lUkrcC52Wrh
	snzy54zQwAlUyZBbN+HQ==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 8bf8fd43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 10:04:37 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 10:04:37 +0200
Message-Id: <DJ9GTUZ0E8DC.2EYP78213NAX@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Cc: <kbusch@kernel.org>, <hch@lst.de>, <linux-nvme@lists.infradead.org>,
 <mlombard@arkamax.eu>
Subject: Re: [PATCH] nvme: fix crash and memory leak during invalid cdev
 teardown
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.21.0
References: <20260605151048.354313-1-mlombard@redhat.com>
 <5a393a6c-371a-4c8f-8a90-6736907dccf4@flourine.local>
In-Reply-To: <5a393a6c-371a-4c8f-8a90-6736907dccf4@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_010444_597351_FF4E8473 
X-CRM114-Status: GOOD (  10.13  )
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

On Mon Jun 15, 2026 at 9:56 AM CEST, Daniel Wagner wrote:
>>  static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
>>  {
>>  	int ret;
>> +	char *name;
>> =20
>>  	head->cdev_device.parent =3D &head->subsys->dev;
>> -	ret =3D dev_set_name(&head->cdev_device, "ng%dn%d",
>> -			   head->subsys->instance, head->instance);
>> -	if (ret)
>> -		return ret;
>> -	ret =3D nvme_cdev_add(&head->cdev, &head->cdev_device,
>> +	name =3D kasprintf(GFP_KERNEL, "ng%dn%d", head->subsys->instance,
>> +			 head->instance);
>> +	if (!name)
>> +		return -ENOMEM;
>> +
>> +	ret =3D nvme_cdev_add(name, &head->cdev, &head->cdev_device,
>>  			    &nvme_ns_head_chr_fops, THIS_MODULE);
>> +	if (ret)
>> +		dev_err(disk_to_dev(head->disk),
>> +			"Unable to create the %s device", name);
>> +	else
>> +		set_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags);
>> +
>> +	kfree(name);
>>  	return ret;
>>  }
>
> nvme_add_ns_head_cdev returns the error code but nvme_mpath_set_live
> handle the return code. So we either don't need to return the error code
> or we should do something in nvme_mpath_set_live with it.

Please refer to the latest nvme-7.2 branch.
Those functions were later modified to not return error codes.

Maurizio

