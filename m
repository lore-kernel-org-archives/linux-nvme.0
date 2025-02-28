Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03332C282C5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 13:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MOu35KTrzd/Q3JC03OViedyLFeYsWkOLSJ/UlGCVsgk=; b=K12yYsv1Fn4kscblAvLY+e1m8D
	FOps6fAxGSligLVxXQ1aN0C3W6GHpc1QrCl9D7RDlFohewYRqzbDcuVDVcTv7SqawKK5YiC86gbkg
	QKqh8+tFjHLxCHo0oIMJp7vbB6v1MKLqUfPJVpopQTa9TS4wiznc5VT698plnW+uEeWD9xZrkm/SH
	fw281FgoAmSSQIVWZtLhNEfI2PtTuWJNhHfKLge67fMNHPx0cYxQnGO4XOnLl5CFWYmmaGoNnUX4E
	qmutuwG0Kk1A4oaFLt3zzN3PtGAG8LbLux8jRMkXrPUi+8LCD1EgkgDL3XWb9rN7fPzWDLPhkhAZ6
	9rdjfQRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1to05S-0000000B1Ux-1L0K;
	Fri, 28 Feb 2025 13:07:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1to05O-0000000B1UQ-405V
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 13:07:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740748045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOu35KTrzd/Q3JC03OViedyLFeYsWkOLSJ/UlGCVsgk=;
	b=jU+ulS1OSqVNusbllgYl7ygRiy5obnCbkjANNjG91Ur114UiemSl8JghxItveYXReviWp9
	JcNqqY2+9SEGFjhWXon0QUFO4fGY3Of236gXVe++8FV/olPzxkOX/TTu7Mlbj9GPkBQzf7
	yQ0oH+Zhd9i20hz6aLg9dd2gNkURiCg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-fBzFcLRHOfO0vXUG3bHy9g-1; Fri,
 28 Feb 2025 08:07:20 -0500
X-MC-Unique: fBzFcLRHOfO0vXUG3bHy9g-1
X-Mimecast-MFC-AGG-ID: fBzFcLRHOfO0vXUG3bHy9g_1740748039
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EBF91944CFC;
	Fri, 28 Feb 2025 13:07:18 +0000 (UTC)
Received: from [10.22.88.31] (unknown [10.22.88.31])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A634D19560AB;
	Fri, 28 Feb 2025 13:07:16 +0000 (UTC)
Message-ID: <efedb363-c25f-4e4f-8a4a-3d991bdf3927@redhat.com>
Date: Fri, 28 Feb 2025 08:07:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM config
 option
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Cc: loberman@redhat.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-3-jmeneghi@redhat.com>
 <bc07b3df-4634-44fc-a16c-f4c3bb30e456@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <bc07b3df-4634-44fc-a16c-f4c3bb30e456@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_050727_067363_D84C6EB6 
X-CRM114-Status: GOOD (  16.61  )
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


On 2/28/25 1:28 AM, Nilay Shroff wrote: 
> On 2/28/25 8:55 AM, John Meneghini wrote:
>> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
>> index 91b0346ce65a..c4251504f201 100644
>> --- a/drivers/nvme/host/Kconfig
>> +++ b/drivers/nvme/host/Kconfig
>> @@ -28,6 +28,21 @@ config NVME_MULTIPATH
>>   
>>   	  If unsure, say Y.
>>   
>> +config NVME_MULTIPATH_PARAM
>> +	bool "NVMe multipath param"
>> +	depends on NVME_CORE && NVME_MULTIPATH
>> +	help
>> +	  This option enables configurable support for multipath access with
>> +	  NVMe subsystems. If this option is enabled NVMe multipath support is
>> +	  configured by the nvme core module parameter named "multipath". If
>> +	  this option is disabled the nvme core module "multipath" parameter
>> +	  is removed and support for NVMe multipath access can not be
>> +	  configured. When this option is disabled a single /dev/nvmeXnY
>> +	  device entry will be seen for each NVMe namespace, even if the
>> +	  namespace is accessible through multiple controllers.
>> +
>> +	  If unsure, say Y.
>> +
> If we want to make NVME_MULTIPATH_PARAM default on then I think we need to add
> "default y" under config NVME_MULTIPATH_PARAM.

OK. I've tested all of the config options.

make mod2noconfig
make allyesconfig
make allmodconfig
make oldconfig

And is all seems to be working correctly, but I'll add the "default y"
as you've suggested.

>>   config NVME_VERBOSE_ERRORS
>>   	bool "NVMe verbose error reporting"
>>   	depends on NVME_CORE
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 2a7635565083..4536ad5fbb82 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -10,10 +10,11 @@
>>   #include "nvme.h"
>>   
>>   bool multipath = true;
>> +#ifdef NVME_MULTIPATH_PARAM
> 
> Shouldn't it be CONFIG_NVME_MULTIPATH_PARAM instead of NVME_MULTIPATH_PARAM?

Oops.  As you can tell, I haven't tested this yet.  I'll fix this up and test these
changes before sending a version 2 patch.

/John
  
> Thanks,
> --Nilay
> 


