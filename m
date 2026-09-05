Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C1CC79F8B
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2026 22:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=On0DruBB9TG4XXAPIftyDOFccWr+haKnHMatYHL3TDQ=; b=cWGdjIiGb46g8tTdKL5rXHYqVT
	k6nZhj6n/s5FroobogSRaaefrJDlAlan+3sjEk8wkIYbUBQ8QrczBf4pid6eZmOSa2ej1cHFiNH1e
	AUAC4qJQbwtv/Us0u/F+ry1wx7AqLoSeXU79hQMVx0AGMazu9e+G5qfm/gnMYZqKn4W+LFhOERHtB
	SjRvn8SDlGtTfuJ53f/AuXAW3vsibDj3hlTra5oaKr/g0LRpT7/rufhfsPO9FPJEyTGBzFL5sRZHP
	Dn3X1N++s0tOUYp9/0jDR5VPe6wF/K3G6k3ZfVk9qNQo8M1G0TeTks/+TWSQXb5EXCsRd5vP1yUZL
	B3TcJA/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2ytl-00000004SCW-2oRr;
	Sat, 05 Sep 2026 22:30:09 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2ytk-00000004SBz-0XV0
	for linux-nvme@lists.infradead.org;
	Sat, 05 Sep 2026 22:30:09 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4957eefd361so16595705e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 05 Sep 2026 15:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788647406; x=1789252206;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=On0DruBB9TG4XXAPIftyDOFccWr+haKnHMatYHL3TDQ=;
        b=QRf9bY07U4j+BSuLNkojEpjUWLhgsqI7HTkycXtoC7/fNRS6UCwNrTR8yaI7MlnO1v
         3eeO9hxPr4UcYGOM15tlcLgEd6U6rePurKPF1aBa8Tg+g+0jh2PlNYyHkGl160yUYxV5
         cOjxMwYdVZ1dRxFzDX7J4IOXcsRF/vpej7R0SSOmBXo4Oo5l5yP+s5pIVO6Wm2fZay/j
         pfj97seZHtq/lYAR/YP3R0sfvI8ILNTlE5/3uB4huV9V2R7lYKn3/USfSuUFa7fJ7nRx
         sW9dpcAS73OKUnQnn9VcUbJ+t3VBzmvPFwuqibIjNqLWuam0ba1NQyPuIpIdbEQlkr9B
         s8aw==
X-Forwarded-Encrypted: i=1; AKwUvBz2nH7W85Qth2PB7FMOp7N6CZDPnRdEOFSst/hKK0/jfB++01cX/PZI5cmyx+EnSPeFBldoD1F+/I2X@lists.infradead.org
X-Gm-Message-State: AFuF++ndeGC5oYgWSsoQfO+rCd6x7PEjUsxnAV/35gS8Lwu500PpTTOq
	+B39ob+vjsoy2EQfLEBChW5MQCoJb2c03mko7fO0umcAaCtS32DKEYtu
X-Gm-Gg: AYBFou1ZlV5jeK/t3t3K10mK94rVuoyr4LgVlWl50TEbChZ1Qkug+/oj333XnLfopBW
	Mtv+rXgEDj+KVlG/uPQu7ZloxWvRUPmMlPV6sfExXuJSeZkk00+Cxdc4N7Jhl2buc3GWGKlC1ix
	qtLJs1iHNRdOv9iLqz3K/5r6Q5M/liesrNCkdWhlGrDbzZO1e4rouiEIMBbvYDk2iYN7H1k3os9
	iHuNSqIER6fbQI0vvxpLN8ndwuS9hQehmPOS1pPixR34974zPR20vPIm5nFv7CRt040IzByHENy
	UoGdkvOE9VEcPL3LKdD4DfiRZCnTryY4UMws7tkYuOwnqe66N/ZtCKGJdQAJFRYHN9bfo5KFq4p
	5q7MuNWwPbtODVTxlaARFENLnFLLBEWKJrJsMWuGWUZdSG+1GspHnyrwI8vPdf+HBw3LQpEmL2l
	U8r+Gg9e04jsfDgem6osf2qsKe47DumYTBr3tRBWvhlMF4Rfg9tBqoLuZTZHofa1gDL0cjpBUHv
	W656xTByjxQQk1ySzlHcYALAjXkWjYzxQ==
X-Received: by 2002:a05:600c:3546:b0:49c:fc6e:a3db with SMTP id 5b1f17b1804b1-49cfc6ea79emr102975815e9.26.1788647405945;
        Sat, 05 Sep 2026 15:30:05 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d00031c95sm123315445e9.11.2026.09.05.15.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 15:30:05 -0700 (PDT)
Message-ID: <39448561-8877-4e20-98e6-fd85acc3d569@grimberg.me>
Date: Sun, 6 Sep 2026 01:30:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 2/2] nvme-tcp: parallelize I/O queue allocation and
 startup
To: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, mkhalfella@purestorage.com,
 randyj@purestorage.com, adailey@purestorage.com
References: <20260824225648.316962-1-sgogte@purestorage.com>
 <20260824225648.316962-3-sgogte@purestorage.com>
 <c98fe50c-172a-4e53-a30c-5416c40cb23f@grimberg.me>
 <CAMof9cWdXR_040SDs2N=3ETvdmxvjx+OokfkSDr7DzVbLbuenQ@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAMof9cWdXR_040SDs2N=3ETvdmxvjx+OokfkSDr7DzVbLbuenQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_153008_169548_53D939D3 
X-CRM114-Status: GOOD (  15.41  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>>>                qid, queue->io_cpu);
>>> @@ -1846,7 +1856,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>>>                queue->cmnd_capsule_len = sizeof(struct nvme_command) +
>>>                                                NVME_TCP_ADMIN_CCSZ;
>>>
>>> -     ret = sock_create_kern(current->nsproxy->net_ns,
>>> +     ret = sock_create_kern(&init_net,
>> I don't think we can just change this...
> Passing init_net explicitly does change behavior on the synchronous connect
> path. However, with queue allocation now moved into an async worker,
> current->nsproxy->net_ns resolves to init_net in that context anyway, so
> the initial connect path already loses the caller's netns regardless of
> which argument is passed.
>
> If the goal is to actually preserve the caller's netns through the full
> ctrl lifecycle - initial connect, reconnect, and error recovery; it can
> be pinned at ctrl creation like:
>
>      nvme_tcp_alloc_ctrl():
>              to_tcp_ctrl(ctrl)->net = get_net(current->nsproxy->net_ns);
>
>      nvme_tcp_free_ctrl():
>              put_net(to_tcp_ctrl(ctrl)->net);
>
>      nvme_tcp_alloc_queue():
>              sock_create_kern(to_tcp_ctrl(ctrl)->net, ...);
>
> This captures the caller's netns while still in userspace context, then
> carries it through all async paths — so reconnect and error recovery
> also honor the original netns rather than falling back to the kworker's
> init_net.
>
> Is this approach preferred?

Yes I think so

