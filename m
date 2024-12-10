Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD0EE77182
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 19:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iF76jqXkDDi7DY14T8DVXQNb8hrSak0UEQ35lCWhfXI=; b=d+2IkYe35PAOzkiuhWEbN6zrub
	3+PnBzDtZr5hwqJIp+AoCcA93ACTjeS36AAx+IHRq9ndKAsLe4nF/POOQ1WG2UUNXw1KLw1Y/RH8Y
	alqjeWNx4lY2B6/5MCaTrI7CiBJqWoytpyfgVaVw9+Yc1toznJDVyVNy6vF+txlEJrZXYuy5EuxBA
	IdHwPaFpr2uYrnqu4S8oaVkbh8zXM44kl25DPA8khemN/hAm/dGYXh+0Nx5GSspNEFLCa0s5bWvOB
	C81ZbHsVG5zpKC3z25LZUafjNe1byNTsLA13j0hMtzgYv7IpyrAFYRqr8u6P4yFCI823HoOGXXn7i
	DYJggD1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6Bb-0000000CYqr-0Kwm;
	Tue, 10 Dec 2024 19:46:23 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tL67K-0000000CYC7-3oNm
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 19:42:00 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Y78J64BV3zlffky;
	Tue, 10 Dec 2024 19:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733859712; x=1736451713; bh=iF76jqXkDDi7DY14T8DVXQNb
	8hrSak0UEQ35lCWhfXI=; b=IdmhmIIFnWb86VH/zbpiNQAl1iF5QHSh7tiknbD7
	fwYmgVufnj2yHTdZrQ2ydlzbFbmrYK8KymywrjRL7M/8Xrh3RDLXWhHSr1MCy1nv
	U/hp6li8gDhZD5U564JOPdY8W9TViwfwGLOahRF5V+BIgsQzgVcwkGeZ0x60xMb4
	XNvSQxQaQFccgboQ7oINay/kr1L/GocXgXopXAMcT3NMspefV1U7HN35/M4E9cL7
	inSf34D/3AZtDGg9f6KqdDkGGZ7CRW+seV4g17qrqXGAf4cfMazlsWE+EIwE9V0c
	hGD6TL/Gig0v0vQgB4sz/wNiODEJ7/1YV5waUAXMYkWFSw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BuScKu7QmEgN; Tue, 10 Dec 2024 19:41:52 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Y78Hx4znCzlfl5W;
	Tue, 10 Dec 2024 19:41:49 +0000 (UTC)
Message-ID: <7d06cc60-7640-4431-a1cb-043a959e2ff3@acm.org>
Date: Tue, 10 Dec 2024 11:41:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>
References: <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
 <2b5a365a-215a-48de-acb1-b846a4f24680@acm.org>
 <20241111093154.zbsp42gfiv2enb5a@ArmHalley.local>
 <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org>
 <20241112135233.2iwgwe443rnuivyb@ubuntu>
 <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com>
 <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org>
 <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com>
 <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org>
 <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
 <CGME20241205081138epcas5p2a47090e70c3cf19e562f63cd9fc495d1@epcas5p2.samsung.com>
 <20241205080342.7gccjmyqydt2hb7z@ubuntu>
 <yq1a5d9op6p.fsf@ca-mkp.ca.oracle.com>
 <d9cc57b5-d998-4896-b5ec-efa5fa06d5a5@acm.org>
 <yq1frmwl1zf.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1frmwl1zf.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_114158_968827_2AD81EA9 
X-CRM114-Status: GOOD (  16.33  )
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

On 12/9/24 6:20 PM, Martin K. Petersen wrote:
> What would be the benefit of submitting these operations concurrently?

I expect that submitting the two copy operations concurrently would 
result in lower latency for NVMe devices because the REQ_OP_COPY_DST
operation can be submitted without waiting for the REQ_OP_COPY_SRC
result.

> As I have explained, it adds substantial complexity and object lifetime
> issues throughout the stack. To what end?

I think the approach of embedding the ROD token in the bio payload would
add complexity in the block layer. The token-based copy offload approach
involves submitting at least the following commands to the SCSI device:
* POPULATE TOKEN with a list identifier and source data ranges as
   parameters to send the source data ranges to the device.
* RECEIVE ROD TOKEN INFORMATION with a list identifier as parameter to
   receive the ROD token.
* WRITE USING TOKEN with the ROD token and the destination ranges as
   parameters to tell the device to start the copy operation.

If the block layer would have to manage the ROD token, how would the ROD
token be provided to the block layer? Bidirectional commands have been
removed from the Linux kernel a while ago so the REQ_OP_COPY_IN
parameter data would have to be used to pass parameters to the SCSI
driver and also to pass the ROD token back to the block layer. A
possible approach is to let the SCSI core allocate memory for the ROD
token with kmalloc and to pass that pointer back to the block layer
by writing that pointer into the REQ_OP_COPY_IN parameter data. While
this can be implemented, I'm not sure that we should integrate support
in the block layer for managing ROD tokens since ROD tokens are a
concept that is specific to the SCSI protocol.

Thanks,

Bart.

