Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00FECA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2n/B57HJWU8yDYO/2K4h+8FKqdHK4wu3gqADOsXPOds=; b=JrOqXO5VX5XgTfYbmuYAi7sIeb
	apSWDFs8SpNCj0TXgmhyJ61UOIKAcP0y59vc668qIc8ZJzR0QRF3S8Z3XPJX751gbtTqiFGjtm6Hr
	qGUIloE2HqA69j//a1OQUGcWtjbJ6KJG8IFZCXkYU1GkUwCECThzCYxJJ3DJMJV1Q40q8Ef2R/6Q/
	88lA7JcugQG19hr5sT7t05JVPY1141+Fj6FHpfDSRzbfSbpoNmVptxLfbwTUfIwjlsRNHLFfVnjWw
	M6E0p4FobpBvGoSecRjX4rTlsH6e77xN828vlIX4b7S+Ew9jyP03mLhTiC04vTgh9dnBXF0WqgHYY
	PSpnYdiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2AE-003I8y-0D;
	Tue, 12 Sep 2023 12:06:42 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2AB-003I8H-0L
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 12:06:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D59391F45A;
	Tue, 12 Sep 2023 12:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694520396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2n/B57HJWU8yDYO/2K4h+8FKqdHK4wu3gqADOsXPOds=;
	b=iGgGrw3LAQmPVIBL0fAf6BAwwwlnCKpD60GjsIfRFqtwl5H0c6yqmbs4CcLy03lMyyKKvD
	I31cfhzd7Py1XWRjqyJxtF9ZfPhbLOLt+Rb/XiJv2Kz5bWNYhpwrfb4dtMKiu56g8s8vVc
	+y+WELIDg9GP1hCdqt41K36XaSp7iRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694520396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2n/B57HJWU8yDYO/2K4h+8FKqdHK4wu3gqADOsXPOds=;
	b=HoYz6dbfhYLA1PhGRxYhu2bczdzJdWAV6caBJKTWWowdC3Tg4pIZ3lVldEdR3yjMtq5ctA
	CDX3Q4Zz8qGnENBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9A3E139DB;
	Tue, 12 Sep 2023 12:06:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 7J3+MExUAGW9CwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 12 Sep 2023 12:06:36 +0000
Message-ID: <25a59314-ff11-4217-b1d8-d06f684312f5@suse.de>
Date: Tue, 12 Sep 2023 14:06:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: Do not terminate commands when in RESETTING
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908100049.80809-1-hare@suse.de>
 <20230908100049.80809-2-hare@suse.de>
 <b21a2472-2afb-5a38-1029-1db153102a0c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b21a2472-2afb-5a38-1029-1db153102a0c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_050639_330598_6C5E1CC8 
X-CRM114-Status: GOOD (  18.32  )
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

On 9/12/23 13:54, Sagi Grimberg wrote:
> 
>> When the error recovery started it will terminate all commands
>> anyway, so we should just return BLK_EH_RESET_TIMER for a
>> command timeout.
> 
> Does this fix a real issue? the timeout handler and the error
> recovery should be mutually exclusive.
> 
They are not. When several timeouts are triggering at the same time,
only the first will start error recovery; the remaining ones will
still hit the timeout function until cancel_tagset() is called.

>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/tcp.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 5b332d9f87fc..1faef1cf5c94 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2274,6 +2274,14 @@ static enum blk_eh_timer_return 
>> nvme_tcp_timeout(struct request *rq)
>>           nvme_tcp_queue_id(req->queue), nvme_cid(rq), pdu->hdr.type,
>>           opc, nvme_opcode_str(qid, opc, fctype));
>> +    /*
>> +     * If the error recovery is started all commands will be
>> +     * aborted anyway, and nothing is to be done here.
>> +     */
>> +    if (ctrl->state == NVME_CTRL_RESETTING &&
>> +        work_pending(&to_tcp_ctrl(ctrl)->err_work))
>> +        return BLK_EH_RESET_TIMER;
> 
> What does the work_pending() check give you here?
> 
'RESETTING' is also entered for firmware download, so we need to check
for work_pending() to find out if the error recovery engaged.

Cheers,

Hannes


