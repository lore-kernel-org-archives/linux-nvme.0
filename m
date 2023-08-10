Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C415C001E0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HrNaBuvs7gciPldxgkst9tI6LIhzz4OpDukzrAp9BsI=; b=ebf3+FlqmrTan9aQau1oyWExUF
	2s/C4Vhj/eyP4Zo30cRERDeP2zlqiZcshBdO9bGLqZvzibdtIMckp3MKezxbTq02g6wwTY5pqUieu
	NJ5N6dXmXvQ8I9aMxVDzCd5DM28Brtba2JvpviATS7Hcsh3kqLOdtUIbVf1tTaAkdzKiWe+HUMUCy
	fz8X2+M5tzmQus7YAdOb+rLrZADVU2XMIlvxeEDk/+z6rJZuEvd2kLNUFl99zRG5NUfn/9t4MTOC3
	CAdE3FLNQU1XkjyYnVpF4nKfCcCaPh/bmBQ37rpsYGHQ4e7mNS5hfve76vHRuljSQAZr5VzcZ5KEQ
	kbNomtlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5k7-007jhB-0u;
	Thu, 10 Aug 2023 13:30:23 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5k4-007jg6-1Z
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 13:30:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4802C1F74B;
	Thu, 10 Aug 2023 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691674219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrNaBuvs7gciPldxgkst9tI6LIhzz4OpDukzrAp9BsI=;
	b=gIe4zZG4cEDYJ1d3LWxhTwyFYOome5qC+JLpyPvC+492fLM+1/vIL7kpkK1cRbDt0yr6YD
	CIkjhUF5IpZ2cmBqCOzPRyazgMH8Jzu1XyDH8oKb+pMJOFrjDNENR/a9yoChIXbck3tjG9
	3W2ZGcXEpmiLKLW+dlmkEvrU92hyYno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691674219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrNaBuvs7gciPldxgkst9tI6LIhzz4OpDukzrAp9BsI=;
	b=6ROG+dzUdMpkdi27WOyAZDDdrTSkeosDcUZdEiJ5D9xWnGagjQsZH4oG17HwPJv9mpG57D
	d4iXyIFlPu7wo/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11D91138E2;
	Thu, 10 Aug 2023 13:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id AKk6A2vm1GQvbAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 10 Aug 2023 13:30:19 +0000
Message-ID: <a2580de7-f1c1-4a42-a1dc-1fca4c5dfd2d@suse.de>
Date: Thu, 10 Aug 2023 15:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 2/6] nvme-tcp: use nvmf_resolve_address helper
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-3-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230724092023.708335-3-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_063020_670694_A240A9DB 
X-CRM114-Status: GOOD (  13.38  )
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
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/tcp.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 3e7dd6f91832..a47b597ace3e 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2537,8 +2537,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>   		opts->mask |= NVMF_OPT_TRSVCID;
>   	}
>   
> -	ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
> -			opts->traddr, opts->trsvcid, &ctrl->addr);
> +	ret = nvmf_resolve_ip_address(opts, &ctrl->addr);
>   	if (ret) {
>   		pr_err("malformed address passed: %s:%s\n",
>   			opts->traddr, opts->trsvcid);

Merge with the first patch?
Otherwise okay.

Cheers,

Hannes


