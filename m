Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D15C369B5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 12:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Esx4qn91QMlCc+qpPgh5fQ64e0KkWgmuRh7QuExDIJA=; b=Zt2gOh7RUn7zq/8uDuvRSh+mtu
	XlfKt50zEIhjREpULiR0oPT9JFFgB2RAaKyLsgQFZkM/jbjsl6HPP4+IZJKCnOtgCVOjE9USV1fDl
	spYAU5Vbor4Ma3ak0CPEvdjY3/57e+qo3JuOvu45a7jl1Nd2Vz8NPiw5rWRUevx82+40qQSavOOkq
	N8g/IRFyJ2Z8X87MC6MFNea063IQkf7mXwuJSLNDqKP25c1I6Db4huWMJYeHoakogSqg7WxSscnKG
	1y3umIo3/6dEYl2ucyicggLVLUMuoVKYUw9NO+m4Hav67XX3SSPcAT/dnH4D+7vhW8gYBM1rCZVY/
	uIMlaZ7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4J4e-00000001yGB-0R0x;
	Mon, 14 Apr 2025 12:38:04 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4J21-00000001xbf-3fh6
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 12:35:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D77351F79A;
	Mon, 14 Apr 2025 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744634119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Esx4qn91QMlCc+qpPgh5fQ64e0KkWgmuRh7QuExDIJA=;
	b=aU9MDA30Fi9C2XUWt0klbEMDWboRviryEa6bNmsqAtcXegMK9WYhq02JzycHPc9FwItz7t
	S1KhuljhXj7Q0k3ccOpEzufCOWCsVji68GffN8zHciTUyJlz9ExwJppcQJtjgquDgJD6DF
	3SXDpuyPxX01NeXjKEEJ9s8zrlwJ8XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744634119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Esx4qn91QMlCc+qpPgh5fQ64e0KkWgmuRh7QuExDIJA=;
	b=Ef7zdWt24E7nA/7Mrr+9PveOU108AsfymmMtAftX86+kAPtvQwi56kUVjWV5k5OlyW5Wbi
	ecRRmMv6eCLFdvDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744634119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Esx4qn91QMlCc+qpPgh5fQ64e0KkWgmuRh7QuExDIJA=;
	b=aU9MDA30Fi9C2XUWt0klbEMDWboRviryEa6bNmsqAtcXegMK9WYhq02JzycHPc9FwItz7t
	S1KhuljhXj7Q0k3ccOpEzufCOWCsVji68GffN8zHciTUyJlz9ExwJppcQJtjgquDgJD6DF
	3SXDpuyPxX01NeXjKEEJ9s8zrlwJ8XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744634119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Esx4qn91QMlCc+qpPgh5fQ64e0KkWgmuRh7QuExDIJA=;
	b=Ef7zdWt24E7nA/7Mrr+9PveOU108AsfymmMtAftX86+kAPtvQwi56kUVjWV5k5OlyW5Wbi
	ecRRmMv6eCLFdvDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C531D1336F;
	Mon, 14 Apr 2025 12:35:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7fdQLwcB/WdfawAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 14 Apr 2025 12:35:19 +0000
Message-ID: <a7d0fb4a-e0b4-4ede-911d-993acdfebd42@suse.de>
Date: Mon, 14 Apr 2025 14:35:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-tcp: sanitize request list handling
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-3-hare@kernel.org>
 <f30a41f0-496b-4ad7-a0aa-01f2d5eade73@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f30a41f0-496b-4ad7-a0aa-01f2d5eade73@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_053522_062665_4610C832 
X-CRM114-Status: GOOD (  15.60  )
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

On 4/14/25 01:00, Sagi Grimberg wrote:
> 
> 
> On 03/04/2025 9:55, Hannes Reinecke wrote:
>> Validate the request in nvme_tcp_handle_r2t() to ensure it's not
>> part of any list, otherwise a malicious R2T PDU might inject a
>> loop in request list processing.
> 
> Not clear what do you mean by "malicious R2T PDU".
> Can you please clarify what you have seen/observed in the commit msg 
> (i.e. what led you to this patch)?
> 
This is coming from code inspection only.
In nvme_tcp_handle_r2t() we are looking up a request by the 'command_id'
value in the pdu, and then add it to 'queue->req_list' without further
checking.
So if a malicious R2T packet is received containing the command_id of
a command currently on 'queue->req_list' we'll end up with duplicate
entries on the list.

[ .. ]

>> @@ -773,7 +785,8 @@ static int nvme_tcp_handle_r2t(struct 
>> nvme_tcp_queue *queue,
>>       nvme_tcp_setup_h2c_data_pdu(req);
>>       llist_add(&req->lentry, &queue->req_list);
>> -    queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>> +    if (list_empty(&queue->send_list))
>> +        queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> 
> Is this change mandatory? looks out of place.
> 
Arguably an optimisation. I can leave it out.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

