Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03126C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 09:46:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A25364E27
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 09:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A25364E27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CUmfT67mhJWztgXFDo8GxTv85qnDmgLHQlXP0PLDxOY=; b=qSWus9KKo/Sihgp8pvCG6c0E1
	XiGjPw0+qvc+IYQigmz8S7N/soUNtPk8I6H0XkdRdqNS8dlAm3vaQNZcNRxj9iPHF4GW1f6wkvD1s
	ka9MQnhmkuaCRi74bETpFG8/lbWYJnbHTzrM259GouhvcsR87fMyQCdErP5EAZdqK3PD0E4u//Vjm
	NT4obVWobFwX7htaDjlpzU/P/OqM1vFu/G/jKqMd7cydHquNuvsdIVHPK/XZqnMNPnnth+YDIy9PP
	ijjWBY4dbws3sCj1iJKVeE70IqvCU53/qUyVpNJ8B0p0nPlsIT4dChlcuZgLLQlJS+acaNBuRDLl5
	IGf5NpAXA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l937h-0007ac-Ag; Mon, 08 Feb 2021 09:46:25 +0000
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l937f-0007Zk-7U
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 09:46:24 +0000
Received: by mail-pl1-f172.google.com with SMTP id a16so7515498plh.8
 for <linux-nvme@lists.infradead.org>; Mon, 08 Feb 2021 01:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+5lag2Pu6I7LiNjAlkA3XIIi+18BqMl/gWMUP4PB43A=;
 b=iypi7NxIGbY6O6nmJzwmpMKCMskjWmIWFjc+db+z82pEY0caD00AGdv+5Fzj6jDhA+
 wkAPt3rBZpKP2KSsF6lgZF0iHL3URX2UtsIH99htjVcgztEmh+GCU6lHoZJxsH3A4kx1
 ViSI5iWMVwh/Gj3IZcinXZDTeordSDijPwPdeUuOQamlQ2p7ZtFzlye4ja3Ql3PRrbgW
 kgtJ6FukWV6IV25M4MDmmlk51tmBJ+6azAk6OQnqj23EwjvnDMwGU7AgaPiyoZ992T2t
 1d3urDuTa6MDWk3EsIrQGC+xePPz81Fmd82p6Icb78dzOmAkYZgbfeIiVQp9pwt9v9WM
 KIkg==
X-Gm-Message-State: AOAM532ZUkt7VCMxDyv6hOBo9Z8UMseqaSY1BBzteetQkl76UzSQe1Uv
 551dB6MsFPZZjP4mOJLaz1WzWjcu9LA=
X-Google-Smtp-Source: ABdhPJy8xQLPSwWLgKj+ORWAdbX7wyFKae7Xnn0rh4IR5FnLBcnBgwMyNw18lwvLuxv1Aj5O+MLVyQ==
X-Received: by 2002:a17:902:b485:b029:e1:916c:a4d6 with SMTP id
 y5-20020a170902b485b02900e1916ca4d6mr15412946plr.57.1612777581324; 
 Mon, 08 Feb 2021 01:46:21 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:a769:ced1:851:e710?
 ([2601:647:4802:9070:a769:ced1:851:e710])
 by smtp.gmail.com with ESMTPSA id g5sm17831358pfm.115.2021.02.08.01.46.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 01:46:20 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block <linux-block@vger.kernel.org>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
Date: Mon, 8 Feb 2021 01:46:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_044623_288756_18FB1981 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
 CKI Project <cki-project@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hello
> 
> We found this kernel NULL pointer issue with latest linux-block/for-next and it's 100% reproduced, let me know if you need more info/testing, thanks
> 
> Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next
> 
> Reproducer: blktests nvme-tcp/012

Thanks for reporting Ming, I've tried to reproduce this on my VM
but did not succeed. Given that you have it 100% reproducible,
can you try to revert commit:

0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter

Also, would it be possible to share your config?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
