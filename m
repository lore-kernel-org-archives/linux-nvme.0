Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E53C4727E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 19:43:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28CA62396E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 19:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vNVuD5Qn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xwxK5ECW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CA62396E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2cbZy8r90YtGAqalyfu5y13ZCIr57wS8tXa7+M9RkUE=; b=vNVuD5QnSlIaxPGzA+UgiX99M
	f+NmqrvuPfBi7Zsj9O+KhiokaUxYw64nvT0cuLZh2xMMw8U7juqmRDcVQlVC3M7hRBA2vX2XDeMWi
	0c5SGzxjK8aN5/fm/12sQ719RLIBJlJvW64WInxjDdQKN3FNEnos7M4MGNceoZOo6GTD+C9EKOmPH
	SoTciufdJH+bH6VVZOgkPdPv+nLZUP5f+KyYUBaxK5Rk1N/qb+kyhwyGvxzFG7NAoDAGFsmngoH8Q
	bmwL/wC+WYEyaIe501H2GtQP7f7U9OrSBnlzZhqpYL8mmMZdpZv69nnyuzO0y5ip4K2YNTc524fZA
	VDzPwfxog==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLX9C-0005DQ-Kj; Thu, 24 Sep 2020 19:43:18 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLX99-0005By-Kt
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 19:43:16 +0000
Received: by mail-pf1-x42b.google.com with SMTP id z18so437513pfg.0
 for <linux-nvme@lists.infradead.org>; Thu, 24 Sep 2020 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0pg1j0ofJKNNpEt0mGcC2+CXyH96ithZ7yyocaMNDVs=;
 b=xwxK5ECWmDB6ICV7/eTNjmWNSMSeFEHWOY3cJpGFNy67B0STEoUtARZtWDPoWx35v5
 70+xKNICk3DBjDcr5mnHKhmdnwgbNxz9RBgKQWJ19a8d9aRAIPbIij3/K+Q546A0qn2M
 n0gz6fyga5pNw0jbWB6a/QOeKhoxbc8sOZTtRIfcYOvryEwH4yrUFz1RnwaUDX9+iYNt
 fPriPHGt34UW3M6QpRUBuenTXrb9jTxWZFt9XdIWfTZZ+JD8LkAmSRkcurWgJJsP7l51
 qfcRtL6sa/kfKdWJKD5tQ4WzwSPy2Plln3EU4bie0uRlexo2slzSUN7YWUQnDbWyMEUu
 vBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0pg1j0ofJKNNpEt0mGcC2+CXyH96ithZ7yyocaMNDVs=;
 b=BYiUdPNb5cL/iq0nuw5lea2SO/MqugxuySCkbuWNx+ztIgXKWOy0R37QTX3rL006Xg
 PX2EUO0DEec2NxuUBhcjHOQLMS16Je6qGqLH0Ze8cDpmoL/rF/uMIcxEY9w+EP8GtSyp
 IagNkR2L0XUpw9ntjDPUq/UcidNj2pUm86ClR16KHTqiyKDvOYao4Y5Ee8zh3NZfAdYJ
 phyE92Az45gLcOHvW/ULgNMn6LfPFX60Lor+9VaAtk3ef4tM0LZBiLs1ytYKxOLQX3Ei
 b8jMeSHVCfDzRxyo0XVdSxR7qeNUZPhCylyb3Dgec7eumuUbgJacckP9S8G31jdFxiJ7
 P0mQ==
X-Gm-Message-State: AOAM530Z2hY9fI/kOOiIlsuQvBKdUIynYJs0YcFo9mKHh9VMYFJSC7l9
 Z7x9dwS9TGg/tsOdDk0ZZ9zQFRQ6kVzHGQ==
X-Google-Smtp-Source: ABdhPJy9N9H9JEyJ0eiaM+CQUET9Yi9UTrzcy8DMxeCwem5GeknDHLYVRALggZa4bGcdlw9KxCOXng==
X-Received: by 2002:a17:902:9697:b029:d1:e598:4001 with SMTP id
 n23-20020a1709029697b02900d1e5984001mr721580plp.59.1600976590983; 
 Thu, 24 Sep 2020 12:43:10 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21d6::1911? ([2620:10d:c090:400::5:d63d])
 by smtp.gmail.com with ESMTPSA id z4sm260011pfr.197.2020.09.24.12.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 12:43:10 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.9
To: Christoph Hellwig <hch@infradead.org>
References: <20200924134654.GA873840@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <930dee00-e995-cdbf-ff15-d91820572a28@kernel.dk>
Date: Thu, 24 Sep 2020 13:43:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924134654.GA873840@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_154315_802334_AA02A1AB 
X-CRM114-Status: GOOD (  13.56  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/24/20 7:46 AM, Christoph Hellwig wrote:
> The following changes since commit 4a2dd2c798522859811dd520a059f982278be9d9:
> 
>   Merge tag 'nvme-5.9-2020-09-17' of git://git.infradead.org/nvme into block-5.9 (2020-09-17 11:49:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.9-2020-09-24

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
