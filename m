Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FC6CD5BA0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Sep 2023 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5ABj5ALgACyeYyjXWM4VOk2gjeNWXQ+F4QyWXtsfCo=; b=PtaUmgqD+8ywjAJkadJJm7pRWy
	iQIE/A3zCH5vLkiNijSJUzE3pfwqs/S1xM8bS9TJSPZrKK8fsoqEIkzwgRCmuGpjjgJbrQG0jASgA
	CBUb2mTBMby1OoHBjNAAjT4fnd8NGNAjcSvAVpREzSFIpLEuFDB49NHbcAHX3aJ8Uz61Pue5474KQ
	CZLzSnlDK63dXCY//p9sbuL+RXKdY+RTKKj2skzVn+cnVwsZQvvcvoMW39H9bnBUxOZink1rZ6H5B
	3BVOzpauUehcG7i9wN8ewr4yqrFT7wfy8Bm8aahgQyHkr1t+qfbtfX+B3MAQAcuDpR+bmwBn9xJSp
	9du1q4iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiZkg-000PAN-1r;
	Tue, 19 Sep 2023 12:22:50 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiZkb-000P9S-2L
	for linux-nvme@lists.infradead.org;
	Tue, 19 Sep 2023 12:22:46 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4046f7d49a9so16847135e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 19 Sep 2023 05:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126163; x=1695730963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5ABj5ALgACyeYyjXWM4VOk2gjeNWXQ+F4QyWXtsfCo=;
        b=Da9u6lRzFGk6Wcey91rzOYnDhnmfpZAJEpRYrAYFxc3zgM4nnKvIpzTAH+oawV6Ynw
         nnAiEw4yZWXTj0g+LIMccHbpf0NN3OT7UmAJfZLTeYcKu8hKNBNJNDg2cN2n84IMsCeC
         uUA1ds1kcH8taX6xY56OpSXQZP8nHdhoUBlCqoOC4ZtN+MNEkiMmMH3MKFKvwE4se0NO
         YWKRbjlPUtyeL3wgtyt/mlGK697O2M+/fMI2QGYukTuXa3bFEeDGrEXY71E9noldFIF0
         gvUfS5KPq+rGcZc0zyf0TWDA+mkhn5TSL91O1YvW0N2P0cEqd2IuvLzTip8K42glq8DV
         Herw==
X-Gm-Message-State: AOJu0Yzmt9Dq9kJ/kuDcjTx3of4keRUbZUM1EWFEWZjmsuQh0rdFcCaw
	6+eyBC7lADZvLa/L9x/aN5jcNH51wt0=
X-Google-Smtp-Source: AGHT+IE/bzHoH2I27iB8eM3kxCJFZ9o8tC6yBlaodrAeke7/YF3CD9OSqMCeIOKVS8ME3azBb97HPw==
X-Received: by 2002:a05:600c:5103:b0:401:faf5:85c3 with SMTP id o3-20020a05600c510300b00401faf585c3mr11427510wms.0.1695126162345;
        Tue, 19 Sep 2023 05:22:42 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t27-20020a05600c329b00b003fd2e898aa3sm737561wmp.0.2023.09.19.05.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:22:41 -0700 (PDT)
Message-ID: <8e8072d2-1564-4879-8f00-682f5367bee0@grimberg.me>
Date: Tue, 19 Sep 2023 15:22:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: nvmet_sq_destroy stuck forever when data digest is turned on
Content-Language: en-US
To: "Grupi, Elad" <Elad.Grupi@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "Engel, Amit" <Amit.Engel@Dell.com>, "Zinger, Eldad"
 <Eldad.Zinger@dell.com>
References: <DM6PR19MB40114101A791D54572BD88C2EFFAA@DM6PR19MB4011.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <DM6PR19MB40114101A791D54572BD88C2EFFAA@DM6PR19MB4011.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_052245_761212_F514C8E0 
X-CRM114-Status: GOOD (  19.83  )
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


> Hi
> 
> I have an issue with nvmet_tcp_release_queue_work hitting hung task after 2 minutes of waiting for nvmet_sq_destroy.
> This issue reproduces only when data digest is on.
> 
> I am inspecting the code of nvmet_tcp_release_queue_work and I see that the code handles 'data in' commands
> This means that it calls nvmet_req_uninit for any command that its data is still in transit.
> 
> There might be commands that the data transfer is already done, but data digest was not received from socket yet (aka rcv_state is NVMET_TCP_RECV_DDGST)
> The data digest will never be read from the socket because the socket is blocked by NVMET_TCP_RECV_ERR
> Hence nvmet_sq_destroy will be stuck forever waiting for nvmet_tcp_try_recv_ddgst to execute.
> 
> Can you suggest a fix for such an issue?

Does this (untested) patch make the issue go away?
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 97d07488072d..f5eaf3457ada 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -204,10 +204,16 @@ static inline u16 nvmet_tcp_cmd_tag(struct 
nvmet_tcp_queue *queue,
         return cmd - queue->cmds;
  }

+static inline u8 nvmet_tcp_ddgst_len(struct nvmet_tcp_queue *queue)
+{
+       return queue->data_digest ? NVME_TCP_DIGEST_LENGTH : 0;
+}
+
  static inline bool nvmet_tcp_has_data_in(struct nvmet_tcp_cmd *cmd)
  {
-       return nvme_is_write(cmd->req.cmd) &&
-               cmd->rbytes_done < cmd->req.transfer_len;
+       u32 total_len = cmd->req.transfer_len + 
nvmet_tcp_ddgst_len(cmd->queue);
+
+       return nvme_is_write(cmd->req.cmd) && cmd->rbytes_done < total_len;
  }

  static inline bool nvmet_tcp_need_data_in(struct nvmet_tcp_cmd *cmd)
@@ -265,11 +271,6 @@ static inline u8 nvmet_tcp_hdgst_len(struct 
nvmet_tcp_queue *queue)
         return queue->hdr_digest ? NVME_TCP_DIGEST_LENGTH : 0;
  }

-static inline u8 nvmet_tcp_ddgst_len(struct nvmet_tcp_queue *queue)
-{
-       return queue->data_digest ? NVME_TCP_DIGEST_LENGTH : 0;
-}
-
  static inline void nvmet_tcp_hdgst(struct ahash_request *hash,
                 void *pdu, size_t len)
  {
@@ -1221,8 +1222,8 @@ static int nvmet_tcp_try_recv_ddgst(struct 
nvmet_tcp_queue *queue)
                 goto out;
         }

-       if (cmd->rbytes_done == cmd->req.transfer_len)
-               nvmet_tcp_execute_request(cmd);
+       cmd->rbytes_done += NVME_TCP_DIGEST_LENGTH;
+       nvmet_tcp_execute_request(cmd);

         ret = 0;
  out:
--

