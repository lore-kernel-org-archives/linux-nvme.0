Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1A5CDB471
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 07:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jQ99NY4RNwizokAbXmo1xB8UcMjUFItb6lYhcjfE5xs=; b=UOzfCxabIZsdARwuSw2KR8uw5C
	Wv+04AumFXBntApTqMlVuNGMLZjzbmQJabsfGNqe6rg2s/zH4nnH9A2ZT8dF39KiBWeiaDJLBvXsR
	Jqawh2T6gR43wiuAUqfJ99zVt/Drac1VeK1a+/uQ0j0M2fKiNhXeECF3xAC22h0Y2K6aVp5MW9rq1
	TZjvvWlnkau1N4Wrbs9PxuzFH4Ao//IDdbjbb+up63K+E3h0p51gGErUH+0lg3/Eh5cFCOAQRzsa4
	F25CFAAsaVcyYTIoBMmjDtWeshY33Nq604IuL4kfakfQTKTRHz8YJ3Sa23GJY1mBVEHJKG99EWIqA
	chsYasmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbYsM-00000004X0L-20Z6;
	Mon, 22 Jun 2026 07:15:22 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbYsK-00000004Wzu-12GE
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 07:15:21 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BFAED70653;
	Mon, 22 Jun 2026 07:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782112516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQ99NY4RNwizokAbXmo1xB8UcMjUFItb6lYhcjfE5xs=;
	b=YqMqvuDK5tIerpTLtvIgTaoM2A3Yw01LBm2lqIfqNkKKD6CfOvGElIlEaPV4VZE0U/xxcE
	msCirFCT3QNtcVBV75IntjlHh4jU43IB1o3U1/0LxNMZzNMsGBFHdu91twnnRayZ+/uP2F
	RUTLeCWwsmVthi49BYlhILKhCu/wxSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782112516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQ99NY4RNwizokAbXmo1xB8UcMjUFItb6lYhcjfE5xs=;
	b=3+pQHo7dpzPXvAXFkD9qyC1QcGnWBGROe0G+38mhMDcNpixUWkIpGhmbKqO9YO5z4DPT5D
	iChxGSy5v5++iABg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782112516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQ99NY4RNwizokAbXmo1xB8UcMjUFItb6lYhcjfE5xs=;
	b=YqMqvuDK5tIerpTLtvIgTaoM2A3Yw01LBm2lqIfqNkKKD6CfOvGElIlEaPV4VZE0U/xxcE
	msCirFCT3QNtcVBV75IntjlHh4jU43IB1o3U1/0LxNMZzNMsGBFHdu91twnnRayZ+/uP2F
	RUTLeCWwsmVthi49BYlhILKhCu/wxSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782112516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQ99NY4RNwizokAbXmo1xB8UcMjUFItb6lYhcjfE5xs=;
	b=3+pQHo7dpzPXvAXFkD9qyC1QcGnWBGROe0G+38mhMDcNpixUWkIpGhmbKqO9YO5z4DPT5D
	iChxGSy5v5++iABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 795C1779A8;
	Mon, 22 Jun 2026 07:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xfEfHAThOGolMwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 22 Jun 2026 07:15:16 +0000
Message-ID: <d46493a3-3c9c-4799-bd63-e8759f04463c@suse.de>
Date: Mon, 22 Jun 2026 09:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during async
 scan
To: Keith Busch <kbusch@kernel.org>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>,
 John Meneghini <jmeneghi@redhat.com>, Maurizio Lombardi
 <mlombard@redhat.com>, hch@lst.de, chaitanyak@nvidia.com,
 bvanassche@acm.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, James.Bottomley@hansenpartnership.com,
 emilne@redhat.com, bgurney@redhat.com
References: <20260225161203.76168-1-mlombard@redhat.com>
 <aZ9sjbZ3CEW_1rW1@kbusch-mbp> <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
 <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
 <aaCNtpPzP9TIDNjE@kbusch-mbp> <869034b1-c7e8-4e35-b153-43fd787a8edd@suse.de>
 <aaXE4s3AT45UIAN8@kbusch-mbp> <DJBICZU143X2.3S261SDT21N0V@arkamax.eu>
 <ajRpWLqaEyA6cwkJ@kbusch-mbp> <531aa19b-a9ae-44f7-82ce-3714621ceee8@suse.de>
 <ajWOWdD0P5ri9bWY@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ajWOWdD0P5ri9bWY@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_001520_456409_51C1EEF4 
X-CRM114-Status: GOOD (  15.41  )
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

On 6/19/26 20:45, Keith Busch wrote:
> On Fri, Jun 19, 2026 at 07:59:43AM +0200, Hannes Reinecke wrote:
>> The problem here is namespace lifetime. The ns_ida is only ever released
>> at the very last step, so the 'number' of the namespace will only be freed
>> once all references to the namespace are dropped.
>> So if you were trying to keep the namespace number ordered you would
>> have to delay the creation of the namespace until that point, and you
>> would induce a serialization between deletion and creation.
> 
> Under the proposed scheme, there is no ns_ida. You just use the NSID of
> the namespace, and that's it. You have to ensure that del_gendisk
> completed on all heads and paths that was using it prior to bringing up
> the next one, but that's not really a problem.
> 
But then you'll have to delay the (re-)scan until the very last 
reference is gone, otherwise the nsid the scan is about to create
will be blocked by the nsid still pending to be deleted.

And we do have blktest nvme/058 as a really nice testcase for executing
rapid namespace remapping; that regularly manages to get the 'nsid'
and 'ns_ida' numbers getting out of sync.

In general I fail to see the issue here.
Any modern distro should be using persistent device links to access
devices, so the actual device name is pretty much irrelevant.
We on our side haven't had any issues here since ages.

And scanning has been one of the most complex operations we are doing
on nvme, and so I'd really think twice before changing that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

