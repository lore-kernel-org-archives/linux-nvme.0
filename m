Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF7CC4727E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 11:27:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C440620708
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 11:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ACUuPLa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C440620708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pPhJ2fEHnWvMk7GHFy54NiXgFB7D2qrC8DTM+gzTAT4=; b=ACUuPLa8uYbiOwGq2pznqCco7
	60I1aMHEeD++/SBSBSAXTd+V+71wTQLz6HwB01PzWppXRye3BNazx1kqmT/RSaj4zl3YbvHIxzBh4
	OQvhqNeXcege0cl6507VukovJ3rcQ+xr/izl+m9opCHAhu006SYvDwpWPlsupC5rbiHFtMfZ1Ibh3
	1lmsvLXP+K6jM/uSXwYcvFjAjz1iUj4ZPhQ/3fSNITdZgRTTh5Nrd86XyfYYOBIExRkCUNJ+940pD
	jLRsnjVZMkVtyYgBzDDkQuuL8+4pyUbFYmJwwlARMc1/Q857WY/0dWq1dJCGbo9muNESHMEmECSIG
	by2LmdZIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNaGv-0003RA-Tv; Wed, 30 Sep 2020 11:27:45 +0000
Received: from r3-21.sinamail.sina.com.cn ([202.108.3.21])
 by merlin.infradead.org with smtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNaGs-0003ON-E8
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 11:27:44 +0000
Received: from unknown (HELO localhost.localdomain)([221.219.2.146])
 by sina.com with ESMTP
 id 5F746B9C00014479; Wed, 30 Sep 2020 19:27:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 602026628872
From: Hillf Danton <hdanton@sina.com>
To: nmeeramohide@micron.com
Subject: Re: [PATCH 01/22] mpool: add utility routines and ioctl definitions
Date: Wed, 30 Sep 2020 19:27:15 +0800
Message-Id: <20200930112715.18532-1-hdanton@sina.com>
In-Reply-To: <20200928164534.48203-2-nmeeramohide@micron.com>
References: <20200928164534.48203-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_072742_742392_DD786C13 
X-CRM114-Status: UNSURE (   6.26  )
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
Cc: smoyer@micron.com, plabat@micron.com, jgroves@micron.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, gbecker@micron.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On Mon, 28 Sep 2020 11:45:13 -0500 Nabeel M Mohamed wrote:
> 
> +/* Rate limited version of mp_pr_err(). */
> +#define mp_pr_rl(_fmt, _err, ...)				\
> +do {								\
> +	static unsigned long mp_pr_rl_state;			\

We do not need to declare a mp_pr_rl_state per use case of mp_pr_rl.

> +	uint dly = msecs_to_jiffies(333);			\

printk_timed_ratelimit() needs msec as input instead of tick.

> +								\
> +	if (printk_timed_ratelimit(&mp_pr_rl_state, dly)) {	\
> +		pr_err("%s: " _fmt ": errno %d",		\
> +		       __func__, ## __VA_ARGS__, (_err));	\
> +	}							\
> +} while (0)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
