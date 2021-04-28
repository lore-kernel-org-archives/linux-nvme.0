Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5692CC43460
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 23:06:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B135161059
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 23:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B135161059
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=07w7tky5HNibHuNu0xqd1b6lRFOCEFfL4RAPYRQ+q6U=; b=fIMV6u1oygFi3Iych6AgLOLsP
	Rkhit90QY5G03gPF/AU3iS2aCXj05thXwkyPoZQSh1vD9U88NEOeLfkVBN58TZx4n/28yg8fPbpPH
	vqfsogwQT4dDvRfZnw1vtyhFqC+AUJY2vd44Qln0upU6OefINp2sZnkLa2uZ5m8OZzDUKV5mMEvvb
	xLqo/tINaa+CizDE+kyUv/YmUTFZdAjTFNfY4HyRkD9luj4334ILgdsDxlmIsp7UiW0X1GwqcQ5nF
	IqqWeFln3b847thQYk94fOcTv2MbmKIzzah0zCYTTcR5pqXOMb53U01s/6YLWDN+k+lBQrxBL4x4D
	WDg24jaPw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbtGF-004T3L-DS; Wed, 28 Apr 2021 23:06:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbtGC-004T36-8i
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 23:06:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=jQjD9kBwh4ysOC+01W1rGerIwUcFfiPpMOrIOk0RzyI=; b=Y6WJUi7KC85Nlgn8OEXLzmf72a
 69eFj/rgYA8sbcRLDM3qQknle6R5xJdKTwWqliXgnVBqBobA5D9bn2Dayg3tZ/lidcOqZRN006+SM
 mXPc/Usnt8/aTw8lWp5JpgX10TFlcskXoM7C15/5FQLPBMQmM2k0dW8M56ls0EuLbgRj/skn7jznl
 qGr+cW54obkKA79J8N+n+Zy16WiruIW993vqv5R/gS4cgYt9PsvRESM2EWDFKA5CfoK92+2vThP1z
 LuLqDSPoB4g16A0XpHv2MOZuRhX9LNewCNe0Gcr9ZVbwU19Tok3auMwjb+8WSB6KtLNEpLFobSssQ
 FGamM+2A==;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbtG9-000FWw-I4
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 23:06:23 +0000
Received: by mail-wr1-f54.google.com with SMTP id x7so64736491wrw.10
 for <linux-nvme@lists.infradead.org>; Wed, 28 Apr 2021 16:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jQjD9kBwh4ysOC+01W1rGerIwUcFfiPpMOrIOk0RzyI=;
 b=P+/OFELdI2RDwKfAfDOL2q+P8Dh4ob1ND9ypnHZovIYAy6Z3Cw0PgHWGF8w8ACENZ2
 p/yCV78g6XmLbKmcFrYVcwFbuPjFYIDfiqfW89aEPK7hnxPTkLWLs35gqHJ5x/sSBZr0
 qCwPYNFG01fRUXHS7m4fPvlKMQTubDN4MYWfE/K1LDsxSuCH8Fr4wT3Nv5njBVWBKKZc
 RJa3zRw7rIMLoJtGllhukQfL3u2AtAlgywD8qCNDySzdVskpfkig44Q5SCdulOVi1A4F
 hC85NfvxeF5Wu5FnEleHQOYIwJ1BtNG8swFs4f08hM6lyNbmMBCr2qOc4o/pWejUi2vw
 9Urg==
X-Gm-Message-State: AOAM5337GY6bAqaLQ9psUGeUIZ+kIDncSQ1t5sjTgjaFNsIs4L1aAmO4
 Fk61SHPKFmimzvw7xx0pKoJaTpyZDdY=
X-Google-Smtp-Source: ABdhPJxD8WP9iMQ/AWiadDk10DYWhsQ3CkbSahKYMftT25RqrSWANGm2Erp7I+Kd2KBtD6J7Kj10UQ==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr25883642wrp.365.1619651176237; 
 Wed, 28 Apr 2021 16:06:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:caa1:f76f:3865:edcb?
 ([2601:647:4802:9070:caa1:f76f:3865:edcb])
 by smtp.gmail.com with ESMTPSA id l14sm1160401wmq.4.2021.04.28.16.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Apr 2021 16:06:15 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <20210407195319.GA30623@redsun51.ssa.fujisawa.hgst.com>
 <8d8c5c82-f1d3-5599-ae3e-5af5ff12eb9d@grimberg.me>
 <20210427233956.GA631292@dhcp-10-100-145-180.wdc.com>
 <549e4f57-5f6e-d5ed-db63-8f82e9a7490a@grimberg.me>
 <20210428155847.GA21854@redsun51.ssa.fujisawa.hgst.com>
 <00a3b480-2885-b32b-139a-ef68ff21bad5@grimberg.me>
 <20210428180147.GB21854@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <500074cf-c0e8-807b-5b30-a3474d37700f@grimberg.me>
Date: Wed, 28 Apr 2021 16:06:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210428180147.GB21854@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_160621_633840_EFAA329A 
X-CRM114-Status: GOOD (  14.73  )
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


>> In tcp.c:
>> --
>> static void nvme_tcp_set_sg_inline(struct nvme_tcp_queue *queue,
>>                  struct nvme_command *c, u32 data_len)
>> {
>>          struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
>>
>>          sg->addr = cpu_to_le64(queue->ctrl->ctrl.icdoff);
>>          sg->length = cpu_to_le32(data_len);
>>          sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
>> }
>>
>> static void nvme_tcp_set_sg_host_data(struct nvme_command *c,
>>                  u32 data_len)
>> {
>>          struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
>>
>>          sg->addr = 0;
>>          sg->length = cpu_to_le32(data_len);
>>          sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
>>                          NVME_SGL_FMT_TRANSPORT_A;
>> }
>> --
>>
>> What is the sgl type you see in the traces? transport specific sgl
>> (host-data i.e. non-incapsule) or inline?
> 
> The Sub Type is 0xA, Transport Specific.

Interesting, I don't see how the host is going to send data
without it being in-capsule, and before receiving an r2t...

Maybe add this one for a sanity check:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index eb1feaacd11a..6cb0e13024e5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -987,6 +987,8 @@ static int nvme_tcp_try_send_cmd_pdu(struct 
nvme_tcp_request *req)
         len -= ret;
         if (!len) {
                 if (inline_data) {
+                       pr_err("no way... data_len %d queue_max_inline 
%ld\n",
+                               req->data_len, 
nvme_tcp_inline_data_size(req->queue));
                         req->state = NVME_TCP_SEND_DATA;
                         if (queue->data_digest)
                                 crypto_ahash_init(queue->snd_hash);
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
