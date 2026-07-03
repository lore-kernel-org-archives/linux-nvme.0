Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6775C43458
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2026 06:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BdHd8Nt8Z7YxLXFZjTcXpdzdMvvfXluI5jCA65TFEoI=; b=LwxOj0Ptb1Za5oQFWyyx4hJeY3
	uNvE5OCcpd4XEmN/5xSvFe6+29M7WALRtUdSUiMW4fstdQbR5bWn88SJ7Amxcss8kSIDjxqkgsRCo
	7XjQegwDXHn6TaQ4x4Hsrkah8cui2I4cbDyHXRMafDAXU5MMMjEGUZM5aupnw6fIoCEacBMpQdDu5
	W7qd1L2WJT1yqTM0Qg47LpkAjnlTSkF3MzUDL5M+dJI3emsU9U2FVkeul7+tEtJ3RGheS0j6IjQgO
	x/RImJuCK0dX3hFjUCm/dHeSOZP2/IpXPNXH5hMyqJ5ClpFPbaIMORHImXVFNt1wnzg49s+kTPaa7
	vfC3UeFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfXK2-000000069S9-3ar1;
	Fri, 03 Jul 2026 06:24:22 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfXJz-000000069RN-3Rrb
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jul 2026 06:24:21 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 54B5E75BA7;
	Fri,  3 Jul 2026 06:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783059856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdHd8Nt8Z7YxLXFZjTcXpdzdMvvfXluI5jCA65TFEoI=;
	b=1YMKqtkhAVV6sd9CXD1HIRwMjMuGenHGDtG+qRLJIuhpIdjVZAQ3wcO4tFcB8bdb1hzYlt
	rIdkmnUjT3PxbCdEm7ulC/q+/r0jR9fPewsTEGk0aHI03XLj3pOJ1VhujSiFYS+NS7/iDu
	osjc/FWy7/KS3XwKP2CUotYLSj7qts0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783059856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdHd8Nt8Z7YxLXFZjTcXpdzdMvvfXluI5jCA65TFEoI=;
	b=S5cGTlRuGez90W+t3iDYDYY728yJgKTeu+lGFJZlsCOSqzMoJF1FNOcNLft6jyh9XKS+vq
	p3DWD3IebRWpWlAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783059856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdHd8Nt8Z7YxLXFZjTcXpdzdMvvfXluI5jCA65TFEoI=;
	b=1YMKqtkhAVV6sd9CXD1HIRwMjMuGenHGDtG+qRLJIuhpIdjVZAQ3wcO4tFcB8bdb1hzYlt
	rIdkmnUjT3PxbCdEm7ulC/q+/r0jR9fPewsTEGk0aHI03XLj3pOJ1VhujSiFYS+NS7/iDu
	osjc/FWy7/KS3XwKP2CUotYLSj7qts0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783059856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdHd8Nt8Z7YxLXFZjTcXpdzdMvvfXluI5jCA65TFEoI=;
	b=S5cGTlRuGez90W+t3iDYDYY728yJgKTeu+lGFJZlsCOSqzMoJF1FNOcNLft6jyh9XKS+vq
	p3DWD3IebRWpWlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 188AB779AA;
	Fri,  3 Jul 2026 06:24:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xreBA5BVR2oQPgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 03 Jul 2026 06:24:16 +0000
Message-ID: <df336dde-f70b-4ddf-b77d-b9b910d2c10e@suse.de>
Date: Fri, 3 Jul 2026 08:24:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] nvme-auth: use crypto_memneq for DH-HMAC-CHAP
 response comparison
To: Xixin Liu <liuxixin@kylinos.cn>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-kernel@vger.kernel.org
References: <cover.nvme-auth-memneq.1781751816.git.liuxixin@kylinos.cn>
 <0001.nvme-auth-memneq.1781751816.git.liuxixin@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <0001.nvme-auth-memneq.1781751816.git.liuxixin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_232420_016867_37535F0E 
X-CRM114-Status: GOOD (  15.72  )
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

On 7/1/26 8:30 AM, Xixin Liu wrote:
> DH-HMAC-CHAP authentication compares HMAC response digests with memcmp().
> Standard memcmp() may stop at the first differing byte, which can leak
> timing information to a remote attacker and allow incremental recovery
> of the expected digest.
> 
> Use crypto_memneq() for constant-time comparison on both the host path
> that validates the controller Success1 response and the target path that
> validates the host Reply digest.  Other memcmp() uses in the NVMe auth
> code (e.g. fixed string prefix checks) are not security-sensitive and
> are left unchanged.
> 
> Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
> ---
>   drivers/nvme/host/auth.c                 | 3 ++-
>   drivers/nvme/target/fabrics-cmd-auth.c   | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 111111111111..222222222222 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -8,6 +8,7 @@
>   #include <linux/prandom.h>
>   #include <linux/unaligned.h>
>   #include <crypto/dh.h>
> +#include <crypto/utils.h>
>   #include "nvme.h"
>   #include "fabrics.h"
>   #include <linux/nvme-auth.h>
> @@ -361,7 +362,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
>   		return 0;
>   
>   	/* Validate controller response */
> -	if (memcmp(chap->response, data->rval, data->hl)) {
> +	if (crypto_memneq(chap->response, data->rval, data->hl)) {
>   		dev_dbg(ctrl->device, "%s: qid %d ctrl response %*ph\n",
>   			__func__, chap->qid, (int)chap->hash_len, data->rval);
>   		dev_dbg(ctrl->device, "%s: qid %d host response %*ph\n",
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index 333333333333..444444444444 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -8,6 +8,7 @@
>   #include <linux/random.h>
>   #include <linux/nvme-auth.h>
>   #include <crypto/kpp.h>
> +#include <crypto/utils.h>
>   #include "nvmet.h"
>   
>   static void nvmet_auth_expired_work(struct work_struct *work)
> @@ -177,7 +178,7 @@ static u16 nvmet_auth_reply(struct nvmet_req *req,
>   		return NVME_AUTH_DHCHAP_FAILURE_FAILED;
>   	}
>   
> -	if (memcmp(data->rval, response, data->hl)) {
> +	if (crypto_memneq(data->rval, response, data->hl)) {
>   		pr_info("ctrl %d qid %d host response mismatch\n",
>   			ctrl->cntlid, req->sq->qid);
>   		pr_debug("ctrl %d qid %d rval %*ph\n",

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

