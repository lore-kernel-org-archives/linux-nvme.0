Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B13FC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0g7+jnT+WUnRwoXkl7H7rCY608j8ASuPqliAkA5nnnA=; b=GqBWleHHvTSmyzBoDK1GhxXcgL
	H8EoqqFzZByWmHbn/0PICPKrmxeO8MBCZxB8RMNmSJQXc3XX4F2yyEVI7Y2yMDVn8vKsTJIQYDj5+
	jAHvp91MIxQNb+zYH7D8ZTIimANmmleJ9HKU08W+0BlIhsIgFpzAzzGVR0hdbeURBo3tQFQWIQ2WC
	cIyu6oAAYcIk+v7FHnnWzljmOFScIm7s1Uv0CVtxogKElqF9KxU5vilO2aZ+1JNOw2OwWocyNQSCa
	qoGNqYbOtkfIN25mW63DUIk09qaQ7V/RcFwye0PbxSU3W+GBIu8GnDUpU5e5lidpiYFPlws3rGQhu
	Nxx2oBsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHjrb-00AooO-06;
	Mon, 25 Dec 2023 12:15:19 +0000
Received: from mail-m6013.netease.com ([210.79.60.13])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHjrX-00Aono-3B
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 12:15:17 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id CF3234C0123;
	Mon, 25 Dec 2023 20:14:35 +0800 (CST)
Message-ID: <b8cd8de7-9167-4b8f-b255-c022376a7c9d@easystack.cn>
Date: Mon, 25 Dec 2023 20:14:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
 peng.xiao@easystack.cn
References: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
 <ZW6pJAm9wgqj1HEW@kbusch-mbp> <20231205044035.GA28685@lst.de>
 <08f2c221-cca7-4d34-ab78-157d4eae4f68@grimberg.me>
 <945fa17c-f1d0-4928-972b-da29ca5c95ec@easystack.cn>
 <a99971dc-9157-4a0f-8fb7-5fa495434b99@grimberg.me>
From: Jirong Feng <jirong.feng@easystack.cn>
In-Reply-To: <a99971dc-9157-4a0f-8fb7-5fa495434b99@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGR1OVkJLHUMfQ0oYTBhJGFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSkxKT05PVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8ca0e5fcf4022ekunmcf3234c0123
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OVE6GRw5TDcrTC5PGiMDTj9C
	ChUKCgJVSlVKTEtITktNT0xNTU1LVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFKQk1NNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_041516_232714_933CF816 
X-CRM114-Status: UNSURE (   5.67  )
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


>
> Did you test the patch I sent in one of the replies before?
>
not yet, I'll test it tomorrow ASAP.

thanks


