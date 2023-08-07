Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC48EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 07:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GXPGgKu/DS2nFDtUn2rsL6EDw9ijUHYJPGo6tg5R91c=; b=jM9zawae03TaWr4EQp4j/YrahL
	m9bWU7FpzJhrxf69yCaQ3K4kUe/rXB9YsUM1sQwqGuw1m+zOQQQAHdukAKumBLixqxYf7B5z5a5kQ
	gi51oXmKr6bvDe0Dbjzq5ON7Q7IUoVorPvOVF9Xg+Bw8hFCmkQWIIkbyuluf9PYJ/zb6W+/RO04ba
	fhVfBoJuvYsxKwg+56eI/6AZnV1WedGxl8RDQM0aQcpaHK+BiLOpMWmovGjKr3X9dewMIj5ml0Tdt
	C5AxPPMdUpjc6Bu/abutySzA5ztgZfuxYt42XfcclWDxr0an3WxJqytABYJLIOyXF0Ws4KgTCwyx/
	ZhoXIbcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuab-00GMOE-2F;
	Mon, 07 Aug 2023 07:23:41 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuaY-00GMNZ-1o
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 07:23:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27EED2189B;
	Mon,  7 Aug 2023 07:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691393017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXPGgKu/DS2nFDtUn2rsL6EDw9ijUHYJPGo6tg5R91c=;
	b=jBCyJRvVZHwGlQMiOmZ83kGQdsDwkhkoYr4zzang1E7SEewVmJWBdOw1oG/NmCErRrTOFR
	Exx74qhRNftHhhEb3lpv8/5AXpue5jCsE/8S1drDmHmdS4yKMQE3IrSKlhOj83E+5MS0q/
	otHR5B9VEVaySbE3B4EBfrmriY9NoLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691393017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXPGgKu/DS2nFDtUn2rsL6EDw9ijUHYJPGo6tg5R91c=;
	b=suFc4kkFq6lKkwGVd7MCriH7EsvAmtoMTTrT/3lq7RxJi6KEFQAfa4pCmT6B7F9rPDBL3s
	ugzlp6zVq3we3VDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CF8013910;
	Mon,  7 Aug 2023 07:23:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xC8xEPib0GRrYQAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 07 Aug 2023 07:23:36 +0000
Message-ID: <b4fce841-c9b5-399f-458f-7ffa05798374@suse.de>
Date: Mon, 7 Aug 2023 09:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 07/14] nvme/tcp: allocate socket file
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-8-hare@suse.de>
 <28c702b1-57f8-d3b9-9027-e6220d81aefe@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <28c702b1-57f8-d3b9-9027-e6220d81aefe@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_002338_742840_FEC5BECC 
X-CRM114-Status: GOOD (  17.78  )
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

On 8/7/23 09:15, Sagi Grimberg wrote:
> 
> 
> On 8/3/23 13:50, Hannes Reinecke wrote:
>> When using the TLS upcall we need to allocate a socket file such
>> that the userspace daemon is able to use the socket.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/tcp.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 9ce417cd32a7..c3b3b938c0f9 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1338,7 +1338,9 @@ static void nvme_tcp_free_queue(struct nvme_ctrl 
>> *nctrl, int qid)
>>       }
>>       noreclaim_flag = memalloc_noreclaim_save();
>> -    sock_release(queue->sock);
>> +    /* ->sock will be released by fput() */
>> +    fput(queue->sock->file);
>> +    queue->sock = NULL;
>>       memalloc_noreclaim_restore(noreclaim_flag);
>>       kfree(queue->pdu);
>> @@ -1512,6 +1514,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl 
>> *nctrl, int qid)
>>       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>>       struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>>       int ret, rcv_pdu_size;
>> +    struct file *sock_file;
>>       mutex_init(&queue->queue_lock);
>>       queue->ctrl = ctrl;
>> @@ -1534,6 +1537,12 @@ static int nvme_tcp_alloc_queue(struct 
>> nvme_ctrl *nctrl, int qid)
>>           goto err_destroy_mutex;
>>       }
>> +    sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
>> +    if (IS_ERR(sock_file)) {
>> +        sock_release(queue->sock);
>> +        ret = PTR_ERR(sock_file);
>> +        goto err_sock;
> 
> Is it safe to fput() an error sock file?
> 
Probably not. I'll fix it up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


