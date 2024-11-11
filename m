Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BC5D3ABDA
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EQ/YSyflFEK19dUNwksnyjAZemqpoYotz99gNmDJJn4=; b=Zq5gYLWqsZtIZwBfWBBsrDaFzo
	nLD6hMmb+iXy4pMe+ibjnU1IdO39JgBkur50cAbl2wHP+KfMpwB/gAJs0a2rxfVE9FV7nP66MBwUN
	aV1NXL03p5kvIc5/IAbkl6LyAesImndr+rXd4xYDV7ySUSEQK2srLzV6CTPXy1RfraQyEwDZOnhOt
	KOxa5eLk1jg6TXM1q60sahoc/+grSXpW6gWKlwHoQbOUU0HkeqQYXUVJYlf0Voblc8eVub4If6fj3
	0OshwEAud28lT+lTp6UeYmssdFZPZgsEoqKMgm5F83kvGd5iuzHr0KQun6cO5UpNEy76I31w82u8J
	925edMzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYWo-00000000mGr-0v0b;
	Mon, 11 Nov 2024 17:48:42 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYUW-00000000lsH-3PGc
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 17:46:22 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XnH5s4cJ7zlgT1M;
	Mon, 11 Nov 2024 17:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1731347165; x=1733939166; bh=EQ/YSyflFEK19dUNwksnyjAZ
	emqpoYotz99gNmDJJn4=; b=mX9ZYwAQ12bes+QJxHZczpD/MW1jRHfypLnkeTdB
	k0Efuu2qex5Us0NBWkQxjuTwVNsVzvgjhNuNQ6zReqbUcYPKUZmkbnvWKTAWm4at
	QGP4Mz4eA0g2yL7QZD+pY7yN3J8/PJjwwt3QibPgwKvaiHfKDvG+i+MrI1b1Rz2a
	eHouoKmM7l7wBGgVxxnhFibo1NYIq8vCHCVIoK6Cv5ut+XueS1VI4vHg8SJ6vmlq
	WvVBb3KRZ1ZZInrKrR7adRI71uGvrSpCJdNF7MIfYqbG4syzoiH1RdHxCALcisbC
	S8GaW0PJtFza68WV4T+GMU8wZGXWoHvCl2t2cFHFG6VqEw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lK5eOCQPE44g; Mon, 11 Nov 2024 17:46:05 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XnH5h3H2BzlgTWG;
	Mon, 11 Nov 2024 17:46:00 +0000 (UTC)
Message-ID: <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org>
Date: Mon, 11 Nov 2024 09:45:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: Javier Gonzalez <javier.gonz@samsung.com>
Cc: Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241105155014.GA7310@lst.de> <Zy0k06wK0ymPm4BV@kbusch-mbp>
 <20241108141852.GA6578@lst.de> <Zy4zgwYKB1f6McTH@kbusch-mbp>
 <CGME20241108165444eucas1p183f631e2710142fbbc7dee9300baf77a@eucas1p1.samsung.com>
 <Zy5CSgNJtgUgBH3H@casper.infradead.org>
 <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
 <2b5a365a-215a-48de-acb1-b846a4f24680@acm.org>
 <20241111093154.zbsp42gfiv2enb5a@ArmHalley.local>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241111093154.zbsp42gfiv2enb5a@ArmHalley.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_094620_880826_ACDE89FC 
X-CRM114-Status: GOOD (  14.44  )
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

On 11/11/24 1:31 AM, Javier Gonzalez wrote:
> On 08.11.2024 10:51, Bart Van Assche wrote:
>> On 11/8/24 9:43 AM, Javier Gonzalez wrote:
>>> If there is an interest, we can re-spin this again...
>>
>> I'm interested. Work is ongoing in JEDEC on support for copy offloading
>> for UFS devices. This work involves standardizing which SCSI copy
>> offloading features should be supported and which features are not
>> required. Implementations are expected to be available soon.
> 
> Do you have any specific blockers on the last series? I know you have
> left comments in many of the patches already, but I think we are all a
> bit confused on where we are ATM.

Nobody replied to this question that was raised 4 months ago:
https://lore.kernel.org/linux-block/4c7f30af-9fbc-4f19-8f48-ad741aa557c4@acm.org/

I think we need to agree about the answer to that question before we can
continue with implementing copy offloading.

Thanks,

Bart.



