Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12B8ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kqex4T3Y8rtRZ8iQ04JmdZpWUZHvwqoF5dzL46YMXew=; b=XCOIVLEpFtDL0OLQNEibR2meze
	Z3IxIwFWqhEK8fEgetLmkK6eN7Ut8j2hmCR2yKnFAvGNVoSMLpAaHBoCYZW0EQajn+Tsj9pKjo6f5
	26ur5Cquoa+q4K2IWpHr/6ABhUmOaq0FKOvGgeg2XHHdreCIeTthMck+xRveWWRxGpNiDwHpZ6qgu
	Mw5IlS0HR27diT7M9vGMxEmWomqLHUUufhN9YujVTzAgEEjZHpWwgzErKXoSTtoKWoG/DFB612Xx1
	3ce3oHjl6WgtTuJ71WAxP4Bk7xYeLxj7T+fUMjTk/nDdQ0ZCGuoSjhDGGZnAGrKOS8oW4SrqbqtvG
	fKdOXN1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVaFg-00EdBH-4Z; Tue, 06 Sep 2022 15:12:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVZNz-00EDG1-Ss
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 14:17:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A14CC1F956;
	Tue,  6 Sep 2022 14:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1662473814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqex4T3Y8rtRZ8iQ04JmdZpWUZHvwqoF5dzL46YMXew=;
	b=epM3ZonD2NhkHyqEHoLBYktE21nMAI9Q8E9Soi1l2Dxoy1WGGQKGIdRUfpbYjB0nK9BFvP
	YPEtbMkaAlDphuSqiypeVeEX4KHEOZ9SEI9fv6poOod8IrBXMShrp2oGGF2vxhlfjtPMyQ
	+aF8M8zvtGpHbP4c040VB7UuOKeYLDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1662473814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqex4T3Y8rtRZ8iQ04JmdZpWUZHvwqoF5dzL46YMXew=;
	b=MEPUzm6UDaYDXc4281ArVEwDY0RVZyyYtDOfe5QohYkG6xcCO10dozmj+AQ8EjBg+fWytW
	yXwc2mkZlIrpijCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 533C313A7A;
	Tue,  6 Sep 2022 14:16:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id h7JoEVZWF2MPeAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 06 Sep 2022 14:16:54 +0000
Message-ID: <d13ce9ac-e851-369a-fe58-1bfebe5cb7c7@suse.de>
Date: Tue, 6 Sep 2022 16:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] nvme-auth: retry command if DNR bit is not set
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Martin George <marting@netapp.com>
References: <20220830124925.40711-1-hare@suse.de>
 <20220830124925.40711-2-hare@suse.de>
 <db927303-525f-6925-7b26-a0f4d8545dad@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <db927303-525f-6925-7b26-a0f4d8545dad@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_071708_153976_1B8496F7 
X-CRM114-Status: GOOD (  16.77  )
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

On 9/5/22 14:05, Sagi Grimberg wrote:
> 
> 
> On 8/30/22 15:49, Hannes Reinecke wrote:
>> If the cqe returns a status with the DNR bit not set we should
>> retry the command; otherwise we might incur spurious failures.
>>
>> Reported-by: Martin George <marting@netapp.com>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/auth.c |  2 +-
>>   drivers/nvme/host/core.c | 20 ++++++++++++++++++--
>>   include/linux/blk-mq.h   |  2 ++
>>   3 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index c8a6db7c4498..4ca3f7d042f1 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -69,7 +69,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, 
>> int qid,
>>       ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
>>                        qid == 0 ? NVME_QID_ANY : qid,
>> -                     0, flags);
>> +                     0, BLK_MQ_REQ_RETRY | flags);
> 
> Surely there is a local way to have this than to leak a flag to
> blk-mq...
> 

Sigh. That was the first attempt I did. Which got rejected by Christoph, 
who wanted to have it generic.

Personally I _did_ like the first version better, for precisely the 
reasons you mentioned.

But if the maintainer requests a change, who am I to object ...

So what to do now?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

