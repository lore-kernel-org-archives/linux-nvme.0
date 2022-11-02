Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBC3C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 08:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4PpHmQXB1YeXdiGokSSn9u83J5uyqqnt/gPooVm5nPM=; b=mOc8VjCt5EjBIPkCwzwYmTtjUW
	AnDYfinqCvphrdX1oesGC0cltCHK+xoduvvfxmNEIKJNeWMyIj/p/ITUb7cZS/a6XmEiRxlzQiLBE
	/PW/WiHI4g73biHR5J16E02pepzdKTC/TkhK7wUEQHsftQhwUkgGvuzSErSqexccq1CEeSy6K3l8B
	Iw/N/YNxkHsu60kLGaLRpvvDeq+q7rVoVnxRH8zn8WReodp4PYyqRGy8VzMsdOrR1U3jC70rmk0A2
	Vq9P6C89OA+lr9qGnujLZ5Mmab5CWDGnh5nSJ6nH5wHoVH0ShyO9zN5aL6Ma6Ve+rM0qpMxsEYRzv
	c8nhU8BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq9U8-009EBt-2c; Wed, 02 Nov 2022 08:52:32 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq9U4-009E9D-KV
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 08:52:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 19C661F8CC;
	Wed,  2 Nov 2022 08:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667379145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PpHmQXB1YeXdiGokSSn9u83J5uyqqnt/gPooVm5nPM=;
	b=a0suReXtWlE4FoTnq5vHWmwM+CjzCn/CIS70JuYHoBENYw5XXVNQ79RwGqfgsb8ILjPrLG
	dpAFsUPteppurbvaL4Vfly6fA4MtVKrRZJPcR95M9KTK0c1oqSKHWGbd/RrXISA7DVTSe5
	I6oBgKqEz+ksFazLdfc66T1fW/1997w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667379145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PpHmQXB1YeXdiGokSSn9u83J5uyqqnt/gPooVm5nPM=;
	b=9C+7nZ11jQSXQo9o6EiSfo9xi3JlXuTEbTJgghnLOG1HjuYULSqCQ3uMCCcDA6JNkYpS4D
	gh272lqMNhiJ0ICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3451139D3;
	Wed,  2 Nov 2022 08:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Bpz0OsgvYmP0GAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 02 Nov 2022 08:52:24 +0000
Message-ID: <c1e10a5e-eab1-c49c-4377-54a94457df5e@suse.de>
Date: Wed, 2 Nov 2022 09:52:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20221102075224.70869-1-hare@suse.de>
 <20221102075224.70869-4-hare@suse.de> <20221102080319.GB10816@lst.de>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/6] nvme-auth: use xarray instead of linked list
In-Reply-To: <20221102080319.GB10816@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_015228_833387_4026BB84 
X-CRM114-Status: GOOD (  13.77  )
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

On 11/2/22 09:03, Christoph Hellwig wrote:
>> @@ -907,33 +915,28 @@ EXPORT_SYMBOL_GPL(nvme_auth_negotiate);
>>   int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
>>   {
>>   	struct nvme_dhchap_queue_context *chap;
>> -	int ret;
>>   
>> +	chap = xa_load(&ctrl->dhchap_auth_xa, qid);
>> +	if (!chap) {
>> +		dev_warn(ctrl->device,
>> +			 "qid %d: authentication not initialized!",
>> +			 qid);
>> +		return -ENOENT;
>>   	}
>> +	flush_work(&chap->auth_work);
> 
> What protects chap from going away after the load, but before use?
> 

The control flow.
Entries are only deallocated in nvme_auth_free(), which is called from 
nvme_free_ctrl().
By that time all processing has stopped, all workqueue entries are 
flushed, and no further commands are accepted.
Entries are allocated from two call sites; one via ops->create_ctrl(), 
and the other one via the workqueue function nvme_dhchap_auth_work().
'create_ctrl' is synchronous, so the controller will only be deallocated 
on the final put() of the create_ctrl() control flow. So we should be 
good there.
The workqueue function is flushed during nvme_free_ctrl(), so we're good 
there, too.

Hence I felt additional protection is not required.
Do correct me if I'm wrong.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer


