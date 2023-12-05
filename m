Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44AEC4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 03:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nqTehZqASvH0w82WQkqFGmSV+0gBviKhvVievtguwgU=; b=2wwP57Cu2VACbJTgkkO/wD+Cxm
	NKYMPFHvtGNe2YkRcAZTa006hZ7SAviko8KZ81AFgnxgoIzLV5uS/3+k314so6fUwUJ/GZMxu2W+5
	BYMZPuw9WxIukfQqcbGZxpf5MPqIDyaGMBbaGZyWgnsy9RKBRh57CQ263XqEsjtFr0Onh1cnhpwjZ
	HhRfSKPR9w1SiVWHgjNWLA2FDSbmJ9p8kBHkLKdEO9WKKPIKFtM9gUivQToZVdr4rU51aJFbxPvuf
	9xnTlpOZP8wBdEC/6wqEl9+YcRFa2yzIZisFnCe9RHMnPd5rRhJctoADZiOSyiHrlNg+KNDYlNfu1
	fHoiXl+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAMWK-006AUG-1W;
	Tue, 05 Dec 2023 03:54:52 +0000
Received: from mail-m17222.xmail.ntesmail.com ([45.195.17.222])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAMWC-006ASV-0L
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 03:54:46 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by mail-m3161.qiye.163.com (Hmail) with ESMTPA id B718D440246;
	Tue,  5 Dec 2023 11:54:00 +0800 (CST)
Message-ID: <830cf59b-d1bc-4238-b9e2-29317fc65492@easystack.cn>
Date: Tue, 5 Dec 2023 11:54:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, peng.xiao@easystack.cn
References: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
 <b769ab2f-e4dd-47a2-9e20-af9b16c21dff@grimberg.me>
From: Jirong Feng <jirong.feng@easystack.cn>
In-Reply-To: <b769ab2f-e4dd-47a2-9e20-af9b16c21dff@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTkNMVkwaTk9DHR5JS0IZHlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8c381c806b00a1kurmb718d440246
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgw6SRw*LDEwFRw5KU8CLEoB
	KThPCh1VSlVKTEtKTE9DT09KQ0tPVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFOS0hINwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_195444_345235_77742600 
X-CRM114-Status: GOOD (  22.39  )
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

Hi Sagi,

On the one hand, in multipath's perspective, if one path fails with 
NVME_SC_INVALID_NS, does that mean namespaces in all other paths are 
invalid either? if not, perhaps a retry on another path also makes 
sense. If so, I'm afraid there's no much choice but only io error 
despite of the semantical mismatch...

On the other hand, it seems there's no soft way to disable a namespace 
in nvmet for now. To do so, nvmet needs to differentiate if a namespace 
is disabled or non-existent but it just does not. After that, we might 
need a new nvme status code for disabled namespace, like 
NVME_SC_DISABLED_NS I guess? and translate it to BLK_STS_OFFLINE which 
is considered to be a path error in blk_path_error()?

Regards,

Jirong

在 2023/12/4 16:47, Sagi Grimberg 写道:
>
>> Hi all,
>>
>> I have two storage servers, each of which has an NVMe SSD. Recently 
>> I'm trying nvmet-tcp with DRBD, steps are:
>> 1. Configure DRBD for the two SSDs in two-primary mode, so that each 
>> server can accept IO on DRBD device.
>> 2. On each server, add the corresponding DRBD device to nvmet 
>> subsystem with same device uuid, so that multipath on the host side 
>> can group them into one device(My fabric type is tcp).
>> 3. On client host, nvme discover & connect the both servers, making 
>> sure DM multipath device is generated, and both paths are online.
>> 4. Execute fio randread on DM device continuously.
>> 5. On the server whose multipath status is active, under nvmet 
>> namespace configfs directory, execute "echo 0 > enable" to disable 
>> the namespace.
>> what I expect is that IO can be automatically retried and switched to 
>> the other storage server by multipath, fio goes on. But actually I 
>> see an "Operation not supported" error, and fio fails and stops. I've 
>> also tried iSCSI target, after I delete mapped lun from acl, fio 
>> continues running without any error.
>>
>> My kernel version is 4.18.0-147.5.1(rhel 8.1). After checked out the 
>> kernel code, I found that:
>> 1. On target side, nvmet returns NVME_SC_INVALID_NS to host due to 
>> namespace not found.
>> 2. On host side, nvme driver translates this error to BLK_STS_NOTSUPP 
>> for block layer.
>> 3. Multipath calls for function blk_path_error() to decide whether to 
>> retry.
>> 4. In function blk_path_error(), BLK_STS_NOTSUPP is not considered to 
>> be a path error, so it returns false, multipath will not retry.
>> I've also checked out the master branch from origin, it's almost the 
>> same. In iSCSI target, the process is similar, the only difference is 
>> that TCM_NON_EXISTENT_LUN will be translated to BLK_STS_IOERR, which 
>> is considered to be a path error in function blk_path_error().
>>
>> So my question is as the subject...Is it reasonable to translate 
>> NVME_SC_INVALID_NS to BLK_STS_IOERR just like what iSCSI target does? 
>> Should multipath failover on this error?
>
> The host issued IO to a non-existing namespace. Semantically it is not
> an IO error in the sense that its retryable.
>
> btw, AFAICT TCM_NON_EXISTENT_LUN does return an ILLEGAL_REQUEST however
> the host chooses to ignore the particular additional sense specifically.
>
> While I guess similar behavior could be done in nvme, the question is
> why is a non-existent namespace failure a retryable error? the namespace
> is gone...
>
> Thoughts?
>
> Perhaps what you are seeking is a soft way to disable a namespace based
> on your test case?
>

