Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5549CC02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 11:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9hgcXd0YAh5jv4UCc6SohnazbpwGxdqHlJhdi/ZVqUU=; b=qxkcq/EonmFb+HNep2R1S9aGLM
	BBTmLCx7xPlkjJfP67zn5W9oTFnETFSC21bBc/v0WwdUqRK0SUH50FK2FtDFpI//b+rQttsdPLoYl
	k2u+DhoSPegWYvhn9i3HTXD2p7AFoQD2u+aiqJAd7UIymXzHBxEhW3RY2QE3nKDLQ0NREUp37HPiY
	Wk+o2uwfEEgho+3bLOQFVKztyzQbNs1IAcfMHdXb2Yq6bvjelHRB1vEKWCQ1UU4LWpYJElmIWXJ5n
	WZXvg9RsGpicOlY+FH1SvDI8Aej1MeF6hzOn4bNz5Qu5leiY8mWPGcRGo5NnXhaMiW5kRZ7MHdao9
	8HoX2KlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbHZ9-0000000EXU4-3a5h;
	Fri, 24 Jan 2025 11:09:35 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbHZ7-0000000EXTh-1hWM
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 11:09:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8079A21168;
	Fri, 24 Jan 2025 11:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737716971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hgcXd0YAh5jv4UCc6SohnazbpwGxdqHlJhdi/ZVqUU=;
	b=MkBLP1fw7RF81YcDbWnZe7XK/VGJtLE8thTdzK83dOJs5OKT1XMCAd/YXoEpd4EBO0a9ZW
	mXai5MqsB14kH7hTO8tnGmb6RUADZtVcbEYyBqudRzwf7IrG9/9FavWjoINo7kJFclchsp
	BmWvfwPC2dTYJVRVh4nooVVhOKwn4No=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737716971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hgcXd0YAh5jv4UCc6SohnazbpwGxdqHlJhdi/ZVqUU=;
	b=aGHTFC4IQSRhsBIHjcZyfgdbVfHdzeId3TqKMu17PS4lQEYsAMQlAbZ1qcXHcJtt/VdWk3
	A1ZSGnUQnBwMsUDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MkBLP1fw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aGHTFC4I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737716971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hgcXd0YAh5jv4UCc6SohnazbpwGxdqHlJhdi/ZVqUU=;
	b=MkBLP1fw7RF81YcDbWnZe7XK/VGJtLE8thTdzK83dOJs5OKT1XMCAd/YXoEpd4EBO0a9ZW
	mXai5MqsB14kH7hTO8tnGmb6RUADZtVcbEYyBqudRzwf7IrG9/9FavWjoINo7kJFclchsp
	BmWvfwPC2dTYJVRVh4nooVVhOKwn4No=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737716971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hgcXd0YAh5jv4UCc6SohnazbpwGxdqHlJhdi/ZVqUU=;
	b=aGHTFC4IQSRhsBIHjcZyfgdbVfHdzeId3TqKMu17PS4lQEYsAMQlAbZ1qcXHcJtt/VdWk3
	A1ZSGnUQnBwMsUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6800713999;
	Fri, 24 Jan 2025 11:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W0PuGOt0k2dxLQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 24 Jan 2025 11:09:31 +0000
Message-ID: <f2dc374b-0a08-48fa-bd9f-1cfccd34446d@suse.de>
Date: Fri, 24 Jan 2025 12:09:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: move percpu handling into
 nvmet_ns_{enable,disable}
To: Sagi Grimberg <sagi@grimberg.me>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250124082505.140258-1-hare@kernel.org>
 <afe8968e-ff56-4907-b3ec-a79ac75d5250@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <afe8968e-ff56-4907-b3ec-a79ac75d5250@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8079A21168
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_030933_592311_664ED7E9 
X-CRM114-Status: GOOD (  11.62  )
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

On 1/24/25 11:50, Sagi Grimberg wrote:
> 
> 
> 
> On 24/01/2025 10:25, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@kernel.org>
>>
>> The namespace percpu counter protects pending I/O, and we can
>> only safely diable the namespace once the counter drop to zero.
>> So we need to init the percpu counter in nvmet_ns_enable(), and
>> wait for it to drop to zero in nvmet_ns_disable() to avoid having
>> I/O pending after the namespace has been disabled.
>>
>> Fixes: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
> 
> Can you please describe the bug and scenario which you are hitting this 
> bug?
> It is also unclear how the above patch is causing this.
> 
>  From quick look patch itself looks reasonable.

Should've said: this is the fix to the reported blktest failure
on nvme/058...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

