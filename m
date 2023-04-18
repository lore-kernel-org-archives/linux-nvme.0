Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574C1C6FD18
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7jZxT4nktq8Kx4+AJOLdMn+kd6dbaoR2UBMTA3rUZOY=; b=aRCD/9jwf5WncLtdbunnJKa4Dc
	tiUO42KqcvXyWzPYa7tF82m+hYP42MjqnEOGMvpj45GLVs/+MiXCNDqpR68ZVGvaq+CZAug3hwA0i
	8Y5RrcmyQmGY0CDxuL+Gd5Ct+VKg4PY92Gfcs7+KaiGAZm4ViuIOV2rh+uN1adwKHOr9avRsUQZxn
	yIaJ5nnr+s63K/mksXa1MUoWui4D2XaDBUQgdqHKOb7JMzwbXkf93i9u8yqDs641ZR22jnVh22J9H
	1vPKLxr7ZNXD00R6bRd9Lg6dZRqmyOULuDUSDjr1rBDE6Bb9PSiTAtgvUdNs/D19O5QqSmjOT+vwY
	LkFRIJow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pooVG-002p1w-2C;
	Tue, 18 Apr 2023 16:48:26 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pooVD-002p0I-2M
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 16:48:25 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20C3D21A58;
	Tue, 18 Apr 2023 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681836500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jZxT4nktq8Kx4+AJOLdMn+kd6dbaoR2UBMTA3rUZOY=;
	b=WzX5dyXjFLOOMTo6QPd7KuJxNITzEPPzyMi5briKo3fys4fbCATDQ+rgeou0glDm/0G9jX
	/LdDEVLsYHhoo04icBepMgLVnOzpmvqJeb/sP+QjsCheeCuRD9X/KGybD3wLcPTdyMdsEG
	4pHXhu5VC+b8Q1BZQHRI/johB/XYCgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681836500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jZxT4nktq8Kx4+AJOLdMn+kd6dbaoR2UBMTA3rUZOY=;
	b=uAkC2GfeRmiTTbSWvHdtl7IeudeNoZdDE/UQv0JuMFThfeszKKzupV3fv2HtKGqmd9reym
	7ij8hX+HCWbAhtBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0A4713581;
	Tue, 18 Apr 2023 16:48:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LFHQNdPJPmQFLwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 18 Apr 2023 16:48:19 +0000
Message-ID: <1f8e665a-7bf2-517e-4e15-7d9e5411f6f3@suse.de>
Date: Tue, 18 Apr 2023 18:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] nvme: double KA polling frequency to avoid KATO with
 TBKAS on
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Uday Shankar
 <ushankar@purestorage.com>, Costa Sapuntzakis <costa@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
Cc: linux-nvme@lists.infradead.org
References: <20230417225558.2890062-1-ushankar@purestorage.com>
 <20230417225558.2890062-2-ushankar@purestorage.com>
 <c6fbc05f-5e53-2ce5-5a33-5bb0d23e4f41@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c6fbc05f-5e53-2ce5-5a33-5bb0d23e4f41@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_094823_914137_7A550FC3 
X-CRM114-Status: GOOD (  19.22  )
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

On 4/18/23 18:03, Sagi Grimberg wrote:
> 
>> With TBKAS on, the completion of one command can defer sending a
>> keep alive for up to twice the delay between successive runs of
>> nvme_keep_alive_work. The current delay of KATO / 2 thus makes it
>> possible for one command to defer sending a keep alive for up to
>> KATO, which can result in the controller detecting a KATO. The following
>> trace demonstrates the issue, taking KATO = 8 for simplicity:
>>
>> 1. t = 0: run nvme_keep_alive_work, no keep-alive sent
>> 2. t = ε: I/O completion seen, set comp_seen = true
>> 3. t = 4: run nvme_keep_alive_work, see comp_seen == true,
>>            skip sending keep-alive, set comp_seen = false
>> 4. t = 8: run nvme_keep_alive_work, see comp_seen == false,
>>            send a keep-alive command.
>>
>> Here, there is a delay of 8 - ε between receiving a command completion
>> and sending the next command. With ε small, the controller is likely to
>> detect a keep alive timeout.
>>
>> Fix this by running nvme_keep_alive_work with a delay of KATO / 4
>> whenever TBKAS is on. Going through the above trace now gives us a
>> worst-case delay of 4 - ε, which is in line with the recommendation of
>> sending a command every KATO / 2 in the NVMe specification.
>>
>> Reported-by: Costa Sapuntzakis <costa@purestorage.com>
>> Reported-by: Randy Jennings <randyj@purestorage.com>
>> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/core.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 6c1e7d6709e0..1298c7b9bffb 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1150,10 +1150,16 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, 
>> NVME_TARGET_PASSTHRU);
>>    *
>>    *   The host should send Keep Alive commands at half of the Keep 
>> Alive Timeout
>>    *   accounting for transport roundtrip times [..].
>> + *
>> + * When TBKAS is on, we need to run nvme_keep_alive_work at twice this
>> + * frequency, as one command completion can postpone sending a keep 
>> alive
>> + * command by up to twice the delay between runs.
>>    */
>>   static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
>>   {
>> -    queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
>> +    unsigned long delay = (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) ?
>> +        ctrl->kato * HZ / 4 : ctrl->kato * HZ / 2;
>> +    queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
>>   }
>>   static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
> 
> This looks fine to me, the only thing that is a bit concerning is that
> we may excessively send keep-alive too frequently (default kato is 10
> divide by 4 gives every 2 seconds).

Well, this is with TBKAS on, so we're sending keep-alives only if there 
is no other traffic on the wire. And then sending a keep-alive every two 
seconds is hardly exacting.

Cheers,

Hannes


