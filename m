Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F927C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 10:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8uxeSvumdl9iZJTL+4+Q3IFBR1yRggXhRDey+LZVcmo=; b=XoQXJRlBQzIAxkMS/M8P+kZRAx
	tOiobtATJ6xoxNHnJ/E4jn15dNFjib+s94ecIMzBlkZJNDfoiHDRqljIgFcsMZT+MFcPg0yW+4ZDZ
	mKZQE4JO7Zn4x8O7e+0n65UHt7fhL81F5rBDdCBOaifGIwKTv1bgDlnN27/Mohva70aRwk9WnKZMY
	JvpzySFKa1bnzIZyaurnguwl8lBWs4yvNUPeDsFe/XHna6CaM7iL2vogx/90YHCOUSYe8i/I3GEwi
	squP7XvxgYLeQKi4662trxSknBZubRBSiQFXx2JmsOQQhtP3NmRuUVKS1MrljcA7pNADcgulRvG4v
	NIo4QYoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKyQd-00AO89-18;
	Wed, 03 Jan 2024 10:24:51 +0000
Received: from mail-m25492.xmail.ntesmail.com ([103.129.254.92])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKyQW-00AO5Z-0q
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 10:24:47 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 689A274023A;
	Wed,  3 Jan 2024 18:24:10 +0800 (CST)
Message-ID: <89b542d3-dedb-4d5c-ad7a-279467d28e51@easystack.cn>
Date: Wed, 3 Jan 2024 18:24:09 +0800
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
From: Jirong Feng <jirong.feng@easystack.cn>
In-Reply-To: <a688834a-99b1-4dd2-b698-c9e54070f78f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSk1IVk8eHkhNTRpMHx8fGFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8cceda20580236kunm689a274023a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mwg6PTo*ATc#NR43TjwzARQ*
	HxMwCRxVSlVKTEtPSUxMT05KSEtKVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFKS0lNTjcG
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_022444_541065_86F61D1A 
X-CRM114-Status: UNSURE (   9.94  )
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

> OK, can you please check nvme native mpath as well?

switch to nvme native mpath:

[root@fjr-vm1 ~]# nvme list-subsys
nvme-subsys0 - 
NQN=nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06
\
  +- nvme0 tcp traddr=192.168.111.99 trsvcid=4420 live
  +- nvme1 tcp traddr=192.168.111.111 trsvcid=4420 live
[root@fjr-vm1 ~]# multipath -ll
uuid.cf4bb93c-949f-4532-a5c1-b8bd267a4e06 [nvme]:nvme0n1 NVMe,Linux,6.6.0-my
size=209715200 features='n/a' hwhandler='ANA' wp=rw
|-+- policy='n/a' prio=50 status=optimized
| `- 0:0:1 nvme0c0n1 0:0 n/a optimized live
`-+- policy='n/a' prio=50 status=optimized
   `- 0:1:1 nvme0c1n1 0:0 n/a optimized live

fio still keeps running without any error, just for this time. (see below)

host dmesg:

[Wed Jan  3 07:42:55 2024] nvme nvme0: reschedule traffic based 
keep-alive timer
[Wed Jan  3 07:42:55 2024] nvme nvme1: reschedule traffic based 
keep-alive timer
[Wed Jan  3 07:43:00 2024] nvme nvme0: reschedule traffic based 
keep-alive timer
[Wed Jan  3 07:43:00 2024] nvme nvme1: reschedule traffic based 
keep-alive timer
[Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 0
[Wed Jan  3 07:43:05 2024] nvme nvme0: ANA group 1: optimized.
[Wed Jan  3 07:43:05 2024] nvme nvme0: creating 4 I/O queues.
[Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 1
[Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 2
[Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 3
[Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 4
[Wed Jan  3 07:43:05 2024] nvme nvme0: rescanning namespaces.
[Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 0
[Wed Jan  3 07:43:05 2024] nvme nvme0: ANA group 1: optimized.
[Wed Jan  3 07:43:05 2024] nvme nvme0: creating 4 I/O queues.
[Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 1
[Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 2
[Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 3
[Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 4
[Wed Jan  3 07:43:05 2024] nvme nvme1: reschedule traffic based 
keep-alive timer
[Wed Jan  3 07:43:10 2024] nvme nvme0: reschedule traffic based 
keep-alive timer
[Wed Jan  3 07:43:10 2024] nvme nvme1: reschedule traffic based 
keep-alive timer

target dmesg:

[Wed Jan  3 07:41:23 2024] nvmet: ctrl 1 update keep-alive timer for 15 secs
[Wed Jan  3 07:41:33 2024] nvmet: ctrl 1 update keep-alive timer for 15 secs
[Wed Jan  3 07:41:43 2024] nvmet: ctrl 1 update keep-alive timer for 15 secs
[Wed Jan  3 07:41:58 2024] nvmet: ctrl 1 reschedule traffic based 
keep-alive timer
[Wed Jan  3 07:42:14 2024] nvmet: ctrl 1 reschedule traffic based 
keep-alive timer
[Wed Jan  3 07:42:29 2024] nvmet: ctrl 1 reschedule traffic based 
keep-alive timer
[Wed Jan  3 07:42:44 2024] nvmet: ctrl 1 reschedule traffic based 
keep-alive timer
[Wed Jan  3 07:43:00 2024] nvmet: ctrl 1 reschedule traffic based 
keep-alive timer
[Wed Jan  3 07:43:04 2024] nvmet: fjr add: returning 
NVME_ANA_PERSISTENT_LOSS
[Wed Jan  3 07:43:04 2024] nvmet_tcp: failed cmd 0000000034dfe760 id 14 
opcode 1, data_len: 4096
[Wed Jan  3 07:43:04 2024] nvmet: got cmd 12 while CC.EN == 0 on qid = 0
[Wed Jan  3 07:43:04 2024] nvmet_tcp: failed cmd 00000000228b330a id 31 
opcode 12, data_len: 0
[Wed Jan  3 07:43:04 2024] nvmet: ctrl 2 start keep-alive timer for 15 secs
[Wed Jan  3 07:43:04 2024] nvmet: ctrl 1 stop keep-alive
[Wed Jan  3 07:43:04 2024] nvmet: creating nvm controller 2 for 
subsystem 
nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 
for NQN 
nqn.2014-08.org.nvmexpress:uuid:1d8f7c82-9deb-4bc8-8292-5ff32ee3a2be.
[Wed Jan  3 07:43:04 2024] nvmet: adding queue 1 to ctrl 2.
[Wed Jan  3 07:43:04 2024] nvmet: adding queue 2 to ctrl 2.
[Wed Jan  3 07:43:04 2024] nvmet: adding queue 3 to ctrl 2.
[Wed Jan  3 07:43:04 2024] nvmet: adding queue 4 to ctrl 2.
[Wed Jan  3 07:43:04 2024] nvmet: fjr add: returning 
NVME_ANA_PERSISTENT_LOSS
[Wed Jan  3 07:43:04 2024] nvmet_tcp: failed cmd 00000000d9d3dba9 id 100 
opcode 1, data_len: 4096
[Wed Jan  3 07:43:04 2024] nvmet: ctrl 1 start keep-alive timer for 15 secs
[Wed Jan  3 07:43:04 2024] nvmet: ctrl 2 stop keep-alive
[Wed Jan  3 07:43:04 2024] nvmet: creating nvm controller 1 for 
subsystem 
nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 
for NQN 
nqn.2014-08.org.nvmexpress:uuid:1d8f7c82-9deb-4bc8-8292-5ff32ee3a2be.
[Wed Jan  3 07:43:04 2024] nvmet: adding queue 1 to ctrl 1.
[Wed Jan  3 07:43:04 2024] nvmet: adding queue 2 to ctrl 1.
[Wed Jan  3 07:43:04 2024] nvmet: adding queue 3 to ctrl 1.
[Wed Jan  3 07:43:04 2024] nvmet: adding queue 4 to ctrl 1.
[Wed Jan  3 07:43:14 2024] nvmet: ctrl 1 update keep-alive timer for 15 secs

>
> Can you try returning NVME_SC_CTRL_PATH_ERROR instead of
> NVME_SC_ANA_PERSISTENT_LOSS ?

I enabled/disabled again and again, found that fio keeps running for 
most time, but occasionally(about 10% or less) fails and stops with error.

fio: io_u error on file /dev/nvme0n1: Input/output error: write 
offset=100662296576, buflen=4096
fio: pid=1485, err=5/file:io_u.c:1747, func=io_u error, 
error=Input/output error

fio_iops: (groupid=0, jobs=1): err= 5 (file:io_u.c:1747, func=io_u 
error, error=Input/output error): pid=1485: Wed Jan  3 08:44:09 2024

host dmesg:

[Wed Jan  3 08:44:06 2024] nvme nvme1: reschedule traffic based 
keep-alive timer
[Wed Jan  3 08:44:07 2024] nvme nvme0: reschedule traffic based 
keep-alive timer
[Wed Jan  3 08:44:09 2024] nvme nvme0: connecting queue 0
[Wed Jan  3 08:44:09 2024] nvme nvme0: ANA group 1: optimized.
[Wed Jan  3 08:44:09 2024] nvme nvme0: creating 4 I/O queues.
[Wed Jan  3 08:44:09 2024] nvme nvme0: connecting queue 1
[Wed Jan  3 08:44:09 2024] nvme nvme0: connecting queue 2
[Wed Jan  3 08:44:09 2024] nvme nvme0: connecting queue 3
[Wed Jan  3 08:44:09 2024] nvme nvme0: connecting queue 4
[Wed Jan  3 08:44:09 2024] nvme nvme0: rescanning namespaces.
[Wed Jan  3 08:44:09 2024] Buffer I/O error on dev nvme0n1, logical 
block 0, async page read
[Wed Jan  3 08:44:09 2024]  nvme0n1: unable to read partition table
[Wed Jan  3 08:44:09 2024] Buffer I/O error on dev nvme0n1, logical 
block 6, async page read
[Wed Jan  3 08:44:11 2024] nvme nvme1: reschedule traffic based 
keep-alive timer
[Wed Jan  3 08:44:14 2024] nvme nvme0: reschedule traffic based 
keep-alive timer

target dmesg:

[Wed Jan  3 08:44:08 2024] nvmet: fjr add: returning NVME_SC_CTRL_PATH_ERROR
[Wed Jan  3 08:44:08 2024] nvmet_tcp: failed cmd 00000000c11e0ae7 id 53 
opcode 1, data_len: 4096
[Wed Jan  3 08:44:08 2024] nvmet: fjr add: returning NVME_SC_CTRL_PATH_ERROR
[Wed Jan  3 08:44:08 2024] nvmet_tcp: failed cmd 00000000e0d12c37 id 54 
opcode 1, data_len: 4096
[Wed Jan  3 08:44:08 2024] nvmet: ctrl 2 start keep-alive timer for 15 secs
[Wed Jan  3 08:44:08 2024] nvmet: ctrl 1 stop keep-alive
[Wed Jan  3 08:44:08 2024] nvmet: creating nvm controller 2 for 
subsystem 
nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 
for NQN 
nqn.2014-08.org.nvmexpress:uuid:1d8f7c82-9deb-4bc8-8292-5ff32ee3a2be.
[Wed Jan  3 08:44:08 2024] nvmet: adding queue 1 to ctrl 2.
[Wed Jan  3 08:44:08 2024] nvmet: adding queue 2 to ctrl 2.
[Wed Jan  3 08:44:08 2024] nvmet: adding queue 3 to ctrl 2.
[Wed Jan  3 08:44:08 2024] nvmet: adding queue 4 to ctrl 2.
[Wed Jan  3 08:44:18 2024] nvmet: ctrl 2 update keep-alive timer for 15 secs
[Wed Jan  3 08:44:28 2024] nvmet: ctrl 2 update keep-alive timer for 15 secs

then back to returning NVME_ANA_PERSISTENT_LOSS, fio occasionally fails 
too. log output are pretty the same.

then back to dm multipath, for about 50 times enable/disable, fio never 
fails.


