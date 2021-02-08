Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A35C433E6
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 14:58:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A6364E84
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 14:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A6364E84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e6IDJi6RWcEPCvDWBLb4iJwgn5RXI00a52riGFV1fqM=; b=TaYWBMZbRee36K7Uo6Jns5II+
	54cYYne/KiRp22dnoFZ2LcnYM9uLJ7LPDY325Ixafm0D+/b407naAAHMQpif+VlXF7Thyu7IIgzSH
	GSJqluocWwuEphksq3nFGYD9MD0+DgmKg/Ky7T6Zfk5sGE5q4bbUogkwcV7ElPfr00t2BUzZZb/sj
	8U3fRLH7/I6IABiR4CP0ltRBiAjj0JnsS/OKbstg2ub4ap7onBNXoBq8ixAKAHmDdtrjGxwbEChLf
	/FG+i18HS1veJhIf+9zW9K+C309JY1UUGFq8Sw7hLlZ8fJpPMfMC+zgWt63ChRHYZd2KXS5uW4DLh
	1/tVfJGEQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l97zA-0002Wq-S1; Mon, 08 Feb 2021 14:57:56 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l97z8-0002Vv-7R
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 14:57:55 +0000
Received: by mail-pj1-x1031.google.com with SMTP id q72so8405586pjq.2
 for <linux-nvme@lists.infradead.org>; Mon, 08 Feb 2021 06:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qsoXhuJoTcNLMh+ZMkJf0rr/sNgJJAVHxaaAmjKhz+k=;
 b=L2FoYZ8HRnhUnZJKZeFIK3ugB7mIqEu4GI/R3e94POtauNV016uR/2wXNodafME0DM
 hH7B3Fud9j21QdbKb0xCq1V0TxRl2bW+LagzEDF9o+O1wgWqjmNd+InMkRsoi2O+CIuB
 /waCS/ksCAHCnO+zNY7SfG0QCxN0MWj5DmKkHWRrD7yK8w3R7kBl/lD2BOhRaqgL13b5
 hmuXBcoNQ6jJI03HXXjL/N/EUIjnU+MJ14BivbrdY1qnQaBsWasDCCEDFlkuT2ol8VYL
 m7WXaoMzLeRZmNKaCgMcRVo7ZMj/CJaWz231AytenEGEbgDJGh5Dq9T4Z54IdhQu8OBc
 0Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qsoXhuJoTcNLMh+ZMkJf0rr/sNgJJAVHxaaAmjKhz+k=;
 b=WtlpbBlElFdV9c8+lvy4F4FTwu8RlTNhA49rZsy5VMpZXWXz+37bip3qSycfnWXDY0
 mfNH2XtlPtNW2VUpzYlloQ+UEmF6VO5g4f18pFJyRgZxn1SOfkXAZN/g2Tbjl35whKwo
 OUUfZT8XuvAsxyrTpKY7un4YAfCDqVAB9Sqk1Y90miVQc5zayx0zkpmMrOz5yoUMj7FU
 iJAbfj2JFMIeIoMNC0ZqPAOJ4KEdGKmnmzr8az2LnH2EX7JtHr57Pt+EogCMihgNQJ+7
 /kMc3Aiup/DULXDIvSj9fnaz0EiGXBUnjQ5LpXRkROIDHzhhOO81c7E527wnTER3eOxn
 JICg==
X-Gm-Message-State: AOAM532s9Fevx9rp54ckOM6DRvJIGc8E0yS0OMJt7+6VHE+ByRjWmQ7W
 A5dqbBoANQO9qjXMmS7Np+Q=
X-Google-Smtp-Source: ABdhPJzDMj6Am/vpUzuAT9HaTmjVYSDhcXq+tnixfc7ZydVKJ6c7xzmi26Xb4dYjC4IQEG5qEIDvCA==
X-Received: by 2002:a17:90b:17cb:: with SMTP id
 me11mr16751476pjb.64.1612796270642; 
 Mon, 08 Feb 2021 06:57:50 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id r68sm8659913pfc.49.2021.02.08.06.57.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Feb 2021 06:57:50 -0800 (PST)
Date: Mon, 8 Feb 2021 23:57:47 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] nvme-multipath: set nr_zones for zoned namespaces
Message-ID: <20210208145747.GA8941@localhost.localdomain>
References: <20210205195002.2657209-1-kbusch@kernel.org>
 <BL0PR04MB65147CDC426FC6345B2048D7E7B09@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210208032851.GA14062@redsun51.ssa.fujisawa.hgst.com>
 <BL0PR04MB651449A902E7FAD397E2169EE78F9@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR04MB651449A902E7FAD397E2169EE78F9@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_095754_284907_66466D8E 
X-CRM114-Status: UNSURE (   9.97  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Hmmm... I see the zone model being set for ns->queue, but nothing for
> ns->head->disk->queue... Shoudln't nvme_mpath_add_disk() also set the zoned
> model for ns->head->disk->queue ?

I think zone model shows properly with the simple multi-path example:

	cat /sys/block/nvme0n1/queue/zoned:		host-managed
	cat /sys/block/nvme0c0n1/queue/zoned:		host-managed
	cat /sys/block/nvme0n1/queue/nr_zones:		0
	cat /sys/block/nvme0c0n1/queue/nr_zones:	2048

But, there are also little more differences between the path namespace
and head namespace:

	cat /sys/block/nvme0n1/queue/nr_requests:	128
	cat /sys/block/nvme0c0n1/queue/nr_requests:	1023
	cat /sys/block/nvme0n1/queue/iostats:		0
	cat /sys/block/nvme0c0n1/queue/iostats:		1
	cat /sys/block/nvme0n1/queue/rq_affinity:	0
	cat /sys/block/nvme0c0n1/queue/rq_affinity:	1

+ Question with Damien's one:  Shouldn't we sync all the differences
between the two request_queues?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
