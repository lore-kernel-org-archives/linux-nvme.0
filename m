Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB2EC433E6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 21:57:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7052313E
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 21:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7052313E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AXV50dVaki2BNhmkskMPEc2SUPGkLlbLA1LW8umJ2eY=; b=G7GSTvcESXpn1gH9HMwlw4IeI
	Gc7jWN75pr597bT9htf2ozRUwbNKl3kPVm4Oxfb5f2BN9W7Ev+N+KOxKGjFv+Rf/99rlcaHnUoaqY
	L+9gx8sUvURvLye6WG8q17KQDXgd8npN7831Olz/hvt+rEjK2jyTcMJK1+sF7uGEB5ZcCAt7uQeWP
	i+qbZ441B6IcXKFO7yz+evzsgvk++zmzWMfiA5/0Z3jqihJMdukeWHLGEe0mGjQAe2Sg/xOK+0ZAG
	NbKjbdNcyj1q6cYkpc1VybEREx11Oatjzc+gK1Nl+tHRmu1F0S89I7Ke4b1MsTQmGbNVLGhvURAh4
	Aga2v/gTA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzo8F-0005G3-Oe; Wed, 13 Jan 2021 21:56:47 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzo8C-0005FX-9d
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 21:56:45 +0000
Received: by mail-wr1-f41.google.com with SMTP id v15so43193wrx.4
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 13:56:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0JfOkLAWZ4C5HPxx+sVKP+QqfNrkjNYLpW/pO/NooDQ=;
 b=fsWXjY+YfRKvlNPx4SfGBoX1G7JKGop66g/0ndOt8/hm3RNyh9KqtgzyGLCjayKoG3
 gJ1v40Kh+NxwRyZQGNkNmYO0hU1xyEoVYtz+1UJgI2m0RBWLLTvN+oVfRKMaaTrmmPbK
 6UoDIBX1kO11rIZq8ZVE9WNNMjP86j2nkoFS8RQJiVtrvpTiZyL/SZ+LVbMoOrzOnZzQ
 7JDVWD+MNsRWJaw70c9JXW6TSiFsGjji7NG+QN3OizvmMR0vu6WdzqqgWpBILyOKqB+P
 80yIde1cSpriFJ/HoRUF6G1FIXXMwLVvkvITNZatIIORZ/jGNXyR0kprAIIPp4dvzffl
 oLvg==
X-Gm-Message-State: AOAM530yzgM+UB+QX/Gloog75KmNF5BH4ZKWtKYbuSPKj/YakM1K46Q5
 yjKJriVWOBf0Y0uDWHGJ4V/Hf0TIaWc=
X-Google-Smtp-Source: ABdhPJwNS/8OaJzX4pA/Ufne8qYKRxO/JUJMEeI0fBTHqWdEx/9D3mqD4X91oyN7ByyXOIWI/4sSOw==
X-Received: by 2002:adf:df03:: with SMTP id y3mr4639555wrl.102.1610575001755; 
 Wed, 13 Jan 2021 13:56:41 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id n9sm5377165wrq.41.2021.01.13.13.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 13:56:41 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: fix possible data corruption with bio merges
To: Christoph Hellwig <hch@lst.de>
References: <20210113182449.1580181-1-sagi@grimberg.me>
 <20210113183142.GA19254@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4aca0d8b-f873-1b78-9468-57e5864d9441@grimberg.me>
Date: Wed, 13 Jan 2021 13:56:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113183142.GA19254@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_165644_424575_AE28CB0F 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>   static inline size_t nvme_tcp_req_cur_length(struct nvme_tcp_request *req)
>>   {
>> -	return min_t(size_t, req->iter.bvec->bv_len - req->iter.iov_offset,
>> -			req->pdu_len - req->pdu_sent);
>> +	return min_t(size_t, req->iter.count,
>> +			min_t(size_t, req->iter.bvec->bv_len - req->iter.iov_offset,
>> +				req->pdu_len - req->pdu_sent));
> 
> We are not supposed to directly poke into an iov_iter.
> 
> I suspect this should be something like:
> 
> 	return min_t(size_t, iov_iter_single_seg_count(&req->iter),
> 		     req->pdu_len - req->pdu_sent);

You are absolutely right, will send out a v2. thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
