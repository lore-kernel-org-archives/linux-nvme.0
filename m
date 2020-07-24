Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18534C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:16:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E11206F0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sav5OldX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E11206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=sav5OldXx92gJWaYaEM7o4R+n
	pCLVyfvgDaDJMfCrv1P56gWc0DBvmO6e/c4IMBUcLaGdFNAt92RW9EQRdDUDYQ7sY4k8xLAvItv/U
	H6/5qz3T7UC6KZGVyC47/Uxw/MFtgPev6KFsuQTy9wUWmzc/91UurMq5BaETZxhfjR2d3pcuUaQoL
	1qt4u9mdlijWOAGTQhuQFy8Xju7/p2iBsy3wcYXwb9oF5P4uyG64RostOCXM5iADnXl8Lx20YAYHp
	ZCMP3wXgg4IQ/2bmSDeYJ32mFuah3VFXt1O+nOc16AYeszi8Qi1vHz+Q9RX5To09HgKUgDGaaKMzv
	NB+ohxOww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz6vN-0005O4-2e; Fri, 24 Jul 2020 23:16:21 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz6vK-0005NW-7J
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 23:16:18 +0000
Received: by mail-pl1-f196.google.com with SMTP id p1so5399210pls.4
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 16:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=RN8wm5C6h5nOT5mR46XU0oBN3SMVVYpzf4FJHwMVN30M6kDC5w+1+IqwB5qPgX99uv
 wu36qbqtORHwiZbfvY3vCu3vz2vMr4mtQyTTyzBDTUlFUr9cwSSB4d1iupTtwBbJ6ZNH
 MYkzRoyxd7zZBSSShXZXafFMSzCjo/D4vx8Av0EeJICJH7cRONdSbiImrHclRGNsYXzm
 Zq9Nx+56umhUB2BWRB8sOnGgN/99w3JxdvCSVfD+eB4F97pri78TjcipJC7f1f3IsWBT
 hMks0JiIHramVbsYOPcY2laX3qwVcYn+rWiEw0dqeUyjBiM1RiZfes7RWBnoHS+H9Vnw
 tArw==
X-Gm-Message-State: AOAM533DauogJ6gV6voUYe8UMT8k8LT1QZCC/32qhCF+pZ7uS7sWCcNi
 PpkIwfh3uJjgndUmyoSe/abrY3ax
X-Google-Smtp-Source: ABdhPJyrWMWozvuxr1yJSgnKn0lzgea+tkzVvqxNI/CCf65m+3CfhZgX/4rKpurhVws5a+1jXVHnCg==
X-Received: by 2002:a17:90a:2683:: with SMTP id m3mr7971515pje.8.1595632576809; 
 Fri, 24 Jul 2020 16:16:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:ac47:9fc4:b59:66fa?
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id e8sm7297732pff.185.2020.07.24.16.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 16:16:15 -0700 (PDT)
Subject: Re: [PATCH] nvmet-fc: remove redundant del_work_active flag
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200724164048.49936-1-jsmart2021@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <47ebbaed-9fff-0b5b-43d5-c9efaffaa48d@grimberg.me>
Date: Fri, 24 Jul 2020 16:16:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724164048.49936-1-jsmart2021@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_191618_312482_AFB7C9FB 
X-CRM114-Status: UNSURE (   7.51  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
