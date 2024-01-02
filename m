Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58915C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 10:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UEjE5NtQBpmeIkehudOHDQn/LB6dKIks9AYaI0fykDQ=; b=OlRZ6AVh/TUog/DLTyXNXjWs8e
	8xQBRpU+gnp6UdTTHBzd/qRht2CprKKeAjGLP5xYovj0Oz8nqmNsOTINgb+3OiC0FQkKDdkoI7/Sf
	92OT4V5/natiSBBv6nqXkduOtUEW3zXsCQEpSSuNJtwsGRGdaVm2Ap6Ag0iK/A0gM4D2P7QL4VHUg
	rf2HHmJjeDnRCRZ5Uxz6ffLwWlOv2N8etm1f91DbgWba+xMppvyVe5viOSxYTZLrdmez4urF2g3xX
	6yojU7F0M0SyEgAOhPQ6nN3wfO0koUhkkfCceGe0mLHpSVk4k47Ea0Sq5hOyH6mYn3qtk1lEgMj81
	koBtPtYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKc6O-007bju-2d;
	Tue, 02 Jan 2024 10:34:28 +0000
Received: from mail-m17219.xmail.ntesmail.com ([45.195.17.219])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKc6M-007bhT-20
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 10:34:28 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id DA67E4C02C2;
	Tue,  2 Jan 2024 18:33:45 +0800 (CST)
Message-ID: <e27ef3fd-d43c-4dc2-8969-4a0f86d9c64c@easystack.cn>
Date: Tue, 2 Jan 2024 18:33:45 +0800
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
From: Jirong Feng <jirong.feng@easystack.cn>
In-Reply-To: <ae40ced9-9f30-4e93-813c-5b94d0667d66@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSRpCVkJNGUkaHxoaT0lLGVUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8cc9bc8c36022ekunmda67e4c02c2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OD46NRw5DDc2Hx8#EiwvIUs1
	CjpPChNVSlVKTEtPSkJKTUlNTU5KVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFISElKNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_023426_863669_7727C3D7 
X-CRM114-Status: UNSURE (   6.56  )
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

in function nvmet_subsys_nsid_exists() added in the patch, remove the 
'\n' from line `if (sprintf(name, "%u\n", nsid) <= 0)`, the patch works 
exactly as what I expect, fio keeps running and multipath does failover.

> Can you paste the log output (host and controller)?
>
host:

[Tue Jan  2 10:22:11 2024] print_req_error: 8 callbacks suppressed
[Tue Jan  2 10:22:11 2024] print_req_error: I/O error, dev nvme1n1, 
sector 186257448 flags ca01
[Tue Jan  2 10:22:11 2024] device-mapper: multipath: Failing path 259:1.
[Tue Jan  2 10:22:11 2024] nvme nvme1: rescanning namespaces.
[Tue Jan  2 10:22:11 2024] device-mapper: multipath round-robin: 
repeat_count > 1 is deprecated, using 1 instead

target:

[Tue Jan  2 10:21:57 2024] nvmet: ctrl 1 update keep-alive timer for 15 secs
[Tue Jan  2 10:22:12 2024] nvmet: jirong add: returning 
NVME_ANA_PERSISTENT_LOSS
[Tue Jan  2 10:22:12 2024] nvmet_tcp: failed cmd 00000000de551a59 id 37 
opcode 1, data_len: 4096
[Tue Jan  2 10:22:12 2024] nvmet: ctrl 1 reschedule traffic based 
keep-alive timer
[Tue Jan  2 10:22:17 2024] nvmet: ctrl 1 update keep-alive timer for 15 secs



