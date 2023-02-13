Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E64C636D7
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 10:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z7QWSSKZBa+BQf6bgTh3GSykN+GyDeK4zqzVUMFZzrs=; b=Kc1M5l8eDkraEf/7OtDiM+I7Dr
	GiXCVrYGji7VLY84j1isiupgVSaBKTiHzmI6dV4yyRG9oByJhDVi+MIcXbB9LZTKl3kL+8nel2HT3
	AfNpbR/EE7L+/61XFWlgmf1Ja71Po4Htm7HwWtwrsAq88iJGbp6scK+EChom7pDbLcLlBYTe3T0J3
	YWo1JHtlmiMUe8gNXUnL/kTDwzTXTJYXHiD3iwLhQrR9ACz6Nk58lQZsFhU3b7NdRkPP3gwBJpCut
	M9A/SIMcysAOCZEEJZykf/GYR8xp0z7HRxn6jYx/A7EwzQ9jEzb6GSegAiyix2boN7gkrDYQefv9+
	IqGbQ9Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVhc-00E1E7-6d; Mon, 13 Feb 2023 10:04:52 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVhW-00E1C0-BV
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 10:04:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 521A81FD81;
	Mon, 13 Feb 2023 10:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1676282681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7QWSSKZBa+BQf6bgTh3GSykN+GyDeK4zqzVUMFZzrs=;
	b=gaTJguJemtLQOnBeJZ/fiJfM9sH89h+LeKyyV3idKrVzQUf1TqanWY03NBFIjien6o1PyK
	styU6DvJzgNZ780uYcV9R15x42frJBrIr4tcfFxalu8nMYbXL0VAOEwOYJA7SCz4A6gLf3
	EfNRUUyKgomrpM8ZQQcsR+AePz8zg2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1676282681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7QWSSKZBa+BQf6bgTh3GSykN+GyDeK4zqzVUMFZzrs=;
	b=mmm/QWmtk0cNlpqpZL0LdYXVSaWiLJTZT/uRk0L4MhGNsCkQ8GdGPoJKAIi5eugFS2EuPt
	kWNyIIr5HJ0azZAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43277138E6;
	Mon, 13 Feb 2023 10:04:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2QH9DzkL6mP1bgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 13 Feb 2023 10:04:41 +0000
Message-ID: <118c9ac2-02b1-8922-9dac-d20364c01837@suse.de>
Date: Mon, 13 Feb 2023 11:04:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/5] nvme: move result handling into nvme_execute_rq()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230209143820.118097-1-hare@suse.de>
 <20230209143820.118097-4-hare@suse.de>
 <a2b720a1-962b-5314-2475-8908a877b943@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a2b720a1-962b-5314-2475-8908a877b943@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_020446_579171_1C058FB6 
X-CRM114-Status: GOOD (  18.98  )
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

On 2/13/23 10:59, Sagi Grimberg wrote:
> 
> 
> On 2/9/23 16:38, Hannes Reinecke wrote:
>> and simplify the calling convention.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/core.c       | 16 ++++++++++------
>>   drivers/nvme/host/ioctl.c      |  5 +++--
>>   drivers/nvme/host/nvme.h       |  3 ++-
>>   drivers/nvme/target/passthru.c |  3 +--
>>   4 files changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 78da9c6cbba8..11faebe87764 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1004,15 +1004,21 @@ EXPORT_SYMBOL_GPL(nvme_setup_cmd);
>>    * >0: nvme controller's cqe status response
>>    * <0: kernel error in lieu of controller response
>>    */
>> -int nvme_execute_rq(struct request *rq, bool at_head)
>> +int nvme_execute_rq(struct request *rq, union nvme_result *result,
>> +            bool at_head)
>>   {
>>       blk_status_t status;
>> +    int ret;
>>       status = blk_execute_rq(rq, at_head);
>>       if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
>>           return -EINTR;
>> -    if (nvme_req(rq)->status)
>> -        return nvme_req(rq)->status;
>> +    ret = nvme_req(rq)->status;
>> +    if (ret) {
>> +        if (result && ret >= 0)
> 
> How can ret be < 0 here?
> 
> Why not always take the result, unconditionally?
> 
Yeah, right. Will be fixing it up.

> Is this really necessary though?
> 
??
Yes, it is necessary to return the status (if there is one).
Quite some callers expect that.
And no, it's probably not necessary to check if there is a status;
we might always return a status here. But for the result I guess we
should be checking the status first; I'm slightly hesitant to blindly
return the result even if we have a zero status.

Cheers,

Hannes


