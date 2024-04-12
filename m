Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7D3C04FF6
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Apr 2024 07:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ixzsR+6Hu8G8zmW4NLVo5D4SU3SdCkL2aYrikYBlVjQ=; b=W7xXWiNL4BMlsXO52SOsCb9lSL
	300a7bZRiG6CnqU+DhHHb/smQOJbeRBUdnm7f3rEmDycEai3LmSgWQghi4BvTtS8T3IlPq1dtuH/n
	0NjZj4t8zQqCMIM97gxhlyLQGEwylkwlCLi5eAoH6sy7xs5HAoj4n/B3T4brZKAtwpZzs5PXxWX6q
	YCQfA2vIhIO51vnwqN+HZtd/qJNAiaF5ewtjLBN2jvvupyWoEf5SIkBNA8hpR1kg+tv2Vr+sNTI6E
	d5ehVbgFRejuF/q9s8JDVOKDeBDArqY8UaNl64ZtewTAy7bepDRel7jOyY7OzpYbR4OtHd4YCPZ9R
	og/lHaGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvBj0-0000000FvnI-2igf;
	Fri, 12 Apr 2024 07:53:30 +0000
Received: from mail-m127156.xmail.ntesmail.com ([115.236.127.156])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvBix-0000000FviE-2qiW
	for linux-nvme@lists.infradead.org;
	Fri, 12 Apr 2024 07:53:29 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id CEDCB4C02A5;
	Fri, 12 Apr 2024 15:52:44 +0800 (CST)
Message-ID: <b6fba9da-7039-4243-8cf7-9a9a33183556@easystack.cn>
Date: Fri, 12 Apr 2024 15:52:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, peng.xiao@easystack.cn,
 Christoph Hellwig <hch@lst.de>
References: <a99971dc-9157-4a0f-8fb7-5fa495434b99@grimberg.me>
 <b8cd8de7-9167-4b8f-b255-c022376a7c9d@easystack.cn>
 <dda859d1-41f5-423c-a9e2-900a1573c3a9@easystack.cn>
 <ae40ced9-9f30-4e93-813c-5b94d0667d66@grimberg.me>
 <e27ef3fd-d43c-4dc2-8969-4a0f86d9c64c@easystack.cn>
 <a688834a-99b1-4dd2-b698-c9e54070f78f@grimberg.me>
 <89b542d3-dedb-4d5c-ad7a-279467d28e51@easystack.cn>
 <53b68337-8370-4deb-9a90-bf5dbb7d6d33@grimberg.me>
 <6b345b99-3dd3-4c96-8644-e9b40d387b58@easystack.cn>
 <b3821176-b6f6-4617-92c9-ce8ad9f1118e@grimberg.me>
 <20240131062526.GA16177@lst.de>
 <08b936ff-10d0-48d8-aacd-6ae1e2659600@easystack.cn>
 <68f99d6e-b79f-42a9-bb19-ece27d35dfa6@grimberg.me>
 <d0d87635-839a-43bb-89e4-9ff853d0a878@easystack.cn>
 <bf0752e1-8fb9-45f6-9cf2-e88716952fe6@grimberg.me>
From: Jirong Feng <jirong.feng@easystack.cn>
In-Reply-To: <bf0752e1-8fb9-45f6-9cf2-e88716952fe6@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCThlNVkwfSRoYTE5KSk5DSVUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8ed14b6c98022ekunmcedcb4c02a5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRA6Hzo5ETc0CS8ZDRM#AjE3
	ODcaFA1VSlVKTEpJQktDSE1OSEJDVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFITEtPNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240412_005328_004032_FE5CECB9 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
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

> So essentially there is no need for the host side patch? interesting. 
> Are you sure?

At least no failure is observed in a newer version(6.6.0) of kernel so 
far. I can only tell that I've tested it for hundreds of times.

In addition, I've got some scripts to enable/disable it continually, we 
can observe it a few more days.


> Can you please also try with mpath iopolicy=round-robin?
All my previous tests were done with round-robin. I retested again today 
both round-robin and numa, the results are still the same.


> I'm asking because I cannot understand what is preventing this path 
> from being selected again and
> again for I/O....

Perhaps we need to dive into the code of old 
version(4.18.0-147.3.1.el8_1) and see what's different?

Or should I try apply the host side patch to the old version and test again?


Thanks


