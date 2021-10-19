Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03511C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 09:01:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B27C6115A
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 09:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B27C6115A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Pw3l3WTRzGPWeEnNxqW8P9i4yq1hh9K8yCK2Y6cxDc=; b=f8oY419z98PtYIRWI5kC2GjKfL
	8318+4msu+YRECljY16S7oRKwbY6V7wb8vm4QYjDRsPDTsMls08wwTrCJl4qBm/OE0ILoyUdVKUVq
	xMfQmqbdJbit/6HC+QaXFE8Q+4iHOZJGxN/mKrvWsvLcaX2Sbly98RgpaghjWRCC3yKaszmN3Bry+
	R58J9CYbbTX/YGt0lPtQksD8HXpFbxIUXqVyEQZQgyHjAadnMNOWML41DQhdND7jdS8RST3QRGUPd
	6G5HOnjKpOmabSdzVyzZUCsc50W+M9Ii7+1MQhoJT805THJXeW/LWRVNDE4wHQlKO0/154bQNWeKJ
	7ND7vP0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mckzz-000cXP-Rc; Tue, 19 Oct 2021 09:01:31 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11] helo=mx1.molgen.mpg.de)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mckzw-000cVO-7U
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 09:01:30 +0000
Received: from [192.168.0.2] (ip5f5aef98.dynamic.kabel-deutschland.de
 [95.90.239.152])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id E5F8961E5FE00;
 Tue, 19 Oct 2021 11:01:22 +0200 (CEST)
Subject: Re: SK hynix BC511: warning: nvme nvme0: missing or invalid SUBNQN
 field.
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
References: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
 <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
 <f3f78d3c-d3f7-67f5-4263-f306b4f623d1@molgen.mpg.de>
 <20210817170222.GA224912@dhcp-10-100-145-180.wdc.com>
 <f02a8989-d255-26ee-2fca-c9db2d1e158c@molgen.mpg.de>
 <20211011180058.GA635062@dhcp-10-100-145-180.wdc.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <3eafec89-0c71-5243-8545-dc0120f1678b@molgen.mpg.de>
Date: Tue, 19 Oct 2021 11:01:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211011180058.GA635062@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_020128_453357_3745B714 
X-CRM114-Status: GOOD (  19.64  )
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

Dear Keith,


Thank you for your reply?


Am 11.10.21 um 20:00 schrieb Keith Busch:
> On Mon, Oct 11, 2021 at 03:08:15PM +0200, Paul Menzel wrote:
>> Am 17.08.21 um 19:02 schrieb Keith Busch:
>>>
>>> In the section for "Identify Controller Data Structure" (section
>>> 5.17.2.1, figure 257 in spec version 2.0), the NQN definition says:
>>>
>>>     "Support for this field is mandatory if the controller supports revision
>>>     1.2.1 or later"
>>>
>>> The driver does confirm the controller's reported revision meets this
>>> requirement before emitting the warning.
>>
>> The Dell support came back to me, and said, that Hynix refuses to publish a
>> fixed firmware unless I show them a use case, where I need that field.
>>
>> Can somebody think of a use case,
> 
> Spec compliance certification. UNH test 1.1 case 2, for example.
> 
>> and why this field was made mandatory in the specification?
> 
> A dependable way to uniquely identify a specific device is generally
> useful. The NVMe TWG determined the previous methods were inadequate.

Do you know, why the serial number, shown by `nvme list`, was deemed 
inadequate to uniquely identify a specific device?

> The linux kernel will continue to use the device without this capability
> since the low level driver doesn't need it to interact with a
> controller, but the driver will warn about the non-compliance in case
> host software is relying on this field.

Yes, I understand.


Kind regards,

Paul

