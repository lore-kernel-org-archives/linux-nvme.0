Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FD606A32D
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WeZZW0Y3;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Eo799los;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HxRGKCHN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Eo799los;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HxRGKCHN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2Q7CdRj+MCvFMxohcbN3zjaqZjL02AoaQHV5q/7P7x0=; b=WeZZW0Y32tdWJn
	+MELpClC//h5MCVR1grgwNpnHo61OC2VbpIe2TuCpzC3+yh1+ZkA4oFHSo7o+0/GvIGZLECST/rOA
	w/89xe5MjEOL8cGH+7r8bt5I4q4cDHaVBBeeugjUTauxNpkVktJsx8CP941P6nBUgiqoOzKeV+LSP
	zLYAp36vF+hsTmba79APeTA8AikcG2W6aoSsHDqp1DURfYR7p8HX3pyBINbWsP+nBvEa3NJNALCuc
	YKOuqaRToABUUTfjN5eIwmIuS275OJCV0yF3Hkj9BmPyyW+f+t2Ui0Zhx601rclarD5fP47fcR4/o
	LUeIq/GyYUzN+XLfSnAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVW96-000000042l8-1Xkq;
	Mon, 23 Nov 2026 15:39:56 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVW92-000000042je-2yde
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 15:39:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A29491F84B;
	Mon, 23 Nov 2026 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795448390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q7CdRj+MCvFMxohcbN3zjaqZjL02AoaQHV5q/7P7x0=;
	b=Eo799los/WG7AgHd5RxhJRtHLaKJ3337K8DDk/4oVdoGOKoSdS7aWAqndsWHs3ujMrLbU7
	FbVnO4JLwwQJ+CTE8o79NF2655MnJuc0oeXGDUo3oNuePLjvNywCliRYjk02b+sxwY91OI
	mjfbxbc6i6N5buSFKH0+Gd9a4hC0ca0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795448390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q7CdRj+MCvFMxohcbN3zjaqZjL02AoaQHV5q/7P7x0=;
	b=HxRGKCHN57bPD6a2nu5pf5xoUrfPk7AGqt44WWk+o65E+PQ9yCw3OJ53GuG0eD3QSzJffu
	Po0xyCI1mav2DoBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Eo799los;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HxRGKCHN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795448390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q7CdRj+MCvFMxohcbN3zjaqZjL02AoaQHV5q/7P7x0=;
	b=Eo799los/WG7AgHd5RxhJRtHLaKJ3337K8DDk/4oVdoGOKoSdS7aWAqndsWHs3ujMrLbU7
	FbVnO4JLwwQJ+CTE8o79NF2655MnJuc0oeXGDUo3oNuePLjvNywCliRYjk02b+sxwY91OI
	mjfbxbc6i6N5buSFKH0+Gd9a4hC0ca0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795448390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q7CdRj+MCvFMxohcbN3zjaqZjL02AoaQHV5q/7P7x0=;
	b=HxRGKCHN57bPD6a2nu5pf5xoUrfPk7AGqt44WWk+o65E+PQ9yCw3OJ53GuG0eD3QSzJffu
	Po0xyCI1mav2DoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 529791352B;
	Mon, 23 Nov 2026 15:39:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6OALC0ZeBGutJQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Nov 2026 15:39:50 +0000
Message-ID: <5f994e96-c662-48c5-82c8-7940e2c0a872@suse.de>
Date: Mon, 23 Nov 2026 16:39:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] nvme-auth: switch to use the kernel keyring
To: Martin Belanger <martin.nvme.dev@gmail.com>,
 Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <5aa50b65-c502-4b87-8f09-23a456e2ca6a@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5aa50b65-c502-4b87-8f09-23a456e2ca6a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.00
X-Spam-Level: 
X-Rspamd-Queue-Id: A29491F84B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_073952_914038_0AF0E527 
X-CRM114-Status: GOOD (  20.72  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 1:59 PM, Martin Belanger wrote:
> 
> 
> On 11/23/26 07:14, Hannes Reinecke wrote:
>> With this I have updated the dhchap arguments to 'nvme connect' and
>> the configfs interface to either be the keydata (ie the original
>> interface) _or_ a key description referring to a pre-populated dhchap
>> key in the kernel keyring.
> 
> Hi Hannes,
> 
> How should nvme-cli determine whether the kernel accepts a key
> description for DH-HMAC-CHAP?
> 
> I will add DH-HMAC-CHAP support to nvme-keysd. It will import the
> secrets into the .nvme keyring, the same way it imports TLS PSKs
> today, and nvme-cli will pass the key description to 'nvme connect'.
> On an older kernel, nvme-keysd must not import the secrets, and
> nvme-cli must pass the key data instead. So both need to know what
> the kernel supports.
> 
> I see these options:
> 
> 1. Check the kernel version. This does not cover backports.
> 
> 2. Use a separate option for the key description, for example
>     dhchap_key=%s and dhchap_ctrl_key=%s. nvme-cli would then detect
>     support through /dev/nvme-fabrics, as it does for the other
>     options. It also avoids having one string that can mean either a
>     description or key data.
> 
> 3. Something else. add_key() fails with ENODEV when the 'dhchap' key
>     type does not exist, but this does not show that the connect
>     options accept a description.
> 
I think option 2) is the easiest. We already have support for that
selection mechanism in nvme-cli, and anyone backporting only parts
of this series deserves no better.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

