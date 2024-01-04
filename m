Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32B9C47073
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 11:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RdzMuP5pGgViSBvkgp9t59sucejFcI29bMivs0v5nhA=; b=e0Izy73qvIMnP+feQmmbLdlAFZ
	ECb4W/fJdF9OEbzO+S12eTGlWPFgYdVyQi7A1a1szyrREDmiV34Ul9cNcfKmnkHcZFAgaJD2rQZQX
	yji5i4sUqJJ9FycwSH2ln6t+TfNXUBDJIn5p6r5GCb9vSDCHai47wQj5N+mbBbfq/iyixIaWPFjCA
	WiQhSnAJw1UZ8CO+udf3Pge0DIIW26CNXeuElSy32PMvf8qbmx/GAysn7nKFnQvrQkaWAFu92vNFk
	2vHCF06YyGZbVaqdI9kM1N51apcOTDA+KKtkt21ObyfCMl5AST++14mlD1jDsQgdsRNzEdhzvV8vj
	nTvD1wKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLMKq-00DtYD-04;
	Thu, 04 Jan 2024 11:56:28 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLMKk-00DtWU-1Z
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 11:56:24 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d377bd169so196415e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jan 2024 03:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704369375; x=1704974175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdzMuP5pGgViSBvkgp9t59sucejFcI29bMivs0v5nhA=;
        b=r6DLMGOq76QoUipf2X/zFSTBZjBFzx82PQR2jFQoo9aRCk6+8IdTOu1cFCymEznApP
         nFPL1sfb/fEdkcz/5iNkgBFQqP6XUu2ZNcR8R1E/68d6K1hEqyWMOc4z5WB1PfXeR5f2
         W3JcAdDwWVFnuB2F2GB6dmmMXulqhGYf7OMzRwY/FCkyk4BjIe/Jo9omcZB7evhNyw3R
         ihnDbr2ZU50r8u39uHCa+ekTsJ/WhpKP5Z0YyErNBrKTZSRHAlg99RcHsE8Ns4mZif+k
         BWVOD+KdMujay5Ki8kzkGJDkrFXQDXuoVdEkLXdRHI0Q0IWac7QX9ZDTE8pBE90bWuue
         hhew==
X-Gm-Message-State: AOJu0Yx0ixR0lqurISmIbe9SUEx4VYEKO2o2BTzyaE1lv4rUcxjSzOEJ
	zsHLCBSFPXxE7AHVihmOeEXpthWaAdI=
X-Google-Smtp-Source: AGHT+IEc0096Jvww+Ga4xIOHl+BIWGTr43c82/6EY1PcKBnzdjZoFmOiLeqg2czdVHoUVPHExEQc0A==
X-Received: by 2002:a05:600c:3b07:b0:40d:891e:92a7 with SMTP id m7-20020a05600c3b0700b0040d891e92a7mr649686wms.3.1704369374634;
        Thu, 04 Jan 2024 03:56:14 -0800 (PST)
Received: from [10.100.102.14] (46-116-232-10.bb.netvision.net.il. [46.116.232.10])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b0040c3dcc36e6sm5526643wmq.47.2024.01.04.03.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 03:56:14 -0800 (PST)
Message-ID: <53b68337-8370-4deb-9a90-bf5dbb7d6d33@grimberg.me>
Date: Thu, 4 Jan 2024 13:56:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
Content-Language: en-US
To: Jirong Feng <jirong.feng@easystack.cn>, Christoph Hellwig <hch@lst.de>,
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <89b542d3-dedb-4d5c-ad7a-279467d28e51@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_035622_522900_E4C38D1F 
X-CRM114-Status: GOOD (  32.16  )
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



On 1/3/24 12:24, Jirong Feng wrote:
>> OK, can you please check nvme native mpath as well?
> 
> switch to nvme native mpath:
> 
> [root@fjr-vm1 ~]# nvme list-subsys
> nvme-subsys0 - 
> NQN=nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06
> \
>   +- nvme0 tcp traddr=192.168.111.99 trsvcid=4420 live
>   +- nvme1 tcp traddr=192.168.111.111 trsvcid=4420 live
> [root@fjr-vm1 ~]# multipath -ll
> uuid.cf4bb93c-949f-4532-a5c1-b8bd267a4e06 [nvme]:nvme0n1 
> NVMe,Linux,6.6.0-my
> size=209715200 features='n/a' hwhandler='ANA' wp=rw
> |-+- policy='n/a' prio=50 status=optimized
> | `- 0:0:1 nvme0c0n1 0:0 n/a optimized live
> `-+- policy='n/a' prio=50 status=optimized
>    `- 0:1:1 nvme0c1n1 0:0 n/a optimized live
> 
> fio still keeps running without any error, just for this time. (see below)
> 
> host dmesg:
> 
> [Wed Jan  3 07:42:55 2024] nvme nvme0: reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 07:42:55 2024] nvme nvme1: reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 07:43:00 2024] nvme nvme0: reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 07:43:00 2024] nvme nvme1: reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 0
> [Wed Jan  3 07:43:05 2024] nvme nvme0: ANA group 1: optimized.
> [Wed Jan  3 07:43:05 2024] nvme nvme0: creating 4 I/O queues.
> [Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 1
> [Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 2
> [Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 3
> [Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 4
> [Wed Jan  3 07:43:05 2024] nvme nvme0: rescanning namespaces.
> [Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 0
> [Wed Jan  3 07:43:05 2024] nvme nvme0: ANA group 1: optimized.
> [Wed Jan  3 07:43:05 2024] nvme nvme0: creating 4 I/O queues.
> [Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 1
> [Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 2
> [Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 3
> [Wed Jan  3 07:43:05 2024] nvme nvme0: connecting queue 4
> [Wed Jan  3 07:43:05 2024] nvme nvme1: reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 07:43:10 2024] nvme nvme0: reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 07:43:10 2024] nvme nvme1: reschedule traffic based 
> keep-alive timer
> 
> target dmesg:
> 
> [Wed Jan  3 07:41:23 2024] nvmet: ctrl 1 update keep-alive timer for 15 
> secs
> [Wed Jan  3 07:41:33 2024] nvmet: ctrl 1 update keep-alive timer for 15 
> secs
> [Wed Jan  3 07:41:43 2024] nvmet: ctrl 1 update keep-alive timer for 15 
> secs
> [Wed Jan  3 07:41:58 2024] nvmet: ctrl 1 reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 07:42:14 2024] nvmet: ctrl 1 reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 07:42:29 2024] nvmet: ctrl 1 reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 07:42:44 2024] nvmet: ctrl 1 reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 07:43:00 2024] nvmet: ctrl 1 reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 07:43:04 2024] nvmet: fjr add: returning 
> NVME_ANA_PERSISTENT_LOSS
> [Wed Jan  3 07:43:04 2024] nvmet_tcp: failed cmd 0000000034dfe760 id 14 
> opcode 1, data_len: 4096
> [Wed Jan  3 07:43:04 2024] nvmet: got cmd 12 while CC.EN == 0 on qid = 0
> [Wed Jan  3 07:43:04 2024] nvmet_tcp: failed cmd 00000000228b330a id 31 
> opcode 12, data_len: 0
> [Wed Jan  3 07:43:04 2024] nvmet: ctrl 2 start keep-alive timer for 15 secs
> [Wed Jan  3 07:43:04 2024] nvmet: ctrl 1 stop keep-alive
> [Wed Jan  3 07:43:04 2024] nvmet: creating nvm controller 2 for 
> subsystem 
> nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 for NQN nqn.2014-08.org.nvmexpress:uuid:1d8f7c82-9deb-4bc8-8292-5ff32ee3a2be.
> [Wed Jan  3 07:43:04 2024] nvmet: adding queue 1 to ctrl 2.
> [Wed Jan  3 07:43:04 2024] nvmet: adding queue 2 to ctrl 2.
> [Wed Jan  3 07:43:04 2024] nvmet: adding queue 3 to ctrl 2.
> [Wed Jan  3 07:43:04 2024] nvmet: adding queue 4 to ctrl 2.
> [Wed Jan  3 07:43:04 2024] nvmet: fjr add: returning 
> NVME_ANA_PERSISTENT_LOSS
> [Wed Jan  3 07:43:04 2024] nvmet_tcp: failed cmd 00000000d9d3dba9 id 100 
> opcode 1, data_len: 4096
> [Wed Jan  3 07:43:04 2024] nvmet: ctrl 1 start keep-alive timer for 15 secs
> [Wed Jan  3 07:43:04 2024] nvmet: ctrl 2 stop keep-alive
> [Wed Jan  3 07:43:04 2024] nvmet: creating nvm controller 1 for 
> subsystem 
> nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 for NQN nqn.2014-08.org.nvmexpress:uuid:1d8f7c82-9deb-4bc8-8292-5ff32ee3a2be.
> [Wed Jan  3 07:43:04 2024] nvmet: adding queue 1 to ctrl 1.
> [Wed Jan  3 07:43:04 2024] nvmet: adding queue 2 to ctrl 1.
> [Wed Jan  3 07:43:04 2024] nvmet: adding queue 3 to ctrl 1.
> [Wed Jan  3 07:43:04 2024] nvmet: adding queue 4 to ctrl 1.
> [Wed Jan  3 07:43:14 2024] nvmet: ctrl 1 update keep-alive timer for 15 
> secs
> 
>>
>> Can you try returning NVME_SC_CTRL_PATH_ERROR instead of
>> NVME_SC_ANA_PERSISTENT_LOSS ?
> 
> I enabled/disabled again and again, found that fio keeps running for 
> most time, but occasionally(about 10% or less) fails and stops with error.
> 
> fio: io_u error on file /dev/nvme0n1: Input/output error: write 
> offset=100662296576, buflen=4096
> fio: pid=1485, err=5/file:io_u.c:1747, func=io_u error, 
> error=Input/output error
> 
> fio_iops: (groupid=0, jobs=1): err= 5 (file:io_u.c:1747, func=io_u 
> error, error=Input/output error): pid=1485: Wed Jan  3 08:44:09 2024
> 
> host dmesg:
> 
> [Wed Jan  3 08:44:06 2024] nvme nvme1: reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 08:44:07 2024] nvme nvme0: reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 08:44:09 2024] nvme nvme0: connecting queue 0
> [Wed Jan  3 08:44:09 2024] nvme nvme0: ANA group 1: optimized.
> [Wed Jan  3 08:44:09 2024] nvme nvme0: creating 4 I/O queues.
> [Wed Jan  3 08:44:09 2024] nvme nvme0: connecting queue 1
> [Wed Jan  3 08:44:09 2024] nvme nvme0: connecting queue 2
> [Wed Jan  3 08:44:09 2024] nvme nvme0: connecting queue 3
> [Wed Jan  3 08:44:09 2024] nvme nvme0: connecting queue 4
> [Wed Jan  3 08:44:09 2024] nvme nvme0: rescanning namespaces.
> [Wed Jan  3 08:44:09 2024] Buffer I/O error on dev nvme0n1, logical 
> block 0, async page read
> [Wed Jan  3 08:44:09 2024]  nvme0n1: unable to read partition table
> [Wed Jan  3 08:44:09 2024] Buffer I/O error on dev nvme0n1, logical 
> block 6, async page read
> [Wed Jan  3 08:44:11 2024] nvme nvme1: reschedule traffic based 
> keep-alive timer
> [Wed Jan  3 08:44:14 2024] nvme nvme0: reschedule traffic based 
> keep-alive timer
> 
> target dmesg:
> 
> [Wed Jan  3 08:44:08 2024] nvmet: fjr add: returning 
> NVME_SC_CTRL_PATH_ERROR
> [Wed Jan  3 08:44:08 2024] nvmet_tcp: failed cmd 00000000c11e0ae7 id 53 
> opcode 1, data_len: 4096
> [Wed Jan  3 08:44:08 2024] nvmet: fjr add: returning 
> NVME_SC_CTRL_PATH_ERROR
> [Wed Jan  3 08:44:08 2024] nvmet_tcp: failed cmd 00000000e0d12c37 id 54 
> opcode 1, data_len: 4096
> [Wed Jan  3 08:44:08 2024] nvmet: ctrl 2 start keep-alive timer for 15 secs
> [Wed Jan  3 08:44:08 2024] nvmet: ctrl 1 stop keep-alive
> [Wed Jan  3 08:44:08 2024] nvmet: creating nvm controller 2 for 
> subsystem 
> nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 for NQN nqn.2014-08.org.nvmexpress:uuid:1d8f7c82-9deb-4bc8-8292-5ff32ee3a2be.
> [Wed Jan  3 08:44:08 2024] nvmet: adding queue 1 to ctrl 2.
> [Wed Jan  3 08:44:08 2024] nvmet: adding queue 2 to ctrl 2.
> [Wed Jan  3 08:44:08 2024] nvmet: adding queue 3 to ctrl 2.
> [Wed Jan  3 08:44:08 2024] nvmet: adding queue 4 to ctrl 2.
> [Wed Jan  3 08:44:18 2024] nvmet: ctrl 2 update keep-alive timer for 15 
> secs
> [Wed Jan  3 08:44:28 2024] nvmet: ctrl 2 update keep-alive timer for 15 
> secs
> 
> then back to returning NVME_ANA_PERSISTENT_LOSS, fio occasionally fails 
> too. log output are pretty the same.
> 
> then back to dm multipath, for about 50 times enable/disable, fio never 
> fails.
> 

Hmm, its interesting why you fail only in particular ios and not every
io. I suspect that there is a timing issue here.

Looking at the code, I suspect that ios continue being sent to the 
path'd namespace although they shouldn't. The reason is that if we
return an ana error, then the host will re-read the ana log page again
and find the namespace eligible for IO (the action of disable/enable
namespace does not impact the ana log), or,
we return a path error which is not ana error, in this case the host
will not re-read the ana log page, and the namespace will be re-selected
in the next IO (or at least nothing prevents it).

First of all, I think that the most suitable status for nvmet to return
in this case is: NVME_SC_INTERNAL_PATH_ERROR

 From the spec:
Internal Path Error: The command was not completed as the result of a
controller internal error that is specific to the controller processing
the command. Retries for the request function should be based on the
setting of the DNR bit (refer to Figure 92).

In the host code, I don't see any reference to such error status
returned by the controller. So I think we may want to pair it with
something like (this untested hunk):
--
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a88d7bdc5e3..0fb82056ba5f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -97,6 +97,14 @@ void nvme_failover_req(struct request *req)
         if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
                 set_bit(NVME_NS_ANA_PENDING, &ns->flags);
                 queue_work(nvme_wq, &ns->ctrl->ana_work);
+       } else if ((status & 0x7ff) == NVME_SC_INTERNAL_PATH_ERROR) {
+               /*
+                * The ctrl is telling us it is unable to reach the
+                * ns in a way that does not impact the entire ana
+                * group. The only way we can stop sending io to this
+                * specific namespace is by clearing its ready bit.
+                */
+               clear_bit(NVME_NS_READY, &ns->flags);
         }

         spin_lock_irqsave(&ns->head->requeue_lock, flags);
--

Keith, Christoph, do you agree that the host action when it sees an
error status like NVME_SC_INTERNAL_PATH_ERROR it needs to stop sending
IO to the namespace but not change anything related to ana?

