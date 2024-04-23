Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6AFC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Apr 2024 03:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nST1RAuG6bTtrUYQjWKA6g3DEUQMy8rR/examRNLCW8=; b=KbB9MAqetAzfkFlmsYgtS0zFaJ
	wD0MMg4oB1g8FCA5q9Rt5K3/nauYJCql+FjnAsuLELQZwVM2gV7ifKXsthYxmC4iBW/VFfaDmMZ7K
	tGjYqihLR3itdzQ0Lfiw4mmkgrC+js2nV2R9PhxGcTn+GmAT4ZMSxSXSgpb6PqBO1SzYCH5XF/tkE
	kOXCrqG6Ie9eN/sV+f0Yw89cGhNRuIPLFPuBO+vp2L0vwBznXh0mIEW651ZLU/ULqneQpShnX3pD3
	JHFAYhlqVxzUXM05/36mBdAZ7zWKORG1tYe4b5Ymg3bqzVnFoHO4NlxboADfhwKtZBPnZ/GRjYr8G
	4OFpvxiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz6do-0000000FoR7-410K;
	Tue, 23 Apr 2024 03:16:20 +0000
Received: from mail-m15594.qiye.163.com ([101.71.155.94])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz6dk-0000000FoQP-2ypN
	for linux-nvme@lists.infradead.org;
	Tue, 23 Apr 2024 03:16:19 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 0CA924C0171;
	Tue, 23 Apr 2024 11:15:37 +0800 (CST)
Message-ID: <cca446d6-19e9-4183-98b5-9f5a7d6d1eac@easystack.cn>
Date: Tue, 23 Apr 2024 11:15:36 +0800
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
 <b6fba9da-7039-4243-8cf7-9a9a33183556@easystack.cn>
 <3f980a50-3405-45bf-8d66-5052930724dc@grimberg.me>
 <5758ea16-62d8-477f-91f2-51fe237df70b@grimberg.me>
From: Jirong Feng <jirong.feng@easystack.cn>
In-Reply-To: <5758ea16-62d8-477f-91f2-51fe237df70b@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQhlIVhpIQ00YSEJLHxpCQlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8f08f3a847022ekunm0ca924c0171
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORw6Kww5TjcwDRNRQxNPHiIU
	LhwaFClVSlVKTEpIQ09JSkhMT0hIVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFISEhCNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_201616_970926_D907194C 
X-CRM114-Status: UNSURE (   5.19  )
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

Sorry for not replying in time.


> Any update on this?
>
Not yet, just too busy on work these days.

I'll find some time in this week.


Thanks for your attention to this case


