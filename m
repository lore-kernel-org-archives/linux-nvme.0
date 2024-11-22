Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D780E69185
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 17:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GVwEH7NKOxp7HHL6S2AFq+acEA1lo3fGSvomSOmbcTI=; b=Bk8QlVn/AaUie+/yI3yHKE/tn/
	fjxvBgaDAegBEWa2GGTAz6AXxBrFcbQtTZ1vr5ep3rzxlh53DVyTehfP4AApht/YAtC9wkM0CELRU
	QHlDqa8vEP69j4VaMD77GBRrVaQrT70cB75S/Q/hNM7w6UrD/qbvybG9GvnxVX+HtD9hPXxb0ldON
	PPYVh/Vd3oOVXk4fEEmEo+yqaTqLNSNCav6UBXFc0kI1ZOy4sVCswQsfKO3T5kp44kJ85Rh1nRxwi
	Lx/S4WedUYudf+9Klq8BOUozlf7JpZRKG30Qgo9X6SYDu1rjcX+sAQNnEvV15pxPmPAiovoCOCqBw
	3rgrHQCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEXmt-0000000325f-1owN;
	Fri, 22 Nov 2024 17:49:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEXmq-0000000325G-2uWy
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 17:49:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732297782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVwEH7NKOxp7HHL6S2AFq+acEA1lo3fGSvomSOmbcTI=;
	b=iistVGwYpctFnvfeaWH3fTVKPkbni3MbiVP0hUHL6gN7r2uiiUmMTbWnQHy69En/CsK/EZ
	VAaQX0ieAFY2ZmU8qJa7yetgIDqT+r5A0VXtQKEgrykVRx89h956N/hxwrl9vcqWDHIQz2
	HtKKq9yGGioMJp7gIw/I/pr6mLYY6EI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-nUFJHOxpOkKCm9DDV94noA-1; Fri,
 22 Nov 2024 12:49:38 -0500
X-MC-Unique: nUFJHOxpOkKCm9DDV94noA-1
X-Mimecast-MFC-AGG-ID: nUFJHOxpOkKCm9DDV94noA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 269E719560AA;
	Fri, 22 Nov 2024 17:49:37 +0000 (UTC)
Received: from [10.22.81.129] (unknown [10.22.81.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD8D630000DF;
	Fri, 22 Nov 2024 17:49:33 +0000 (UTC)
Message-ID: <a6902168-0a8e-43ff-afef-b100f75d266c@redhat.com>
Date: Fri, 22 Nov 2024 12:49:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: always enable multipath
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@kernel.dk,
 mpe@ellerman.id.au, naveen@kernel.org, maddy@linux.ibm.com,
 kernel@xen0n.name, bmarzins@redhat.com
References: <20241121220321.40616-1-bgurney@redhat.com>
 <20241122120925.GA25817@lst.de>
 <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_094944_814975_629A6F8E 
X-CRM114-Status: GOOD (  24.29  )
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

On 11/22/24 10:39, Keith Busch wrote:
> On Fri, Nov 22, 2024 at 01:09:25PM +0100, Christoph Hellwig wrote:
>> On Thu, Nov 21, 2024 at 05:03:21PM -0500, Bryan Gurney wrote:
>>> Since device-mapper multipath will no longer be operating on NVMe
>>> devices, there is no longer a need to set CONFIG_NVME_MULTIPATH=n.
>>>
>>> Always enable NVMe multipath, remove CONFIG_NVME_MULTIPATH, and use
>>> the code paths that would be used if CONFIG_NVME_MULTIPATH=y.
>>
>> As mentioned last round not having to build the not tiny multipath
>> code for embedded systems and other small builds that never require
>> multipathing still seems like a sensible idea.
> 
> It's not just embedded either. I have plenty of single port datacenter
> PCIe NVMe's that claim multi-controller capabilities. I think it's some
> artifact of SRIOV that some versions of the firmware can bring.
> 
> Anyway, we only use the one physical function, so they're certainly not
> multipath devices here. We disable the CONFIG option because while the
> nvme multipath IO overhead is low, it's not zero.

So you're saying you want to keep CONFIG_NVME_MULTIPATH and simply remove the modparam nvme_core.multipath? (I know I said we 
were going to do that but that's before Bryan and I started testing his changes with blktests. I think we can fix that.)

The problem with this solution is: when you build a kernel with CONFIG_NVME_MULTIPATH=n you get exactly the same thing as 
CONFIG_NVME_MULTIPATH=y with nvme_core.multipath=n. You get a separate /dev/nvmeNN entry for every namespace/controller path, 
minus the multipath.c code.

So, I don't see the point. If you really want to stop supporting user space multi-path solutions like DMMP with nvme we need to 
stop creating multiple dev entries for multi-path controllers, no matter what.

Note that this multi-pathing stuff is a part of the confusion in UDEV, like I spoke about at ALPPS this year. One reason why the 
/dev/disk/by-path symlinks are so broken is because the kernel has at least three different ways to configure multi-pathing 
support for nvme devices.

We've been saying we're going to do this since since v5.18.

So how do we want to do this?

-
-		if (!multipath) {
-			dev_warn(ctrl->device,
-				"Found shared namespace %d, but multipathing not supported.\n",
-				info->nsid);
-			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
-		}

commit ce8d78616a6b637d1b763eb18e32045687a84305
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Mar 15 13:27:07 2022 +0100

     nvme: warn about shared namespaces without CONFIG_NVME_MULTIPATH

     Start warning about exposing a namespace as multiple block devices,
     and set a fixed deprecation release.

     Signed-off-by: Christoph Hellwig <hch@lst.de>
     Reviewed-by: Keith Busch <kbusch@kernel.org>

(master) > git name-rev --tags --name-only ce8d78616a6b637d1b763eb18e32045687a84305
nvme-5.18-2022-03-17^0


