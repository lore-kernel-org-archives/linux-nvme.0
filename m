Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42322CA0EE6
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 06:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2XMawW7GgoBy0gVYxELPsas7tv2tQN06qUuUwoK2W3o=; b=WMazhMo84sUYs9Wj/UtlS9H+zp
	Js60MdJImW28iPFY5do/LvnUNEGzSGqaFvw9xcYktALJbHpa7H3Le1asIeq0OmMMZLtgHPyQBGwuo
	Cy31k71R/mr+RtDcj4ScjJCnK27JtxENOmpbWJpdIfWNTB1axvt8gnPw6M56s6ximIyOB/TpBU0TB
	I/1RgYvqOn4JTU4F/hMwDG0hf5AF+MNAWfTmgG9KDiHqvjQWIpw9bbuiHBXhWXVjUBmbAK/qGbGzh
	pEYz+A0+MIPgKmyMoNMQogOon99r7MXLYLtJj8M6uAdB9j9pYUzmP2recZeOOEVUIFO6jjtQzjQD5
	uBYRc9WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoFXh-00000009Uq6-27Zd;
	Tue, 19 Aug 2025 06:09:57 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoFXf-00000009UpW-0l5H
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 06:09:56 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F38621257
	for <linux-nvme@lists.infradead.org>; Tue, 19 Aug 2025 06:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755583793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XMawW7GgoBy0gVYxELPsas7tv2tQN06qUuUwoK2W3o=;
	b=eTj4iaKQKcytaBkcPE6l5vr1kzFd8FzOVEOSxtjz+YJZMYnO1vD04IaYEqtKNw0NbHTqNI
	pOfEx31pZgjP2HqE7xjcIFxzZKksnnwDow90KL6xvwZcefKlu9QFkcRnQuBnEWZ0C/w69H
	WqKmYlM6cnnDzxgqsOGsmIYe1GKzJFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755583793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XMawW7GgoBy0gVYxELPsas7tv2tQN06qUuUwoK2W3o=;
	b=xABWGq+lUp+cvQ9a1i2/Z/RQi82DX9Cl0iKJOwJDT2qe0zwZR38MQRh+3nnP05BEqfWlGL
	y9isSPFlneTW30DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eTj4iaKQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xABWGq+l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755583793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XMawW7GgoBy0gVYxELPsas7tv2tQN06qUuUwoK2W3o=;
	b=eTj4iaKQKcytaBkcPE6l5vr1kzFd8FzOVEOSxtjz+YJZMYnO1vD04IaYEqtKNw0NbHTqNI
	pOfEx31pZgjP2HqE7xjcIFxzZKksnnwDow90KL6xvwZcefKlu9QFkcRnQuBnEWZ0C/w69H
	WqKmYlM6cnnDzxgqsOGsmIYe1GKzJFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755583793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XMawW7GgoBy0gVYxELPsas7tv2tQN06qUuUwoK2W3o=;
	b=xABWGq+lUp+cvQ9a1i2/Z/RQi82DX9Cl0iKJOwJDT2qe0zwZR38MQRh+3nnP05BEqfWlGL
	y9isSPFlneTW30DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F0A5139B3
	for <linux-nvme@lists.infradead.org>; Tue, 19 Aug 2025 06:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fUWiHDEVpGiFDAAAD6G6ig
	(envelope-from <hare@suse.de>)
	for <linux-nvme@lists.infradead.org>; Tue, 19 Aug 2025 06:09:53 +0000
Message-ID: <7a48ed7a-bbc6-4847-94bb-8fb08def0ca4@suse.de>
Date: Tue, 19 Aug 2025 08:09:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unable to reconnect namespace via NVMe/TCP
To: linux-nvme@lists.infradead.org
References: <CAAiJnjqKqMHjrPLOvY5sCXiQR0n6pMvm2mS5pQEqy2XY1cD_6Q@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAAiJnjqKqMHjrPLOvY5sCXiQR0n6pMvm2mS5pQEqy2XY1cD_6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 9F38621257
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_230955_512174_27E7431C 
X-CRM114-Status: GOOD (  11.67  )
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

On 8/12/25 17:48, Anton Gavriliuk wrote:
> Hi
> 
> There are NVMe/TCP target and initiator servers, both running on
> RHEL10 (6.12.0-55.25.1.el10_0.x86_64)
> 
> NVMe/TCP target exports single NVMe SSD
> 
>        "namespaces": [
>          {
>            "device": {
>              "nguid": "01000000-0000-0000-8ce3-8ee3064aa4f2",
>              "path": "/dev/nvme0n1"
>            },
>            "enable": 1,
>            "nsid": 1
>          }
>        ],
> 
> If NVMe/TCP target is not available, initiator tries to reconnect
> every 10 seconds
> 
> [ 2586.071048] nvme nvme9: failed to connect socket: -111
> [ 2586.071403] nvme nvme9: Failed reconnect attempt 16/-1
> [ 2586.071565] nvme nvme9: Reconnecting in 10 seconds...
> [ 2596.310921] nvme nvme9: failed to connect socket: -111
> [ 2596.311186] nvme nvme9: Failed reconnect attempt 17/-1
> [ 2596.311349] nvme nvme9: Reconnecting in 10 seconds...
> [ 2606.550772] nvme nvme9: failed to connect socket: -111
> [ 2606.551252] nvme nvme9: Failed reconnect attempt 18/-1
> [ 2606.551592] nvme nvme9: Reconnecting in 10 seconds...
> 
> when NVMe/TCP target become available, initiator failed reconnect the namespace
> 
> [ 2606.551592] nvme nvme9: Reconnecting in 10 seconds...
> [ 2616.793080] nvme nvme9: creating 16 I/O queues.
> [ 2616.829881] nvme nvme9: mapped 16/0/0 default/read/poll queues.
> [ 2616.833685] nvme nvme9: Successfully reconnected (attempt 19/-1)
> [ 2616.834446] nvme nvme9: identifiers changed for nsid 1
> [ 2616.835618] block nvme9n1: no usable path - requeuing I/O
> [ 2616.856602] block nvme9n1: no available path - failing I/O
> [ 2616.856811] block nvme9n1: no available path - failing I/O
> 
> and there is no nvme9n1 namespace in the "nvme list" output.
> 
This looks like the missed re-scan issue I found recently.
Should be fixed with
9546ad1a9bda ("nvme: requeue namespace scan on missed AENs")

(And you are running RHEL. Please open a bugzilla with RH.)
(And why am I even answering that?)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

