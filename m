Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2A7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 06:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qkR7ebtIVjm7inBsqM6Oqgxc/g3FGebw4RY4J3moUDY=; b=wqrayeptprlIPo+TsvlnhtkwVU
	hKub86tH2DYCqADZjqpx9l0k2o/BKzjJYi+XtxRPaozIxk3+yK7xTz6uULLxZNGuKC1w+TITL3V3l
	O9qXEZv/sIdiu8vGB8qw/PD6aA8C63hq6fHlQ1eATyG2cfrvt9lDzLeLw/oZVfFZ9/P+YyxqCl74n
	tCr8+Lo9yoJ8tcU0cdwV+Fev9tgs7pb+ZnGbqzJjTNumPGEpVFFnp5Lm5VIAzZJBnkh2LwRSo/FZ2
	S312N3htU7A2qaETRqq2vPSbrlHRtMGPgb40ya8S45SrZuirwU85TL8S24SeXQ1Xmwbsy4CqMhtgN
	qBzu0x8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDh5C-005iWg-Qj; Tue, 19 Jul 2022 06:51:50 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDh59-005iVd-K3
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 06:51:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F17833A4C;
	Tue, 19 Jul 2022 06:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658213505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkR7ebtIVjm7inBsqM6Oqgxc/g3FGebw4RY4J3moUDY=;
	b=yPBvSqClTZO1S0u+a00gI09Nf35hycaideI7XArEP5w6511+4ZzAYb6FRgFC/zdnKezaea
	yGs2TOCvXAA+T5CPnpeOhjjzxIXP/VunNXofMc0EBCc8FGOpj4/kDgrKHz8Li3dlqevmBc
	ip44uVYRjRp33ZsHOkgVpAFP2EBJ8ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658213505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkR7ebtIVjm7inBsqM6Oqgxc/g3FGebw4RY4J3moUDY=;
	b=GBv+ftKkbyLTgxG+3rn/taSpBOPHszKqlPj0kVV/ADpk7BlqlsVBddlyUPCRsbdv7Beh3Z
	g1sjy9i43sPnDYBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7466E13A72;
	Tue, 19 Jul 2022 06:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id d1aPG4FU1mJnHgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 19 Jul 2022 06:51:45 +0000
Message-ID: <fc2206c5-5140-2226-f60d-dd7e73eb3e23@suse.de>
Date: Tue, 19 Jul 2022 08:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] nvmet: fix return value check in auth receive
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <20220718231233.3886-1-kch@nvidia.com>
 <20220718231233.3886-3-kch@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220718231233.3886-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_235147_829893_0E1FECBD 
X-CRM114-Status: GOOD (  17.24  )
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

On 7/19/22 01:12, Chaitanya Kulkarni wrote:
> nvmet_auth_challenge() return type is int and currently it uses status
> variable that is of type u16 in nvmet_execute_auth_receive().
> 
> Catch the return value of nvmet_auth_challenge() into int and set the
> NVME_SC_INTERNAL as status variable before we jump to error.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index f1c9c2f51afb..45056e204dde 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -486,8 +486,9 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
>   		 ctrl->cntlid, req->sq->qid, req->sq->dhchap_step);
>   	switch (req->sq->dhchap_step) {
>   	case NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE:
> -		status = nvmet_auth_challenge(req, d, al);
> -		if (status < 0) {
> +		int ret = nvmet_auth_challenge(req, d, al);
> +
> +		if (ret < 0) {
>   			pr_warn("ctrl %d qid %d: challenge error (%d)\n",
>   				ctrl->cntlid, req->sq->qid, status);
>   			status = NVME_SC_INTERNAL;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


