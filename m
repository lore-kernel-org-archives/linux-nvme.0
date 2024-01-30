Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FC7C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AL5EjAyp7LBwDvISzY1S1XsHQOptZGqvKVbfB/+sN9Y=; b=B+YcPNbrfkxoEyA3OMrWUavCZY
	SJWO/iIAy/BnKaSYoYiCQWa1n60vcq9mj3Lw4/aEB+azBxUP910TSNqrodx5X49zlNi9FiJpF0DoS
	VbJ88/Y39BXh7sM9+4n4ohDZCsYbs4k1WXw+2bxOWVyyfn5mcNn5nozjnXPzG0QRsrW4uNvpoC0Xm
	U25GeLOy4DmgkW+cl+c0yL16ZIlEBRIc0xQKhL7N95bIQeMa4zXIsqib3zJcbRxYi1m0xwT5MBpQS
	Cl9QdtNC9GVg7x4xvr5HR9+tPQ/SHcTW12w3uppvS2WmabO5u8Uqh43W3f6G+BEJl9kzpVyabXJpl
	vuNGlA8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUkXo-0000000Fxzq-11Lx;
	Tue, 30 Jan 2024 09:36:40 +0000
Received: from mail-m15566.qiye.163.com ([101.71.155.66])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUkXk-0000000FxyI-2znn
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 09:36:39 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 7C3534C0233;
	Tue, 30 Jan 2024 17:36:01 +0800 (CST)
Message-ID: <6b345b99-3dd3-4c96-8644-e9b40d387b58@easystack.cn>
Date: Tue, 30 Jan 2024 17:36:01 +0800
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
 <b8cd8de7-9167-4b8f-b255-c022376a7c9d@easystack.cn>
 <dda859d1-41f5-423c-a9e2-900a1573c3a9@easystack.cn>
 <ae40ced9-9f30-4e93-813c-5b94d0667d66@grimberg.me>
 <e27ef3fd-d43c-4dc2-8969-4a0f86d9c64c@easystack.cn>
 <a688834a-99b1-4dd2-b698-c9e54070f78f@grimberg.me>
 <89b542d3-dedb-4d5c-ad7a-279467d28e51@easystack.cn>
 <53b68337-8370-4deb-9a90-bf5dbb7d6d33@grimberg.me>
From: Jirong Feng <jirong.feng@easystack.cn>
In-Reply-To: <53b68337-8370-4deb-9a90-bf5dbb7d6d33@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGU9MVk1PHh1JTEpNQktIHlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8d59b9be71022ekunm7c3534c0233
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCI6TSo4MDcxEjoSLi8JPko4
	TwNPC0NVSlVKTEtNTUtMSE1KQkhCVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFITExCNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_013637_001151_D285CB00 
X-CRM114-Status: UNSURE (   7.52  )
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

Now I suspect that my testcase is inappropriate for nvme native multipath.
according to the base spec, chapter 2.4.1, nvme native multipath aims at
accessing a certain namespace through multiple paths, not how to group
different namespaces into one device. Therefore, in fabrics' case, a
namespace must belong to one subsystem on a single target server. Looking at
the latest code of nvme driver host, the host does refuse those namespaces
reporting the same uuid on two different subsystems(in function
nvme_global_check_duplicate_ids), which is exactly what I'm doing. The
testcase seems to be a misuse of nvme native multipath.

However, the testcase is pretty reasonable for dm-mpath. In a cloud 
scenario,
we usually need a volume to be synced and exposed on multiple target servers
for high availability reason. dm-mpath can do that, only if we choose 
group by
serial. Namespaces from different subsystems reporting different uuid, but
with same serial, can be recognized as one device by dm-mpath.

The only problem seems just to be the returning code for dm-mpath to
failover. native mpath should not encounter this case.

please correct me if I'm wrong :)

Thanks

