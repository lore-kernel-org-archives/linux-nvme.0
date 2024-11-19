Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51297D44162
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 14:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LbnLOJpboCYYfSE51bY73euh9VLGe1v8sjrP+GmKz50=; b=omLSl3i+AxV7NQFgNplVyQpYjW
	LX6yiiXgzSA7z4yB4qr6eSYj4rBAF7EhwjpYyR5rzccZ04nguQOZJYCQ9umWKwS6DgBzadRaXEyRP
	VSTqyC7hMY8mztqOqFO4mLWV4ykomtQClw8OzrzEuD5N+6LFLeQ9pS/h01iJE7SR1osIzHfBoCuqK
	1kxOlSX+QjwVGOgKedRM56glauShABUj8r403OfvfuPOOSHUpk6mwdsLIvmcBVOnDDnErNAGOdqOg
	4Ivh5yQx1cud8OYOLYQO53CJdg2xS0yzj6QcWimgBtZysY881Rh5Yk8h6PuQkmbIQqgba7gr5uCgN
	K0NpEvxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDPe8-0000000CkXy-2rVY;
	Tue, 19 Nov 2024 14:56:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDPe4-0000000CkWg-1qxr
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 14:56:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732028157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbnLOJpboCYYfSE51bY73euh9VLGe1v8sjrP+GmKz50=;
	b=O6T5EkJWjCSeQ2R+AwmVCGr8QeBKIxYNPkziTVcn9RRlLmPg3qxBYl4jsn2M3bVTkgC41B
	M/+5FT451hbXed+kee4ZtCVbwbxa35jealZJDAMzRbIPsvrknP4A5kKNOnb9RNGZfc7jY6
	LOM27RKu/45u9GVC9IVGo4Qft6eKQYw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-NtTvVHynM5SQx8QlKVKR1g-1; Tue,
 19 Nov 2024 09:55:56 -0500
X-MC-Unique: NtTvVHynM5SQx8QlKVKR1g-1
X-Mimecast-MFC-AGG-ID: NtTvVHynM5SQx8QlKVKR1g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6ED251953978;
	Tue, 19 Nov 2024 14:55:55 +0000 (UTC)
Received: from [10.22.81.39] (unknown [10.22.81.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E8F01944CC9;
	Tue, 19 Nov 2024 14:55:53 +0000 (UTC)
Message-ID: <1ef1539e-87a2-47c9-af15-d6b32da36312@redhat.com>
Date: Tue, 19 Nov 2024 09:55:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_NVME_MULTIPATH - Do we need this?
To: Nilay Shroff <nilay@linux.ibm.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Ewan Milne <emilne@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
 Chris Leech <cleech@redhat.com>, Maurizio Lombardi <mlombard@redhat.com>
References: <889e1d2a-1cda-4979-8279-f2f665350376@redhat.com>
 <1548948a-3cc6-4372-8d24-7a501da8b31e@linux.ibm.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <1548948a-3cc6-4372-8d24-7a501da8b31e@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HOqUj1refrQDjf76xpyNH_QWKslw4a66TaYN8oIEhuk_1732028155
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_065600_556205_6C99291F 
X-CRM114-Status: GOOD (  17.26  )
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

At this point I think we are going to remove the module_param(multipath) and leave the KCONFIG option alone.

That should be a little less disruptive and we can always submit a separate patch to remove the KCONFIG option later.

Red Hat is currently testing this change internally and will submit a patch for consideration sometime next week.

Thanks,

/John

On 11/19/24 05:18, Nilay Shroff wrote:
> 
> 
> On 11/13/24 05:53, John Meneghini wrote:
>> Now that RHEL-10 beta has shipped we no longer support anything but native nvme multi-pathing and I'd like to do something about the multipath module parameter:
>>
>> bool multipath = true;
>> module_param(multipath, bool, 0444);
>> MODULE_PARM_DESC(multipath,
>>          "turn on native support for multiple controllers per subsystem");
>>
>> I'd like to remove this parameter from nvme_core/multipath.c. The fact is, setting nvme_core.multipath=N never worked in anything but RHEL and keeping it around only causes confusion.
>>
>> For that matter, I'd like to remove the CONFIG_NVME_MULTIPATH kconfig option altogether.
>>
>> Does anybody actually use this?
>>
>> # CONFIG_NVME_MULTIPATH is not set
>>
>> Do we actually support running nvme without multipath.c ?
>>
> Yes I think it's supported but I don't foresee any side effect of removing
> CONFIG_NVME_MULTIPATH except that the following blktests would require some updates:
> 
> nvme/033
> nvme/034
> nvme/035
> nvme/036
> nvme/037
> nvme/039
> 
> All above tests require CONFIG_NVME_MULTIPATH is unset. So if you're planning
> to get rid off this config option then we need to update above tests.
> 
> Thanks,
> --Nilay
> 
> 
> 


