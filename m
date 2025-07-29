Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F12CC87FCB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pdtdL83ySdzVcOjcM/If1HVX/MdEz/8nkOEt4H8mAMA=; b=c5aa+goJ5ghApAMXkVSz61wJUB
	+3F+P3Mtin0q5h8MUBGkJtAoMarWGw1rsAm19ZFQY4rfQEvcngnFlKAVoG/J0MhlmyJh3sBSJxkOT
	Zi2CBt2bBizzwNeNTAv+b//ek7G7NCNrskFL5nXSc80v5kPIsYvwct0nutNpvr3SlQFM0TvzfhdT3
	s8dy4rlyrCXrtpQ6fG5OaSv45CpD1obwN+DLIQHXRcgQ9VagrySR3nmCZ+DmhZe8UoAfcppt6ctPQ
	ePh2cPxRGVSVKxamyME+AknI7MfEt12xhec8e+jiz6Hxz/IusVy/EfxxbPwb0Y4pkYegjoKtnaBPa
	eEGAV4eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh94S-00000001sUz-40mQ;
	Wed, 30 Jul 2025 15:50:24 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugfS8-0000000GDS5-3BsS
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 08:12:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4CFB21A26;
	Tue, 29 Jul 2025 08:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753776771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdtdL83ySdzVcOjcM/If1HVX/MdEz/8nkOEt4H8mAMA=;
	b=TP0CXxJALp4/Y4BfEbYLZnhuBPV1q0vfL6cnfMVT5gFDJp5sBHHZPXmB+CPJc18adZhuTu
	ZotniTUatLxSurWVvQnNVq37yFkWIQ797P02DZY3WVaubIevjUabbfBqeHTiZFBTm5aWcN
	8mKkW+xnSGWRz/qfXkyisLsI55Et3uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753776771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdtdL83ySdzVcOjcM/If1HVX/MdEz/8nkOEt4H8mAMA=;
	b=FWyyTVVLpIXFQgr/VV2sXnRR0pxWybQ9Np52/d4tpc7JSsggtTic5PqIEvd9+c37xTrqZq
	qEmmN78CYqrjn2CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e+2sTR3N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YHcTOh35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753776770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdtdL83ySdzVcOjcM/If1HVX/MdEz/8nkOEt4H8mAMA=;
	b=e+2sTR3NLIPhsudzRRZXAuiZWxvVOSxs3ho549QjdLN756QMDiRVDqPMmyGG7rHzBo/NWb
	bnp0a68ZsKTKV0pz54tE0xn4W55gxRHcCPvaOKY5/7sFX6pQYRXva56heR0wjBh64OWEd3
	ACSZav5bNNqrSiBgFEUslS9jvGmgkxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753776770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdtdL83ySdzVcOjcM/If1HVX/MdEz/8nkOEt4H8mAMA=;
	b=YHcTOh35iZh/BRTK8lD+n7XiCATU9tLk6XmoENjWc7QDZZVyHPXC4MflA4WTJ7Gh0R48XY
	vKtZwuDZX8t+nvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FEA713876;
	Tue, 29 Jul 2025 08:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MEp1A4KCiGhZNQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Jul 2025 08:12:50 +0000
Message-ID: <2a9c71e0-f29d-46b6-823d-a957b10b4858@suse.de>
Date: Tue, 29 Jul 2025 10:12:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/4] net/handshake: get negotiated tls record size limit
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, alistair.francis@wdc.com,
 dlemoal@kernel.org, chuck.lever@oracle.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, borisp@nvidia.com,
 john.fastabend@gmail.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
 anna@kernel.org, kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
 <20250729024150.222513-4-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250729024150.222513-4-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4CFB21A26
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,wdc.com,kernel.org,oracle.com,davemloft.net,google.com,redhat.com,lwn.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,talpey.com,lists.linux.dev,vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLhu34id7c3duw89qhx7eswje4)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,wdc.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_011253_122431_3BF59CE1 
X-CRM114-Status: GOOD (  19.16  )
X-Mailman-Approved-At: Wed, 30 Jul 2025 08:35:22 -0700
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

On 7/29/25 04:41, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a handshake, an endpoint may specify a maximum record size limit.
> Currently, this limit is not visble to the kernel particularly in the case
> where userspace handles the handshake (tlshd/gnutls). This patch adds
> support for retrieving the record size limit.
> 
> This is the first step in ensuring that the kernel can respect the record
> size limit imposed by the endpoint.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>   Documentation/netlink/specs/handshake.yaml |  3 +++
>   Documentation/networking/tls-handshake.rst |  8 +++++++-
>   drivers/nvme/host/tcp.c                    |  3 ++-
>   drivers/nvme/target/tcp.c                  |  3 ++-
>   include/net/handshake.h                    |  4 +++-
>   include/uapi/linux/handshake.h             |  1 +
>   net/handshake/genl.c                       |  5 +++--
>   net/handshake/tlshd.c                      | 15 +++++++++++++--
>   net/sunrpc/svcsock.c                       |  4 +++-
>   net/sunrpc/xprtsock.c                      |  4 +++-
>   10 files changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index b934cc513e3d..35d5eb91a3f9 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -84,6 +84,9 @@ attribute-sets:
>           name: remote-auth
>           type: u32
>           multi-attr: true
> +      -
> +        name: record-size-limit
> +        type: u32
>   
>   operations:
>     list:
> diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
> index 6f5ea1646a47..cd984a137779 100644
> --- a/Documentation/networking/tls-handshake.rst
> +++ b/Documentation/networking/tls-handshake.rst
> @@ -169,7 +169,8 @@ The synopsis of this function is:
>   .. code-block:: c
>   
>     typedef void	(*tls_done_func_t)(void *data, int status,
> -                                   key_serial_t peerid);
> +                                   key_serial_t peerid,
> +                                   size_t tls_record_size_limit);
>   
>   The consumer provides a cookie in the @ta_data field of the
>   tls_handshake_args structure that is returned in the @data parameter of

Why is this exposed to the TLS handshake consumer?
The TLS record size is surely required for handling and processing TLS
streams in net/tls, but the consumer of that (eg NVMe-TCP, NFS)
are blissfully unaware that there _are_ such things like TLS records.
And they really should keep it that way.

So I'd really _not_ expose that to any ULP and keep it internal to
the TLS layer.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

