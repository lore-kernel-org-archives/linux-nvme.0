Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B7DC36010
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 22:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Befyf2MillwSBKMFj/rTqdswT5mC0g4BS1/gE352LrA=; b=l6/7FsZ0nPkGwyas4UMJ08IHjD
	QfFjua2a9MM3aJm2NyjK+cZTlcpO8Ux3zt4iUT/t/BiMW3osD7fAufoWEpDz/mVh0HJh8O9o/wQBP
	ISbSAXi/jIWIxgkCr00aNFzfMXpPoqbF10qqMVIQKuYrk99EQK7u5n0xADt/rMKYl3HXK2b0469TV
	DNhDOUH3iCy++km+d2+7TrYmKiW2onW8GZZuTtYkkUVrqLYTnJnV121g6oafp8dFaFLFOhm7xutKQ
	IaAiyERd+IvxjkzPOnCFlovVhhRQA9VBZ7QcQNCWtkq/qaRy4y2ldZDjMkHqePStcEeMjg2Bphg7g
	9PIZDp9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0pWS-0000000CzDF-2EBh;
	Fri, 04 Apr 2025 22:28:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0pWQ-0000000CzCS-098q
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 22:28:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743805699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Befyf2MillwSBKMFj/rTqdswT5mC0g4BS1/gE352LrA=;
	b=XFfIcb6B5s8wRtiVH2J/MyscPR75d04kyDXpc6s9unR4qgQhaOSJ5CeRoVgxT1gHlpe1MZ
	GuG+Yjfc1G+rrYbKuJ81ThJuhEVMv4WpapbA7uJCyzrNZnSU9dxPvToeHcQDniNr1NKeyq
	obIvitm/61Jx6szksznVPHGTh2VkWcs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-t-oQUblOMoGHXvd33mwDWw-1; Fri,
 04 Apr 2025 18:28:16 -0400
X-MC-Unique: t-oQUblOMoGHXvd33mwDWw-1
X-Mimecast-MFC-AGG-ID: t-oQUblOMoGHXvd33mwDWw_1743805694
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 280231801A06;
	Fri,  4 Apr 2025 22:28:13 +0000 (UTC)
Received: from [10.22.81.88] (unknown [10.22.81.88])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4257C1801752;
	Fri,  4 Apr 2025 22:28:10 +0000 (UTC)
Message-ID: <f949d227-b3ba-48dc-8dab-d527b82e1246@redhat.com>
Date: Fri, 4 Apr 2025 18:28:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nvme-multipath: add the NVME_MULTIPATH_PARAM
 config option
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, loberman@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 emilne@redhat.com, bgurney@redhat.com, jmeneghi@redhat.com
References: <20250322232848.225140-1-jmeneghi@redhat.com>
 <20250322232848.225140-3-jmeneghi@redhat.com> <20250403043526.GC22526@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250403043526.GC22526@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_152822_152719_64EE124F 
X-CRM114-Status: GOOD (  22.94  )
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


On 4/3/25 12:35 AM, Christoph Hellwig wrote:
> On Sat, Mar 22, 2025 at 07:28:47PM -0400, John Meneghini wrote:

>> +config NVME_MULTIPATH_PARAM
>> +	bool "NVMe multipath param"
> 
> This isn't really a good config options description.
> 
>> +	depends on NVME_CORE && NVME_MULTIPATH
>> +	default y
>> +	help
>> +	  This option controls the inclusion of the NVMe core module
>> +	  "multipath" parameter. If this option is disabled the
>> +	  nvme_core.multipath parameter is excluded from the kernel.
>> +	  If this option is enabled the nvme_core.multipath parameter
>> +	  is included in the kernel.
> 
> So maybe invert the option to
> 
> config NVME_MULTIPATH_DISABLE
> 	bool "Allow overriding the default nvme-multipath parameter"

So the question is: do you want the core_nvme.multipath parameter
to be excluded by default, or included by default?

Keith and I agreed to call this CONFIG_NVME_DISBALE_MULTIPATH_PARAM.
However during testing I realized that many of the default make 'config'
rules would end up with CONFIG_NVME_DISBALE_MULTIPATH_PARAM=y,
even if I set the config rule to "default n".

For example:

  make localmodconfig
  make allmodconfig

would end up with compiling out the core_nvme.multipath parameter and I
don't think this is what we want.

If we want this new config option to provide no net change in the
default behavior, we need this to be the logic to be positive.

> 	help
> 	  This option controls the inclusion of the NVMe core module
> 	  "multipath" parameter. If this option is enabled the
> 	  nvme_core.multipath parameter is excluded from the kernel.
> 	  If this option is enabled the nvme_core.multipath parameter

How about something simple like this:

+config NVME_ENABLE_MULTIPATH_PARAM
+       bool "NVMe enable core_nvme.multipath param"
+       depends on NVME_CORE && NVME_MULTIPATH
+       default y
+       help
+         If this option is N the core_nvme.multipath parameter
+         is excluded from the kernel. If this option is Y the
+         core_nvme.multipath parameter is included in the kernel.
+
+         If unsure, say Y.
+

> 	  See the nvme_core.multipath documentation why disabling
> 	  multipathing is generally harmful but there might be
> 	  exception reasons to do so anyway.
> 
> (assuming we already have the documentation mentioned, if not we
> need to add it)

Yes, I will add some documentation about this.  It looks like we currently
don't have any.

/John


