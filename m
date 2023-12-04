Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5F2C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 07:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z/4sdXWBk2aZq9daJHxuUYR0ecjQtDCs5aQxdMRY3gk=; b=hSS+liG54rB5usvL9zPWBWWj2t
	WYRpUFpM7LaJKseuCajj/bYxILG1N40waJR99exNBHGIpF485qrUvhir48Pc61TEvCo2ahC98SDgu
	Hq9Cx6Gd1RIIjJnsObj4KvH4/OGb+ZusYN4Um2EhLA7nc+DMDe2Aw3YoRI6R6P+crPztIX05C99qN
	UHDIO4H1m4Xvoy17ZvbhpSQvGbRxHAZVtM0oNKFGrjvgeixz+vWRBvwoRJZtWzxQLT7RKrcBujWtS
	29AgM4uhDBSG+M7H6TTU5OF7katzE+T+35+K3HPq0R0t95+JDYUCkS38a3C4pDH2d8OOYOAJ1TZp1
	Xa7rlV4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA3rM-003CzN-1c;
	Mon, 04 Dec 2023 07:59:20 +0000
Received: from mail-m17236.xmail.ntesmail.com ([45.195.17.236])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA3rJ-003Cys-1Y
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 07:59:19 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by mail-m3161.qiye.163.com (Hmail) with ESMTPA id 9DF69440430;
	Mon,  4 Dec 2023 15:58:38 +0800 (CST)
Message-ID: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
Date: Mon, 4 Dec 2023 15:58:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, peng.xiao@easystack.cn
From: Jirong Feng <jirong.feng@easystack.cn>
Subject: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead of
 BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSU8dVhoaSxlKSx4eTx5IQ1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8c33d61bda00a1kurm9df69440430
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAg6OTo5TjE4Th4XDjZOIQgP
	HU0KCS5VSlVKTEtKTUxNTEpCQk9OVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFISUhINwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231203_235917_752102_0CC1BB54 
X-CRM114-Status: GOOD (  11.02  )
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

Hi all,

I have two storage servers, each of which has an NVMe SSD. Recently I'm 
trying nvmet-tcp with DRBD, steps are:
1. Configure DRBD for the two SSDs in two-primary mode, so that each 
server can accept IO on DRBD device.
2. On each server, add the corresponding DRBD device to nvmet subsystem 
with same device uuid, so that multipath on the host side can group them 
into one device(My fabric type is tcp).
3. On client host, nvme discover & connect the both servers, making sure 
DM multipath device is generated, and both paths are online.
4. Execute fio randread on DM device continuously.
5. On the server whose multipath status is active, under nvmet namespace 
configfs directory, execute "echo 0 > enable" to disable the namespace.
what I expect is that IO can be automatically retried and switched to 
the other storage server by multipath, fio goes on. But actually I see 
an "Operation not supported" error, and fio fails and stops. I've also 
tried iSCSI target, after I delete mapped lun from acl, fio continues 
running without any error.

My kernel version is 4.18.0-147.5.1(rhel 8.1). After checked out the 
kernel code, I found that:
1. On target side, nvmet returns NVME_SC_INVALID_NS to host due to 
namespace not found.
2. On host side, nvme driver translates this error to BLK_STS_NOTSUPP 
for block layer.
3. Multipath calls for function blk_path_error() to decide whether to retry.
4. In function blk_path_error(), BLK_STS_NOTSUPP is not considered to be 
a path error, so it returns false, multipath will not retry.
I've also checked out the master branch from origin, it's almost the 
same. In iSCSI target, the process is similar, the only difference is 
that TCM_NON_EXISTENT_LUN will be translated to BLK_STS_IOERR, which is 
considered to be a path error in function blk_path_error().

So my question is as the subject...Is it reasonable to translate 
NVME_SC_INVALID_NS to BLK_STS_IOERR just like what iSCSI target does? 
Should multipath failover on this error?

Thanks & Best Regards,
Jirong

