Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF920C433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 19:39:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382B1610A7
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 19:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382B1610A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MNKFVCPwCtOFAtP1wyjeS/DbxIzKetG35ofgb05+lNs=; b=da8sfYgK+OaLf6Q8qqjerVFeZ
	rH/eW1yIXXLMi+Se8GodF2Z3m1y2gEdvL49DNlVtBvIs0eJS+XeiN1+euzsePFvKcO0u5m86DnrjU
	L2wpuw1Sl+7ZGhbIHEmAQw+68aTJhfpxq/Cn0bWx/bZ9xZ1qtjXXp/09cNLYKoljcnmNUB3UD0AdM
	fJL4k0p1jB+FpxAXAmee1LrjgOZmdWKAMcedPcXV8ZiOXTAtO73y/qU8AuV6JHKTv5I3yK7UmbZ1K
	yxk1tFh2kX7knr7a8o8ZpWzevQ2VTgQ2S5uDM44XWs1h00DKv14fRLqtp730tkchPahtacFZ+HIkt
	H35ZAnk7w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldeP3-00EjiP-SZ; Mon, 03 May 2021 19:38:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldeOz-00Ejet-Qk
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 19:38:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=6+0TwuMpjNO7i/75uD0PcPLmnTm+kR7FgGzz8ATH5sg=; b=ucgDvSqI9c/k0yU2aezVdveAtp
 ZBnGo8DczWmDhiRyKyz+MlutmZMUjKqPfvfN3w3hwqGglgF4AllaxndNjuV/emfK4w3NuY3Zvot1n
 QVROLoNeODW/FHhXJ2CoAV/zWM7ucbfxadUIOSR/a/IBi/GA0/nJi7ATVNHuSmfvz1VgzvMo2WGK6
 L4Tlegi8+KiPmX7JAJ+tT/Tohx+yR0jgFWO/NG7jXvtXO4b8LPz79nbJkVaDA72vCcNYkvQF0Dk4F
 FGrQ0I4ysaug3FXKQtn7ja3opyMfUwPAQhKKjczc6B0bHTW3QyQrgB+S/hrWb5SXOsQYt6mrisjf/
 gaPPVDhg==;
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldeOx-003RD6-Aj
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 19:38:44 +0000
Received: by mail-pf1-f175.google.com with SMTP id c17so5014063pfn.6
 for <linux-nvme@lists.infradead.org>; Mon, 03 May 2021 12:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6+0TwuMpjNO7i/75uD0PcPLmnTm+kR7FgGzz8ATH5sg=;
 b=ikgwDF95leqyVAI6k3EudCGe9VTXhzUl9AXGGlpHTKMKctisPosBl9MQWMcqSdyVGe
 eT+pqlajyeEqUvBu+bg1Vk9QhScLVYRN2x+UjapS3LcIkV1hHyXQGLd2eelmuJzOkvgn
 IkG0kCk9dtt84zagogDvHuefL7FXiN1qqfpyMm3km0qQTbfHd1lY4+6pmh2e+IupYOEY
 REjNJQehmaTIlVy+L+hjagP5ShPX6eTEHTPYuaRKNEDfGwjx+2clSAy3KPwMieS27z7K
 7tuyRGHLXGLyDWNw0U4U8uw6lfuM39MKsJ1EmmFsOyGPov7upRfTA8xPE5WT6YmXD7qf
 QTFQ==
X-Gm-Message-State: AOAM532SWvuNW7v4VTgQ055JtcMFeD0FWWgLlKezFH3xdGedDk5WomM4
 xHy+Q0au9YBwIyW0p9NTJ8E=
X-Google-Smtp-Source: ABdhPJy/0lpbldomVIVA3bw93qxyafMOAA7AEr7Cv8gAwOTRMt7iU9Fh4Su6JKPe9Z4OVnU9cNdWWQ==
X-Received: by 2002:a65:590a:: with SMTP id f10mr19948491pgu.358.1620070720520; 
 Mon, 03 May 2021 12:38:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4840:6f98:816c:4241?
 ([2601:647:4802:9070:4840:6f98:816c:4241])
 by smtp.gmail.com with ESMTPSA id s30sm4252927pfw.77.2021.05.03.12.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 May 2021 12:38:40 -0700 (PDT)
Subject: Re: nvme tcp receive errors
From: Sagi Grimberg <sagi@grimberg.me>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <300c9e90-9bd6-abc8-c67a-fa92e119e4a7@grimberg.me>
 <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
 <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
 <20210426153137.GD12593@redsun51.ssa.fujisawa.hgst.com>
 <f247f9e2-6724-0feb-b40c-08ada848d290@grimberg.me>
 <20210427181236.GA631001@dhcp-10-100-145-180.wdc.com>
 <686a7cdc-a9a8-3700-3805-90d07db39707@grimberg.me>
 <d27ccec0-7b2c-790c-3192-96c6e2aeee0c@grimberg.me>
 <20210503142848.GB910137@dhcp-10-100-145-180.wdc.com>
 <8932c0f7-1d9d-90a0-dd9d-32ba43d03d76@grimberg.me>
Message-ID: <bd69eafa-9f1d-4cdf-f1b5-8b71ffd78917@grimberg.me>
Date: Mon, 3 May 2021 12:38:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <8932c0f7-1d9d-90a0-dd9d-32ba43d03d76@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_123843_402261_CF24D2B0 
X-CRM114-Status: GOOD (  21.32  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Hey Keith,
>>>
>>> Did this resolve the issues?
>>
>> We're unfortunately still observing data digest issues even with this.
>> Most of the testing has shifted to the r2t error, so I don't have any
>> additional details on the data digest problem.
> 
> I've looked again at the code, and I'm not convinced that the patch
> is needed at all anymore, I'm now surprised that it actually changed
> anything (disregarding data digest).
> 
> The driver does not track the received bytes by definition, it relies
> on the controller to send it a completion, or set the success flag in
> the _last_ c2hdata pdu. Does your target set
> NVME_TCP_F_DATA_SUCCESS on any of the c2hdata pdus?

Perhaps you can also run this patch instead?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6bd5b281c818..a848b5b7f77b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -55,6 +55,7 @@ struct nvme_tcp_request {
         /* send state */
         size_t                  offset;
         size_t                  data_sent;
+       size_t                  data_received;
         enum nvme_tcp_send_state state;
  };

@@ -751,6 +752,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue 
*queue, struct sk_buff *skb,
                 *len -= recv_len;
                 *offset += recv_len;
                 queue->data_remaining -= recv_len;
+               req->data_received += recv_len;
         }

         if (!queue->data_remaining) {
@@ -759,6 +761,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue 
*queue, struct sk_buff *skb,
                         queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
                 } else {
                         if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
+                               BUG_ON(req->data_received != req->data_len);
                                 nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
                                 queue->nr_cqe++;
                         }
@@ -2274,6 +2277,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct 
nvme_ns *ns,
         req->state = NVME_TCP_SEND_CMD_PDU;
         req->offset = 0;
         req->data_sent = 0;
+       req->data_received = 0;
         req->pdu_len = 0;
         req->pdu_sent = 0;
         req->data_len = blk_rq_nr_phys_segments(rq) ?
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
