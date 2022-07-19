Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A90C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 06:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a/24frEewwQIK0fAiL/khBUUKRExmdYhsz+fytz3MOw=; b=Pzh4ObfKK581r996NI50DkOlgK
	w3Pj7vHi5VcohF0O54OqY66TTFpXD8Jq8OldUOfSM4xm5xWcMA8mfPL3jrOjKQ+ZFZD7XQURM8Jod
	GCS+tHuGAp9M6tdKKBPP8KzjlZuahOoL+/LRqqNIXLM9dzzq5+sTlsRQnz4v7ZWh7Qx9NcZ/Y9CPi
	x2csOAt0PKC/Y4y/E1vnXI6GECu6PfafQiESjVQcy30VSRNEsL9DfBOAtpAF7eSFVcx/ht4yeiWSz
	VVykkEBo+ixPULUASd89XMQ+ZFor0sD3UfAjzGOo5aqPtyce07iidsPRXhfcOyFGfLl4fS1FfWe5s
	8YijaSiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDh4h-005iNN-Ep; Tue, 19 Jul 2022 06:51:19 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDh4f-005iM9-1x
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 06:51:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7EFA1FA3E;
	Tue, 19 Jul 2022 06:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658213470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/24frEewwQIK0fAiL/khBUUKRExmdYhsz+fytz3MOw=;
	b=UXNcH/QN3VumHzQxLfO6cUMx5Y+fkg/VWwaz5Teh1Dzv3kvRHVYWTNekbZOS+3HsMNmMYe
	yL7+hmU9DL91pHyBEojtGbJ/yUy4HpZujfi9qziE2syKZ5JQa+FNC/zDqfKFkI3CDTKdpA
	C0ETdKmkgfur7DfBrptEAtpq6NoQZ5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658213470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/24frEewwQIK0fAiL/khBUUKRExmdYhsz+fytz3MOw=;
	b=/l/9a37RzS2xHhe0I32ZqGh2RawM5XFOd4cQSCEWikszFsYDMhlbIp5YeVImR4h7BtQqW+
	lIULmRNkQLpKFpCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 819D213A72;
	Tue, 19 Jul 2022 06:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id OIhbHl5U1mItHgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 19 Jul 2022 06:51:10 +0000
Message-ID: <7334d6c7-4b2f-5767-850a-330db69a57ec@suse.de>
Date: Tue, 19 Jul 2022 08:51:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nvmet: fix return value check in auth send
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <20220718231233.3886-1-kch@nvidia.com>
 <20220718231233.3886-2-kch@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220718231233.3886-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_235117_298014_65020916 
X-CRM114-Status: GOOD (  17.91  )
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
> nvmet_setup_auth() return type is int and currently it uses status
> variable that is of type u16 in nvmet_execute_auth_send().
> 
> Catch the return value of nvmet_setup_auth() into int and set the
> NVME_SC_INTERNAL as status variable before we jump to error.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index cc56e8c821ce..f1c9c2f51afb 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -247,8 +247,10 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   			pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
>   				 ctrl->cntlid, req->sq->qid);
>   			if (!req->sq->qid) {
> -				status = nvmet_setup_auth(ctrl);
> -				if (status < 0) {
> +				int ret = nvmet_setup_auth(ctrl);
> +
> +				if (ret < 0) {
> +					status = NVME_SC_INTERNAL;
>   					pr_err("ctrl %d qid 0 failed to setup"
>   					       "re-authentication",
>   					       ctrl->cntlid);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

