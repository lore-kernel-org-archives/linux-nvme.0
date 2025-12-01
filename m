Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56BED116F1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 08:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q01qSLhDlWk+n0vJOUW7owcRlbtApf4jkB1biQw3MMg=; b=03m+KPlPvgLluOqkuhRR1xjXgo
	HB1q3G2qrpb2gYruVPC8IY6BZFphwFMO5Rru4oDuPgp4PLdZD12HKmN/CaTZVljKEiFrN/+/FFi85
	1t2/aTVUKZOxFOchNyGjToQY1AmSR0prjYWwqm+HhzXYOXQ7EK7jHL3MyyFsQ93gE6r+QG3kaRPg/
	uydA1xlC8pVBwRNZ+pPYPQ+tW/vSmmp9ENH2YxXQWQLEPBAcO5mXDDsPqThY0TvhE89R1MJbSNj5M
	EbH3TCwkCVg7ALbZ3KyvU133+U3s608H63NyteCjhymHbXNa12fsEaGbd7rsMylRSBiWFtjHZSQxV
	ONXNRDsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPzcS-000000039s2-1GZE;
	Mon, 01 Dec 2025 08:50:52 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPzcQ-000000039rN-13LM
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 08:50:51 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75C0B33791;
	Mon,  1 Dec 2025 08:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764579048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q01qSLhDlWk+n0vJOUW7owcRlbtApf4jkB1biQw3MMg=;
	b=ImKZjqZ43wnMqXS92nPkQ2k0WVfeOK5MEes7E0sUPmVNf4Ky8M/erl3yyhNaXUeTMtsYhh
	bfdePLkylGwRwGXMQRbaBEto6x7avzMp3M0IK6e+G9tzSqA9zgBkpX2rMA6iHhgbbFmk1q
	12OX6lKoYoBtNQaUGxOVRPPbVcGV9m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764579048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q01qSLhDlWk+n0vJOUW7owcRlbtApf4jkB1biQw3MMg=;
	b=8sd/DAQXZfsx6iQfjgj8YVcufqOgYOBm0Btbbx9A2gfM0aihAsT8PEz2UgOD19PmnamFAg
	qoo+ax/QhZKmodAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ImKZjqZ4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="8sd/DAQX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764579048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q01qSLhDlWk+n0vJOUW7owcRlbtApf4jkB1biQw3MMg=;
	b=ImKZjqZ43wnMqXS92nPkQ2k0WVfeOK5MEes7E0sUPmVNf4Ky8M/erl3yyhNaXUeTMtsYhh
	bfdePLkylGwRwGXMQRbaBEto6x7avzMp3M0IK6e+G9tzSqA9zgBkpX2rMA6iHhgbbFmk1q
	12OX6lKoYoBtNQaUGxOVRPPbVcGV9m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764579048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q01qSLhDlWk+n0vJOUW7owcRlbtApf4jkB1biQw3MMg=;
	b=8sd/DAQXZfsx6iQfjgj8YVcufqOgYOBm0Btbbx9A2gfM0aihAsT8PEz2UgOD19PmnamFAg
	qoo+ax/QhZKmodAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D6753EA63;
	Mon,  1 Dec 2025 08:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VAwADehWLWmnNQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Dec 2025 08:50:48 +0000
Message-ID: <c27575e5-55a6-47ac-8be1-678d6a810721@suse.de>
Date: Mon, 1 Dec 2025 09:50:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] nvme-auth: switch to use 'struct key'
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-4-hare@kernel.org>
 <834f1966-5a05-4351-b7de-3a54fb5df9cf@grimberg.me>
 <a7c115c1-36cb-4521-8d9f-df07ff1554a8@suse.de>
 <d9188ff0-7467-403f-8cf2-e9a27a25f2e7@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <d9188ff0-7467-403f-8cf2-e9a27a25f2e7@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 75C0B33791
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_005050_437651_E7692FA9 
X-CRM114-Status: GOOD (  10.71  )
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

On 11/30/25 22:44, Sagi Grimberg wrote:
> 
> 
> On 27/11/2025 10:15, Hannes Reinecke wrote:
>> On 11/26/25 08:53, Sagi Grimberg wrote:
>>>
>>>
[ .. ]
>>>
>>> It is a bit confusing that you replace a generate_key with an 
>>> extract_key function.
>>> Can you explain a bit on this?
>>>
>>
>> It was probably a misnomer to start with.
>> 'nvme_auth_generate_key()' constructs a 'struct nvme_dhchap_key'
>> from the input parameters on the commandline.
>> (And so in a sense 'generates' it, without having anything to do
>> with the 'generated' key in the NVMe sense).
>> And internally 'nvme_auth_generate_key()' is a wrapper around 
>> 'nvme_auth_extract_key()' anyway.
> 
> This makes sense. Can you please put this in the patch description?

Sure. Will do for the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

