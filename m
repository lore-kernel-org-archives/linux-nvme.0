Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552F3C25B7E
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 06:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6wehzuMAsbGO5mJxKsUAnIgIPnmsrtH8jEonbB62AKc=; b=Hdsv3Qi+bW8oKFoNTFQg7gsMk0
	Hls0YyjlUkA9IY8f77GTgwFU546IpEMdMBfkMJ9eaFu+n61RrOrpQFBdUPgmJ4njQy509fOFOc6XS
	7k4n1RlD3eNFgTRrluw1utXs1cKsE1hLfOmA+y+bkxTTfYpg7sitvkEEK0Jr4lg2SlPw6sTRuQSHa
	sJdoVmzcZshiTL0bDzsEvoRmMPQMGeN0yOlr4kTtHsiZR3ErIGMnQ747UE9ksoxCz6RZbL0xx7gTc
	ygzTRs5MgD3FU4XTlSWxKkw2Hexr431E7M7vW46CxiC/yZVc/Uy5oDsxgZgGvMx52PXUKr+LjRLLC
	scfdLPIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sENxp-00000001Ql7-0UG9;
	Tue, 04 Jun 2024 06:48:09 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sENxj-00000001QiM-30tH
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 06:48:06 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51D3E1F7CD;
	Tue,  4 Jun 2024 06:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717483673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wehzuMAsbGO5mJxKsUAnIgIPnmsrtH8jEonbB62AKc=;
	b=Qv++45Ot6Hz/RK0xSiBs4Jxpq9XonP6vdP0b9+srnTMJ794aojtcjrGBK0ZP4Jnm3S5Onc
	zv/4TVZ6te3zEDhB5CU+/32KP3yH2/IE6quAq37+8L3zUxSfZTosQXZFZRD1xLVcCsVq7/
	g3yW68uIi/yGe9XBRYrfdOkOAS4eURs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717483673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wehzuMAsbGO5mJxKsUAnIgIPnmsrtH8jEonbB62AKc=;
	b=+wQdxT5nupwd9gfGN98Tb8QW/r8FZTRuhlNbcBLgvsRiFpUJpxUgW4wCHr+6hTWZe7pp3Z
	5aQu8im0+vGsSdAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Qv++45Ot;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+wQdxT5n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717483673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wehzuMAsbGO5mJxKsUAnIgIPnmsrtH8jEonbB62AKc=;
	b=Qv++45Ot6Hz/RK0xSiBs4Jxpq9XonP6vdP0b9+srnTMJ794aojtcjrGBK0ZP4Jnm3S5Onc
	zv/4TVZ6te3zEDhB5CU+/32KP3yH2/IE6quAq37+8L3zUxSfZTosQXZFZRD1xLVcCsVq7/
	g3yW68uIi/yGe9XBRYrfdOkOAS4eURs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717483673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wehzuMAsbGO5mJxKsUAnIgIPnmsrtH8jEonbB62AKc=;
	b=+wQdxT5nupwd9gfGN98Tb8QW/r8FZTRuhlNbcBLgvsRiFpUJpxUgW4wCHr+6hTWZe7pp3Z
	5aQu8im0+vGsSdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B97031398F;
	Tue,  4 Jun 2024 06:47:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aI5HK5i4XmZbdgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Jun 2024 06:47:52 +0000
Message-ID: <a8524e5d-f9d1-45c1-a641-0e3f57155822@suse.de>
Date: Tue, 4 Jun 2024 08:47:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-RFC 2/5] nvme: tcp: split controller bringup handling
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 mlombard@redhat.com, shinichiro.kawasaki@wdc.com,
 Keith Busch <kbusch@kernel.org>
References: <20240603230524.3854115-1-kbusch@meta.com>
 <20240603230524.3854115-3-kbusch@meta.com>
 <CADUfDZpbsNmYsVX6AvUtmkjD92zJvWWjyS7KBCDzhHSksL+tqQ@mail.gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CADUfDZpbsNmYsVX6AvUtmkjD92zJvWWjyS7KBCDzhHSksL+tqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 51D3E1F7CD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_234803_937203_5A3493F9 
X-CRM114-Status: GOOD (  15.08  )
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

On 6/4/24 02:35, Caleb Sander wrote:
> On Mon, Jun 3, 2024 at 4:08 PM Keith Busch <kbusch@meta.com> wrote:
>>
>> From: Keith Busch <kbusch@kernel.org>
>>
>> Drivers must call nvme_uninit_ctrl after a successful nvme_init_ctrl.
>> Split the allocation side out to make the error handling boundary easier
>> to navigate. The nvme tcp driver's error handling had different returns
>> in the error goto labels, which harm readability.
>>
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
>> ---
>>   drivers/nvme/host/tcp.c | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 8b5e4327fe83b..7f75d01dcbed0 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2686,7 +2686,7 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
>>          return found;
>>   }
>>
>> -static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>> +static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
>>                  struct nvmf_ctrl_options *opts)
>>   {
>>          struct nvme_tcp_ctrl *ctrl;
>> @@ -2761,6 +2761,24 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>>          if (ret)
>>                  goto out_kfree_queues;
>>
>> +       return ctrl;
>> +out_kfree_queues:
>> +       kfree(ctrl->queues);
>> +out_free_ctrl:
>> +       kfree(ctrl);
>> +       return ERR_PTR(ret);
>> +}
>> +
>> +static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>> +               struct nvmf_ctrl_options *opts)
>> +{
>> +       struct nvme_tcp_ctrl *ctrl;
>> +       int ret;
>> +
>> +       ctrl = nvme_tcp_alloc_ctrl(dev, opts);
>> +       if (IS_ERR(ctrl))
>> +               return (struct nvme_ctrl *)ctrl;
> 
> This cast doesn't look right, as struct nvme_tcp_ctrl doesn't start
> with a struct nvme_ctrl field. Looks like this should be &ctrl->ctrl
> to match the current implementation of nvme_tcp_create_ctrl()?
> 
ERR_CAST() ?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


