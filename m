Return-Path: <SRS0=G7yG=I2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4E0C433C1
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Mar 2021 04:05:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40D561936
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Mar 2021 04:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40D561936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UUS2Bxz1aW2lmCdvtA4Obe/1AVBwrvJ5jz7katFyMT4=; b=Tx8Y5FEa/qROQbPJtUM10YwLt
	6s2awk3Y9wfuANygxiKfPoBYsngRti1vEnEw7qEX8ESLbMd7JygVxdYLgp0Ti/HkQXiFj1DplN94D
	7/D7wOK2GBACvMmZrWIvDIeQNPj8vxEpqnYvYSC+/6+6QXw++cNEV6baLXCZ2+uTV8Pp5QxIAolju
	7+8rwi+Wh7+W9G/FXMeeNX4F5cSLCI0PuW5DylDCZDcw0b69VJG4mWUbf8eCoeV5gre2UonPudII6
	YAZ2kVSudaiVuPgcUK6ONOuB7XkfA6mIXlncHlnKu8zBZNSPeHgc3Ypl6JXwXnDLajlpmUJ0msd5d
	Et8RArBoA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lQMfa-005obb-4K; Sun, 28 Mar 2021 04:04:58 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lQMfL-005oZI-H3
 for linux-nvme@lists.infradead.org; Sun, 28 Mar 2021 04:04:45 +0000
Received: by mail-pf1-x435.google.com with SMTP id s11so1546109pfm.1
 for <linux-nvme@lists.infradead.org>; Sat, 27 Mar 2021 21:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pH6hHzlQZLf2jQC4WK/ZMMJF7tkojldUbAfPSd7QNiM=;
 b=J/uZ4YjDvoT1e/3m8Kkd4I4nLMFoa97tQaFyz39lIhywttEnbwmoLsVcWEin7UPiX+
 mYBYHFlbzoKLFNarJva7AHdQZxAvkMPlt0WlwHInezLWK7vcoRDKV8dey0vTuHlmLw/G
 doXVb90b2DhH0Cm+Qml5C44vWK4j7JajvfTKYNv3vOINIhfrvrncNd+R9cZri7hQQ6py
 w9h9MVgATnCp5+s+bBHKyI+T5FN39+NFu0Bh+jIx/S3PwH+M3KVfHaLY8qmeMJVfq59j
 MMeKQisEL2p3PViUPsdRKi6ZmJD91kHHvISub1X7GgoHLH06fUDIGeopf1lcZ5KuQ1Dm
 jGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pH6hHzlQZLf2jQC4WK/ZMMJF7tkojldUbAfPSd7QNiM=;
 b=HbvEPD9u3/1gpcQT0Si8jok9KTWizATImMpU99I4NYwP5jRLQNO3pdmdxodAU6dju+
 iloMUhyJgakGnmxoejf5H/Onp2GQRlcoOHcdmrqfhsqeD2uZbjlgIAbigcY8h4R6Ak5I
 blHqNYqjSyrAIdLRHZhpmrpMAQCUq2W8FHhZOAoDXCMEtBJrwyfbrfSs5uhn3dH9PLsE
 xXAuT1mdtIldC7K1QQEt4OjaaZ/JlT4kbUMnFEAEUlMgAQpxXgrubEVE6jj8FesrsY0Z
 dxrJhqWigqhAAGHRS2H364MI2CUjPiXzkuFSgU+LVvH4Dnxjs55cxYDGVpVrtfMnSjgS
 oyRA==
X-Gm-Message-State: AOAM532+IMnnCacxu7zHt5B/fBKStNQFK5WynkeiskjV1qjoZT4144QV
 XPaYobSkhjsVPB1QiVCweDU=
X-Google-Smtp-Source: ABdhPJy9rt33LQOSxVeH6cFfPmnIanyal/U65uTYusZzNTUlP9+y3KK2mWhZBH7RXZCgM1yQ4MsB1g==
X-Received: by 2002:a63:4c63:: with SMTP id m35mr18315909pgl.105.1616904279061; 
 Sat, 27 Mar 2021 21:04:39 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id w23sm12283033pgm.64.2021.03.27.21.04.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 27 Mar 2021 21:04:38 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: elad.grupi@dell.com
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	houpu.main@gmail.com
Subject: RE: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing
 error
Date: Sun, 28 Mar 2021 12:04:27 +0800
Message-Id: <20210328040427.20895-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210326175941.22734-1-elad.grupi@dell.com>
References: <20210326175941.22734-1-elad.grupi@dell.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210328_050443_693802_49F25A5C 
X-CRM114-Status: GOOD (  24.59  )
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

On Date: Fri, 26 Mar 2021 20:59:41 +0300, Elad Grupi wrote:
> In case there is an io that contains inline data and it goes to
> parsing error flow, command response will free command and iov
> before clearing the data on the socket buffer.
> This will delay the command response until receive flow is completed.
> 
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Signed-off-by: Elad Grupi <elad.grupi@dell.com>
> ---
>  drivers/nvme/target/tcp.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)

Hi Elad,
Just noticed that we still queue the failed REQ to the response queue
in this version. Am I missing something?

Is this still needed? (I think it is).
@@ -526,6 +527,12 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
 
+	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
+			nvmet_tcp_has_inline_data(cmd))) {
+		/* fail the cmd when we finish processing the inline data */
+		return;
+	}
+


Thanks,
Hou

> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 70cc507d1565..3bc0caa47873 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -702,6 +702,17 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>  			return 0;
>  	}
> 
> +	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> +			nvmet_tcp_has_data_in(cmd) &&
> +			nvmet_tcp_has_inline_data(cmd))) {
> +		/*
> +		 * wait for inline data before processing the response
> +		 * so the iov will not be freed
> +		 */
> +		queue->snd_cmd = NULL;
> +		goto done_send;
> +	}
> +
>  	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
>  		ret = nvmet_try_send_data_pdu(cmd);
>  		if (ret <= 0)
> @@ -1103,9 +1114,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>  		return 0;
>  	}
> 
> -	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> -	    cmd->rbytes_done == cmd->req.transfer_len) {
> -		cmd->req.execute(&cmd->req);
> +	if (cmd->rbytes_done == cmd->req.transfer_len) {
> +		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +			nvmet_tcp_queue_response(&cmd->req);
> +		else
> +			cmd->req.execute(&cmd->req);
>  	}
> 
>  	nvmet_prepare_receive_pdu(queue);
> @@ -1143,9 +1156,13 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
>  		goto out;
>  	}
> 
> -	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> -	    cmd->rbytes_done == cmd->req.transfer_len)
> -		cmd->req.execute(&cmd->req);
> +	if (cmd->rbytes_done == cmd->req.transfer_len) {
> +		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +			nvmet_tcp_queue_response(&cmd->req);
> +		else
> +			cmd->req.execute(&cmd->req);
> +	}
> +
>  	ret = 0;
>  out:
>  	nvmet_prepare_receive_pdu(queue);


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
