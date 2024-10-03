Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC2ACF8549
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 00:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oh0VWAuDQnXtvqrOgW+mdNBpO1eMzfyHq16DUHZnGIc=; b=m0z4H3yeMYPCnVAOZSqLne0xMT
	cVkIV05hMrrMA9VZ2ADqO45K+X/h/ArLunm2tWtDXaKKs4Nw/ahZRRw6QXEGi8tw4eWz40h6YcKGF
	2rI678KJ+4Mw0SN7M9eaL/XAb4Nd25FPxQwX+YC5OcHZ2AyCKdpAzvemrZd949v3NXyJbYfAhnsxT
	qbaxxYOKkDy3EZpjVzsrNGzHeNkHvM0KCXoueQlf0gvRWGc4i443WTIIDWBXqF+WMyJUhH5yybcrR
	LO/WJu2QRd5exBP8bO5ms+UsgYyD39SS1kl5ZEzHNiHKUxQ3AREHtFTQrwQU72bXsSdk9ii7ASJfp
	JWa9KcpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw9aJ-00000007r1P-42ie;
	Thu, 03 Oct 2024 00:20:47 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw9aH-00000007r0b-28il
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 00:20:46 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XJslc5hknzlgMW9;
	Thu,  3 Oct 2024 00:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1727914839; x=1730506840; bh=Oh0VWAuDQnXtvqrOgW+mdNBp
	O1eMzfyHq16DUHZnGIc=; b=q4Q10RP3cvtsde0sb2ibCa9e909lRJus9XrjroPK
	B+Vo8AEO2LHR4T59I2Vw8U7LuErXXaOZ3yQsZP4gHblTnU6tXSqsVRiXydJ7yCe0
	sGYpf69OhfMjsorv6slK6lRQXdgOKgUVgPoAHHWdk1O3+QW8Ogp8ku5bFmOnthYC
	oR2lvZRouL6esIoM3OM/Wr1bdJ+1nH5ZUYqTpkoKZLFYRN7Df7JUld7g2e/yiYag
	TQFHmM8W3jpPk/XHPMOnDjN52iYxzDWmChJP+gDGwkwrjCM2EufkemQO4zPUG+Ap
	pZK6LSrTtVI7ZPgT54P0IEFiPSWQH6iz6f8JUn2Om1hmmg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LlQiNrpWlL36; Thu,  3 Oct 2024 00:20:39 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XJslN5L2NzlgVnY;
	Thu,  3 Oct 2024 00:20:32 +0000 (UTC)
Message-ID: <052e0503-eb3f-4345-b366-1c0a2c4604a5@acm.org>
Date: Wed, 2 Oct 2024 17:20:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, hare@suse.de, sagi@grimberg.me, martin.petersen@oracle.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 asml.silence@gmail.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org,
 gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240930181305.17286-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_172045_600383_10FD28EB 
X-CRM114-Status: GOOD (  12.06  )
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

On 9/30/24 11:13 AM, Kanchan Joshi wrote:
> Another spin to incorporate the feedback from LPC and previous
> iterations. The series adds two capabilities:
> - FDP support at NVMe level (patch #1)
> - Per-io hinting via io_uring (patch #3)
> Patch #2 is needed to do per-io hints.
> 
> The motivation and interface details are present in the commit
> descriptions.

Something is missing from the patch descriptions. What is the goal
of this patch series? Is the goal to support FDP in filesystems in
the kernel, is the goal to support filesystems implemented in user
space or perhaps something else? I think this should be mentioned in
the cover letter.

Thanks,

Bart.


