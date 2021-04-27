Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E8CC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 23:59:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7FB613A9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 23:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7FB613A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cxI5SxCxDv1cukivjh5NGcuzekymTa680Iwoj4PmLe0=; b=VjNw43uGTy100O2EcydWDfWOr
	6Cqnu14kQGaAAbyik7Ige2lC4EeqHxQ41w9jGl6lnflY4pCIx7jdG1QvD0QNrDblA1vKTYSBIn9Wf
	OyhqQUcJvVqUjcC0uRdsGP5IrGHxYQ6sNtzAYzmK3oOyKSX62jpoZrVsoZ3AMA4TRbE3XMpZ0Q2wX
	xwgQyyd0qHKKVIfOzZ9Gt+5CU85N1kTG2OmzF4ISEKTxfvK5t7GNI+sjyH25xpeIvLsw4jvQ4MCfA
	t78MiO70wP0h6s9LDhS8bFOvkIoeIrTd4VL2204Yr/rmh4q8//m/EWTQY8mH3vG27JfZErczzFPKL
	yRBE37puQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbXbQ-002Rmm-1h; Tue, 27 Apr 2021 23:58:52 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbXb9-002Rkp-1A
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 23:58:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=CaYD30DvYET9ejGBwjFkIdklnOqpmb+hsBEnJ8niz14=; b=HnGg1DeZ9tQnFXHUVUsuB/PZG7
 YD8PkeAxPzM5+66/lqTQIMP0nZqhwN/PkyONbVDjeK7HWS5XHNK7Nl+VortjcITtuvdLcnjPgsuZI
 cf+HdDBgB+iKbaxRvyETsY8SgH6uAA6cjymxjpFc17AGve6BcZX0sjhXxj3o5H0POCFlo7Yg2PJdT
 ql4s9k8OYbDFqLxTkR8giJh7hA88ZLFELNjrxo/TZltM9XB1dUksRQatvcAripj+6cem/OboDmd3y
 e6wVEIChf1Q+wBrszMKL5hP2l+Kw/c9K5oaQN5wvoxVEZzef20SHcrDMoYFLBbnSS1eIR3HBadLlv
 ptJgT4bg==;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbXb6-00H6RC-Gy
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 23:58:33 +0000
Received: by mail-wr1-f43.google.com with SMTP id h15so8877368wre.11
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 16:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CaYD30DvYET9ejGBwjFkIdklnOqpmb+hsBEnJ8niz14=;
 b=SHCMIBu5Bcz21KZPZYfL+uzrTb/2mUqco0tEy0vqErsnBKv9Jy99Lqu57yRP9vZSk7
 +on5SNfyRCFsHP0QxISLVY5TCWSD7O8g7Bb7bg8vnB4UamgWLSxsxxFecAP6vAf9sF41
 /lsAtr4XNw01MV6g1sCsRR7QFDp1Jma2tHKNklfMB2u5a0fhNaPTGE/qPVSsdS3jLgdi
 IQqa98Ou4Sa5d3MBbrW2K3XaXw0DpmHaUX8ZKpGx1FmoUf34uOyCzGAwXnoCy30OwvRp
 TXGLIyDNJ+F/zt/85xYwL9C7IfeV7ZGfFxI274WSVLDchiFBGF3Gk/zNP52HuktTeVfD
 5r0g==
X-Gm-Message-State: AOAM533T2eY5j4HoB9E0qxgeUG1sPyC/0pUaZwlgO1xbPe1MIazOQSCk
 jnuIs5MWRBQzvI2BJfm3pts=
X-Google-Smtp-Source: ABdhPJzTKInj8IYs8dE0UJ+zOFkfc5bzq8xazNFjK7PjoL3TiuZP1MLznHS9sildeCzCVQPNZo34JA==
X-Received: by 2002:a5d:6548:: with SMTP id z8mr24931577wrv.116.1619567911121; 
 Tue, 27 Apr 2021 16:58:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c15:5b14:335a:66ab?
 ([2601:647:4802:9070:4c15:5b14:335a:66ab])
 by smtp.gmail.com with ESMTPSA id l14sm5884610wrv.94.2021.04.27.16.58.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Apr 2021 16:58:30 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <300c9e90-9bd6-abc8-c67a-fa92e119e4a7@grimberg.me>
 <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
 <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
 <20210426153137.GD12593@redsun51.ssa.fujisawa.hgst.com>
 <f247f9e2-6724-0feb-b40c-08ada848d290@grimberg.me>
 <20210427181236.GA631001@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <686a7cdc-a9a8-3700-3805-90d07db39707@grimberg.me>
Date: Tue, 27 Apr 2021 16:58:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210427181236.GA631001@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_165832_595963_FBE844C8 
X-CRM114-Status: GOOD (  23.66  )
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


>> What should I put on the Reported-by: and Tested-by: tags?
> 
> This report and testing was done courtesy of
> 
>    Narayan Ayalasomayajula <Narayan.Ayalasomayajula@wdc.com>
> 
> Before you submit a patch, though, we did additional testing with data
> digest enabled and observe a regression with the following error:
> 
>    nvme nvme0: queue 0: data digest flag is cleared
> 
>  From looking at the patch, the following part looks a bit suspicious:
> 
>> @@ -776,19 +776,20 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>> 		req->data_recvd += recv_len;
>> 	}
>>
>> -	if (!queue->data_remaining) {
>> +	if (!queue->data_remaining)
>> +		nvme_tcp_init_recv_ctx(queue);
> 
> The code had previously called nvme_tcp_init_recv_ctx() only if
> queue->data_digest wasn't set, but now it's called all the time. I see
> that calling this function clears ddgst_remaining, so does that explain
> the new errors?
> 
>> +	if (req->data_recvd == req->data_len) {
>>   		if (queue->data_digest) {
>>   			nvme_tcp_ddgst_final(queue->rcv_hash, &queue->exp_ddgst);
>>   			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
>>   		} else {
>> -			BUG_ON(req->data_recvd != req->data_len);
>>   			req->cmd_state = NVME_TCP_CMD_DATA_DONE;
>>   			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
>>   				req->cmd_state = NVME_TCP_CMD_DONE;
>>   				nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
>>   				queue->nr_cqe++;
>>   			}
>> -			nvme_tcp_init_recv_ctx(queue);
>>   		}
>>   	}

You are exactly right, I think this should do the trick:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8e55d8bc0c50..eb1feaacd11a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -55,6 +55,7 @@ struct nvme_tcp_request {
         /* send state */
         size_t                  offset;
         size_t                  data_sent;
+       size_t                  data_received;
         enum nvme_tcp_send_state state;
  };

@@ -751,9 +752,12 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue 
*queue, struct sk_buff *skb,
                 *len -= recv_len;
                 *offset += recv_len;
                 queue->data_remaining -= recv_len;
+               req->data_received += recv_len;
         }

         if (!queue->data_remaining) {
+               if (req->data_received < req->data_len)
+                       return 0;
                 if (queue->data_digest) {
                         nvme_tcp_ddgst_final(queue->rcv_hash, 
&queue->exp_ddgst);
                         queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
@@ -2274,6 +2278,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct 
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
