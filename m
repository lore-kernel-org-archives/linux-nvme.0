Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3C3CA0EFA
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Aug 2025 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xiNs42RT8JY287EqVp/Sj5aOw0z1IPc9RNKRq3M2mrY=; b=eAmZpcMwIjZ+cc8YDJTa5BccFZ
	dDdJup5INGABk8wHMV17uIIS/k+7saII7MAKId6jpf/rK4y9C/aidllvzBnbbcN1UYtqzh6BvkpFr
	m4Ik29Z4oNRZBDw6xKrvZBwk2iNrm+ZZ4y7iGHj1hKkeQb27kQEL2mQKUUXAoCFMBjhr1RYQskZn+
	Da4mHTA9sey/dF9iyi9Khwi1NfEm7Vd5NC3egErz4tJv6AkGnS5EO9GQHVIe1Zr3S4WJDj8uyOCGR
	0JPoKtX8oF5mKHZFiZWOV/DByrFr4L9Nuf6wrIb6y4egtC9fVBo3cwhFe4C4pubZyMtJmRz6qG3Vk
	37Eo0KTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uquno-0000000CHzm-16Zz;
	Tue, 26 Aug 2025 14:37:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uquMe-0000000CCjZ-2CYg
	for linux-nvme@lists.infradead.org;
	Tue, 26 Aug 2025 14:09:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756217370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiNs42RT8JY287EqVp/Sj5aOw0z1IPc9RNKRq3M2mrY=;
	b=HSUk983uX5Pj6b6RSIntBHkAMi/vSyDiEY6PKW5yYm6M4VYegpxboWo7bzlKgqAEmlSlW4
	yjbga2nm/ddTL2bDfUVP1olFpoUXVUZhH6+i9HCK76kuCmn4TtZPhpirIfD0F6iS2Bj3e1
	sYm7xwUxWNm834nK6xh9AVCpd7ne0Xc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-rTYn78kXMNOmC182-9CjOw-1; Tue,
 26 Aug 2025 10:09:28 -0400
X-MC-Unique: rTYn78kXMNOmC182-9CjOw-1
X-Mimecast-MFC-AGG-ID: rTYn78kXMNOmC182-9CjOw_1756217367
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5021519560B0;
	Tue, 26 Aug 2025 14:09:27 +0000 (UTC)
Received: from [10.17.17.65] (unknown [10.17.17.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05E3919560AB;
	Tue, 26 Aug 2025 14:09:25 +0000 (UTC)
Message-ID: <fddfda33-e149-4e0f-914c-c20dde754031@redhat.com>
Date: Tue, 26 Aug 2025 10:09:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libnvme: TLS PSK derivation fixes
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org,
 Prashanth Nayak <prashanth.nayak@netapp.com>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <20250721021718.1159879-2-cleech@redhat.com>
 <d8f4ed91-3fcb-45b9-b4d6-900382eb4ae7@suse.de>
 <aH5dbhXOS8h9gxzX@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <3c3c3194-7275-4a77-9397-4c159458f2c5@suse.de>
 <aIPINwQZNxk_7FZs@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <df8bfa36-c1a9-4398-8246-5bc31991b8c9@suse.de>
 <aJrEAia9jVk17y-j@my-developer-toolbox-latest>
 <3fc1b734-263e-4580-83f8-6852e72f198d@flourine.local>
 <61da6ec7-500e-4e33-a51a-d2f6ec9e08b6@suse.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <61da6ec7-500e-4e33-a51a-d2f6ec9e08b6@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YCyxmHzFFuro_Yip3mW53hssd-OGLNJjWgV6GBnOhWk_1756217367
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_070932_635420_7A2BC056 
X-CRM114-Status: GOOD (  13.09  )
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

On 8/20/25 4:22 AM, Hannes Reinecke wrote:
> On 8/20/25 10:10, Daniel Wagner wrote:
>> On Mon, Aug 11, 2025 at 09:33:06PM -0700, Chris Leech wrote:
>>> If we don't have a resolution by then, maybe this is something we can
>>> resolve at ALPSS.
>>>
>>> [1] Side note; with nvme_fabrics_cfg _not_ being allocated through
>>> libnvme, I don't see how the various additions there can be ABI safe. It
>>> looks to me like this struct alone broke ABI in libnvme 1.4, 1.8, 1.9,
>>> and 1.11.
>>
>> I know and I was hopping it wouldn't cause troubles... nvme_fabrics_cfg
>> is a bit of a problem. I was planing to address this for v2.
> 
> In a similar vein: shouldn't we have a session at ALPSS around
> libnvme v2?

Yes, both Chris and I have proposed a talk to discuss NVMe/TLS at ALPSS.

> Or, if not a session, maybe a beer topic?

Sure, you can drink a beer when we talk about it. ;-)

/John

> Cheers,
> 
> Hannes


