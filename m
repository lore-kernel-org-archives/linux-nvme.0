Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96E9C982EE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 12:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LAogAuTzoAcUZej5+4ik6YXvF8UZtTZbj1E1243Jb4w=; b=QlTq+3GNSN/ECjymc2oo4sfxom
	I3gEfGqdlEl819rFI3GXwOquwp1HYA0SzAr0sioZsxuZNd327NZWPVZm+1Xg9B/8QGT7Atm1HpW/i
	cqcUhEDneAV1ubN9wvm9f4nvJsfKM4MV997VHAp+KVK38dDMkhdE4vq7ay61kj0tg0Errree49udI
	2asHfGOwoqCHJsOU/Ix2ksXmONc9Zn6wxllmYEqHghX6DAwWY9dNsR34i0QaO82nnTosPa+m/1ZbR
	UgrqkIklboQvH+7tXn7kRbP69AYEIrS3JBgGN/WgYdFGQPY9KOhaPBKdGNxEYhJqG289iR0gVStYn
	DFnDhEzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8dKE-000000026Jy-0k4N;
	Mon, 21 Sep 2026 12:40:50 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8dKA-000000026IX-2OBZ
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 12:40:49 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8876521CD3;
	Mon, 21 Sep 2026 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789994440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LAogAuTzoAcUZej5+4ik6YXvF8UZtTZbj1E1243Jb4w=;
	b=eI82n2ij95YQd/LE8J/H1QTlCU+tbeVYvn8H82nENpKhqDipIX7W6Ti9EFseS5r3yx2wB+
	BUw2oon7ETcOFh1k+vYDihIr2tDBf+TMsjSxBZ2TSEBBKqCpvE1A1grtj1gtASjNuLdW4E
	pk0jh2kd9E2D1VlHv2LJIPa9vcyQm2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789994440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LAogAuTzoAcUZej5+4ik6YXvF8UZtTZbj1E1243Jb4w=;
	b=yisguxdhHib3Hlwg3EneKR9mti8sXPtNXRm9CanDJ2zhUppDDh3z3tKvLZS2I3FjiwIG2J
	cCtPZa7xGKgC9nAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dtoepLWN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NJgdHKBf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789994436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LAogAuTzoAcUZej5+4ik6YXvF8UZtTZbj1E1243Jb4w=;
	b=dtoepLWNP8N+CLP9oUvb7jBrLACMB7IHPPFfhhFq00SlhsOmbdQqt5uGkR9co56pKoOA2h
	uJQ6PY1n0JJvgdsjLL/t2WZ1z1yVhB99oL9Tjj/UoiJAT7QDi5CkOXQ1/dqgnIIEu/+ZFo
	addXYlfhT/9PrADf5n7FKgfN892LTuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789994436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LAogAuTzoAcUZej5+4ik6YXvF8UZtTZbj1E1243Jb4w=;
	b=NJgdHKBfWb2LfcS62+Xir/z1tSGyVRQhLyQ7cPDez3rPYeqai2mPXmCRpYPrGyQ0MhKsyP
	ksfxKu7ZBQBlkjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 239BA139E2;
	Mon, 21 Sep 2026 12:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3CylOcMlsWqDTAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 12:40:36 +0000
Message-ID: <1d735a85-2c08-4a36-85cb-cb46b2e5984a@suse.de>
Date: Mon, 21 Sep 2026 14:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: look up host_iface in the current netns
To: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org
References: <c14cd4633c27abe2dec863480168691023694aee.1785033817.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c14cd4633c27abe2dec863480168691023694aee.1785033817.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8876521CD3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,kylinos.cn:email,suse.de:dkim,suse.de:email,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_054046_756749_4F9E1D24 
X-CRM114-Status: GOOD (  19.25  )
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

On 7/26/26 4:46 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> nvme_tcp_alloc_ctrl() looks opts->host_iface up in &init_net, the boot-time
> netns. When called from any other netns - e.g. the selftest's ns2, where
> ns2eth1 actually lives - the lookup misses and the controller setup fails
> with "invalid interface passed":
> 
>   nvmet: adding nsid 1 to subsystem nqn.2014-08.org.nvmexpress.mptcpdev
>   nvmet_tcp: enabling port 24660 (0.0.0.0:24099)
>   # nvme discover -a 10.1.1.1 --tos=0x10 --host-iface=ns2eth1
>   nvme_tcp: invalid interface passed: ns2eth1
>   # failed to add controller, error invalid interface
> 
> Look the device up in current->nsproxy->net_ns instead so the check sees
> the calling task's netns.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   drivers/nvme/host/tcp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ba5c7b3e2a7c..c89d84ccce1a 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2960,7 +2960,8 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
>   	}
>   
>   	if (opts->mask & NVMF_OPT_HOST_IFACE) {
> -		if (!__dev_get_by_name(&init_net, opts->host_iface)) {
> +		if (!__dev_get_by_name(current->nsproxy->net_ns,
> +				       opts->host_iface)) {
>   			pr_err("invalid interface passed: %s\n",
>   			       opts->host_iface);
>   			ret = -ENODEV;

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

