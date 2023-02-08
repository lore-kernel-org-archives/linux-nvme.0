Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2FEC05027
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vzJGW5PQoH0A71ivsCzWZzrel51niPSElkoFtUt6V4U=; b=uLVogOeHk7iaz2camQ3zp8LRDd
	X4fqoBNFAehPCH5pq8V6D+fnDDe0mcciDo5SovQMmKMniyrYU8ttW9t25uYbYgmZ+75OwAiS72XXs
	L1H3haeD9SLtv6T8tUBu9HFOJ8V8eJb11/Afr4SR48inWYjpcVBbDxg1q7MxgYC4sZCZPOB5mwoNk
	5ivWlZLv7XnO7bvWiEtTxSrt3XeNTHmmG2nUBZZsUOLFnO0at3u+rsI8CG6GVI2zsKZ97RWVT4aKT
	ItNK/oCW9rphySM1yWlnb33gsMEIrnBFF8aU6TxrPrVY09ob/zzkcljZdfpOx/VzVd+dD7VNBhAII
	sCQYrBAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPlzP-00G0XF-G0; Wed, 08 Feb 2023 15:04:03 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPlzN-00G0Vw-3O
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 15:04:02 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 467221FE93;
	Wed,  8 Feb 2023 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675868638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzJGW5PQoH0A71ivsCzWZzrel51niPSElkoFtUt6V4U=;
	b=HNNzJ7+YHgZlRkpayitviZr3gG2Ci7te/cI1G3wPtWNyO3m8OLHeSgvkV/iSWrryHdOrW4
	duuY0alk7jDEoApWuVI/qSbucveWDnwoQs5nDi3VVFCgqECdLTK22t3Bp049YBcSVg7mnv
	Pj+fnw7G+mpPY1CIFs03kddJp+cj8/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675868638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzJGW5PQoH0A71ivsCzWZzrel51niPSElkoFtUt6V4U=;
	b=SykMmyAhGwnUs+TaYKFqbaFhGBqielMVPdrT3AXfV7XnXblBdNlbi7wBt+l4nBgZmEPdde
	OH/dVCwWMjyyKICQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C0E413425;
	Wed,  8 Feb 2023 15:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 9O1ADt6542MJNgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 08 Feb 2023 15:03:58 +0000
Message-ID: <458d075b-27fc-a64b-6ccb-a7a28f8a43d0@suse.de>
Date: Wed, 8 Feb 2023 16:03:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] nvme: split __nvme_submit_sync_cmd()
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230208084939.145257-1-hare@suse.de>
 <CGME20230208090014epcas5p4a10459c8d27dbe4d8e8f457f845fa271@epcas5p4.samsung.com>
 <20230208084939.145257-2-hare@suse.de> <20230208141036.GB13408@green5>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230208141036.GB13408@green5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_070401_312495_59BEF22E 
X-CRM114-Status: GOOD (  15.39  )
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

On 2/8/23 15:10, Kanchan Joshi wrote:
> On Wed, Feb 08, 2023 at 09:49:37AM +0100, Hannes Reinecke wrote:
>> Split a __nvme_alloc_rq() function from __nvme_submit_sync_cmd()
>> to reduce the number of arguments.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>> drivers/nvme/host/auth.c       |  9 ++++--
>> drivers/nvme/host/core.c       | 59 ++++++++++++++++++++++------------
>> drivers/nvme/host/fabrics.c    | 42 ++++++++++++++++++------
>> drivers/nvme/host/nvme.h       |  8 ++---
>> drivers/nvme/host/pci.c        |  8 ++---
>> drivers/nvme/target/passthru.c |  3 +-
>> 6 files changed, 85 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index 787537454f7f..cbb6f1cb2046 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -62,6 +62,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, 
>> int qid,
>>     struct nvme_command cmd = {};
>>     blk_mq_req_flags_t flags = nvme_auth_flags_from_qid(qid);
>>     struct request_queue *q = nvme_auth_queue_from_qid(ctrl, qid);
>> +    struct request *req;
>>     int ret;
>>
>>     cmd.auth_common.opcode = nvme_fabrics_command;
>> @@ -76,9 +77,11 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, 
>> int qid,
>>         cmd.auth_receive.al = cpu_to_le32(data_len);
>>     }
>>
>> -    ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
>> -                     qid == 0 ? NVME_QID_ANY : qid,
>> -                     0, flags);
>> +    req = __nvme_alloc_rq(q, &cmd, qid == 0 ? NVME_QID_ANY : qid, 
>> flags);
>> +    if (IS_ERR(req))
>> +        return PTR_ERR(req);
>> +
>> +    ret = __nvme_submit_sync_cmd(q, req, NULL, data, data_len, 0);
> 
> First argument 'q' of above can also be killed.
> 
Indeed.

Cheers,

Hannes

