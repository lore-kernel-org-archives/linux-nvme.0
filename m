Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E84C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 07:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z5rFjZDz18CGMD8Gh/fEZeBTHQf9QmJHTKm5ZVwYcg0=; b=DjJL6Rni2jkJRPwjOROtlnEY3L
	3/+sHKyr4Nbf2k/Fr93PA2nOM42FH+z/kzAjmXKhpn/8eYZ4jdGY6v/lrbTTGKrmMG1mvAzkmjgHy
	B7RTorj8/zXfyPSSD87Yd9zsMUkVhjgPmYUhXaPh+ANN8j/WjcwYk2jaH8H1+KqCj8s5Zfb+PtSQG
	rBmZLNAlViVeBHYTfqos7kuCiTQ0wwzRdisctrpPiaM6HYhOwTwHLAv9TTLGQ5NhWYquzQoPxC5vq
	5zZ86ufetkx3k4YInNQ8lEbGMHAa8OcXoB775CA0ukGFHdj+dzxL/tot+sMtT9mSg/pqRvL/2z6cV
	6DdLLOoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q64vW-00EbHs-0P;
	Mon, 05 Jun 2023 07:46:54 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q64vS-00EbG2-39
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 07:46:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 823481F8AB;
	Mon,  5 Jun 2023 07:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1685951204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5rFjZDz18CGMD8Gh/fEZeBTHQf9QmJHTKm5ZVwYcg0=;
	b=zk2s7e647er094p8hPBIjxyt17NTYEzPqKhYcdb+Dx2I9Ek3glGkILyYD1GyZCymtHIK0i
	+UQLAqsAMUmFJCMKGPoag+ar6k3mEzuN7WqvTLRlziOqWgFmG34TuA/bix1cnwdrtovF12
	z7kcFazzkbnfrV34uQjnEqkz3tgNY64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685951204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5rFjZDz18CGMD8Gh/fEZeBTHQf9QmJHTKm5ZVwYcg0=;
	b=ycrIfLvRxE6Yrrnyv1IOvcBIEvTPDGw4w+nTzHzVSON5UiNemXfyfxUbvMHQLXwJCpRc7t
	J683HtlBhbSZY1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63ECC139C7;
	Mon,  5 Jun 2023 07:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id T3SVF+SSfWSVdAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 05 Jun 2023 07:46:44 +0000
Message-ID: <d9785297-d603-1ccd-91f2-9490b104b07a@suse.de>
Date: Mon, 5 Jun 2023 09:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 3/4] nvmet-auth: use helper for auth send/recv cmd prep
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 kbusch@kernel.org
References: <20230605064434.45233-1-kch@nvidia.com>
 <20230605064434.45233-4-kch@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230605064434.45233-4-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_004651_159591_4A00F06D 
X-CRM114-Status: GOOD (  15.14  )
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

On 6/5/23 08:44, Chaitanya Kulkarni wrote:
> Add a common helper to factor out secp/spsp values check and transfer
> buffer allocation in nvmet_execute_auth_send() and
> nvmet_execute_auth_receive().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index 778961e231a3..d331c22ed26e 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -41,6 +41,15 @@ static u16 nvmet_auth_alloc_transfer_buffer(struct nvmet_req *req, void **buf,
>   	return *buf ? NVME_SC_SUCCESS : NVME_SC_INTERNAL;
>   }
>   
> +static u16 nvmet_auth_common_prep(struct nvmet_req *req, void **buf, u32 *len)
> +{
> +	u16 status = nvmet_auth_check_secp_spsp(req);
> +
> +	if (status)
> +		return status;
> +	return nvmet_auth_alloc_transfer_buffer(req, buf, len);
> +}
> +
A wrapper for a wrapper?
Please move nvmet_auch_check_secp_spsp() tion 
nvmet_auth_alloc_tranfer_buffer().

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


