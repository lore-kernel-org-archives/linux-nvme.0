Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1EBC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 04:19:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A9520707
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 04:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A9520707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0kJ0fgxmnRPdgvZquT0sV3rIkwn/q2SJsCwDgczHD4M=; b=g6RqRYRihAbdi8MY3XHLVKmo1
	bA8hVMVcdde/x7iSIsd19uWfXDBJToP1lV9QYYkAcEe44+rUwfOUKvfnPTmVrbQrX7W0NpELoxxwT
	yArvOzf2cT3A8r1cwVvwZjVEtEd2azRs3GaFLLQ4kltBSjdxssd+9520/Gl8G7VJ0rotk+A3saA0f
	5ppw2A1HCyRcTC9PIKn9b0TvtQptSgv3v7BMc6ejFFoVh/HKyr9+qeQKpJWvwLSMp0+WUVYICaeZd
	6Ko1dbYxRl1vjxtcab14d+4uDna4QQnJvOoNf8NL7MyXuQL2ZZTxbU+JyVMqYa+4X/7X4nvd75As8
	2fVy0WmVg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1iTj-0003SI-On; Tue, 19 Jan 2021 04:18:51 +0000
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1iTh-0003Rj-0T
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 04:18:50 +0000
Received: by mail-ot1-x32c.google.com with SMTP id w3so18526347otp.13
 for <linux-nvme@lists.infradead.org>; Mon, 18 Jan 2021 20:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PGQWnRykzJUb1S9lKNedKSEMsPVcpfZ4OcuUTj/9aeM=;
 b=jP8BzF3xDMu98sFpJMShdpW0yMy492LbJFp9GgFB4p6qmu05mg6wXNTqe0as8tKID3
 3UCIfRJDpxP16GSu2ZbGgFb8cuR384r8AtUvpUEtgrw7CfRPg40P1xPFudQ1MzNcQ89j
 kKlXJ4aq+6rCXtKqG13+9+j1tn/Y+zZb68EHOJaVVUPRr5sk2UrU+aJmKVWMIE/0Vmxh
 de6R6nIrGMmm39nu+xLtYPPpz7Axydq9DuadhgwbHckUKMjfZy72vAts6vDAv+llpAx2
 kCtHbpy5Sj/nIf1Py2JH+WsazdaztC0eQTInDpfyL3COgusRoYfnGkIjhoQS3RwkYpHm
 1Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PGQWnRykzJUb1S9lKNedKSEMsPVcpfZ4OcuUTj/9aeM=;
 b=CcVM0mkccfL2/nQxad25thyIxtpqa5WzcAWo+Dx93b6XY5UwaJQY1biI9v7DAMGyNk
 Tk6FkkU2UlpEoDyqdSPU7X4EiGq0O7lRX56+T2bUMS/fiJtTamCJOwx026yN+TCYWOY7
 evDJwKwEtKM9ICpqIWY7tgRgCLp9UM9UtKpbIo6xLQh/Rcb4QdH7jk8nVRbh7dQMaxiY
 9BycfMImpXMZvW4C5jhyE5VXthLWIi63A4dEq3cQ78gxstrK0Usn0N5fZrgzsACA+oXb
 lPDqSdK4q+VefFBSZu95/z/VUeiNtF1WNwbeH29hDIeqyaEpZPmqbI7WB8yqxTgTh+Rd
 yPlA==
X-Gm-Message-State: AOAM531repkEau3VMZdtGmFVW+ioj5haFQBe6V2POe/KAmv7jbkEYO61
 tr926UegtOVHmlFNm4OY99w=
X-Google-Smtp-Source: ABdhPJxdWVSAgii/2MkPvERcKolGR6i+7ta0jZQ7GpHk/SqwbsPfyB7CKBksX1tJHuK0ErHfmPxpNA==
X-Received: by 2002:a9d:4e87:: with SMTP id v7mr2070437otk.302.1611029926930; 
 Mon, 18 Jan 2021 20:18:46 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.6.112.196])
 by smtp.googlemail.com with ESMTPSA id y84sm3786465oig.36.2021.01.18.20.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Jan 2021 20:18:46 -0800 (PST)
Subject: Re: [PATCH v2 net-next 07/21] nvme-tcp: Add DDP data-path
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com, smalin@marvell.com
References: <20210114151033.13020-1-borisp@mellanox.com>
 <20210114151033.13020-8-borisp@mellanox.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <84cc2af1-22e8-abf5-07da-bc7b4a2b6b12@gmail.com>
Date: Mon, 18 Jan 2021 21:18:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210114151033.13020-8-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_231849_357638_AE757623 
X-CRM114-Status: GOOD (  18.79  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 benishay@nvidia.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/14/21 8:10 AM, Boris Pismenny wrote:
> @@ -664,8 +753,15 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>  		return -EINVAL;
>  	}
>  
> -	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> -		nvme_complete_rq(rq);
> +	req = blk_mq_rq_to_pdu(rq);
> +	if (req->offloaded) {
> +		req->status = cqe->status;
> +		req->result = cqe->result;
> +		nvme_tcp_teardown_ddp(queue, cqe->command_id, rq);
> +	} else {
> +		if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> +			nvme_complete_rq(rq);
> +	}
>  	queue->nr_cqe++;
>  
>  	return 0;
> @@ -859,9 +955,18 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>  static inline void nvme_tcp_end_request(struct request *rq, u16 status)
>  {
>  	union nvme_result res = {};
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_tcp_queue *queue = req->queue;
> +	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>  
> -	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> -		nvme_complete_rq(rq);
> +	if (req->offloaded) {
> +		req->status = cpu_to_le16(status << 1);
> +		req->result = res;
> +		nvme_tcp_teardown_ddp(queue, pdu->command_id, rq);
> +	} else {
> +		if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> +			nvme_complete_rq(rq);
> +	}
>  }
>  
>  static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,


The req->offload checks assume the offload is to the expected
offload_netdev, but you do not verify the data arrived as expected. You
might get lucky if both netdev's belong to the same PCI device (assuming
the h/w handles it a certain way), but it will not if the netdev's
belong to different devices.

Consider a system with 2 network cards -- even if it is 2 mlx5 based
devices. One setup can have the system using a bond with 1 port from
each PCI device. The tx path picks a leg based on the hash of the ntuple
and that (with Tariq's bond patches) becomes the expected offload
device. A similar example holds for a pure routing setup with ECMP. For
both there is full redundancy in the network - separate NIC cards
connected to separate TORs to have independent network paths.

A packet arrives on the *other* netdevice - you have *no* control over
the Rx path. Your current checks will think the packet arrived with DDP
but it did not.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
