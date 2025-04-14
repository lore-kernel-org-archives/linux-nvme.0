Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27691C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 12:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hnne692P/dybF1uXLDdGVcPaAOF+Qn1k7QErb3MFCPQ=; b=MxNs0pfHhq5uuHZh3k3nhl+zwM
	T98P+sgxKQjQF4Vj+HgEnzRGPV+QGa3Y3XkVuFCZN99EEf3o/YBJD0SX5BUKcyLeTuPQEBCvRDU0Z
	tKj45JXqXEDotZoyHxRRuNktS4WE7cX13xIE/fLyMMh3/f8lZ5clowZFITQ6xuQFCgQpGWWBm98UR
	tSNvnl9S5H59ZeRtBba0ChL6LmO+ZJwjBDm8haljvIczluw+ZvsBBes+i3qK5Zzr9xsB9hNnJ4Ugd
	q3G3Qvajb7mJVkEjhn2BxbPxb6FT9VbejK1v/JUcURodJzrSqELagg1sAAsvU0Q2+RdTQj/mUfHkk
	8XiSvShQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4IWY-00000001rvo-3P6a;
	Mon, 14 Apr 2025 12:02:50 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4IPR-00000001r0P-1FLd
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 11:55:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7741B1F45F;
	Mon, 14 Apr 2025 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744631727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnne692P/dybF1uXLDdGVcPaAOF+Qn1k7QErb3MFCPQ=;
	b=nWQsYjqeKyrkrjoVVxtQawe6YtuXa+fEXvBYHftTOMeDlPey8rnJuWe+AQQNMMhLhef4lj
	NpFhHSfnrqLRug19ug4O8huniVleDNbwpNPq5uayZTNY5SQAAQuNzjrURvTChDDqx6Xrkv
	JuXGgUBZ+p8qOmeO7NCmY+YGoBgpmjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744631727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnne692P/dybF1uXLDdGVcPaAOF+Qn1k7QErb3MFCPQ=;
	b=4pKHpDr9xWzZoAIKRX2xIdB/FH0TjVGoZtR+kvyn2qDpacefU3gIGHYV+d+PBuiGxQZZVC
	AluuR2SQ/QWDlVAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nWQsYjqe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4pKHpDr9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744631727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnne692P/dybF1uXLDdGVcPaAOF+Qn1k7QErb3MFCPQ=;
	b=nWQsYjqeKyrkrjoVVxtQawe6YtuXa+fEXvBYHftTOMeDlPey8rnJuWe+AQQNMMhLhef4lj
	NpFhHSfnrqLRug19ug4O8huniVleDNbwpNPq5uayZTNY5SQAAQuNzjrURvTChDDqx6Xrkv
	JuXGgUBZ+p8qOmeO7NCmY+YGoBgpmjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744631727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnne692P/dybF1uXLDdGVcPaAOF+Qn1k7QErb3MFCPQ=;
	b=4pKHpDr9xWzZoAIKRX2xIdB/FH0TjVGoZtR+kvyn2qDpacefU3gIGHYV+d+PBuiGxQZZVC
	AluuR2SQ/QWDlVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46A5B136A7;
	Mon, 14 Apr 2025 11:55:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GO4CEK/3/GfcXQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 14 Apr 2025 11:55:27 +0000
Message-ID: <564eb846-6208-49c0-bdf9-409568698dd0@suse.de>
Date: Mon, 14 Apr 2025 13:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: handle partially unique NID value
To: Christoph Hellwig <hch@lst.de>
Cc: hare@kernel.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>,
 Javier Gonzalez <javier.gonz@samsung.com>, Daniel Wagner <dwagner@suse.de>
References: <20250414090959.2015-1-hare@kernel.org>
 <20250414111916.GB13225@lst.de>
 <3e6fb1f6-d6f0-4f33-9389-dff37daae7b0@suse.de>
 <20250414114128.GA13822@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250414114128.GA13822@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7741B1F45F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_045529_482043_4C9E36F1 
X-CRM114-Status: GOOD (  13.21  )
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

On 4/14/25 13:41, Christoph Hellwig wrote:
> On Mon, Apr 14, 2025 at 01:31:29PM +0200, Hannes Reinecke wrote:
>> We have discussed this at LSF, and the involved parties (ie
>> Samsung as the vendor, HPe as the IHV, and us as the OS provider)
>> are happy with this approach.
>> And we have paying customers for which the cited patch caused a regression,
>> so ignoring it is not an option for us.
> 
> Tell them to fix their broken systems instead of shifting this broken
> crap upstream.  Really, we bend over backwards for consumer hardware
> that doesn't know better.  We don't add crap for vendors that absolutely
> should know better participate in the working group and only provide
> expensive enterprise hardware just because they pay you.  If you have
> so little spine that you want to accommodate this intentionally broken
> behavior do it in your tree but don't force the burden on others.

A simple NACK would have been sufficient.

Cheers,

Hannes 'spineless' Reinecke
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

