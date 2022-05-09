Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6682C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  9 May 2022 21:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0Q8xLzbhQMqYTvPPOURLWOXv7T5rmh0vcwsAE/b1ms=; b=vblaPIDaWjn5/rhD34Gbxh/NFy
	kJnH5PWKtyfJK1cxe4St+ZICvTuIqhI05+yOIUNSvN5RrHt1lUvMPlJ5T5g24g3z+Q6OExIaVqtIm
	2zIGKdYffefc7EY4jVkDdFn4fYR0Ep02RCtSqkKllCsigvH4TvFCnmyqOSCVQwM7ZcZ6szb6EJ+r/
	FZ6ThoVA9We8wK1m/YEnfcv8OdITmNrWJWOC57jOcuw129yDxjMNh7VcqTCMnRvAR7/31MK7QILuE
	A3GgtddEHoHS0sXm1fwJRs/J1YsythN9cdR4+j7MyxiwRSZNMz+qOUyM+Sg8bB06CzKqYjG6yBl55
	fGIobATw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noApj-00GMa9-6C; Mon, 09 May 2022 21:22:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noApg-00GMYz-M7
 for linux-nvme@lists.infradead.org; Mon, 09 May 2022 21:22:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652131338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0Q8xLzbhQMqYTvPPOURLWOXv7T5rmh0vcwsAE/b1ms=;
 b=SkIMCz6FjQwXYlnq2jgztd8+c9RclNYR+wqbbM5CvFWfTANzUamilSG9MCdMUGq/mbTCjO
 2EXl2G1fxnNCvmzA61v238YM3NynXIB0TylCBH5BK8QU/Xco45bkbZQA//KNdHsUCM/se8
 kJPVR0IGS1j3NMFIloZDm11+Z4sovxY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-eI9KUKsfP_mAWxDWQz5Mkg-1; Mon, 09 May 2022 17:22:17 -0400
X-MC-Unique: eI9KUKsfP_mAWxDWQz5Mkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3A86811E78;
 Mon,  9 May 2022 21:22:16 +0000 (UTC)
Received: from [10.22.18.110] (unknown [10.22.18.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3842B111E3E6;
 Mon,  9 May 2022 21:22:13 +0000 (UTC)
Message-ID: <14f3b14b-b228-7758-a556-213cd07f6593@redhat.com>
Date: Mon, 9 May 2022 17:22:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] nvme-host: tcp: do not read from the socket if we are
 performing a reset
To: Sagi Grimberg <sagi@grimberg.me>, Maurizio Lombardi
 <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, cleech@redhat.com
References: <20220415101437.292254-1-mlombard@redhat.com>
 <31923ed3-3d6e-b25c-6971-9d5cdfd4e057@grimberg.me>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <31923ed3-3d6e-b25c-6971-9d5cdfd4e057@grimberg.me>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_142220_838919_947800F2 
X-CRM114-Status: GOOD (  33.13  )
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

On 5/3/22 07:48, Sagi Grimberg wrote:
> 
>> nvme_tcp_io_work() may be scheduled while the controller is resetting,
>> triggering kernel crashes because of invalid memory accesses.
>>
>> general protection fault, probably for non-canonical
>> address 0x82f4228d6e5c6
> 
> Can you please provide more details on what kernel this happened? Does
> this reproduce in upstream kernel?
> 

This is a RHEL 9.0 Beta kernel that has been patched up to about v5.16.

> The current controller teardown flow is supposed to guarantee that
> io_work will not run after a queue is being stopped. See
> nvme_tcp_stop_queue() it shuts down the socket to deny any new
> datagrams to go to the network (or come from the network), restore
> socket calls so data_ready/write_space are not called again, and
> cancels the io_work. New submissions are prevented as the queue
> state clears LIVE.
> 
> So in theory, io_work should not be running in conjunction with
> queue shutdown. Can you explain how it happens to get there?

This bug has been reproduced on a partner's testbed.  We don't
have direct access to the tests they are running but it appears
they are running error insertion tests which aggressively
bring the TCP link up and down, reset the NVMe/TCP controller,
and randomly add/remove NVMe namespaces from the controller
while IO is in progress. With these tests they have been able
to reproduce this bug with our v5.16 based kernel.

I do see a number of patches from v5.17 and v5.18 which
look like they might affect this problem.  Specifically:

63573807b27e0faf8065a28b1bbe1cbfb23c0130 nvme-tcp: fix bogus request completion when failing to send AER
d6d6742772d712ed2238f5071b96baf4924f5fad nvme: fix RCU hole that allowed for endless looping in multipath round robin
a4a6f3c8f61c3cfbda4998ad94596059ad7e4332 nvme-multipath: fix hang when disk goes live over reconnect

This is the testbed that reproduced the RCU hole fixed in d6d6742772d712ed2238f5071b96baf4924f5fad.
We should definitely make sure they are running with that fix before we go any further.

If you agree the above patches are needed we can give them a new v5.18-rc6 based kernel
and ask them to run their test again.

/John

>>
>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>> ---
>>   drivers/nvme/host/tcp.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index ad3a2bf2f1e9..e3ef014bbc0b 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -103,6 +103,7 @@ enum nvme_tcp_queue_flags {
>>       NVME_TCP_Q_ALLOCATED    = 0,
>>       NVME_TCP_Q_LIVE        = 1,
>>       NVME_TCP_Q_POLLING    = 2,
>> +    NVME_TCP_Q_CONNECTING    = 3,
>>   };
>>   enum nvme_tcp_recv_state {
>> @@ -1213,6 +1214,10 @@ static void nvme_tcp_io_work(struct work_struct *w)
>>           bool pending = false;
>>           int result;
>> +        if (unlikely(!test_bit(NVME_TCP_Q_LIVE, &queue->flags) &&
>> +                !test_bit(NVME_TCP_Q_CONNECTING, &queue->flags)))
>> +            return;
> 
> How is this protecting anything? If the queue is torn down we may access
> other freed memory, not just from accessing the sockets.
> 
>> +
>>           if (mutex_trylock(&queue->send_mutex)) {
>>               result = nvme_tcp_try_send(queue);
>>               mutex_unlock(&queue->send_mutex);
>> @@ -1670,6 +1675,8 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
>>       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>>       int ret;
>> +    set_bit(NVME_TCP_Q_CONNECTING, &ctrl->queues[idx].flags);
>> +
>>       if (idx)
>>           ret = nvmf_connect_io_queue(nctrl, idx);
>>       else
>> @@ -1683,6 +1690,7 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
>>           dev_err(nctrl->device,
>>               "failed to connect queue: %d ret=%d\n", idx, ret);
>>       }
>> +    clear_bit(NVME_TCP_Q_CONNECTING, &ctrl->queues[idx].flags);
>>       return ret;
>>   }
> 
> Question, can you tell from your stack dump if this queue is the admin
> queue or I/O queue?
> 
> If this is indeed the admin queue, please check if you have a related
> fix applied:
> 0fa0f99fc84e ("nvme: fix a possible use-after-free in controller reset during load")
> 


