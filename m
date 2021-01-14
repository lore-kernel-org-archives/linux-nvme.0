Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F15C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 03:28:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C5A23741
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 03:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C5A23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8L1RmSLxmSYeWpE0LUhhNY80UcWUEAPKjbF4g5qwyzA=; b=oFAVnosqPDKVUHKRxusrqfogF
	yk0nO9PABZc1l0x9iJAoVZfWiOj3Vkh/+O4crz53cgejxjQEf2zyxyyLUmTuW8rDSeeX4GwJKQUwf
	zFBQOkkfamo0iAHJDrvqDEZpxsZdVQgYkjR8WXB0vWmC6h9/c54LxKtv2mB25dPpMWTilTSnEu0HE
	lP+exXTU8ntQTSWVWGadtJrs+Vv/vMhZ1F4jcmNiu2hvQa2qq53mUAKOyZv2O5qpkBjP7XQmyM0yh
	SsX+cokW7nQjE1lL/RMvUPQC5G+csfiRu1Y/q7tMxNEN+PGpJ8jTF5eD0yeHyFfzBwZ5Sl+rty0Gf
	/Y8aJ7g+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kztII-0005ag-1M; Thu, 14 Jan 2021 03:27:30 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kztIF-0005ZH-A9
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 03:27:28 +0000
Received: by mail-pj1-x102b.google.com with SMTP id p15so2251607pjv.3
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 19:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qR3zQuMNhmGASj9k9dQlnSK3nfQRgZ+E9UAKRPE5d3g=;
 b=DADSDL/oDCfblJ3TfUSFhIt22DAbJm6wwPoj8bM8GjyAKx8vNgnZ9lt8/hBk+E9nXS
 3NQu/nZPD7Od9GcukW8vXfg4DpJH/wIewIxZJHdSqjZOBYHlsuN6DzwMnn5SuOStZjtG
 hA+7mvLismtCHy/ueztvj328KTUhzrAbt7WQsZNhTIfO+1tq95149FY3rxUk/t4FnB2W
 VVTVj8CNvdwNWHwe0EyOoXAvQgU1PFfAPVJ24naTcbTNpgF7s+IDRM5zja9DttyEzUyD
 l3+Iw3J/UC0RZXyE/NZxSuAbGkFP1LmAdMH3hfodxQ+FPRUcbLhhMl2m1vss8zov5nAo
 lBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qR3zQuMNhmGASj9k9dQlnSK3nfQRgZ+E9UAKRPE5d3g=;
 b=eTWMc1xpYbB8vTYXt1ASBLTwAOFMPYGXQjbTN6+6vnhPpJF4EOH/+cVR5a8LDJUBl5
 HQqKu9tJRioqaLK55XgHXaLteP2MbVDWMO6j4stx6BcFsJM3kr0G2IgaO03oDVFrs6CV
 2etbt9stjFOE9EVVSfDiCmhV9ZA3/mNIfcGSlncj4fdVrVvN/xZkFVh1hw4ZR0H8Yw+3
 Ge/Ejb+iPP8LjNiwyw0d/n2CS8XQCvun2BmYIHqzG1XyqWr8GQMMxc/Re/hEltw7x2Js
 yfSV0w9+JCsk03gUGUD1HajXEv9nd+YsZQgG5mhmXnaRr8Mj+5ehLdW7PW7gNV0iilPX
 7d2A==
X-Gm-Message-State: AOAM5325ie0BJR12+0SpIQMVWmSQexFvJRoxtQW2k2agMm+zPDwd1/Q0
 1qsCLY2BWPg3CqbyEe4qSJw=
X-Google-Smtp-Source: ABdhPJy3NR7SDfzpfEZ9gygz8CVKuEDqHPO/lzwA33HDl+tK6SDk3UxR8AM0QCEnyXtJGXyv2TBWwA==
X-Received: by 2002:a17:90b:14c7:: with SMTP id
 jz7mr2763873pjb.40.1610594844788; 
 Wed, 13 Jan 2021 19:27:24 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id a22sm3827350pfg.49.2021.01.13.19.27.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Jan 2021 19:27:24 -0800 (PST)
Date: Thu, 14 Jan 2021 12:27:21 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH V2 2/2] nvme: retry commands based on ACRE result
Message-ID: <20210114032721.GA5817@localhost.localdomain>
References: <20210113143538.554-1-minwoo.im.dev@gmail.com>
 <20210113143538.554-3-minwoo.im.dev@gmail.com>
 <b122f482-cb73-67ff-1a30-053c1e8c9c18@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b122f482-cb73-67ff-1a30-053c1e8c9c18@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_222727_392263_8690319C 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

> If acre is true and nvme_req(req)->status is nvme path error and
> blk_noretry_request(req) is true, we need return complete for REQ_FAILFAST_XX.
> Otherwise, connection process may takes long time in abnormal scenarios.
> We can do like this:
> 
> +    if (nvme_req(req)->ctrl->acre &&
> +        !nvme_is_path_error(nvme_req(req)->status) &&
> +        !blk_queue_dying(req->q))
> +        return RETRY;
> +
> +    if (blk_noretry_request(req))
> +        return COMPLETE;

Ah.. You're right.. I really appreciate for your review!
I will prepare the next patches.

Thank you!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
