Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8A5C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 14:31:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6FD23A5B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 14:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6FD23A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kIK9x20aEVrceFiQ0x+NZqK5nfYyhtN+jGFuXAd96XY=; b=i4ZH3g+cw/BEaxV9g5ZoVQy6e
	vFoCSfNbMgPh30E9UlCAFVotIMRJal+7b5TAKi1e8yNmdoU9HSTcgpINhFyrkrMW52RjEjc/ebbso
	SFwtIP05s4zb0mhbAmZf5ky+Cfh+bJQ83rhTV1Mm5K7gkii1B1zu8YzXuvFuZ8DRUedVLRcLX+qS1
	eXSJq972wj3hzPZZrsBJbq8Q0Y+LJ6cItPdlBk847qBADU1PeOPuMcP4Xg1+yBSe1KAk/T4d1luwo
	EPb/FoBNovwYXA02f9TOVjY/bJIJm5/c2mid+cq6S14tTZATUkMz585gb727bGl+sA64CEObs9V8Y
	QVz4zzlWg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kme1B-00005g-VR; Tue, 08 Dec 2020 14:31:06 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kme19-0008WM-BB
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 14:31:04 +0000
Received: by mail-ej1-x643.google.com with SMTP id b9so14551428ejy.0
 for <linux-nvme@lists.infradead.org>; Tue, 08 Dec 2020 06:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=oW/0Def7+syZBHy2KEEtk4RcVTNw5OOV1PYvwMkOqxA=;
 b=QkQK4aZ97qoLladTirg8VOwoThhsx/hiD0TJqyhfoxqq2jmowi5gq2CUC0phSfFzwi
 jJ89ILZ1nddu9jOmP0AWFa792RcOOoXNUTZKtes7Q7JGnivMsG1f2VBWsh4UP7xes986
 HdJEcNJuEkwbAys/DryjdvYOTSCodnk0ngUD/w8ZppQtZeUd3KweNJM57/64VM2AedEO
 EZeF7esrzpxnjrpB89gtpUAJzGSr7DKIKve6RuG+S9/kc11mnL2tgm18SEEP78E9rYmP
 i82jFL1a5/jD7HSTWfvSZR27cdBICQuCpiPxqFS0atjr2Sz+McmTtopEPzPjOXHGs0YP
 UC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=oW/0Def7+syZBHy2KEEtk4RcVTNw5OOV1PYvwMkOqxA=;
 b=M2FaKYSknEjoFK/Pw6djMEZ1mhPtloVrx4/KlEPsv4gxJsaHO0gfzqpLZC1jCVRXlJ
 LlMxU3vxlG0kcPoQxkfQxTPoDMsH7iScllMd1LIHzxhU8te+N4LunkaklSXoJcG+QedH
 b2YJMqbDumqlEGcwBHMFV21D4QQnypnTvakWtXinZ2OFySmNw3ZhM36q9ypoRV0MAVYP
 v1kxo8Dv4vavoyMidK1ZJN3aiZvcqJ0HPjsz6Qi+3ZIEjXUkjUbZ9GZVj6opA9w4iNDd
 mYcgnfWnPM9mgIc10GnKg1vjQxoHWVVQLMzWu7TpbQLpKWQH83+tqVdSnyB+U9ncEDXo
 j1Xw==
X-Gm-Message-State: AOAM530uAlfgrjZhUr/tQLuxa7ALcAERzS4LEjKWFbfeCENTG3dNK0JN
 bwLWCJR7v2HPdFPSliUhB2I=
X-Google-Smtp-Source: ABdhPJy/7c06e+YRuNmU/KgnwjADm+SYBPre9cKBVuDYInQdk4C3RUeUEmhTvIcEMDRL3YVPh3sTHw==
X-Received: by 2002:a17:906:17d0:: with SMTP id
 u16mr23099000eje.452.1607437861169; 
 Tue, 08 Dec 2020 06:31:01 -0800 (PST)
Received: from [132.68.43.153] ([132.68.43.153])
 by smtp.gmail.com with ESMTPSA id d18sm8707633edz.14.2020.12.08.06.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Dec 2020 06:31:00 -0800 (PST)
Subject: Re: [PATCH v1 net-next 01/15] iov_iter: Skip copy in memcpy_to_page
 if src==dst
To: David Ahern <dsahern@gmail.com>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-2-borisp@mellanox.com>
 <f399b37d-872b-c832-be43-c7930b487a16@gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <eb974de5-01c7-a4e1-b08d-d2e64bfed4a8@gmail.com>
Date: Tue, 8 Dec 2020 16:30:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <f399b37d-872b-c832-be43-c7930b487a16@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_093103_419025_0EADA03B 
X-CRM114-Status: GOOD (  16.57  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com, borisp@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 benishay@nvidia.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 08/12/2020 2:39, David Ahern wrote:
> On 12/7/20 2:06 PM, Boris Pismenny wrote:
>> When using direct data placement the NIC writes some of the payload
>> directly to the destination buffer, and constructs the SKB such that it
>> points to this data. As a result, the skb_copy datagram_iter call will
>> attempt to copy data when it is not necessary.
>>
>> This patch adds a check to avoid this copy, and a static_key to enabled
>> it when TCP direct data placement is possible.
>>
> Why not mark the skb as ZEROCOPY -- an Rx version of the existing
> SKBTX_DEV_ZEROCOPY and skb_shared_info->tx_flags? Use that as a generic
> way of indicating to the stack what is happening.
>
>

[Re-sending as the previous one didn't hit the mailing list]

Interesting idea. But, unlike SKBTX_DEV_ZEROCOPY this SKB can be inspected/modified by the stack without the need to copy things out. Additionally, the SKB may contain both data that is already placed in its final destination buffer (PDU data) and data that isn't (PDU header); it doesn't matter. Therefore, labeling the entire SKB as zerocopy doesn't convey the desired information. Moreover, skipping copies in the stack to receive zerocopy SKBs will require more invasive changes.

Our goal in this approach was to provide the smallest change that enables the desired functionality while preserving the performance of existing flows that do not care for it. An alternative approach, that doesn't affect existing flows at all, which we considered was to make a special version of memcpy_to_page to be used by DDP providers (nvme-tcp). This alternative will require creating corresponding special versions for users of this function such skb_copy_datagram_iter. Thit is more invasive, thus in this patchset we decided to avoid it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
