Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F3606A339
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Gk3Rb8QD;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j6QX9J7P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NzfYm77lyOLl36W7NY5+T2QhwEs8UbFrYopaBE1E02Y=; b=Gk3Rb8QDnFg8jX
	YHYBHzVyN9VdBS2dmukYpEd2vRvfaNajcOcOvV0xwYK9fyy82S1xRJjn8wZar7hrhzblFRi4wr+I1
	kSfbSsh8gcZ+/EKPH3jeY8ew1vYGL+bGuS3uN2sryRRaQfoyC4TLYMbEH3ztk5UCqM0IOMjARNrhP
	BGYe3KhlvGm/Hoct1JRl0AlhwJucWSExknUbtvnPfGKE1qvU0t4GWRGFadlkTK6U4ETRHe+RX4u73
	SNlSt/2PU4qetSsAlRJrDuTbUv032bz5sHAYubyGWJQG9nSrFBsINgOsn2+5eYwEIeFKBmxskWgHW
	IXqRCsD9m1/FspprTkXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPGFg-0000000Bhcl-3Syc;
	Fri, 06 Nov 2026 09:28:52 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPGFZ-0000000BhcP-2p6g
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 09:28:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793957322; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NzfYm77lyOLl36W7NY5+T2QhwEs8UbFrYopaBE1E02Y=;
	b=j6QX9J7Pvvrk/hq8li/5N9BkxFQZy+x7lSwgwQyw04QEA3hAPPHe5Ak+ogsJ6jQ0gmk+LxOHv8HubqmdWSgTZbMUBhV35vPwhKa1CwkeV5NPfApl/jDOhnEKHnlwi9WHg44isb+HcVlpcBvc3rNnr8V0bWBg5nNwRCuLUs4TCts=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEBIoqH_1793957319;
Received: from 30.178.83.72(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEBIoqH_1793957319 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 17:28:40 +0800
Message-ID: <9a0a055d-eb92-4971-875d-157f5cc8047b@linux.alibaba.com>
Date: Fri, 6 Nov 2026 17:28:38 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] nvme-auth: fix data race on ctrl->transaction
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-4-kanie@linux.alibaba.com>
 <58fc6953-b73f-4a0f-b67b-9e5aa6a32db2@suse.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <58fc6953-b73f-4a0f-b67b-9e5aa6a32db2@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_012846_342185_3FAD7AC1 
X-CRM114-Status: GOOD (  14.43  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-24.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/6 15:27, Hannes Reinecke 写道:
> On 11/6/26 2:58 AM, Guixin Liu wrote:
>> nvme_ctrl_auth_work() queues the DH-HMAC-CHAP exchange of every queue
>> on nvme-auth-wq without waiting for them, so multiple
>> nvme_queue_auth_work() instances run concurrently and all increment
>> ctrl->transaction in nvme_queue_auth_work(). The plain increment is a
>> data race, and the lost updates hand the same transaction id to
>> concurrent queues.
>>
>> The controller side only echoes the transaction id within a queue, so
>> the race has no functional impact today, but the increment is still
>> unsynchronized and KCSAN reports it. Use an atomic_t.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/nvme/host/auth.c | 2 +-
>>   drivers/nvme/host/nvme.h | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index 85f005a5efd0..107355ee9ef1 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -765,7 +765,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
>>           return;
>>       }
>>   -    chap->transaction = ctrl->transaction++;
>> +    chap->transaction = (u16)atomic_fetch_inc(&ctrl->transaction);
>>         /* DH-HMAC-CHAP Step 1: send negotiate */
>>       dev_dbg(ctrl->device, "%s: qid %d send negotiate\n",
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 92c048002ecd..1fb676dade12 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -446,7 +446,7 @@ struct nvme_ctrl {
>>       struct nvme_dhchap_queue_context *dhchap_ctxs;
>>       struct nvme_dhchap_key *host_key;
>>       struct nvme_dhchap_key *ctrl_key;
>> -    u16 transaction;
>> +    atomic_t transaction;
>>   #endif
>>       key_serial_t tls_pskid;
>>   
> Hi-speed authentication races ... every day a new surprise.
> Although I wonder why a normal 'atomic_inc_return' isn't sufficient.
Sure, changed in v2.

Best Regards,
Guixin Liu
>
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
>
> Cheers,
>
> Hannes


