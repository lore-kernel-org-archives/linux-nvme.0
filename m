Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D30C28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 03:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V/taELm4S5wjSnSK9zdR6jac90PyrwFhqo2me21EPLw=; b=lXGaCbWR9VQ2ciBP3H19SaJ0ug
	3zyuAwE8pY7fKPOxXdw1NkTunc3glR7rr6QaxfIk/jHchBn3bbTPmzdccchpzOCsfSPxqsMWr6Vhv
	wVeUCqs9Z97gl1N7DFGXj9fsY9b/XoxgFNglook9wEbL/m2oZkqgGpZY/5wLNWVaP/Dzn5jDFuuoj
	Hjfl1sgEqNrUlWRWQXFqtenn+DsmhRaE5XzOzFLHsFG0NSU6Osftp/v/wQ8zlEpZObSSvqSIf8QiW
	8oVhykbf5boQY73KAen6P32aYYbs3Jeh6RJ3sBxCFJrAN72gqcl0xymbk/eXjCWp2uTsfJE/uxYJX
	vS47QYHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsD55-00000007Qjx-2nAJ;
	Wed, 12 Mar 2025 03:48:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsD4b-00000007Qh0-2kFq
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 03:48:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741751278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/taELm4S5wjSnSK9zdR6jac90PyrwFhqo2me21EPLw=;
	b=byI9Wb78k/yr1uHIXD+/3kjNZkT+YscI/098g2eBiJYBO8xdLcbQFU5MNTYKg8/fPCE83f
	U1FS7Qlj4D/YcMshaXPYqR+T9D1V7rb6rgpTRYVJCNJWseAhQl8wiJs4RV+zovtVcmejr2
	wOV6UNSWQu7FpKjLXIz9DW9+qq+KxIs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-EVC0RFCHPdmtsG1Sx8ft4g-1; Tue,
 11 Mar 2025 23:47:55 -0400
X-MC-Unique: EVC0RFCHPdmtsG1Sx8ft4g-1
X-Mimecast-MFC-AGG-ID: EVC0RFCHPdmtsG1Sx8ft4g_1741751273
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F22071956087;
	Wed, 12 Mar 2025 03:47:52 +0000 (UTC)
Received: from [10.22.65.26] (unknown [10.22.65.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA7391955BCB;
	Wed, 12 Mar 2025 03:47:49 +0000 (UTC)
Message-ID: <01d799d1-fc93-4285-aa8f-89ac2d01478b@redhat.com>
Date: Tue, 11 Mar 2025 23:47:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, bmarzins@redhat.com,
 Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
 axboe@kernel.dk, Randy Jennings <randyj@purestorage.com>
References: <Z8hrJ5JVqi7TgFCn@kbusch-mbp> <20250305235119.GB896@lst.de>
 <Z8jk-D3EjEdyBIU5@kbusch-mbp> <20250306000348.GA1233@lst.de>
 <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
 <20250306141837.GA21353@lst.de> <Z8m4vzE36UHWjwep@kbusch-mbp>
 <20250306151654.GA22810@lst.de> <Z8pB9jQALxMN6WaA@kbusch-mbp>
 <b2c9df64-0afc-46cd-9e8d-6a3f41a4f1c7@linux.ibm.com>
 <Z8sUB2bbbMsurZmu@kbusch-mbp>
 <69cdaf9d-2fb4-4ee0-9c32-cc946405a23a@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <69cdaf9d-2fb4-4ee0-9c32-cc946405a23a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_204801_775294_4CD34024 
X-CRM114-Status: GOOD (  19.11  )
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

On 3/9/25 1:23 PM, Nilay Shroff wrote:
>> It honestly has potential to solve some real problems, like
>> re-enumeration triggered by a link reset on an in-use drive. You'd
>> currently need to close the old handle and open a new on, even though
>> it's the same device. It may not even be possible to do that if that
>> device contains your root partition, and then you can only power cycle.
>>
>> The downside is we wouldn't get the short cut to blk_mq_submit_bio. We'd
>> instead stack that atop an indirect call, so it's not free.
>>
> Yes agreed however it seems advantages of using an indirect call outweighs
> using the short cut to blk_mq_submit_bio. Moreover it seems the cost of
> indirect call is trivial because we already cache the nexthop.
> 
> I integrated your proposed patch (with few trivial additional changes on top)
> and I see that it's coming out nicely. I ran few tests and confirmed it's
> working well. However, in the proposed patch we*always* delay (~10 sec) the
Have you tested this with a NVMe-oF controller... yet?

Where did the number 10 seconds come from?

> removal of multipath head node. That means that even while removing the
> nvme module (rmmod nvme) or if user delete/detache the namespace, we delay
> the removal of head node but that may not be what we want. So I'd suggest
> instead, delayed removal of multipath head not shall be configurable using a
> sysfs attribute. With this attribute then we shall let user opt for pinning
> the head node (with optional delayed time as well?). And it's only when user

So be aware the TP-4129 is adding a CQT parameter which does almost exactly this.

> shows the intent to pin the node we should delay its removal. This is what
> exactly (pinning of head node) Christoph's proposed patch implements. So I'd
> suggest a bit of amalgamation of yours as well as Christoph patch to implement
> this change.

Please cc: me on your patches Nilay, I'd like to test them with my NVMe-oF testbed.

/John


