Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5493FE7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 17:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gmWh5tFfs7soVBLFuSO/qLnXu+8CTMZDvRiQMaBPqDA=; b=tf4N4rlS9E5TNVXKN8chQTCxx/
	k5ctXQUtGRWyji4mw8dGlhrY9c+DQv9uAk+BClRFiRFLQcomRI8X2LunJG2JZYTo9m8aIHHKGU5p0
	0mStLwzCdxyNTfm+7LEnnM7b0L4gN6cg93t/y0UkjMmB9pm3OE8FG8UwYVPd1UyKdobFl/i702BAs
	ol08oOoNSbgphiV3SzY2ZC0JZvMpAXsni8M1OAxqCUs3yKTZC7Nr4XapUDY5xQeoPinmjIbH5Ur7R
	1JZCUERX1oLJFyec1LlyOu0XwEwZcnJaJzujlubW9bXHZcgrvL50mgBQkR6ykgfym/n2j3ENaEf88
	FC0lg0/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLQUw-0000000FbJA-0Hij;
	Wed, 11 Dec 2024 17:27:42 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLQUs-0000000FbEH-1p7v
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 17:27:40 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Y7jGQ6jb4z6Cr2Gt;
	Wed, 11 Dec 2024 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733938040; x=1736530041; bh=gmWh5tFfs7soVBLFuSO/qLnX
	u+8CTMZDvRiQMaBPqDA=; b=Jn6+ZsKHbREar6WFe1GZ0ByPNPgeHh1eoVH5k3Bf
	mH/A5t7lCLVsuWak0fNQXlIKOfzO8126Uzjxaba+goDPEjzFT9AjaBJtIULKzqe0
	9IWyuEoe9yd53BI+GN7KPYPmZUQw52b/ofwJJtzgSSYTRROAPtiBuqxT82oaIDf0
	HpAedfiM8HBcDPijE4nqorCERsOU0bxylbNfd0qb4M7fHn2k9LptP8qKw51lM4H9
	G1dmjVSE85gGToRztGnGgtDPO/kpi57nFluPjq0j5JEQ0KcPP4ChqlvrsRIflYeH
	ORJIpf7HL5DSubgUBgwRZ2ik7TSML8T1sqIGrppT0jkkhA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7pH0caqGSLM7; Wed, 11 Dec 2024 17:27:20 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Y7jGC4KWJz6Cr2Fp;
	Wed, 11 Dec 2024 17:27:14 +0000 (UTC)
Message-ID: <2f260b23-006a-4ea2-a508-39f2bace1bec@acm.org>
Date: Wed, 11 Dec 2024 09:27:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>
References: <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org>
 <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com>
 <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org>
 <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
 <CGME20241205081138epcas5p2a47090e70c3cf19e562f63cd9fc495d1@epcas5p2.samsung.com>
 <20241205080342.7gccjmyqydt2hb7z@ubuntu>
 <yq1a5d9op6p.fsf@ca-mkp.ca.oracle.com>
 <d9cc57b5-d998-4896-b5ec-efa5fa06d5a5@acm.org>
 <yq1frmwl1zf.fsf@ca-mkp.ca.oracle.com>
 <7d06cc60-7640-4431-a1cb-043a959e2ff3@acm.org>
 <20241211093549.n6dvl6c6xp4blccd@ubuntu>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241211093549.n6dvl6c6xp4blccd@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_092738_477303_FC1840B8 
X-CRM114-Status: GOOD (  12.98  )
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

On 12/11/24 1:36 AM, Nitesh Shetty wrote:
> Block layer can allocate a buffer and send this as part of copy
> operation.

The block layer can only do that if it knows how large the buffer should
be. Or in other words, if knowledge of a SCSI buffer size is embedded in
the block layer. That doesn't sound ideal to me.

> This scheme will require sequential submission of SRC and DST
> bio's. This might increase in latency, but allows to have simpler design.
> Main use case for copy is GC, which is mostly a background operation.

I still prefer a single REQ_OP_COPY operation instead of separate
REQ_OP_COPY_SRC and REQ_OP_COPY_DST operations. While this will require
additional work in the SCSI disk (sd) driver (implementation of a state
machine), it prevents that any details about the SCSI copy offloading
approach have to be known by the block layer. Even if copy offloading
would be implemented as two operations (REQ_OP_COPY_SRC and 
REQ_OP_COPY_DST), a state machine is required anyway in the SCSI disk
driver because REQ_OP_COPY_SRC would have to be translated into two SCSI
commands (POPULATE TOKEN + RECEIVE ROD TOKEN INFORMATION).

Thanks,

Bart.


