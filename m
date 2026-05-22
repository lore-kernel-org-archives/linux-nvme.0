Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D9CCD5BB0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qnnkAknxkW4BAZjGZmW//V0uyb+y/XGEO6fXvzEO+aA=; b=L+J1uuARu0onQZAL7+3JbVeFz1
	Q4T97k8TgGNNKXKWG3WmvtGaqxC8qhchC7vBKdiDscNPl9j3Jj/UOMHEptxD4a6roTZhNoSiBhSaF
	RQfHe9+a0RdZonRgQAuALCiHQNzA6JKsJiitAztKYKHJYoaOeQq9MwY+x1cmqSsJLDzumQ6tO4lmT
	gBdrXhj5uUhfEArZBAXavsmf9IrXzLPbdCnQUau3UwUkcrfemISFNCZkxzLr8YYylibkGyTxQUQxf
	zZvmOHhWZn26JxL2wImNyP9Mp1AJHcPoJeqxpeCucAQ+3eRfa8ISTXNcpJ35zN/T8Q5gm0wkfkHux
	Hamjbwmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQSdk-0000000BPlE-48mu;
	Fri, 22 May 2026 16:22:24 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQSdi-0000000BPjp-0uCD
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 16:22:23 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gMVsv2sf2z1XM6Jb;
	Fri, 22 May 2026 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779466927; x=1782058928; bh=qnnkAknxkW4BAZjGZmW//V0u
	yb+y/XGEO6fXvzEO+aA=; b=hr8mpagw99tZzxCQtfK+mglOj7MjsOdD8z7EVN/n
	38qTXRso80Dn6oS1f5ALm8M1EWp9ZgM8pAfkLfYtcJr0n/KecSmiHO3o+LJDjeIK
	Y47OB4vlf/oW2cG0HMyTD6ioclyUST0oPDK5O21mz2UyWBAGlfXFSd0fUoo8I55/
	uwr4Xc0Sq3OizSuB9GsCiSJr0NLZFyukIdIJ4VBW7p0q3f0Dtp52C3BdI8dvMF6A
	ifaH35ODopU7qEQRZW6tD6ropvxfCIzVgGwb4GesVuLbdSC9SFDSO4/53Am4JHxC
	r3iCTRdXgF4UXeWBAsV9ysjhwx4dV1IOpeYkZoC3foR7XA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id mS_-y8NxLE1w; Fri, 22 May 2026 16:22:07 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gMVsp1Rgkz1XM6Jk;
	Fri, 22 May 2026 16:22:05 +0000 (UTC)
Message-ID: <e838f00a-03d8-4a62-bb64-5c6be8561303@acm.org>
Date: Fri, 22 May 2026 09:22:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Block storage copy offloading
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Nitesh Shetty <nj.shetty@samsung.com>
References: <20260424224201.1949243-1-bvanassche@acm.org>
 <ahBD9fRrPDuoB2cj@shinmob>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ahBD9fRrPDuoB2cj@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_092222_371703_D52B584C 
X-CRM114-Status: GOOD (  11.65  )
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

On 5/22/26 5:00 AM, Shin'ichiro Kawasaki wrote:
> FYI, blktests CI trial run detected that this patch series triggers nvme/018
> failure. I manually applied this series on top of the v7.1-rc4 kernel and
> observed the failure is recreated in stable manner.
> 
> nvme/018 (tr=loop) (unit test NVMe-oF out of range access on a file backend) [failed]
>      runtime  1.208s  ...  1.189s
>      --- tests/nvme/018.out      2025-04-22 13:13:27.738873155 +0900
>      +++ /home/shin/Blktests/blktests/results/nodev_tr_loop/nvme/018.out.bad     2026-05-22 20:57:31.060000000 +0900
>      @@ -1,3 +1,4 @@
>       Running nvme/018
>      +ERROR: nvme read for out of range LBA was not rejected
>       disconnected 1 controller(s)
>       Test complete

Thanks Shin'ichiro for having reported this. I plan to include a fix
when I publish v2 of this patch series.

Bart.

