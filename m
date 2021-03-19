Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE99C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 03:54:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3DC6023C
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 03:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3DC6023C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0cpLCbZ0l9L1YXgkqIGMPvVuFLMTlgj5qzMfIV3Ap+Y=; b=dJ+ASgyliaKlyGT5nM5DA7z0e
	W2pj92YtanGR4orZmmsiar+h5AfGlMbxchNmXfMqCRbiWrqwRX3zJkeMt2r17FxBwAsm/YVlc7OzB
	em0jqz+x2WgCYBM1mTIJ1s+aiB9JeXXu/gPChrJcKv4JzTh3NCdDjVQsIdqlWlJYM8oPVT4B/2SzB
	rSzfqLIKhe2P1eAiRoBSbd4xGtXVqj6ucuPHZ4k86aCW2P+2MmlCiE+ZYaJNxZoyfyEFGlb1YemX1
	LaZFYFTpZPIAxBiUA3sQDlmaQJp90FOqPEIX5AvFLQ/qYPt8hPP3BK6ue4M2JCRpER1xp1qfG14rY
	SkyPlgxaA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lN6Ch-006QiL-Ah; Fri, 19 Mar 2021 03:53:39 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lN6CD-006QdN-L8
 for linux-nvme@lists.infradead.org; Fri, 19 Mar 2021 03:53:12 +0000
Received: by mail-pj1-x102f.google.com with SMTP id
 a22-20020a17090aa516b02900c1215e9b33so6048858pjq.5
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 20:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iKkORFc+JloMGcaUApbOzsM9/BLaUQ2gpVNVmnrMiCY=;
 b=LgIlBtWx+C6HqN3QcxDzleIfJboAk9kmAkpZZrZeASb4U/YI6Z7kwLRxXvpDoQ1b4K
 iNZluttszQEmmbZhEj/OIj+xgGy9jApSTE+t2v38hL1RxcvQ/SwN8UAVba4SYbhy5V7M
 O0IPUtfa4YnxCh2jw9eQHsAb+AKR6RFOjTn3mt6j90MQcIVKVl5LbdqV7NKnLFh1UFIF
 sUEtidTcRQdybqZLyriV+hpEBBcDz74sAK93bKQNCkCW7Bux+t6F0TyeYdvfsN9lQlba
 5zva2RNPnOBxVmfeDaU/M9oL8dwMbyzlK+gSKg4I0UPhwERTYTkaOSdy/9z9TZYl2OWq
 L4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iKkORFc+JloMGcaUApbOzsM9/BLaUQ2gpVNVmnrMiCY=;
 b=sZh1bePEeaVoJXJUvIPN0SHTX0Si91iXDB3U9qNRfHcvMYWB9WoahfBjIT801ReEWt
 wkBec20jJi45nJHdweCRhXaPBGHyBuM9uE7LRj00iTQl+B0y7id5+l+Y5TdS3bi3CuwZ
 Q6WQkx9KwXz1oM3YrlpchCKA6/fXFpTanFoIoKd/6Rb76VRM1r/UAdkz+PVUv7oIGrpq
 FAJwsJ3kDla1bUdYPgzKPtOosD8+qUo+RTx1uRfdxaOq4ZSYmtBBNd4n0rkKb1MgHxO7
 3h0QkeQ6AVNa3VjmhseQEth3dwWbp2eBz+hjEcPBj+TZVMTIdWgr2wfrfq42jqBK2QEd
 XOdg==
X-Gm-Message-State: AOAM5308fWD7WxC7SC/k5x4Xa5zcF5QlMTsJHCRg0Zr817nE3XCDC7Hr
 kXIuj9Z1LO1qhAprp0yAPaH7/xho9HOfTA==
X-Google-Smtp-Source: ABdhPJxcQiwsfgf5gJY56N54zhZkpefAQtI0dz+OL2HWR9T58ptf4cltoI4WUPqP77wyf/Eq/bbWLA==
X-Received: by 2002:a17:90a:9f8d:: with SMTP id
 o13mr7532469pjp.25.1616125988266; 
 Thu, 18 Mar 2021 20:53:08 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id 35sm3393231pgm.64.2021.03.18.20.53.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Mar 2021 20:53:07 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: elad.grupi@dell.com
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	houpu.main@gmail.com
Subject: RE: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing
 error
Date: Fri, 19 Mar 2021 11:52:57 +0800
Message-Id: <20210319035257.96267-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210318125518.27121-1-elad.grupi@dell.com>
References: <20210318125518.27121-1-elad.grupi@dell.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_035309_857373_E29B2F3C 
X-CRM114-Status: GOOD (  17.60  )
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

> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 70cc507d1565..5650293acaec 100644
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

Hi Elad,
Although this works, I think Sagi would prefer not adding this to the
response queue in nvmet_tcp_queue_response().


>  	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
>  		ret = nvmet_try_send_data_pdu(cmd);
>  		if (ret <= 0)
> @@ -1106,7 +1117,9 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>  	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>  	    cmd->rbytes_done == cmd->req.transfer_len) {
>  		cmd->req.execute(&cmd->req);
> -	}
> +	} else if ((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> +			cmd->rbytes_done == cmd->req.transfer_len)
> +		nvmet_tcp_queue_response(&cmd->req);
>  
>  	nvmet_prepare_receive_pdu(queue);
>  	return 0;
> @@ -1146,6 +1159,8 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
>  	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>  	    cmd->rbytes_done == cmd->req.transfer_len)
>  		cmd->req.execute(&cmd->req);
> +	else if ((cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +		nvmet_tcp_queue_response(&cmd->req);
 
Here we also need to check cmd->rbytes_done == cmd->req.transfer_len as
we could get multiple data pdu.

(BTW, did you forget to add [PATCH v2] to the subject line?)

Thanks,
Hou

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
