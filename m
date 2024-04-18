Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF32C04FFF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 11:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fqLAGDCq7r/snxiT7T+KkM+kzX1ev65FhklpklmSIxU=; b=u6xb6Haf6XsLIGg8Hi61q2eTQA
	JHE2oMN2ZVAN0UtW9dKBEMdmwmZHlKmdBjvy2dHlSYsPGYpSMJ2apnQQZiVAGMwpf2O8j4K2ufP2g
	9XwGlHOI5tIzWfJj13OQpfB4k28UZP9BbJIfzQ8oUzH9Ja4pBlueSqQlQSm7j3vvIwZZv2y0kxtok
	Ap+T1VrxWyvYqPAwrLJnKrAQLrQJ/qhEvEVXAurerhoM4qcjaq3LAUjV5j21LhhoiP6ACVYul1rH4
	XtdlTMvlUxB54wU6wKIMmB/8vVjOuNEE28u9EDbrjIrUHJEEsFyagZjxCqyPJZIr7SdGa2SyYORCq
	XUH/SULw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxQ1W-000000020V9-47vx;
	Thu, 18 Apr 2024 11:33:50 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxQ1R-000000020RN-21F2
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 11:33:48 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7775E34E36;
	Thu, 18 Apr 2024 11:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713440023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqLAGDCq7r/snxiT7T+KkM+kzX1ev65FhklpklmSIxU=;
	b=R1GUGRJUQmPuhZfSq5rlWJ3my1dn9xoxURDlcCg+mz6Yae4zDeuDDho6J2rNI7zab3MkuE
	Br1px1SIRWqjw0bRVvSvXbP0KctLnKDYYpsHJVy2ftxzEPMMSa6n2u/cy6GknY63VMaUX0
	gWXgtleWr8vVHUhGASRR1hIFl+YF6aY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713440023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqLAGDCq7r/snxiT7T+KkM+kzX1ev65FhklpklmSIxU=;
	b=ODPjUKQNj8sNIHKO2pLJ8iXWAbAonbEhGocZFesGgQ/fRjuaXmLfjTJDVa8NzRsCpBo/SX
	YOapx72EkDQgFsBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713440023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqLAGDCq7r/snxiT7T+KkM+kzX1ev65FhklpklmSIxU=;
	b=R1GUGRJUQmPuhZfSq5rlWJ3my1dn9xoxURDlcCg+mz6Yae4zDeuDDho6J2rNI7zab3MkuE
	Br1px1SIRWqjw0bRVvSvXbP0KctLnKDYYpsHJVy2ftxzEPMMSa6n2u/cy6GknY63VMaUX0
	gWXgtleWr8vVHUhGASRR1hIFl+YF6aY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713440023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqLAGDCq7r/snxiT7T+KkM+kzX1ev65FhklpklmSIxU=;
	b=ODPjUKQNj8sNIHKO2pLJ8iXWAbAonbEhGocZFesGgQ/fRjuaXmLfjTJDVa8NzRsCpBo/SX
	YOapx72EkDQgFsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E46A1384C;
	Thu, 18 Apr 2024 11:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aY1mFhcFIWZcZQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Apr 2024 11:33:43 +0000
Message-ID: <045e76a2-b92c-44b7-bb9b-9b9aa1462d04@suse.de>
Date: Thu, 18 Apr 2024 13:33:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] nvme-tcp: do not quiesce admin queue in
 nvme_tcp_teardown_io_queues()
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-10-hare@kernel.org>
 <ea0d9634-d220-4e0e-9aef-567941c39dcd@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ea0d9634-d220-4e0e-9aef-567941c39dcd@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_043345_737517_A323E77D 
X-CRM114-Status: GOOD (  16.89  )
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

On 4/7/24 23:24, Sagi Grimberg wrote:
> 
> 
> On 18/03/2024 17:03, Hannes Reinecke wrote:
>> nvme_tcp_teardown_io_queues() is for I/O queues; the admin queue
>> should be left untouched here.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/tcp.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 7018dc0dd026..66675b2dc197 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2173,7 +2173,6 @@ static void nvme_tcp_teardown_io_queues(struct 
>> nvme_ctrl *ctrl,
>>   {
>>       if (ctrl->queue_count <= 1)
>>           return;
>> -    nvme_quiesce_admin_queue(ctrl);
>>       nvme_quiesce_io_queues(ctrl);
>>       nvme_sync_io_queues(ctrl);
>>       nvme_tcp_stop_io_queues(ctrl);
> 
> 1. can you explain why is this needed?
> 2. I have some vague recollection of this being added to address
> something, but git blame leads to a patch that looks completely unrelated:
> d4d61470ae48 ("nvme-tcp: serialize controller teardown sequences")
> 
> So I do not really object this (primarily because I cannot figure out why
> this exists there in the first place).
> 
You are right; this is unrelated. I'll leave it out for the next round.

Cheers,

Hannes


