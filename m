Return-Path: <SRS0=GoWw=5K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999F0C10DCE
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 00:19:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6925420724
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 00:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UNtSYk9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6925420724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uDu8F1Ot4xvVJ9kKvSznkm/jkbflv3Kr/A+slKfvbX0=; b=UNtSYk9DmRs3nmBYSayY4aKp9
	7aBjrUTLRpd22fAX2lzb0uze/sL+hgEuj4sHg4j7y+vtU2LPNhDqbJfUYOWtw2v55x6GnNCGkj++o
	dlbOZ+UPuJEj6275JIpzdNWTnETOUYI1huPzDbrN2LzKQgAnEvTj0YtSYJYWwbjE2kEXHzv+HauTN
	9biFTMgr/E7WW0flWrCN2WXwVILbznUy/t4LwDuQhIL+V5Q02E4pJFq/qGhxcV3/jAirWgKA48Aym
	gj3ZuU1CU/ry+Z91v+7XRpNWI+MiMWaAdzOHE6Vply5fhEx6CU0rkDsFM9e2fyDfbLChsgl9AFouQ
	qzfXOYPfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGtlh-0006v8-Ml; Wed, 25 Mar 2020 00:19:37 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGtlf-0006ug-6W
 for linux-nvme@lists.infradead.org; Wed, 25 Mar 2020 00:19:36 +0000
Received: by mail-pg1-f195.google.com with SMTP id u12so266183pgb.10
 for <linux-nvme@lists.infradead.org>; Tue, 24 Mar 2020 17:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LEJ6XIToAJYGN40iID9kRAZa6OpZfOf9UznFkT5wX9M=;
 b=PwMRceKUY6uVPIE3y3gF1b5akabUSMGpw9ZyL/doEZxKqWuIO6fXeJlnQJK2Oz3Au6
 nKWE/X0MdXsGsT/Aa1V0LLKT39e3I5FJ5Ov2R0cl+KpFLVtQ8b9gsCumXzHzCqbxATmx
 kMt0jlyq59p99mBZM8PSF2Nr5ShC0/LQ+3QC6XOPs9WL0l1LJbfn+kr44gzRs1tvJ/gu
 qfCsqHrGMPATlOvDnd4CxLPTMJotvOYBgLu6pGBTLTZ+cj0KF9Z+MLX1Kf++l1hPx1JA
 +8Xwc/OPIHGZjFCyH/3OJVPJiA2etpeEROYgnviyM1hV0GG7FT9BP0PNRuzRTqhRDCKW
 k9tg==
X-Gm-Message-State: ANhLgQ3ukznxdA4LIbQoxf1rYn2+T1dTkyGWK7Jg3xyuVi39O//7JPHG
 +wtfhrIdLSbpsbawjX/34y4=
X-Google-Smtp-Source: ADFU+vt9aN9wG+a4hBsKZFviMQ4vABBpu6QcZZu0x7NNLLX0pdLJw4E/eP0IzsI+UnXWXz3iRYQWCA==
X-Received: by 2002:a63:100c:: with SMTP id f12mr338586pgl.185.1585095573893; 
 Tue, 24 Mar 2020 17:19:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2c87:e6f8:1c11:1d73?
 ([2601:647:4802:9070:2c87:e6f8:1c11:1d73])
 by smtp.gmail.com with ESMTPSA id y131sm17176385pfg.25.2020.03.24.17.19.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Mar 2020 17:19:33 -0700 (PDT)
Subject: Re: [PATCH 6/7] nvme-rdma: Add warning on state change failure at
 nvme_rdma_setup_ctrl
To: Israel Rukshin <israelr@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1585063785-14268-1-git-send-email-israelr@mellanox.com>
 <1585063785-14268-7-git-send-email-israelr@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b49bee23-3041-9e35-5359-efbc861be595@grimberg.me>
Date: Tue, 24 Mar 2020 17:19:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1585063785-14268-7-git-send-email-israelr@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_171935_239739_7C181404 
X-CRM114-Status: GOOD (  19.75  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Max Gurtovoy <maxg@mellanox.com>, Shlomi Nimrodi <shlomin@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> The transition to LIVE state should not fail in case of a new controller.
> Moving to DELETING state before nvme_tcp_create_ctrl() allocates all the
> resources may leads to NULL dereference at teardown flow (e.g., IO tagset,
> admin_q, connect_q).
> 
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/rdma.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index c99a882..3ae3011 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1022,8 +1022,13 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
>   
>   	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
>   	if (!changed) {
> -		/* state change failure is ok if we're in DELETING state */
> +		/*
> +		 * state change failure is ok if we're in DELETING state,
> +		 * unless we're during creation of a new controller to
> +		 * avoid races with teardown flow.
> +		 */
>   		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
> +		WARN_ON_ONCE(new);
>   		ret = -EINVAL;

I still don't understand this. Why are we warning on new controller?

Are you saying that a the state change must succeed in case its
a new controller? because if its expected to not succeed in case
of a failure then there is no point of the warning.

I am missing something here..

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
