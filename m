Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7A5C64ED6
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Feb 2023 08:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kqCqJtjUw1LNQBBQMny6VKOle+LX7e5Wpq8HXGHPINg=; b=O7bYJvJ6ILLfgNwdtK2tq6Rg6z
	2keJTL45pSnz4s/RwW42sFt7eI00GfM8gbzIM/fXAD6edTV9YHP2wKzIgXU3i3iO9qHB4sY4b1gGZ
	FRCQylSsjweP8ESgocIAO/qWBMIQYGQkvj1EZX3Ow2kI4gt6F1kNv0pXtILsEcn+eNV9hCDwdOy+G
	jvWw5pOFL1Ql8WYsjuFw4+PmtZBDCObsbigzaWXP8GUIX+1xB+AYAoc0XkzVoHaLbpXmYE5XnILoy
	zS0+1WtYwUgQQ7a8w7TXTJ7uoe/ODiIVvoGXW27wQolgORgl2O794vhDvxBUeflTdY1XlZ/uXD7h9
	U1lZEfyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWYsB-008qJD-6p; Mon, 27 Feb 2023 08:28:39 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWYs8-008qHn-4e
	for linux-nvme@lists.infradead.org; Mon, 27 Feb 2023 08:28:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65D111F8D4;
	Mon, 27 Feb 2023 08:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1677486512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqCqJtjUw1LNQBBQMny6VKOle+LX7e5Wpq8HXGHPINg=;
	b=d9QxuJI8uGGIwLnvaK5v4i1WLh0dxKCz/ySmSBG5Zv71y9aV86fuS/j/TctKTkYTs+z50V
	jv4pUB06n6qqmuDFdpdjxWRX5VJsjmEwaw6pqF6NUyY0EWjIvqfatOLHLs15zh/zwThXNX
	hQ9z3uU3SOcx8mtgpcovsDM3bfPPjjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1677486512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqCqJtjUw1LNQBBQMny6VKOle+LX7e5Wpq8HXGHPINg=;
	b=GnIzxpfDLTn/Sw9/BHKaS20/BIN/AYO88y/HX/LBkyoAZJwhuQR1nOpZAT9jwwrX940LPj
	yOhl39C+no0878Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C89413A43;
	Mon, 27 Feb 2023 08:28:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id IRd5DLBp/GPGNwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 27 Feb 2023 08:28:32 +0000
Message-ID: <4e057da2-9168-43a8-452b-2e5b354afc98@suse.de>
Date: Mon, 27 Feb 2023 09:28:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] nvme-tcp: don't access released socket during error
 recovery
Content-Language: en-US
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-nvme@lists.infradead.org
Cc: Martin Belanger <martin.belanger@dell.com>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>
References: <20230226124254.59970-1-akinobu.mita@gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230226124254.59970-1-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_002836_349192_68E3CFE2 
X-CRM114-Status: GOOD (  19.85  )
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

On 2/26/23 13:42, Akinobu Mita wrote:
> While the error recovery work is temporarily failing reconnect attempts,
> running the 'nvme list' command causes a kernel NULL pointer dereference
> by calling getsockname() with a released socket.
> 
> During error recovery work, the nvme tcp socket is released and a new one
> created, so it is not safe to access the socket without proper check.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Fixes: 02c57a82c008 ("nvme-tcp: print actual source IP address through sysfs "address" attr")
> Cc: Martin Belanger <martin.belanger@dell.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1955c0ec209e..7723a4989524 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2492,6 +2492,10 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>   
>   	len = nvmf_get_address(ctrl, buf, size);
>   
> +	mutex_lock(&queue->queue_lock);
> +
> +	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
> +		goto done;
>   	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
>   	if (ret > 0) {
>   		if (len > 0)
> @@ -2499,6 +2503,8 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>   		len += scnprintf(buf + len, size - len, "%ssrc_addr=%pISc\n",
>   				(len) ? "," : "", &src_addr);
>   	}
> +done:
> +	mutex_unlock(&queue->queue_lock);
>   
>   	return len;
>   }
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


