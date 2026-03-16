Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45F7FB5E8B
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 23:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YFQ61RTtycUh5p2nWyByuEdkQhIoYRlH2gukTJs5mis=; b=zSAnYDiD+iaUE9+h6kREH2eGAv
	DCJdd7KfP1owi1nOwkefjcm1j2dxpSxu0oCpg5lFxQDiLVNQUPgQS9fI5pDcr7ZpL8ecR+htJBCA0
	x9MJto6NKLSzNNs6FqDrGfvkoHlpj911+oEbAuw7Jv40MEjZ14pirsBKQe0XL9vEpqmjwGJJnpkoN
	AUlSRSrzt9bkkww+7dnUhEztnV49riLszbDTqC+cEjlAnJeLFmPjPauGERUKFnf/hFHzbY1vbrPPq
	WuT2wHHiFa/96eZFuvF1XlL2j9sRsEJQ1n8Q/j+W7Dgsurz+yHKBsBsH9ZC87pQK9Bg64eQ3mnjj6
	dVDai/yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2HKJ-000000054IZ-0nSX;
	Mon, 16 Mar 2026 23:26:23 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2HKG-000000054IE-2xLe
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 23:26:22 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZWSB6T9Jzlh1Rb;
	Mon, 16 Mar 2026 23:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:from:from:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773703575; x=1776295576; bh=YFQ61RTtycUh5p2nWyByuEdk
	QhIoYRlH2gukTJs5mis=; b=3fbO3MKzJyhSowx5+dbqwzHKCmJZaHbAEnel4Q9P
	3QxKpWRHJdD55yjZ/xAurR4IDQ5joX0nlqCPlHfy1Cv13NTiGjOTGCr+3tiIqj+P
	7p50r6VnMmOXPqCJE+5L2Xvekb5sf+vAKTqXtEiAyQvr1uC0M6PtgCUuZJIBkP5P
	nDB8ELeXzurajKIVnmy4dwplGfiq3q5RVv5H9KNYirOjB8/dDhB/D7crrOjTPmwU
	sqMecn75EMBDz94EhMdz8AUP8ZtHy60fpvO3sQUj7FX4dUW3xo4EkQ2DH3J6P71U
	7Cuu4+cSQ5gqKtdKu0GGb+UZSCcb4gvi8x+RVoorDl663A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Is6MgBSkwYAp; Mon, 16 Mar 2026 23:26:15 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2e19:8:245b:9369:f866:f27] (unknown [104.135.180.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZWS56y1yzlh1Nt;
	Mon, 16 Mar 2026 23:26:13 +0000 (UTC)
Message-ID: <8d6fc6da-4406-4609-92a2-c5e7e9475c1f@acm.org>
Date: Mon, 16 Mar 2026 16:26:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
From: Bart Van Assche <bvanassche@acm.org>
To: Hannes Reinecke <hare@suse.de>, lsf-pc
 <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org, Theodore Ts'o <tytso@mit.edu>
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
 <e2733d9f-823d-433b-9bfd-24df20b98b7d@acm.org>
Content-Language: en-US
In-Reply-To: <e2733d9f-823d-433b-9bfd-24df20b98b7d@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_162620_784263_0FBA441D 
X-CRM114-Status: GOOD (  12.12  )
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

On 2/19/26 6:53 AM, Bart Van Assche wrote:
> On 2/19/26 1:54 AM, Hannes Reinecke wrote:
>> I (together with the Czech Technical University) did some experiments=20
>> trying to measure memory fragmentation with large block sizes.
>> Testbed used was an nvme setup talking to a nvmet storage over
>> the network.
>>
>> Doing so raised some challenges:
>>
>> - How do you _generate_ memory fragmentation? The MM subsystem is
>> =C2=A0=C2=A0 precisely geared up to avoid it, so you would need to com=
e up
>> =C2=A0=C2=A0 with some idea how to defeat it. With the help from Willy=
 I managed
>> =C2=A0=C2=A0 to come up with something, but I really would like to dis=
cuss
>> =C2=A0=C2=A0 what would be the best option here.
>> - What is acceptable memory fragmentation? Are we good enough if the
>> =C2=A0=C2=A0 measured fragmentation does not grow during the test runs=
?
>> - Do we have better visibility into memory fragmentation other than
>> =C2=A0=C2=A0 just reading /proc/buddyinfo?
>=20
> The larger the block size, the higher the write amplification (WAF),
> isn't it? Why to increase the block size since there is a solution
> available that doesn't increase WAF, namely zoned storage?

(replying to my own email)

The following paper shows that it is possible to achieve great
performance with filesystems like ext4 and ZNS SSDs by implementing
an FTL in software (ZTL). This could be a more interesting approach
than optimizing host software for large indirection units. See also
Sass, Jan, Andr=C3=A9 Brinkmann, Matias Bj=C3=B8rling, Xubin He, and Reza
Salkhordeh. "ZTL: A block layer ZNS driver." Journal of Systems
Architecture (2026): 103757.
(https://www.sciencedirect.com/science/article/pii/S1383762126000755).

Bart.

