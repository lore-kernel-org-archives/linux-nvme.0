Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DE7C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 11:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=imgaJFtZRTEuhQUM92WPY8yixJ/Q3/X9nJtuM84gaqI=; b=LgoukbveyhDF6kLfzGKM6TiaKD
	eUmx9iIqOYzP4GIk+dA3KfchseA6b790mYDr9fkmZ0blnQfD1topVr+Ia/NtC6cNEIFPgHz+IWCay
	LIutizd0QoiZEZV1gY9RoBwtn11Y573x691FdjePKJSob6YPLbvbu8MPoQRKdQiJw94FAWfNeMi5E
	QNIkXJSLQ/Bm42iY+8k3c7s5C34J4bsrwHJaoQHgQfzcU4P59Oh9x+1Hf/Nv30bScGSOaNE/pR+wm
	B8rV4tviPMKnUplQcTaJG4yOPd6qtY2LPwx+yd6677iyt+wRSwq1xpgS4XERQIrDcWWphUtE+9HEf
	CuFOVqCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1PHQ-00000002TLG-3ZGj;
	Mon, 29 Apr 2024 11:34:44 +0000
Received: from mail-m17215.xmail.ntesmail.com ([45.195.17.215])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1PHN-00000002TJR-1BgE
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 11:34:43 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 54D3F4C021D;
	Mon, 29 Apr 2024 19:34:07 +0800 (CST)
Message-ID: <8ef75533-3dc0-46c8-be27-504e5cd9a234@easystack.cn>
Date: Mon, 29 Apr 2024 19:34:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix nvme status code when namespace is disabled
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20240428092540.77366-1-sagi@grimberg.me>
From: Jirong Feng <jirong.feng@easystack.cn>
In-Reply-To: <20240428092540.77366-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSUgYVk9IGB4aTh5NGUxIGFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8f29a23566022ekunm54d3f4c021d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MC46PRw6KTc8Kwk0MjkLLFE0
	TjwwCTVVSlVKTEpPSEJLT09MQ0NMVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFKT0xONwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_043441_662729_E4E1B6B3 
X-CRM114-Status: UNSURE (   5.91  )
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

> Jirong Feng, can you please re-run the test as requested and verify
> that the I/O error goes away. If so, please reply with your "Tested-by"
> tag.

Having re-runned the test basing on kernel 6.9.0-rc5, the error does go 
away.

Tested-by: Jirong Feng <jirong.feng@easystack.cn>



