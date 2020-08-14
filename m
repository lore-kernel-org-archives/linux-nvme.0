Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C87C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 18:00:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3732078D
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 18:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P8GRBKOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3732078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0cxAqI2tUphmL0ZLyRjWGIBB+wx5XpbiVuvSkc0vql0=; b=P8GRBKOjplQ1pU+ZUSAErtiyq
	NHOsSFuXccHDp0FmF7PY0VIJRDAB/GdG1zN3TbUncGp5gd5IQi/2Pav5vk1BjTQnEO3B5bfQ58pqL
	SxYLK+dSzch5BvA8m1KYV+/yWmVlwhrRwsYc4fTDZ8Lj5Jh0+vY5cmHAOND/YZ5RCpKkCfmXwMQjD
	U48Xh99hbXBVUgjHGN0+azvkhRgYgXMleWy7Q7eDPODoN3MqChvqDTmgYcosggHhEpwe0hDZnAtlK
	N19qCI1BTF6ZNljnJ6oUbWj1Ss+iGR7e6/sb7DgvSXuftUnx0HCmqCgeOHXaKg6tq+t/BIKX73tI6
	ZOh1gUE9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6dzx-0004Iu-Mu; Fri, 14 Aug 2020 18:00:13 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6dzv-0004IP-Pg
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 18:00:12 +0000
Received: by mail-pf1-f196.google.com with SMTP id a79so4907263pfa.8
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 11:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b1l6WJIr43PpfFuXs56xVTu2jiFSLMBw3oL0hztXcos=;
 b=GRSo+mxC/v6Ik19fGL+13p1UoxKOUQPGW60YQYdI6IAWLzsXVx2V3dZnL6wZtTD7Q0
 zQzmqj6rhmWfVsOFUrXBDgTU4D8M3ImcZGhRrCKDrZ/VVg5/wRgEYMiQXVsuP4iMw1SY
 sGKjAkMyt9gb1nzo3Lkcq+nCGwKSMGc3h/sVgBP784w4etp9wbRjZKeyPsO6FRRSUrVW
 MHiAAUJwvMaY596MVj9TSdbW0S6YC6qj5uU6c+14IJShQlQzFr6nQbRoX14bHvPFFSG6
 0obNL0yrQ/W8qhQXuPSwz17BAIsazjLdhFq2A2rk47Magh4MCJqyWiKnm/qjoJcNLaUE
 3okw==
X-Gm-Message-State: AOAM532Pco9LOgkKUX02cU7wFH4ywnTp3KYa1fCl0/V+BBgXENIw0Z1m
 4iyYiQsB16aH4hHVidSEoPzBMBwA+ZIo0Q==
X-Google-Smtp-Source: ABdhPJyF3ztckgCcdugn+Ud0cF+bfv1vKWCsXc7NhxQ8d6m3EUTgVQchX0lrfO+uwb2WyTIiWwHV5w==
X-Received: by 2002:a05:6a00:1509:: with SMTP id
 q9mr2652041pfu.24.1597428010590; 
 Fri, 14 Aug 2020 11:00:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id x6sm10054474pfd.53.2020.08.14.11.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 11:00:09 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
To: Keith Busch <kbusch@kernel.org>, Tong Zhang <ztong0001@gmail.com>
References: <20200814071431.201400-1-ztong0001@gmail.com>
 <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com>
 <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <02d965f9-d465-6e6f-b113-5f6f7e327afb@grimberg.me>
Date: Fri, 14 Aug 2020 11:00:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_140011_868354_1261FBAE 
X-CRM114-Status: GOOD (  17.43  )
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
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>>> index ba725ae47305..c4f1ce0ee1e3 100644
>>>> --- a/drivers/nvme/host/pci.c
>>>> +++ b/drivers/nvme/host/pci.c
>>>> @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>>>>                dev_warn_ratelimited(dev->ctrl.device,
>>>>                         "I/O %d QID %d timeout, disable controller\n",
>>>>                         req->tag, nvmeq->qid);
>>>> -             nvme_dev_disable(dev, true);
>>>>                nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>>>> +             nvme_dev_disable(dev, true);
>>>>                return BLK_EH_DONE;
>>>
>>> Shouldn't this flag have been set in nvme_cancel_request()?
>>
>> nvme_cancel_request() is not setting this flag to cancelled and this is causing
> 
> Right, I see that it doesn't, but I'm saying that it should. We used to
> do something like that, and I'm struggling to recall why we're not
> anymore.

I also don't recall why, but I know that we rely on the status
propagating back from submit_sync_cmd which won't happen because
it converts the status into -ENODEV.

> The driver is not reporting   non-response back for all
> cancelled requests, and that is probably not what we should be doing.

I'd think that we should modify our callers to handle nvme status
codes as well rather than rely on nvme_submit_sync_cmd to return a
negative codes under some conditions.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
