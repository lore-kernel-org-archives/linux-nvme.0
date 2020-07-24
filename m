Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4219EC433EA
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:02:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103A720737
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vg93BONf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103A720737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JedIlV68A+7+eZ7lh09hSt0dVGHOF50sg1ILr967GYw=; b=vg93BONfryawgQto0seC/w14w
	I7debnfO+PO3qlEQgiPJ1h7c54TLfLr8wd9MCiqcsbv7L4j32mOi5cZQGbTzUIsHEo9vWpO3xO3j3
	iE6/wT+ox90RNHp2QhhAk465PpcdweehkAkYfEqgGJLS9k7XxbsaaJ01YME5Nt57aQdw5M+95iJoc
	bfQSymO4VpQp42DGX15qzu8pRhuKYEQ1tifJMZDdOyynZMywhPVLaWRNI2/fc+LWy/ZQ2G3dF5ztL
	lq+kLZK1Nc+OQ5WY6KDER+xwOJ1SACOCorYMJlQ/J1NGYIXXUn9C8ES1VczJPMPgWWB6QblXIqogg
	VYkRFGbvQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz6hR-0002PT-90; Fri, 24 Jul 2020 23:01:57 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz6hO-0002P5-3J
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 23:01:55 +0000
Received: by mail-pl1-f195.google.com with SMTP id 72so5389011ple.0
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 16:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tTsNxlz/epdF0i1fyGoYgpiqwrnfZjaqlSGxyIMi/8c=;
 b=s1kBrtpZhs3hOBZxoTTcSlHEv4k1LSf674M7ao6ob6PrArI4ljevkK1/m4dHXNAIde
 aM/3jk0p5OYyWIgnAhwyUq0EMgSW9gbU0fcAhlF8tEBSvlUtsG9c6xvMR7BNyQWSFcjv
 /jTem+fCadHlTyotkcHZAfgQlUXfrLIV9ikkjqnzfL1CIPO+WzJrKMZX9LS+XjIIgbd/
 nXCpmwcLziUDecHogiv8b0bH2cvnvWnJjMDQE9nD9qn1gdb4h2tqN1CRuSqtLSnJTota
 jk0bxHkHDjYeNft7VxsKmb1CBTKOlUEFKU4vVXUnjIaCGIscnsPKzN+gV6qssbhdgHM6
 ECYQ==
X-Gm-Message-State: AOAM532QEj5kF9qcGF5a6luPyzaIAk1iLBzWpItzH1xUZlQpVHERDIaG
 Qd/y3bUsto4LS5+T4WUknYg=
X-Google-Smtp-Source: ABdhPJyxCunKNQo9FnMndynFzuPraPzQDw9WFiwlPysTRTenqF8WIBs8Wcm2lcdC7RYA4X/zvmM5mA==
X-Received: by 2002:a17:902:b7c3:: with SMTP id v3mr624731plz.26.1595631712854; 
 Fri, 24 Jul 2020 16:01:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:ac47:9fc4:b59:66fa?
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id u13sm6531575pjy.40.2020.07.24.16.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 16:01:51 -0700 (PDT)
Subject: Re: [PATCH rfc 2/4] nvme: improve quiesce for blocking queues
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
References: <20200724215452.26401-1-sagi@grimberg.me>
 <20200724215452.26401-3-sagi@grimberg.me>
Message-ID: <d2f49961-69e4-b180-df5f-3247cae8ab17@grimberg.me>
Date: Fri, 24 Jul 2020 16:01:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724215452.26401-3-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_190154_188793_FE1D0F5E 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Chao Leng <lengchao@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7953362e7bb5..9534626379e7 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1887,6 +1887,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>   {
>   	if (ctrl->queue_count <= 1)
>   		return;
> +	nvme_start_freeze(ctrl);

Woops... wrong patch...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
