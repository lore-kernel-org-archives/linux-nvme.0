Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938FDCD4F52
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 08:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0DDWPan8gWQ6HSccljODwuS99gCgju6jSsocYIUqOZo=; b=rQ6Yw2HNN6p6U3DkPIn6+17xzu
	76Tt4b7v1/I0cQIJRNLm2G7zTkF2EP716AQTtkN0Afv/htChX9DrxGz6zV+DjH+B11Kdwuzac0hkN
	NCNi5PtXeBh7IY+a4d+KkuOV3EzUeG5YwrOstWCC5Cu5kqZCuXCMRcqPIOrRoy5Eh5QjRu/btmQ/3
	hoh+DxrL2LLvT0YG4jdM5RCw3SWJuXKXAvlpI5yAKUD4mtqzQPwmMoqzb/MN7Ka6wjYp0WBJzU6al
	nrHXROHjXkNipjuPeENg+bH8ejd2gP6Ws2HYZJQmGPs5pmkD6Hg6WLCje4pBVPhEuljQMdxICxmSL
	Ej6ZvX5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPG3q-00000000ipe-0pDx;
	Tue, 19 May 2026 08:44:22 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPG3o-00000000ioW-06pF
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 08:44:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9165A5E09B;
	Tue, 19 May 2026 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779180258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0DDWPan8gWQ6HSccljODwuS99gCgju6jSsocYIUqOZo=;
	b=xtH8DBvpPkcsdZA+y4UQsNQUiGaf+QuN+e8lmLBjIWwDWRhFoO5i6kAqHWwTptIDF8CSS+
	kvduLgc5Gfo3zkgT646/HxDDOWVr9h+ymEP9cfYkc2mNm927CB0r0IpYQGfyPntnL+ZwFG
	Gzwebh9kLB0yYxcCzhlazpPcbuHQ3cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779180258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0DDWPan8gWQ6HSccljODwuS99gCgju6jSsocYIUqOZo=;
	b=BN1hcEXtLXiHWuUWXEkWhvDXeBg08gWyx8ra8EIAdUtEkFXSmyfUSVlKCr1Cns7YwrYILn
	m/eUtR9Q2QFg6HCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qRv8tgAw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bch4hNbK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779180257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0DDWPan8gWQ6HSccljODwuS99gCgju6jSsocYIUqOZo=;
	b=qRv8tgAwYbg0yYYCqH48RcUjV164QgLrcRwL7mH3cO3cAW6VNH3qm6+5xj9i6UL9S7WM2X
	VL68AK687pPPXiu/A0YdhoLG5jfxQ7DjEG2GGnSMhCSaZkb7x4N4Cz268YmsTdIn6ICkDs
	ML6X7k4Om1aTElMXPUA5/jGQNp0CUD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779180257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0DDWPan8gWQ6HSccljODwuS99gCgju6jSsocYIUqOZo=;
	b=bch4hNbKRlG1MtKCpXtJCzzOEBDeEUQbgHNohbIhEPTG3cJ0bzqHfZx+T0BRZLuREkiYJ/
	93RZi9csE8mvbyBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FFD9593AA;
	Tue, 19 May 2026 08:44:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +SUjGuEiDGqEHQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 08:44:17 +0000
Message-ID: <1cad38c9-ae8a-4a97-96db-db8adeb768f5@suse.de>
Date: Tue, 19 May 2026 10:44:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-tcp: check return value of
 nvmet_tcp_set_queue_sock
To: Geliang Tang <geliang@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Maurizio Lombardi <mlombard@redhat.com>,
 John Meneghini <jmeneghi@redhat.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org
References: <cover.1779170418.git.tanggeliang@kylinos.cn>
 <6bbdda41e981777241d74d069b0cec7bb655bf58.1779170418.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6bbdda41e981777241d74d069b0cec7bb655bf58.1779170418.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,kylinos.cn:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9165A5E09B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_014420_210777_3A895EBC 
X-CRM114-Status: GOOD (  18.62  )
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

On 5/19/26 08:10, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The return value of nvmet_tcp_set_queue_sock() is currently ignored in
> nvmet_tcp_tls_handshake_done(). If it fails (e.g., due to the socket
> not being in TCP_ESTABLISHED state), the socket callbacks will not be
> properly set, leading to queue and socket leakage.
> 
> Fix this by capturing the return value and calling
> nvmet_tcp_schedule_release_queue() on failure to ensure proper cleanup.
> 
> Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   drivers/nvme/target/tcp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 164a564ba3b4..8a243d22a511 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1842,10 +1842,11 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
>   	if (!status)
>   		status = nvmet_tcp_tls_key_lookup(queue, peerid);
>   
> +	if (!status)
> +		status = nvmet_tcp_set_queue_sock(queue);
> +
>   	if (status)
>   		nvmet_tcp_schedule_release_queue(queue);
> -	else
> -		nvmet_tcp_set_queue_sock(queue);
>   	kref_put(&queue->kref, nvmet_tcp_release_queue);
>   }
>   

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

