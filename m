Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6336C25B10
	for <linux-nvme@archiver.kernel.org>; Mon, 13 May 2024 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CK/yTD4vsBE25iZLNTjIJQVNn6zNelLGLfVBPKfwaCQ=; b=mc2hIGdStXjng8caghSdyotLJe
	gy2yxbvdrs+JIfS15GzehNoH1FKt/cdC4l3qX9xjS0AI1+Kf/6UKPIvY3hgyD1HcucP4XYCqd+uB8
	e6wQbx409dbj85pUpWXCi3rJdM9UzG2i9/taf9ujRhm/ALb7b4xHUenoVLWZHPJJz+rtwv3rlWB3o
	3/uFPGTXVX85InLrVajyJClwHmVDK6gCGDmxb7nywZBvrbaF77CEFNyFeZoRBwEwdXKikfvqJNVAF
	T70OW4Qaciu1Cb3Ilr1jZtfD0cY6TI01qEzC+zNgrJnRvak6b8T1chTrmisq5iuGXA41aIpxsL6YD
	5rSCgX3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6VUE-0000000CxNM-2LGE;
	Mon, 13 May 2024 13:13:02 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6VUA-0000000CxJr-2VZH
	for linux-nvme@lists.infradead.org;
	Mon, 13 May 2024 13:13:00 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VdKfR2Dh3zlgVnf;
	Mon, 13 May 2024 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715605964; x=1718197965; bh=CK/yTD4vsBE25iZLNTjIJQVN
	n6zNelLGLfVBPKfwaCQ=; b=apbCsBl00eKoh96TCJA+4gFfsHjvC2MCRzFnHNjt
	igYlO5msrwPg+wC8vWf1qPY/DOiw9OJ4Ky2aBN6iQ8/DCmz939vm4E0beYyLgbbX
	0qRe61nDogYk5RF/Y9zTLl8X1WwMjAC7z7WaF/Vshag1ytEjhbot0pJ+8/y0qCZ0
	S3/lr4lbr34hCcqJEIJNMv2f6C/or7FAFe9/q8n7JkknryhXufZdPyqFekY1u8CU
	DE+xlyblECb+NRNCPeBAKvAAPI4BbzsAOMBOa84Z7OJhwEuYHkB/llQubhJCys7Q
	ya4MzBzUFU5tdoxJyzCwQNtaAV1bzPN6Fcx3OHmauIuKzA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id oJpwUKMiAjg5; Mon, 13 May 2024 13:12:44 +0000 (UTC)
Received: from [172.20.0.79] (unknown [8.9.45.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VdKfM5rYNzlgVnW;
	Mon, 13 May 2024 13:12:43 +0000 (UTC)
Message-ID: <c75bef55-f3f3-444f-9aa9-d646fd13f73d@acm.org>
Date: Mon, 13 May 2024 07:12:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, ming.lei@redhat.com, Keith Busch <kbusch@kernel.org>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com> <20240510151047.GA10486@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240510151047.GA10486@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240513_061258_732515_50A9D503 
X-CRM114-Status: GOOD (  11.17  )
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

On 5/10/24 08:10, Christoph Hellwig wrote:
> On Fri, May 10, 2024 at 07:14:59AM -0700, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> Some people _really_ want to control their interrupt affinity.
> 
> So let them argue why.  I'd rather have a really, really, really
> good argument for this crap, and I'd like to hear it from the horses
> mouth.

Performance can be increased by modifying the interrupt assignments
carefully, especially in storage appliances that have to process a
large number of network and storage interrupts. By carefully assigning
interrupts the number of completions processed per interrupt can be
increased and hence performance also increases. In 2014 I was working
on a product that benefited from this approach.

Thanks,

Bart.


