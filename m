Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE8ACCA472
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Oct 2025 06:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ieQNXVqmB6gn/hvFv/XITJL4ngvi9+RBwAGH1eRq154=; b=SJrVm65QLBeySn/JUTEEJyuPvT
	9jifMKuxyDZAhpa3mqgoOY3mCxE/1RaXVsWWB4zfn1k+hQOwzyHfH08BpVk2BkGsPURNmvVDIUJUF
	zIKUIMLzoNeE4rw+Wb0xte0EDkeY5J/Z66l7Hh6LuXQQn8eGOh8EJPKF0LWTNE2TgJhroAn+uzm9v
	Q9ECuVERixlmtoBn0b1srBr7YSLmcmIEaUrczREcAzV6HcNeE+Z9cSoW+I3lU0G3Kez5tEBe8nCh6
	Q9Pi5rGOFxC6PIvoCqM/OYKsglADWQSF+u0mWAHiFeCfwa4XvnI3VeDmCWMoUEBm+/up2qgMa3DIS
	j1LNVwBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5eaS-0000000H0Pb-4C7y;
	Mon, 06 Oct 2025 06:20:45 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5eaQ-0000000H0NL-3Ro1
	for linux-nvme@lists.infradead.org;
	Mon, 06 Oct 2025 06:20:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3F283373A;
	Mon,  6 Oct 2025 06:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759731641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieQNXVqmB6gn/hvFv/XITJL4ngvi9+RBwAGH1eRq154=;
	b=SaXgqXGSevXjjEUlphyftgnwGrZPHYWI/Xb99hXNTkgKEXV2n1ry78sYkqYBM6prcyi6qa
	QCdW9xU5JLTFBq4oMNO6zOmwt4T32iczk6zadMQphKPGTCyujglYUbaOkQl3XNs0s6qaF/
	4s430JyblTm8berAhxuGKMZLQ72uzt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759731641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieQNXVqmB6gn/hvFv/XITJL4ngvi9+RBwAGH1eRq154=;
	b=/yCdVZNTE9XmFD9z8Wv+/ETQleD4JDQEeGvCXfzPFNJYskBcy3zVSXJvWWG4JoRBhQfSVk
	QzxTPnoPMvvoMqDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759731640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieQNXVqmB6gn/hvFv/XITJL4ngvi9+RBwAGH1eRq154=;
	b=A1tn8sexGJSps+DbMx3RYcG40mk1bpcinCBZMW2D9KfioirZlDyAhvTOuQZa3nKkN6/iJV
	yAnZ1TKMXrI/igOt3XP2oNI84Ravfj1h1NjCZPuaO2Mw1JOU8B3GLdlCcyg3rDEXaR85Rr
	jzuPw+qxJJFAwYrbJsprdDWDmXdiqEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759731640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieQNXVqmB6gn/hvFv/XITJL4ngvi9+RBwAGH1eRq154=;
	b=vXOBVo4yw5iDibDnJQfwYGnpgfoibhmsPbdYw+QUmydb7b4UhBCOed/KZgeJ1zKPv08743
	TA7EQJbeYR3ZixBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54B0E13995;
	Mon,  6 Oct 2025 06:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BKV6Erhf42jsBwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 06 Oct 2025 06:20:40 +0000
Message-ID: <c275aa3d-9a7c-4049-ae27-218fa170a904@suse.de>
Date: Mon, 6 Oct 2025 08:20:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] net/handshake: Support KeyUpdate message types
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-6-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251003043140.1341958-6-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,wdc.com:email,imap1.dmz-prg2.suse.org:helo,ietf.org:url];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251005_232043_009827_2036DC03 
X-CRM114-Status: GOOD (  17.76  )
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

On 10/3/25 06:31, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> When reporting the msg-type to userspace let's also support reporting
> KeyUpdate events. This supports reporting a client/server event and if
> the other side requested a KeyUpdateRequest.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>   - Fixup yamllint and kernel-doc failures
> 
>   Documentation/netlink/specs/handshake.yaml | 16 +++++++++-
>   Documentation/networking/tls-handshake.rst |  4 +--
>   drivers/nvme/host/tcp.c                    | 12 ++++++--
>   drivers/nvme/target/tcp.c                  | 11 +++++--
>   include/net/handshake.h                    | 10 +++++--
>   include/uapi/linux/handshake.h             | 13 +++++++++
>   net/handshake/tlshd.c                      | 34 ++++++++++++++++++----
>   7 files changed, 84 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index a273bc74d26f..c72ec8fa7d7a 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -21,12 +21,18 @@ definitions:
>       type: enum
>       name: msg-type
>       value-start: 0
> -    entries: [unspec, clienthello, serverhello]
> +    entries: [unspec, clienthello, serverhello, clientkeyupdate,
> +              clientkeyupdaterequest, serverkeyupdate, serverkeyupdaterequest]
>     -
>       type: enum
>       name: auth
>       value-start: 0
>       entries: [unspec, unauth, psk, x509]
> +  -
> +    type: enum
> +    name: key-update-type
> +    value-start: 0
> +    entries: [unspec, send, received, received_request_update]
>   
>   attribute-sets:
>     -
> @@ -74,6 +80,13 @@ attribute-sets:
>         -
>           name: keyring
>           type: u32
> +      -
> +        name: key-update-request
> +        type: u32
> +        enum: key-update-type
> +      -
> +        name: key-serial
> +        type: u32
>     -
>       name: done
>       attributes:
> @@ -116,6 +129,7 @@ operations:
>               - certificate
>               - peername
>               - keyring
> +            - key-serial
>       -
>         name: done
>         doc: Handler reports handshake completion
> diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
> index d7287890056a..f858011e5bfb 100644
> --- a/Documentation/networking/tls-handshake.rst
> +++ b/Documentation/networking/tls-handshake.rst
> @@ -110,7 +110,7 @@ To initiate a client-side TLS handshake with a pre-shared key, use:
>   
>   .. code-block:: c
>   
> -  ret = tls_client_hello_psk(args, gfp_flags);
> +  ret = tls_client_hello_psk(args, gfp_flags, handshake_key_update_type);
>   
>   However, in this case, the consumer fills in the @ta_my_peerids array
>   with serial numbers of keys containing the peer identities it wishes
> @@ -140,7 +140,7 @@ or
>   
>   .. code-block:: c
>   
> -  ret = tls_server_hello_psk(args, gfp_flags);
> +  ret = tls_server_hello_psk(args, gfp_flags, handshake_key_update_type);
>   
>   The argument structure is filled in as above.
>   
I would very much prefer to have our own function here; currently the
'tls_server_hello_psk' is issuing a 'ServerHello' command, the
'tls_client_hello_psk' is issuing a 'ClientHello' command.
Consequently I'd rather have 'tls_client_keyupdate_psk()' /
'tls_server_keyupdate_psk()' functions to indicate that we're sending
a KeyUpdate command instead of overloading the existing
commands.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

