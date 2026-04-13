Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F203EBFD0A
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 07:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MwX77/VJxa21uh8TVve6Qkvdkw3XMpCA95RLfNyfj+c=; b=NF48tl8GBjTKE7HB2TVyBXjx1w
	3H4CPX1qg7h4U/tQ88RlhGIRbaZwfMDOOH8EXC4sGhuCTbpdrrjh2vTH/ZG4Xg218h2p3O65pjupP
	W2Mxmyicch1hutEEl2HxMxLS7FhQ/uUgh9mkz+h7WQDvHKKE5JnX3iZcgtG1wPt9buO+wqqFeSQqE
	nsti/yP+trYTcmtIquh0SQ28+0SPoGil6Q6YzLFpfk1DmyLM7zFxCJ0Kv/qDLwx+T7aLcLGzJWRAg
	J0WXh4zThqm6AKiCh5hxyxXwOrYJjYryzRWj1VZZwG4g6cfxwZ5KuHOVsBJgqlEkSEfnVwuO0pm2B
	n5C0d/Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCC20-0000000FBnT-3Drm;
	Mon, 13 Apr 2026 07:48:28 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCC1x-0000000FBn7-0UC9
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 07:48:26 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F6236A88F;
	Mon, 13 Apr 2026 07:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776066503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwX77/VJxa21uh8TVve6Qkvdkw3XMpCA95RLfNyfj+c=;
	b=pFU/HPffP5C/HEugZonK1Ohck8rzrbRD9LtePuYbEoe9rxBs/C9dMQKfaNivsPoaqSdjcR
	VnndMUpq4/SeQ/2Dz4l8JeLa1G+78nvi3j04HdB3d1DaA6urGrd3pvi2dkxcs3gUcUzj4H
	1+6sQP2ZPqzoJpkOYvRojWt2iwYUm4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776066503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwX77/VJxa21uh8TVve6Qkvdkw3XMpCA95RLfNyfj+c=;
	b=ctlsUEyfYd6idIQQ5gnTFhc00EnuAFtb35hEyH3BUnbzcxhh0Au3ezFwcXGvBn86ROlcH5
	6cY/IgFA3e8jXoDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="pFU/HPff";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ctlsUEyf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776066503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwX77/VJxa21uh8TVve6Qkvdkw3XMpCA95RLfNyfj+c=;
	b=pFU/HPffP5C/HEugZonK1Ohck8rzrbRD9LtePuYbEoe9rxBs/C9dMQKfaNivsPoaqSdjcR
	VnndMUpq4/SeQ/2Dz4l8JeLa1G+78nvi3j04HdB3d1DaA6urGrd3pvi2dkxcs3gUcUzj4H
	1+6sQP2ZPqzoJpkOYvRojWt2iwYUm4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776066503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwX77/VJxa21uh8TVve6Qkvdkw3XMpCA95RLfNyfj+c=;
	b=ctlsUEyfYd6idIQQ5gnTFhc00EnuAFtb35hEyH3BUnbzcxhh0Au3ezFwcXGvBn86ROlcH5
	6cY/IgFA3e8jXoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E8F4AD91;
	Mon, 13 Apr 2026 07:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f7lQCMef3Gl3ZAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Apr 2026 07:48:23 +0000
Message-ID: <7de99cf0-2b34-4fa1-9fbd-fc55133eac62@suse.de>
Date: Mon, 13 Apr 2026 09:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-auth: Hash DH shared secret to create session key
To: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20260311012116.2504291-1-cleech@redhat.com>
 <20260311231643.2672061-1-cleech@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260311231643.2672061-1-cleech@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 5F6236A88F
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_004825_354971_701B4687 
X-CRM114-Status: GOOD (  20.73  )
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

On 3/12/26 00:16, Chris Leech wrote:
> The NVMe Base Specification 8.3.5.5.9 states that the session key Ks
> shall be computed from the ephemeral DH key by applying the hash
> function selected by the HashID parameter.
> 
> The current implementation stores the raw DH shared secret as the
> session key without hashing it. This causes redundant hash operations:
> 
> 1. Augmented challenge computation (section 8.3.5.5.4) requires
>     Ca = HMAC(H(g^xy mod p), C). The code compensates by hashing the
>     unhashed session key in nvme_auth_augmented_challenge() to produce
>     the correct result.
> 
> 2. PSK generation (section 8.3.5.5.9) requires PSK = HMAC(Ks, C1 || C2)
>     where Ks should already be H(g^xy mod p). As the DH shared secret
>     is always larger than the HMAC block size, HMAC internally hashes
>     it before use, accidentally producing the correct result.
> 
> When using secure channel concatenation with bidirectional
> authentication, this results in hashing the DH value three times: twice
> for augmented challenge calculations and once during PSK generation.
> 
> Fix this by:
> - Modifying nvme_auth_gen_shared_secret() to hash the DH shared secret
>    once after computation: Ks = H(g^xy mod p)
> - Removing the hash operation from nvme_auth_augmented_challenge()
>    as the session key is now already hashed
> - Updating session key buffer size from DH key size to hash output size
> - Adding specification references in comments
> 
> This avoid storing the raw DH shared secret and reduces the number of
> hash operations from three to one when using secure channel
> concatenation.
> 
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---
> v2:
> - Renamed nvme_auth_gen_session_key() arguments from ctrl_key to
>    public_key, as it is the peers public DH key and this code is also
>    used on the target/controller side when the peer is the host.
> - Changed argument validation from erroring on sess_key_len < hash_len
>    to sess_key_len != hash_len to be more precise in calling requirements
> 
> created on the nvme-7.1 branch
> this depends on Eric Biggers "nvme-auth use crypto library" patches
> from <20260302075959.338638-1-ebiggers@kernel.org>
> 
>   drivers/nvme/common/auth.c | 88 ++++++++++++++++++++++++++++++--------
>   drivers/nvme/host/auth.c   | 13 +++---
>   drivers/nvme/target/auth.c | 15 +++---
>   include/linux/nvme-auth.h  |  6 +--
>   4 files changed, 92 insertions(+), 36 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

