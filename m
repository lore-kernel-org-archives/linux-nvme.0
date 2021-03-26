Return-Path: <SRS0=jxE6=IY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BAAC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 10:27:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB27F61A48
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 10:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB27F61A48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0j/xV/ANcHRoT2hHM7TeeIL9VdhrLG1k7eBBnYODmN8=; b=lghr377cNz2tieBEgMPHkALxh
	0NZ8EPW5bkRvEQGY+rc1adK2L1AnbyUVLAcr8YDxQkDel+ZKYyItNuBDUn+rlCMuaM849IEnJ7c/7
	ncTF9apjIFGxTAc89SKLY1FcEEfC4D1Y8DL5/GPkqPd+RnGT/JWQ5vkokWOIpY+Nyu5lXVwYK2J09
	PZLM8h2VG+KTi855nrcxXX1O5JiSKlVsguoHjP/yW5RfG7MBLOnulIMbrj5bLnVNOHH18H3G266BJ
	ncvoNMiy1H87a0W79o7Q7XOMUCzcYQ4TThGJyJtCy8WZRqluRBX8KOpgWKPyGSjtHTRgfRsaxRpQG
	pZy6o1JPA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPjgH-003I6t-OL; Fri, 26 Mar 2021 10:27:05 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPjg3-003I6M-Mt
 for linux-nvme@lists.infradead.org; Fri, 26 Mar 2021 10:26:53 +0000
Received: by mail-pj1-x102d.google.com with SMTP id s21so2356191pjq.1
 for <linux-nvme@lists.infradead.org>; Fri, 26 Mar 2021 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XKbEYByM8N1WS8dc1O+8KagsbZTUI5GriM9isXSIIXU=;
 b=QN0RYtoASzR1rCIz8/3m4ljX3O+Vjc07mRCI9lonZPUcyO4xW8FYTQBGTz3KM5hk74
 cg3KhZBR1TGb/DxLvQr2HBkeeS5w3NEtdWxMuj/dTxlmUU1B22N3IFKVCY+ynD9/sNx3
 cNx5ReJ2pXXsqtHETclsOrXFZt7Zu+txDF+qkD6MkxGa6s+moK4v4SZvaC6i0+Lo8/Ic
 lsSF9GkB/grv4YUWjUek50ta6rbgfYThSbHKLamcIMjOYt0QuyaeWoRXA2eM1lOczQga
 owKE2o5VwE2E9lH8NHFjShoM8zB4bAxFeFOPe8HifQ8KxnbmpP1MFh6ia30nKz2tf3Co
 msUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XKbEYByM8N1WS8dc1O+8KagsbZTUI5GriM9isXSIIXU=;
 b=mqQMhnVbdxD1aF8CIEtWsMahaaSa6zxxWok0OW46enjdsVjo3xeFD1d0oJGyhZzo6s
 pd1SgXHMnufuzZP9vzywZ9U4dyqv4MTp0WpUpL+Bl8Pk4tQzPzDGtO+I0aZFwx5Kq9Nb
 blgdsRghpFDMseaHzLQ+UebusFWU1q8Hd5nBAq9YWY7gwKZDvvEP8/yarQ7FJy29kdYr
 47CQYhbXDIqnZ9m6j2gQZjuH6BKcBZLQKqHXj4sSn0eT9RIUzCGfEOKoL+jmnPXRtsjU
 e3JqbyJrxrmQicmT4igF6hlLC3zHDz89cAogd+RHsmAqA3jdTAiGS+1EzVbLWEUQW1wt
 HsRw==
X-Gm-Message-State: AOAM5336p3yWROkSgtOmdL2PaKq9LnN1R33n6FUZNU+iS2LA/GCf7qyD
 mHD0m+1JagM2P6cpzs08MtU=
X-Google-Smtp-Source: ABdhPJya8SlmbGKTcaF/eK2Vy416Ax6OlJOH+BNTFzWu3BSDHIFc3gDLaGpRVf70i4zCRhvFus3Z4g==
X-Received: by 2002:a17:903:22c2:b029:e7:1f02:434c with SMTP id
 y2-20020a17090322c2b02900e71f02434cmr2559112plg.73.1616754408247; 
 Fri, 26 Mar 2021 03:26:48 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id k5sm8931829pfg.215.2021.03.26.03.26.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Mar 2021 03:26:47 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: elad.grupi@dell.com
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	houpu.main@gmail.com
Subject: RE: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing
 error
Date: Fri, 26 Mar 2021 18:26:36 +0800
Message-Id: <20210326102636.55949-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210325224952.18311-1-elad.grupi@dell.com>
References: <20210325224952.18311-1-elad.grupi@dell.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210326_102651_886315_AAADF082 
X-CRM114-Status: GOOD (  15.08  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Date: Fri, 26 Mar 2021 00:49:52 +0200, Elad Grupi wrote:
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 70cc507d1565..f10fa2b5aaeb 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -154,6 +154,7 @@ static struct workqueue_struct *nvmet_tcp_wq;
>  static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>  static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>  static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
> +static void nvmet_tcp_queue_response(struct nvmet_req *req);

Do we need declare it here?
 
> @@ -1103,9 +1121,14 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>  		return 0;
>  	}
 
> -	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> -	    cmd->rbytes_done == cmd->req.transfer_len) {
> -		cmd->req.execute(&cmd->req);
> +	if (cmd->rbytes_done == cmd->req.transfer_len) {
> +		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +			nvmet_tcp_queue_response(&cmd->req);
> +		else {
> +			if (unlikely(cmd == &queue->connect))
> +				nvmet_tcp_executing_connect_cmd(queue);

Is this in somewhere not yet upstream? I did not find
nvmet_tcp_executing_connect_cmd on upstream (5.12-rc4).

> +			cmd->req.execute(&cmd->req);
> +		}


Hi Elad,
The patch looks ok to me except these 2 question.

Thanks,
Hou

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
