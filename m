Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878CBC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 06:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qZkAW6H9/M+NSAXJp9PAkVtakl/9na4DWmGt2EZQFgQ=; b=nJBHuCcW78hutuy+djeVpowSEP
	adHi6rh5Lx1cg/M7p1WEh/83qVWw8ZFnjWa2ukjQeRm1mMUmPaEfzsXaWXho6b0iJzaF8AM/mqKxo
	9A2Q/xUKp8pyCY0BjaOaHacIFKsPceei8nf5YpjDVg56uWRnY3D4++Mdk4d+yF0AjX30DIh+mW71b
	oYSjiQb5lKixLiWJyBBNTNxjvm4XUkimw/cHA2R9kzHClPZu1Rds0Ph7fqAmlMVYcIOz5ribPIvG5
	ciZko6W0C8oFBqqwD4vjQLk4l2Q8vOkPueoQN0PCvJ5QU7V16lonSSZGDKcanxadEDQkyL7uTvXUm
	DrMbe1gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ZNA-00000004clh-1Mdd;
	Tue, 15 Apr 2025 06:02:16 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ZLn-00000004cah-2qeL
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 06:00:53 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E49EF210F6;
	Tue, 15 Apr 2025 06:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744696849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZkAW6H9/M+NSAXJp9PAkVtakl/9na4DWmGt2EZQFgQ=;
	b=shGOipY3bJlKTsH8Uw+KoVto102IPcj6q67Bh98marMbEvcG4FM3cXdv7iHvikJFy/f7YT
	oR6QTSj7eH0oTLunRhMaHBGUucCGHP9l42hEkGyyopiyBm7LzUYX88JWBkt9mBhPm7pgFi
	1CSVj1jFMwrrkSrbk26PfZmsylSJlrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744696849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZkAW6H9/M+NSAXJp9PAkVtakl/9na4DWmGt2EZQFgQ=;
	b=F0D09nCMYPNgLDlxzmJAhE9Moh/VS1M+CuWpukhFJIXNlVLyXwMXrAC6Skhiq+B8hX42cb
	c0aaQC2a5X1qITDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744696849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZkAW6H9/M+NSAXJp9PAkVtakl/9na4DWmGt2EZQFgQ=;
	b=shGOipY3bJlKTsH8Uw+KoVto102IPcj6q67Bh98marMbEvcG4FM3cXdv7iHvikJFy/f7YT
	oR6QTSj7eH0oTLunRhMaHBGUucCGHP9l42hEkGyyopiyBm7LzUYX88JWBkt9mBhPm7pgFi
	1CSVj1jFMwrrkSrbk26PfZmsylSJlrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744696849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZkAW6H9/M+NSAXJp9PAkVtakl/9na4DWmGt2EZQFgQ=;
	b=F0D09nCMYPNgLDlxzmJAhE9Moh/VS1M+CuWpukhFJIXNlVLyXwMXrAC6Skhiq+B8hX42cb
	c0aaQC2a5X1qITDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA4D9139A1;
	Tue, 15 Apr 2025 06:00:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8F3eKxH2/WdWFwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 15 Apr 2025 06:00:49 +0000
Message-ID: <92dff698-4a18-4675-b033-f42f7a7db325@suse.de>
Date: Tue, 15 Apr 2025 08:00:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme-fabrics: reset admin connection for secure
 concatenation
To: Sagi Grimberg <sagi@grimberg.me>, Dan Carpenter
 <dan.carpenter@linaro.org>, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <a10a314e-0a2b-4b28-8aaf-38e4e2129e3d@stanley.mountain>
 <d88872cc-a58d-49a4-ac3b-3caf29102949@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <d88872cc-a58d-49a4-ac3b-3caf29102949@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_230051_860613_8E986961 
X-CRM114-Status: GOOD (  10.43  )
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

On 4/14/25 23:50, Sagi Grimberg wrote:
> 
> 
> On 22/03/2025 9:40, Dan Carpenter wrote:
>> Hello Hannes Reinecke,
>>
>> This is a semi-automatic email about new static checker warnings.
>>
>> Commit 104d0e2f6222 ("nvme-fabrics: reset admin connection for secure
>> concatenation") from Feb 24, 2025, leads to the following Smatch
>> complaint:
>>
>>      drivers/nvme/host/tcp.c:2359 nvme_tcp_setup_ctrl()
>>      warn: variable dereferenced before check 'ctrl->opts' (see line 
>> 2355)
>>
>> drivers/nvme/host/tcp.c
>>    2354
>>    2355        ret = nvme_tcp_configure_admin_queue(ctrl, new);
>>                                                       ^^^^
>> ctrl->opts is dereference here
>>
>>    2356        if (ret)
>>    2357            return ret;
>>    2358
>>    2359        if (ctrl->opts && ctrl->opts->concat && !ctrl- 
>> >tls_pskid) {
>>                      ^^^^^^^^^^
>> so hopefully this check can be safely removed.
> 
> Yes it can.
> 
> Hannes, can you send a patch to remove this check?
> 
> Thanks Dan.

Done.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

