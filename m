Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD669C3ABC3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 09:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TXgU7THCH3QTwW2N9m9LPYV/splDqC7VhMVklHHmNmk=; b=DniI8IqqXjwMzFlgv++FosN4y9
	Th02cQJYuOHI/ZLBlA6qOqCoAqpwe+tL0ceFxiUgrMu2SNnYusP9OK0WYrOwASxduCCcElfxB1Yk2
	utgaJNYthJVu3jW+wH5k5A0FnnP5c/FYiJKhtvtvoULMZ7Mz3CFMS4PcKPNYqLNj4IioZUomXtZQ7
	m42s04WkqP5HpckRbg3L/U5j6Tv/XLmf8TL3BWWVUmwOLe9GSTd3hK3+N9VV4pzhG4UeMMsh+lws/
	HdzwYWPJyK3xOBYkWo8KGGswncnclaL6qe0sH4MG5ObJelE9K6+CfcMlkj4sH1IHu1h/NDL6a5Rnr
	BwmS3CFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCb78-0000000EyBd-3MyU;
	Wed, 07 May 2025 09:30:54 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaGW-0000000EmM3-26W2
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 08:36:36 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8E1021182;
	Wed,  7 May 2025 08:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746606990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXgU7THCH3QTwW2N9m9LPYV/splDqC7VhMVklHHmNmk=;
	b=cTNDxGToKZm2J6Ju2ztElnKIvYDZjy8NBfJoVgmxy3uPPLHxYSdExAoGKfxp43nahz5gu9
	4FtnoNOs9d31eLu5kWJJEe/WglZI5hC/FJPfRg02V8bhkRz9k6jG1hxjxyhYmIma/7uPDZ
	dyC3yfwY+7lJF29d272t3adXzbGLfoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746606990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXgU7THCH3QTwW2N9m9LPYV/splDqC7VhMVklHHmNmk=;
	b=vor2kxzYaJ10duteLWGKdKoRF6eobr3wVLjH5961XZJlbrUSuPREbElN82rGAEmEOIbFjb
	vr0+kpe7Uh5CPGAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cTNDxGTo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vor2kxzY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746606990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXgU7THCH3QTwW2N9m9LPYV/splDqC7VhMVklHHmNmk=;
	b=cTNDxGToKZm2J6Ju2ztElnKIvYDZjy8NBfJoVgmxy3uPPLHxYSdExAoGKfxp43nahz5gu9
	4FtnoNOs9d31eLu5kWJJEe/WglZI5hC/FJPfRg02V8bhkRz9k6jG1hxjxyhYmIma/7uPDZ
	dyC3yfwY+7lJF29d272t3adXzbGLfoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746606990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXgU7THCH3QTwW2N9m9LPYV/splDqC7VhMVklHHmNmk=;
	b=vor2kxzYaJ10duteLWGKdKoRF6eobr3wVLjH5961XZJlbrUSuPREbElN82rGAEmEOIbFjb
	vr0+kpe7Uh5CPGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B54E9139D9;
	Wed,  7 May 2025 08:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xEarK44bG2j/agAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 May 2025 08:36:30 +0000
Message-ID: <5ebf1f1a-48b8-454c-8c1f-eebbed04165c@suse.de>
Date: Wed, 7 May 2025 10:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
To: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-nvme@lists.infradead.org
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <ee591788-e2fc-4407-9f78-d73a6f406438@grimberg.me>
 <aBsSmc7W8Cx7n9md@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aBsSmc7W8Cx7n9md@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C8E1021182
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_013632_685741_4FC53C88 
X-CRM114-Status: GOOD (  15.30  )
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

On 5/7/25 09:58, Christoph Hellwig wrote:
> On Wed, May 07, 2025 at 10:50:00AM +0300, Sagi Grimberg wrote:
>> Just so I understand, this is a separate issue from passing the keyring to
>> tlshd correct? Is the suggesting that nfs will create a special .nfs keyring
>> similar to what nvme does?
> 
> Yeah.
> 
>> Note that nvme also allows the user to pass its own keyring (never tried
>> it before - we probably need a blktest for it //hannes). So in this case,
>> the
>> possessor will need to set user READ perms on the key itself (assuming that
>> it updated tlshd.conf to know this keyring)?
> 
> I think so.  Or give user read permissions for the keys (which from
> my limited undertanding renders the patches a bit useless).
> 
> Let me send out my current patches and discuss it there.
> 
The canonical way here is to link the requested keyring into the
session keyring of the calling process. That way you have access
to the keys in that keyring.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

