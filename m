Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF28C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zuKRyKF09ZA2kKGYmAOBqIeiSzKj99VeH7vivdSL6tM=; b=37K/aVccUDYCOqAD8diICgr1cI
	Fc5RagSq8n8Gl9QhcstMBvdOQzncKE0HLz1QobLLXZdEWk+6k1MAd9kai72Q9jZjV9be2bYKaOAmE
	ecpofzxCqWv1riQ3DPqXhtG1e4gSRofog4vLhuptsML/RGyIb8a5a4gttisTkO9if7z1W1G7GXbpV
	JJI3O1Rm8k/02dGhbHYNLQEG82q6cXxVb5SUkEwBKF92SCwKfhb20Gr6vme+X0se9MtQaD7z31dyh
	8Yybs47qE75mAhdMsL1MHimdUaYIULJDTjXVAEP6NTvZmRxUXWRM0md3mqT34XmH+ClsDFhqEWVJK
	1XFF1uUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9jL8-00000009VdF-2G2B;
	Tue, 29 Apr 2025 11:41:30 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9jBr-00000009SLw-0ORX
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 11:31:56 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B76B1F391;
	Tue, 29 Apr 2025 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745926313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuKRyKF09ZA2kKGYmAOBqIeiSzKj99VeH7vivdSL6tM=;
	b=fxrVBEW0/2qyMM8IO5Fg137EBf6P76ujLmfsh0K9ttKa84Luu+KZfaZFZ68aZ2YR9pR94D
	lIV6IzlXn+yYVMR63pTmyQIUtltFfLujclRxK4KipKjBDnqu9syixA6AU1a/zLvGrjtEaF
	PLO8aAcAWL0ujfeZIY2TCQ/mNLfrKI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745926313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuKRyKF09ZA2kKGYmAOBqIeiSzKj99VeH7vivdSL6tM=;
	b=BbCD8QxIsvimMACzQJGpUXCRoA3MLbTtGyNYUP38aJVaCEJQX+hhIRXro1PMbvEvgHoHrf
	MKT1gxUHGNYxNhBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745926313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuKRyKF09ZA2kKGYmAOBqIeiSzKj99VeH7vivdSL6tM=;
	b=fxrVBEW0/2qyMM8IO5Fg137EBf6P76ujLmfsh0K9ttKa84Luu+KZfaZFZ68aZ2YR9pR94D
	lIV6IzlXn+yYVMR63pTmyQIUtltFfLujclRxK4KipKjBDnqu9syixA6AU1a/zLvGrjtEaF
	PLO8aAcAWL0ujfeZIY2TCQ/mNLfrKI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745926313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuKRyKF09ZA2kKGYmAOBqIeiSzKj99VeH7vivdSL6tM=;
	b=BbCD8QxIsvimMACzQJGpUXCRoA3MLbTtGyNYUP38aJVaCEJQX+hhIRXro1PMbvEvgHoHrf
	MKT1gxUHGNYxNhBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6433B1340C;
	Tue, 29 Apr 2025 11:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7mPDF6m4EGgSQwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Apr 2025 11:31:53 +0000
Message-ID: <a85a663c-25f5-4ecf-800c-adfb7114551c@suse.de>
Date: Tue, 29 Apr 2025 13:31:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-tcp: fix I/O stalls on congested sockets
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chris Leech <cleech@redhat.com>
References: <20250429081739.44820-1-hare@kernel.org>
 <20250429081739.44820-3-hare@kernel.org>
 <eb0ef09b-4266-4a3b-ad6f-0a6522a8d243@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <eb0ef09b-4266-4a3b-ad6f-0a6522a8d243@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_043155_275885_C7BC9F1C 
X-CRM114-Status: UNSURE (   6.38  )
X-CRM114-Notice: Please train this message.
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

On 4/29/25 11:13, Sagi Grimberg wrote:
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> I want kamaljit to give his Tested-by tag.

Sure.
I just wanted to push out the patches to give him a clean state
for his testing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

