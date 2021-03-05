Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E38EC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:42:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD6B650A8
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD6B650A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fuKWl+xlduMlV4uwIjkLqsvp5PBJKG/E44vKbHkzgbU=; b=HgS7sHTm5LXsxiEt9jitu4aq0
	08LTlswNF81W1k1H8OLgtQcXN1BfXPs88m4EyzckblEHO7FntTTnt8YgUOSciB36KkADK2SiequUV
	ijQruNItdNTXyGiFY/Ko8QBwC6ydwIGX6uqIhzmd8uHOZn48Aq5KgxCpx8IoVpxizrBc2sPlt0/hc
	38FJBwfoHTMLnY5iX985G7J+lZau6GNUontHC8Ix9+LqjZqW394NEYxwcGj0TOno7FFSN+Ewg/MH1
	wPJ2Yi8ZQjZhAAX7Cm3FtcefQtzjWfgwDqrasuX4d4UN4qdyy+8Xe+UIKjBAo0D3ibGuJ1BeWneZs
	Q8gS8xOFg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIJ90-00GtVj-3g; Fri, 05 Mar 2021 22:42:02 +0000
Received: from mail-ot1-f43.google.com ([209.85.210.43])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIJ8q-00GtSB-7B
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 22:41:56 +0000
Received: by mail-ot1-f43.google.com with SMTP id j8so3395554otc.0
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 14:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fcsBLQuteK4hdvzv9Ewj2uRw1vyW861w7yl0wLC7pmQ=;
 b=PELeYRFCFwE4DtT4vJ0qiw69PkDivCnXGUyA5m02w2V63t0M7PnZd07+Yh2qer+nVD
 bpj27l+U0qLkFf2vls6pRFbnLb9FJT31PmSbkVC4FVmum+gOk3QksmAIDyUJewCX4jsH
 h8sgZLfqcop6f7snMOpNkAbwhyv90lG2mOkkSzOviASj/0G1Lrslntzo05vxsjmZthHq
 a117DzzrKZz6JL/LuzJqTD3eJQ1Tz4naRQ8S8XRjc7uA/n15Js1QRqwgJQACcOLWD3g5
 FvnbPxHu/kvBijxSQCf7y7gDfDVynTZ9IpCKlBDoEMwLyHV5QL8Wbu5iBHLfdeSqf34W
 gKDQ==
X-Gm-Message-State: AOAM532KdHp855z6kIFDbHGOvymQ5B53G169/pCkoD9WxB5OLGyl0rEq
 hU1HjnDHx2ikit9iPMcXK6o=
X-Google-Smtp-Source: ABdhPJzIdsOZ3Tt9yLPrB5c+ttS4rLMhsIGMe6bDImjb4S6jTWQl445rJGTH1DMOlsdmpa9YdJ5tSg==
X-Received: by 2002:a05:6830:232f:: with SMTP id
 q15mr10136248otg.165.1614984111170; 
 Fri, 05 Mar 2021 14:41:51 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id 3sm873101otn.18.2021.03.05.14.41.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 14:41:50 -0800 (PST)
Subject: Re: [PATCH V2 5/6] nvmet: remove unnecessary function parameters
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
 <20210225015642.29288-6-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5cb61638-f308-6e6f-dd27-125c870497a6@grimberg.me>
Date: Fri, 5 Mar 2021 14:41:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225015642.29288-6-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_224153_667905_035D4665 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
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


> The function nvmet_alloc_ctrl() accepts subsysnqn, hostnqn, cntlid,
> nvmet_req, and out pointer to nvmet_ctrl structure. The parameters
> subsysnqn, hostnqn and cntlid can be derived from the caller's
> struct nvmf_connect_data.
> 
> Replace these parameters with structure pointer nvmf_connect_data *d.

Again, not a fan of this. But if others think its fine then go ahead...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
