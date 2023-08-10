Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D8EC001DB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 13:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uaDlU6KGioJtp85DYhhzxktv4t1ppe6aTCxi9S9RIQM=; b=KYUSXHMGCUb+dcadIQNVKifDTo
	plGNQPL5qUVEaYRBsxmCgzOqzcCsgRKg0kUijlGWUuWJCIbDw34yCluEZEZXhHv43uYyXOD0OtgNk
	hiCrR7V9m8rRynb9iR4ID/HiUEBzhcm09xvKWZCi/cJtzmUdrC88Yi5VUS0BqaTEVT2AiS1/t7VKd
	Arh2e8nLmarWoFXlfeGZkkcVzeszYelX25uNmtwYakH2q1aY6E2wR+UMmgvZHsaJr/I8LjaL/jSC0
	RnICD9GhAueMrqZGikOhRHA6DuVGgkDV5Xh+G6LsbOSJlpScHGbegUIjZHEm5RZNWzxliwpRoBwcr
	GqXxfs2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5jd-007jc9-2m;
	Thu, 10 Aug 2023 13:29:53 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5ja-007jaq-37
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 13:29:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 582691F74B;
	Thu, 10 Aug 2023 13:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691674187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaDlU6KGioJtp85DYhhzxktv4t1ppe6aTCxi9S9RIQM=;
	b=Fi65slQqdvrFpfxZ8/s4bgJd4TM5ncQT5DSUZMSIHuj9lT7nU/yW/+DeHn5jkpYtzY2vT3
	SlglTCrd2b4EtEumyTA9EtNlixLpb7DN+TYR1/ayZfq1Vi4/fXVD27dL6tANWqR8Aqr3MC
	Qe4Y3S9D9Szc7hnaBls+G9UYm18xF50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691674187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaDlU6KGioJtp85DYhhzxktv4t1ppe6aTCxi9S9RIQM=;
	b=C5vwbJ75WHcRMUOnXR2u6TkUEbZPoF7cFNgCtfHTIgXGLlwRStmlpfxBJrQbqz+swt5Dw+
	ndglq1NRuC1q6hCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D0F8138E2;
	Thu, 10 Aug 2023 13:29:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sz7XCUvm1GQvbAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 10 Aug 2023 13:29:47 +0000
Message-ID: <667f8993-c087-43ec-a7f4-a379c5dcc54a@suse.de>
Date: Thu, 10 Aug 2023 15:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 1/6] nvme-fabrics: add helper to resolve ipv4/ipv6 or
 dns name
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-2-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230724092023.708335-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_062951_148914_4EE45569 
X-CRM114-Status: GOOD (  19.92  )
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

On 7/24/23 11:20, Sagi Grimberg wrote:
> Allow userspace to pass in traddr as a dns name as well. This may be
> useful for a discovery service that may have a dns name, that may also
> change in time (with an updated dns record).
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/fabrics.c | 28 ++++++++++++++++++++++++++++
>   drivers/nvme/host/fabrics.h |  2 ++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 8175d49f2909..fadd25538d1b 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -10,6 +10,7 @@
>   #include <linux/mutex.h>
>   #include <linux/parser.h>
>   #include <linux/seq_file.h>
> +#include <linux/dns_resolver.h>
>   #include "nvme.h"
>   #include "fabrics.h"
>   
> @@ -1133,6 +1134,33 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>   }
>   EXPORT_SYMBOL_GPL(nvmf_ip_options_match);
>   
> +int nvmf_resolve_ip_address(struct nvmf_ctrl_options *opts,
> +		struct sockaddr_storage *traddr)
> +{
> +	char *traddr_str = NULL;
> +	int traddr_len;
> +	int ret;
> +
> +	/* first check if traddr is ipv4/ipv6 address */
> +	ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
> +			opts->traddr, opts->trsvcid, traddr);
> +	if (!ret)
> +		return ret;
> +
> +	/* second check if traddr is dns name */
> +	traddr_len = dns_query(&init_net, NULL, opts->traddr,
> +			strlen(opts->traddr), NULL, &traddr_str,
> +			NULL, false);
> +	if (traddr_len < 0)
> +		return traddr_len;
> +
> +	ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
> +			traddr_str, opts->trsvcid, traddr);
> +	kfree(traddr_str);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvmf_resolve_ip_address);
> +
>   static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
>   		unsigned int allowed_opts)
>   {
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 82e7a27ffbde..603d8d176168 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -222,6 +222,8 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
>   bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
>   bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>   		struct nvmf_ctrl_options *opts);
> +int nvmf_resolve_ip_address(struct nvmf_ctrl_options *opts,
> +		struct sockaddr_storage *traddr);
>   void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,IS
>   			u32 io_queues[HCTX_MAX_TYPES]);
>   void nvmf_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,

dns resolver is a config option, so we would need either a '#ifdef 
DNS_RESOLVER' or if (IS_ENABLED(CONFIG_DNS_RESOLVER))' somewhere ...

Cheers,

Hannes


