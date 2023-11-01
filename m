Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B255FC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Nov 2023 17:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ulAsW2hdQqo1T8F9K4tSpDehUyEzaIFhFt1NrM+7UvY=; b=madfuieCyp9RQI+SdsSOXtUGKI
	HgTfONP3SstBSA4AAxe7jDy7uceomMkGTyQx/xTB6z2MsMRHHc8UJmoFhz2RAvmL4Nr3AIk3QNRPQ
	CxDxTtPwN0jMKaB8t//TfdEr/nD1PhHNljdc5mDPBF3i/ajoIC7s4gzegGUHxA9zk+mKRVt27v11w
	7jclifQYNdwlLiCEgfp/XmMTfmRGa5g9yW/31yXXfuoMptoCrRnAfkUEzl0VuBJ6/RiKV5MFT/BKM
	a3JL8akgJz36zwyo6vFts6wQBJtNlnGZ5NZnHBTPHpptZAAgB32LK58IPSpF4TNotl3x+qGd5Lham
	wO6lJxKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyF1e-007sS3-0N;
	Wed, 01 Nov 2023 17:29:06 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyF1Y-007sRC-1B
	for linux-nvme@lists.infradead.org;
	Wed, 01 Nov 2023 17:29:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F8AA21A3A;
	Wed,  1 Nov 2023 17:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698859738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulAsW2hdQqo1T8F9K4tSpDehUyEzaIFhFt1NrM+7UvY=;
	b=fGlF2TA+weU9blFCcIBgtwhoRJkuHClzKNRyS1M8DU0tm3Qs7TJIXyXgzzssuuom50gawG
	2aVJqH/wS6+/oSm1Wq/IovmLUPx9diWDSaRfVTi5vq0YFtNTaKbEIu45XhSWdDDQGEc9wM
	rGD6JRDeXzL3H9uPW7zFGeUVf9GoLq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698859738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulAsW2hdQqo1T8F9K4tSpDehUyEzaIFhFt1NrM+7UvY=;
	b=FapflsMMo5k7wZ8KXv9HfUen9m70c38c+Aa8KV8UTaH+kNj5ke9RRsIwnKWw9Do5JJsu9L
	z0dXrKaBArdQ5NAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8580A1348D;
	Wed,  1 Nov 2023 17:28:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2od8HdmKQmXnWgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 01 Nov 2023 17:28:57 +0000
Message-ID: <17bd1e06-d959-4709-8ce3-28bfd2e629ef@suse.de>
Date: Wed, 1 Nov 2023 18:28:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20231101103228.136570-1-hare@suse.de>
 <20231101103228.136570-2-hare@suse.de>
 <29253636-b9da-40b0-a217-013800ffc18c@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <29253636-b9da-40b0-a217-013800ffc18c@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231101_102900_554003_4F331992 
X-CRM114-Status: GOOD (  21.04  )
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

On 11/1/23 17:21, Jens Axboe wrote:
> On 11/1/23 4:32 AM, Hannes Reinecke wrote:
>> nvmet_rdma_install_queue() is driven from the ->io_work workqueue
>> function, but will call flush_workqueue() which might trigger
>> ->release_work() which in itself calls flush_work on ->io_work.
>>
>> To avoid that check for pending queue in disconnecting status,
>> and return 'controller busy' until all disconnects are completed.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/rdma.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 4597bca43a6d..eaeb94a9e863 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -1583,8 +1583,18 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
>>   	}
>>   
>>   	if (queue->host_qid == 0) {
>> -		/* Let inflight controller teardown complete */
>> -		flush_workqueue(nvmet_wq);
>> +		struct nvmet_rdma_queue *q;
>> +		int pending = 0;
>> +
>> +		mutex_lock(&nvmet_rdma_queue_mutex);
>> +		list_for_each_entry(q, &nvmet_rdma_queue_list, queue_list) {
>> +			if (q->state == NVMET_RDMA_Q_DISCONNECTING)
>> +				pending++;
>> +		}
>> +		mutex_unlock(&nvmet_rdma_queue_mutex);
>> +		/* Retry for pending controller teardown */
>> +		if (pending)
>> +			return NVME_SC_CONNECT_CTRL_BUSY;
> 
> Not sure if it's worth turning this into a helper since both patches do
> the same thing. Probably not, since you'd need to pass in the mutex and
> state too. In any case, why not just break if you hit
> NVMET_RDMA_Q_DISCONNECTING rather than keep looping? You don't care
> about the exact count, jsut whether it's non-zero or not.
> 
True, that's easier. Will be updating the patches.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


