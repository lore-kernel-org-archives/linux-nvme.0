Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96680C28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 08:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DBaVbAFjC49NeGYTnOEYL019VhZNRYwAWAJMtBcOaxg=; b=dcaYTcMrPKaBL1BZXJPG8Z2uyu
	vmArGVp00bHhnKa5//e7TPEXCpbcOskjX1GVP6bi9c+SOa5pfyJBWPUequRN4vAzng/rQs5WKGlQV
	H55lbsEQKNbnEwnr4kVXgd1mpP3E/0P/VlBX3/0Bn8m4z7NP00RibS6jST/dR61mJDVxaSSUiCfAz
	FYBp5Vz4DxLchiznTix0MUEa0yEMmvB0h2T3SuatMLGlBTSXZTduRSD/rO7Qb8TK8WDIx6qoUhR1H
	0frITMw38jCh88minIoclKmQGGbjXvSRwDPUYnvpMu0toL0ip/8MGfm+9vyYquaN8uMI51yZRJD3O
	WIO0yvuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsHGN-00000007oEJ-05MO;
	Wed, 12 Mar 2025 08:16:27 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsHGK-00000007oDr-1juE
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 08:16:25 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1121F21180;
	Wed, 12 Mar 2025 08:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741767383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBaVbAFjC49NeGYTnOEYL019VhZNRYwAWAJMtBcOaxg=;
	b=EsMBRQKPZ/UmakzmHlbY4L2Mge9zm5GuHWfyH3ikX1ZhrvkoWfspkTPGVrgBWlSQg62KLC
	QfZ+FuuO1weiVh7HUy8v0EgYIviotdZpxn7oboLuwOX2TWaEvDlQcxNbclsFlNtZYV8HSA
	fF0sMX/frum+Bj/ZXeyql4E7cpjd+U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741767383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBaVbAFjC49NeGYTnOEYL019VhZNRYwAWAJMtBcOaxg=;
	b=an55AfunV1sSK4BCeqgCHT9zLfibw9nl8RHG4FRd+TN1yNoLrkg4OYpN371vaCNn57UV4m
	SSrsY3JpeXBCpjBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741767383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBaVbAFjC49NeGYTnOEYL019VhZNRYwAWAJMtBcOaxg=;
	b=EsMBRQKPZ/UmakzmHlbY4L2Mge9zm5GuHWfyH3ikX1ZhrvkoWfspkTPGVrgBWlSQg62KLC
	QfZ+FuuO1weiVh7HUy8v0EgYIviotdZpxn7oboLuwOX2TWaEvDlQcxNbclsFlNtZYV8HSA
	fF0sMX/frum+Bj/ZXeyql4E7cpjd+U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741767383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBaVbAFjC49NeGYTnOEYL019VhZNRYwAWAJMtBcOaxg=;
	b=an55AfunV1sSK4BCeqgCHT9zLfibw9nl8RHG4FRd+TN1yNoLrkg4OYpN371vaCNn57UV4m
	SSrsY3JpeXBCpjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAB491377F;
	Wed, 12 Mar 2025 08:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PVc4NNZC0WeZeQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 12 Mar 2025 08:16:22 +0000
Message-ID: <224d7699-abf5-4bd9-a31e-f92973b94401@suse.de>
Date: Wed, 12 Mar 2025 09:16:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-tcp: sanitize request list handling
To: Chris Leech <cleech@redhat.com>, Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250307132802.111513-1-hare@kernel.org>
 <20250307132802.111513-3-hare@kernel.org>
 <Z9CGtUqkAR6uWWs-@my-developer-toolbox-latest>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z9CGtUqkAR6uWWs-@my-developer-toolbox-latest>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_011624_606241_BBA42775 
X-CRM114-Status: GOOD (  17.22  )
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

On 3/11/25 19:53, Chris Leech wrote:
> On Fri, Mar 07, 2025 at 02:28:01PM +0100, Hannes Reinecke wrote:
>> Validate the request in nvme_tcp_handle_r2t() to ensure it's not
>> part of any list, otherwise a malicious R2T PDU might inject a
>> loop in request list processing.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/tcp.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
> 
> ...
> 
>> @@ -759,8 +762,12 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>>   
>>   	nvme_tcp_setup_h2c_data_pdu(req);
>>   
>> +	WARN_ON(queue->request == req);
>> +	WARN_ON(llist_on_list(&req->lentry));
>> +	WARN_ON(!list_empty(&req->entry));
>>   	llist_add(&req->lentry, &queue->req_list);
> 
> Are we happy with a WARN here, or should this be handled as an error?
> The idea of an duplicate R2Ts creating a loop in req_list is
> frightening.
> 
It is, but wanted to check if others see this as an issue, too.
We actually should bail out and reset the connection; BUG_ON()
is pretty harsh, and not really appropriate as this isn't an error
on our side.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

