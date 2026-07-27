Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC2DC531D0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eJ8uR9M5o9uKnrAgWo9NaKKgNIj7TVmFGyXhFvAE7ns=; b=R/ow63FIz7E0GILBSuhXojNwB+
	K1IG9wmmXsdVIx7KQpBrVTxnaUr+c1Cu7epXcN0tIs/fQuOwzkZE1Q9PZktXBW299a+61KHZgfHmV
	6lENSTHANpa1iNAiUgEhn+rilU6D/f2PGOAHNzk+fkv7HiFtN8McrNmC61OS+fLEgDYTsueGkeBxw
	tyW+YUxeypdlB9wso3okD8ATfCYrQjquswmgOKrAlRR7fjeBhQymU+IddBhLcD7132drfemde8aK6
	2OFZ0c4FL/belhJ66A6xWarKjtI4Jbs2TWYNJBJkDBOM/t2evpyNSUynUBUl/Y2c7L5U3dRHFlfvN
	tk5ibdwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woLJn-00000002qia-2AGf;
	Mon, 27 Jul 2026 13:24:31 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woLJl-00000002qhD-0fpm
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 13:24:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A8D85310;
	Mon, 27 Jul 2026 13:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785158661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJ8uR9M5o9uKnrAgWo9NaKKgNIj7TVmFGyXhFvAE7ns=;
	b=s75R93C2WEaVfkNHM1/wJFYgP7B50Xu55WwcI0CbRaHjZbPuoVDsR4AofY/DvDCMdKCOLc
	SrlKsZfDAwzmjxIDma4MtkCUh+1sm/xKQqphl9oeRucOax+bZl6JeJqWa6lpZWyO7wL+Uq
	ogO/qFbgnqkKX8vulGgX3XOcCBLuFkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785158661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJ8uR9M5o9uKnrAgWo9NaKKgNIj7TVmFGyXhFvAE7ns=;
	b=bYDfG8YzAptJzV2RVp+XalPYWjz3ylIk+BdnUWfG5VTuRYQsr57lK30MuIF/B8x5WtYhv5
	AYbjXLudGQ4twVAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785158657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJ8uR9M5o9uKnrAgWo9NaKKgNIj7TVmFGyXhFvAE7ns=;
	b=uL6ie+BI23Cc2KmkA7J3HHqBzw9DzJGPbCNuvUyQej/bskjGQwSti9te+erI2CN6Voz6zv
	GLuIRvIwgIun1moyNtWVepuMYeOWYr5QwVuTH8LDTRy7zidXlC+zpjJnAtX7hQ3O3wrJUj
	PgZFTQTdW8OapnY1UFY3fHvzqcKIo+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785158657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJ8uR9M5o9uKnrAgWo9NaKKgNIj7TVmFGyXhFvAE7ns=;
	b=2Nn8IJ4BFaN4iL4Rm5BzzKN6XJo3lmPk8kRk2/lf8yG236MTxYtCwN/MyzgpUZPzrgFb7r
	0JN/oQ1Ktq5DMLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74F3A779B9;
	Mon, 27 Jul 2026 13:24:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qxAGHAFcZ2ryBQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 27 Jul 2026 13:24:17 +0000
Message-ID: <8a23cec1-2e7b-451b-8c13-dffb72fcc757@suse.de>
Date: Mon, 27 Jul 2026 15:24:17 +0200
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
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,kylinos.cn:email,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_062429_369404_4955C72C 
X-CRM114-Status: GOOD (  22.08  )
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

But: if we are running in a network namespace the IP address of the
ports in the discovery log page will be relative to that namespace,
too, and there's a good chance that they are not reachable from
the initiator reading the log page.
Making the whole point of discovery a bit pointless.
But I really don't have a good idea how to resolve that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

