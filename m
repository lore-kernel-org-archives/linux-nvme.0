Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7D2D116F1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 08:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6QsjpecVN4yUVblYStfvxg2gEBuLB94THnBDytRWxIw=; b=kc+pGxpAspU2LwJFtvn5Er6PP7
	q7qj4qQ7l5ynRm8kxIRswhTZe8TBnBIT525poEP41NHUonblPuCtuuEeRCcmAJxK2/CWevqocxlx4
	w97SJfYaLef5IaWO1MAVNM4OPSTizQVyKGFzw+lR2U8dca5fo/VXu3RSyoENjRCj1SKSwXeuTlqF2
	Lv5AVDOa7ab08dW+VL95D0EY8s5O2aV7lZBSeUfjiwqd5x6XfuUhjxZD2ehSoQZyrJw84ILySPAze
	CYw+fH8InekZ0to+jtcwpJujUWgE4JxPjqBtKywR+Sp9F7ECibZX//3KZ1qVLQLx9PBF/QKdZrIkW
	OE/xlkKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPzbV-000000039fQ-1deP;
	Mon, 01 Dec 2025 08:49:53 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPzbT-000000039ez-0gDu
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 08:49:52 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5026933792;
	Mon,  1 Dec 2025 08:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764578989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QsjpecVN4yUVblYStfvxg2gEBuLB94THnBDytRWxIw=;
	b=1hOeb0QtTW0qVKKQlfhMWtXdxPUvFQpTqeaZuYZ7g0gYsDq9tzpdaKRDw2epC3MmLgletq
	2QlRTFu4FCjIxLebZ+lb+CN7/hEgr2r9bcJHbnI9QSi/IOE2BPjV+0d1vTiZVeOi29YUR5
	jNv6Fn9YEdsmlUClcHj5xJZhZzqn1wQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764578989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QsjpecVN4yUVblYStfvxg2gEBuLB94THnBDytRWxIw=;
	b=3w6XWg5mE8cbX2uB0dhuz/CTSDQEM//yMtLFIcnVrIc3NZ/LOcQqFq+xDScFIRpMWMiVBM
	3ESRN9Z3e7q0s+BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1hOeb0Qt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3w6XWg5m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764578989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QsjpecVN4yUVblYStfvxg2gEBuLB94THnBDytRWxIw=;
	b=1hOeb0QtTW0qVKKQlfhMWtXdxPUvFQpTqeaZuYZ7g0gYsDq9tzpdaKRDw2epC3MmLgletq
	2QlRTFu4FCjIxLebZ+lb+CN7/hEgr2r9bcJHbnI9QSi/IOE2BPjV+0d1vTiZVeOi29YUR5
	jNv6Fn9YEdsmlUClcHj5xJZhZzqn1wQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764578989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QsjpecVN4yUVblYStfvxg2gEBuLB94THnBDytRWxIw=;
	b=3w6XWg5mE8cbX2uB0dhuz/CTSDQEM//yMtLFIcnVrIc3NZ/LOcQqFq+xDScFIRpMWMiVBM
	3ESRN9Z3e7q0s+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1148A3EA63;
	Mon,  1 Dec 2025 08:49:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PmOTAq1WLWnmNAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Dec 2025 08:49:49 +0000
Message-ID: <4bbea4ec-fab6-4fbd-af57-db48727620c8@suse.de>
Date: Mon, 1 Dec 2025 09:49:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] nvme-auth: modify nvme_auth_transform_key() to return
 status
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-2-hare@kernel.org>
 <c01b35d7-d1a6-467e-b3e8-a1aa3d613f2d@grimberg.me>
 <55a3dfe4-3c7d-4b05-9131-a7077b1b3437@suse.de>
 <3b10eee4-d2d4-4576-a63b-0ade6e23481b@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3b10eee4-d2d4-4576-a63b-0ade6e23481b@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5026933792
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_004951_488566_1735B08F 
X-CRM114-Status: GOOD (  16.95  )
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

On 11/30/25 22:42, Sagi Grimberg wrote:
> 
> 
> On 27/11/2025 10:01, Hannes Reinecke wrote:
>> On 11/26/25 08:39, Sagi Grimberg wrote:
>>> Patch title is misleading. The addition is the transformed secret 
>>> output...
>>>
>>> On 28/05/2025 17:05, Hannes Reinecke wrote:
>>>> Modify nvme_auth_transform_key() to return a status and provide
>>>> the transformed data as argument on the command line as raw data.
>>>
>>> The patch is missing the why explanation. I mean it looks fine, its 
>>> unclear
>>> why we need this change.
>>>
>> To keep the knowledge of key contents inside the kernel keyring only, 
>> and avoid having to specify the key contents on the commandline (where
>> it's prone to show up in audit logs).
>> Also it allows for exteral provisioning of the keys; some other
>> application can provision the keys in the kernel keyring, and
>> nvme-cli can pick it up from there.
> 
> I wasn't referring to what the patchset is trying to solve for.
> The "why" refers to "Modify nvme_auth_transform_key() to return a status 
> and provide the transformed data as argument on the command line as raw 
> data" What would help the reviewer is something along the lines of: 
> "preparing for XXX" or "in a following patch the caller will be using it 
> for XXX"

Ah, right. Will do for the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

