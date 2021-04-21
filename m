Return-Path: <SRS0=D0Wy=JS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1236DC43460
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 05:34:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3636141C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 05:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3636141C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=02H5d2vteJz75jqeXX1aupxXIdygBe07N4+Ppy6JG1c=; b=ImkIzFEjYkCUEKOczXGC35oqc
	FpfObyd/oWE0vw85tFxOLijV/F80nV9bxd3wSFzo/26oLTINkiiJeT42MKZWQGPzYEPSt0o9ZWkpn
	UDEj8kHqkJNUmGqjll6/nlcjck8mCneJHIx+1tIWcZ1OkB43hStElpR+55XoOGCGQVz5zDALLoHER
	sNkD3D4lJdhzYUBgnKYWE8OOXdWTKFO4JvjSoX9kGK968ywNKXTJhh/GdLYPjPKPLqh/Sxz2DPqrf
	aigHqb47TAqtb6rDd+uWwv4UG6dVyeF+lJI/nZk6AZwRpO28xwv4QbkLh8xH8F25M6J1mzrsfCaRe
	JcScQM8SQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZ5Ug-00DiXr-Sf; Wed, 21 Apr 2021 05:33:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZ5UZ-00DiWe-Nn
 for linux-nvme@desiato.infradead.org; Wed, 21 Apr 2021 05:33:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=hHkNTMqdMK+etaiSr3Lpsk0Ujdk/RwWkLszmD5qIFtU=; b=NsvM+kYqI7uyiRsFSeOL8WtZNL
 NRO4Uxy1xQx14brlUcA7Sc3v7t2qmcVR14yKegjG93/zs1UdnvwzrkDC7bYbZfA6dbFRfarGXrh/g
 2i8aWQhPwZ39AtY3sRZ71e0Alus5zqFrmttQt6DUwc7t1f0L9vfJol6sPdcwXB/W6NRj/y1zU23r5
 S+PlEBgN8GQodArugx88LX7PqNvACwM97BLsKyhkKS6Sc1JFFXHOPnfbU8EacBQ3jFkHSkuBo6NQN
 KZOdMaeN1l9YKWF+6YzPSgJY7xJjfjyNTOezChzHBOXSiyVRVfIlbmU+0pqO3Tg0z5++pk0J2PJgA
 570FfKeg==;
Received: from mail-pg1-f178.google.com ([209.85.215.178])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZ5UT-00Cc9U-V0
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 05:33:38 +0000
Received: by mail-pg1-f178.google.com with SMTP id w10so28696384pgh.5
 for <linux-nvme@lists.infradead.org>; Tue, 20 Apr 2021 22:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hHkNTMqdMK+etaiSr3Lpsk0Ujdk/RwWkLszmD5qIFtU=;
 b=F7h0xg5dEC6UJE09H0SDXJoOGjuZrfYN3fRtHIjJRyD63PHtQHTtNgx+LzLealz7l+
 EMDg7I3IpSE5k18lq7mHIdJ7w59fKqSQ/vtTeHucGMxlNMJjjXGtU2DaJlsavgtupcZ3
 IIgnZTk3bdWk6ff6oXG1Xlht3f8dyJG9OI3+IYXuzDAekXQOFo//DooWzfiYDCp6okMi
 zgmUa/ons8yhTaALocND78DIquBik2eciufcpG4q0pTT7KhIkXhgd38DSCc56XLNnwae
 D5w5JO5ikvoxVY2ZVPDvMFNTpBfNK04yGj7CwSdho30dgCf5+33fXcF22i3RqrdmjFdt
 FdfQ==
X-Gm-Message-State: AOAM530IyuBXYGj1KnRg/QJVQvYf687/ndodsAQUAcu81BokmJW7CgSi
 lNSSt3AZv+7NV8/JHtkA1uAmdxMnRTI=
X-Google-Smtp-Source: ABdhPJzTxUUFUIza3UvE2UsP3BRXfD27Y6mj3h8AXfeTEysltHFvte+Bws1dbkgTItTZ0Z2lMUb/Ww==
X-Received: by 2002:a63:6805:: with SMTP id d5mr19863305pgc.273.1618983212580; 
 Tue, 20 Apr 2021 22:33:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8f2:ea71:f6eb:321b?
 ([2601:647:4802:9070:8f2:ea71:f6eb:321b])
 by smtp.gmail.com with ESMTPSA id q3sm627869pfh.43.2021.04.20.22.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Apr 2021 22:33:32 -0700 (PDT)
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
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
Date: Tue, 20 Apr 2021 22:33:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_223334_030928_C8E644FD 
X-CRM114-Status: GOOD (  20.68  )
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

Hey Keith, sorry for the late response, been a bit under water
lately...

> Sorry, this was a mistake in the reporting. The last one's data length
> was only 808; 832 was the packet length.
> 
>> Can you share for each of the c2hdata PDUs what is:
>> - hlen
> 
> 24 for all of them
> 
>> - plen
> 
> 11 transfers at 1440, 832 for the last one
> 
>> - data_length
> 
> 11 transfers at 1416, 808 for the last one
> 
>> - data_offset
> 
> 0, 1416, 2832, 4248, 5564, 7080, 8496, 9912, 11328, 12744, 14160, 15567
> 

Can you retry with the following applied on top of what I sent you?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c60c1dcfb587..ff39d37e9793 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -63,6 +63,7 @@ struct nvme_tcp_request {
         /* send state */
         size_t                  offset;
         size_t                  data_sent;
+       size_t                  data_recvd;
         enum nvme_tcp_send_state state;
         enum nvme_tcp_cmd_state cmd_state;
  };
@@ -769,6 +770,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue 
*queue, struct sk_buff *skb,
                 *len -= recv_len;
                 *offset += recv_len;
                 queue->data_remaining -= recv_len;
+               req->data_recvd += recv_len;
         }

         if (!queue->data_remaining) {
@@ -776,6 +778,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue 
*queue, struct sk_buff *skb,
                         nvme_tcp_ddgst_final(queue->rcv_hash, 
&queue->exp_ddgst);
                         queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
                 } else {
+                       BUG_ON(req->data_recvd != req->data_len);
                         req->cmd_state = NVME_TCP_CMD_DATA_DONE;
                         if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
                                 req->cmd_state = NVME_TCP_CMD_DONE;
--

There might be a hidden assumption here that may cause this if multiple
c2hdata pdus will come per request...

If that is the case, you can try the following (on top):
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ff39d37e9793..aabec8e6810a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -773,19 +773,20 @@ static int nvme_tcp_recv_data(struct 
nvme_tcp_queue *queue, struct sk_buff *skb,
                 req->data_recvd += recv_len;
         }

-       if (!queue->data_remaining) {
+       if (!queue->data_remaining)
+               nvme_tcp_init_recv_ctx(queue);
+
+       if (req->data_recvd == req->data_len) {
                 if (queue->data_digest) {
                         nvme_tcp_ddgst_final(queue->rcv_hash, 
&queue->exp_ddgst);
                         queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
                 } else {
-                       BUG_ON(req->data_recvd != req->data_len);
                         req->cmd_state = NVME_TCP_CMD_DATA_DONE;
                         if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
                                 req->cmd_state = NVME_TCP_CMD_DONE;
                                 nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
                                 queue->nr_cqe++;
                         }
-                       nvme_tcp_init_recv_ctx(queue);
                 }
         }
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
