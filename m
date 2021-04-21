Return-Path: <SRS0=D0Wy=JS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E551FC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 16:59:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC6C61453
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 16:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC6C61453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LkN1rOcsFY4awKxY5CvHT6d95BWuIkLoSOl59ymaZ9E=; b=kcQc8OypgkGJJqFxq0Qy8U5ZR
	Sea1siqlwDy58sogz0MJnbqhT7AAm25m1b1wxdmHqXoZjzGcB5yFBO4r4t3bmufkMd6KmtvywUvk6
	2ClQqE1ta80/gm8NtQGwEeFNVGcTjQioZKwCey5JxcJqIpHULp20tpFUJ2dQXFlEa+BSsVitlcdVU
	B+sQrj7iAJlwUdCNcFJPBtH4xfmw5CF0Klljqo3wHqI9akS63qR7UxAMjYQ3/0NZmdNmRZxDXHo05
	c5QlHdsK6BN1llF1MoXJXwameCElAC9UUtF2RBAWb6XNVA/7SQOSSd77RO8TByvgNIawpiFw9Hgh1
	hhy6ENl0w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZGCK-00Ennu-Db; Wed, 21 Apr 2021 16:59:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZGCH-00Enni-PO
 for linux-nvme@desiato.infradead.org; Wed, 21 Apr 2021 16:59:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=ZSuJ4U/pe3CJlgJZyVaasc/ZKV2pGqoLduRUwDKZOBg=; b=HfxL7VcHx/TWOZCWIRNgA4HTKC
 NRX1bayfIrBoD6JLFmiCww17E3R9AjKLGKSzoIb7mESwwh1DUwkEcCbwZSvm7J83xx4pgKVizRJ0e
 zfiw86x8thDAzzzNx4AiejMk/PGYeDiCJZ8Mb3oIxpZyfgu77Ua+0jlWxjTZP5Vn1m/mRpzfaRpGP
 JaH3dlz/RNwWxhf/S0gmpbqcrdiwff7ZKYvgnyx6sVnCsmr2C/h44wXmXm9BYX86nyEVEX1n5MMHu
 wt2iIFhhhmgW0AuLpu+rkzgUfNLJdvepuQZMsmXALxFBrJ94bhIJWPNMgr6TQOUSLnkx1OP2oodct
 tl1waTmA==;
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZGCB-00D2ql-V4
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 16:59:28 +0000
Received: by mail-pl1-f174.google.com with SMTP id u15so13446040plf.10
 for <linux-nvme@lists.infradead.org>; Wed, 21 Apr 2021 09:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZSuJ4U/pe3CJlgJZyVaasc/ZKV2pGqoLduRUwDKZOBg=;
 b=Vky3YevgvsjhekBQ6OgIUnrKAaLEIpebAg9dALUFbKGeNIoVgQTaxuh0qv3oc3K1Yz
 faKe6ftf9OOYAfDENPgXQiFA7mqNWTK2yxl5/ruMBw+UYz1tADDouetYeqydb2bPHBNT
 Q/wY1dFvY77zwUmJcITiaS37Xsw4MYAzAN8OWzLwZ0+y1SSbpo1rW0xu+XO3AiivmX1b
 Ep3Da7bxN/NXhyPOE6Zgxtq8vCA7TZBZ7RKENig7tUWcsPQxSXYcsdJEQGb8eKRkv4J5
 Pbyg6HGtrFrcFmdcs/zJm9aWjzt8DROfWj911rdb4kHKwEarpom8j3eCqy163tMuh3BX
 0M7Q==
X-Gm-Message-State: AOAM532dnRIznTMctfe3OfOVtlzzjl68nTkSffhPUhNk42q1uEU2vTv7
 xLgCKjsq20huIuI397aaZH4=
X-Google-Smtp-Source: ABdhPJxKuRHysGdpz9XDS4uxfcaA2OzeSGCB7JYuS58rMmk6RuxAyrqIzm30HtgWVcHI+68LuGkK7g==
X-Received: by 2002:a17:902:ff08:b029:ec:a2ef:87d0 with SMTP id
 f8-20020a170902ff08b02900eca2ef87d0mr17335112plj.0.1619024363151; 
 Wed, 21 Apr 2021 09:59:23 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5ac:19d2:59e4:7269?
 ([2601:647:4802:9070:5ac:19d2:59e4:7269])
 by smtp.gmail.com with ESMTPSA id s70sm2309428pfs.148.2021.04.21.09.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Apr 2021 09:59:22 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <300c9e90-9bd6-abc8-c67a-fa92e119e4a7@grimberg.me>
 <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
 <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
 <20210421142841.GA3575546@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8df56003-c39d-fdb6-fbda-d0a850184d5f@grimberg.me>
Date: Wed, 21 Apr 2021 09:59:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210421142841.GA3575546@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210421_095924_033871_4FFC5586 
X-CRM114-Status: GOOD (  16.52  )
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


>> Can you retry with the following applied on top of what I sent you?
> 
> Thanks, we'll give this a try. Just a quick question on the first patch:
> 
>> --
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index c60c1dcfb587..ff39d37e9793 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -63,6 +63,7 @@ struct nvme_tcp_request {
>>          /* send state */
>>          size_t                  offset;
>>          size_t                  data_sent;
>> +       size_t                  data_recvd;
>>          enum nvme_tcp_send_state state;
>>          enum nvme_tcp_cmd_state cmd_state;
>>   };
>> @@ -769,6 +770,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue
>> *queue, struct sk_buff *skb,
>>                  *len -= recv_len;
>>                  *offset += recv_len;
>>                  queue->data_remaining -= recv_len;
>> +               req->data_recvd += recv_len;
> 
> Does this need to get reset to 0 during the initial setup? It looks like
> a "req->data_recvd = 0" in nvme_tcp_setup_cmd_pdu() should happen, no?

Yes, this hunk is needed as well:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8e55d8bc0c50..226404239b49 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2274,6 +2274,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct 
nvme_ns *ns,
         req->state = NVME_TCP_SEND_CMD_PDU;
         req->offset = 0;
         req->data_sent = 0;
+       req->data_recvd = 0;
         req->pdu_len = 0;
         req->pdu_sent = 0;
         req->data_len = blk_rq_nr_phys_segments(rq) ?
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
