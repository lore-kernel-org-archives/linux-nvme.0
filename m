Return-Path: <SRS0=K5Lp=F4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D60DC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Dec 2020 17:56:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA13224B8
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Dec 2020 17:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA13224B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AfWOmUEDsOyVTW9ANUP8HHuoaKk6+PlaNIcn6oDbjpU=; b=LxnOPQeAFE5eMzTZZIf+da2Nd
	I0PnyAPlYDt0y9mNFUkeZAUsl5xMnNjfI84ZPA1KVtshs5eXxnzRW29vZUWvB2Cl4j8pTTL5018YJ
	3UArcN+HIYdR69TJKTkU316f2CcXKT0sSsLkZCNmuFmESh1JmET3fzuM1I6usCrUxHoQLK+SuA0n/
	cPEZme+dhBNEDTCHcCodkHqOKYnid2EY+ZGlP7d+nC/1qXZKGCWDcJBz9whKYx/9oWspii4FgliWP
	KTdODQwX2qbIaCqD/ysx6gxgz3UQALzTQ0uEv3ySgDsLOeAZNaAYZO3hA0ACIMoHPDYYJQN+UCCmL
	E/wdqa8bQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ksUqn-0005ag-Ke; Thu, 24 Dec 2020 17:56:33 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ksUqb-0005a3-VK
 for Linux-nvme@lists.infradead.org; Thu, 24 Dec 2020 17:56:23 +0000
Received: by mail-pl1-f181.google.com with SMTP id y8so1558643plp.8
 for <Linux-nvme@lists.infradead.org>; Thu, 24 Dec 2020 09:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S5btIY/ps/cjstmFe9Lgv11NMQ78zHWlSYoiUSyZHRY=;
 b=XLk+036/XEp6jtKvybH7sDqXt90408XMA7m6cQ/1lK5Hfr6YoI2z4zkLux1jLXu2ha
 xuoDLISc8uWMta6YjKyEO1oEThe7FBy7gxcmj8pe3TviISK652gKDs4KPYNrFdXXmJ8j
 x8Q1p5rOsmA/cyIdZHP1ZLLRmRRA1/ry1rk1ifpsz4Ua4LiOf3vGhl6wyMgddmkCQ5vQ
 sCy9ZHmdXn4LXCRo2sbtvlzlOZRF8Z1fUKJ9tbxSAqZzfqRlELVisZonCMaUI0Pt3v6z
 lto2gfx27XuRHbc0qxtR8iMXFyLQxe+xvLonadYt8mB0aZqDLsE6CyhF5PvRiLt/+55O
 u1yg==
X-Gm-Message-State: AOAM5317cbMBvb/FC434raeuMlEVc0sWE4Q4U1K+o5GXxXPnfJqD2qh3
 JoCt5S8uiLwMW73IoKGWuoItAFmvweI=
X-Google-Smtp-Source: ABdhPJyX9IS9dywYDLQqRAJqSGx/coMMytq/DFKyhpaoktm6ikd9RwwN6QQhogC2Q6Md4zT7VTegiQ==
X-Received: by 2002:a17:90a:d494:: with SMTP id
 s20mr5455024pju.178.1608832580298; 
 Thu, 24 Dec 2020 09:56:20 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:1c23:8bf3:f7bf:ad28?
 ([2601:647:4802:9070:1c23:8bf3:f7bf:ad28])
 by smtp.gmail.com with ESMTPSA id l197sm27570420pfd.97.2020.12.24.09.56.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Dec 2020 09:56:19 -0800 (PST)
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Hao Wang <pkuwangh@gmail.com>
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
 <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
 <20201223084332.GA30502@infradead.org>
 <CAJS6EdijX6ws_wHxygdpcYGtB6JFwLDbDE3A0t0QUYS-LbRakg@mail.gmail.com>
 <16d876c1-524a-38d3-3cff-99ec694464b2@grimberg.me>
 <CAJS6EdivEF0c=3FmKj4wGZoVRKbUvjH_qJLXmO7Tvwsp+km0rw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f631893c-5ce9-95fd-c32c-35a7e70d093c@grimberg.me>
Date: Thu, 24 Dec 2020 09:56:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJS6EdivEF0c=3FmKj4wGZoVRKbUvjH_qJLXmO7Tvwsp+km0rw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201224_125622_027401_F12E2761 
X-CRM114-Status: GOOD (  15.46  )
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
Cc: Christoph Hellwig <hch@infradead.org>, Linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Sagi, thanks a lot for helping look into this.
> 
>> Question, if you build the raid0 in the target and expose that over nvmet-tcp (with a single namespace), does the issue happen?
> No, it works fine in that case.
> Actually with this setup, initially the latency was pretty bad, and it
> seems enabling CONFIG_NVME_MULTIPATH improved it significantly.
> I'm not exactly sure though as I've changed too many things and didn't
> specifically test for this setup.
> Could you help confirm that?
> 
> And after applying your patch,
>   - With the problematic setup, i.e. creating a 2-device raid0, I did
> see numerous numerous prints popping up in dmesg; a few lines are
> pasted below:
>   - With the good setup, i.e. only using 1 device, this line also pops
> up, but a lot less frequent.

Hao, question, what is the io-scheduler in-use for the nvme-tcp devices?

Can you try to reproduce this issue when disabling merges on the
nvme-tcp devices?

echo 2 > /sys/block/nvmeXnY/queue/nomerges

I want to see if this is an issue with merged bios.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
