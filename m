Return-Path: <SRS0=tL+/=A3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234E7C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 14:58:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E438E207BC
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 14:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PuwD/KRG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ln8xmXfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E438E207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wa4DcNWcnteLI7ounJfTpqVG1g/2DQGY0k3KLvu65DE=; b=PuwD/KRGKGk1eJjIDON0MN2F6
	RhnBps9KEIs5Ic88OXKmXrfF/9aCtng5L480/gOV70PGb30/eY5TF7bwE90EBEVaL44hzE4em9Od8
	BP4CbloApu6yL5LgKtuno3D46ApdgnDrX6CfaIwF5r8wiqIJXd4YdLsR4R6jS/FAON+KP91NuQdvj
	THrtI/NV0/nAaHvk8Ps0ZrAUfcngwd8vrJr4IjPWfX3T6qjQ+5r0eGjzp1VGZfhniZ/WIuYCQMLuL
	iuCScdxJWF0OWQnDRwHBZJLjxJYXN80IoGcK6CsX3zv20GTsnrO9iN65EwGtP4TtHuvpcTOsaFqSh
	Kz5dYHclQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jw5LY-0003NV-2y; Thu, 16 Jul 2020 14:58:52 +0000
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jw5LV-0003MD-Gd
 for linux-nvme@lists.infradead.org; Thu, 16 Jul 2020 14:58:50 +0000
Received: by mail-il1-x143.google.com with SMTP id x9so5323536ila.3
 for <linux-nvme@lists.infradead.org>; Thu, 16 Jul 2020 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sbSSrPonKJfXJbjkODGw5kCeYi2eB9jEjMNe2MWe9po=;
 b=ln8xmXfwt0w2jAmcOb3H5wB7TSW0eNCcj/TOTdQTA/mv8BpAV/mSSA1vClJY4MUZIt
 L1MRoY1nkwneHe45S5yKdLgJkFGBa6xHbSho2ZkrAQSo8e5GnWvuA4v2mwVPxybrG3p8
 loApfClf2p6O3LVFfOPVwtAkY8xxQE35dmLc6VBouSkjIBIXsXYquhZWYyVDPyp7XWPe
 0fJ/Nyh7ofzp6xfMrDi8E+mC5/g1K0wTvNORNJcXks3p6iFKoPw46LSHmTRal8/C6Hpl
 uFHGLV/G2YYCxMEll68QvyC03Cqcj7nslY7Tmc5LVgnsXw0XiBnFyynpNUkcrMQHWPqn
 R9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sbSSrPonKJfXJbjkODGw5kCeYi2eB9jEjMNe2MWe9po=;
 b=r0ab19J8yh//DN2pTp8VuKoNpqjo+9T8Rmfwmi/BHn9tdB8iK6usEIdKibr9p7qDJg
 +8b5EKc4n9Mk6v7/VLQNriJYc3BspgmWWCw33+NZ4wOExNwgvqI7bL7Xd3Cqk0mZQaN0
 /l5KslJFowPVBai8acHmOWpbgGYJ+vvm5Pt4ago4Vn8HzXFk/71aGznIKo1feNuUigHU
 7wBSRVxvmJb3HSLXt1sD+EYts1ZHSb3IhZwM9+vd05iYi5XC7hZoE+j/86gI3Gd8t69+
 LVicqtoB0UPWli3Ee11j/JOPPBmphxAScxquzZz/kjf0WxuApc99zV87G2eZfo9hJTIV
 tjXA==
X-Gm-Message-State: AOAM530ksFIZNtXuIFRq4nnj7RjhpktD/czsAw4RzrA8EQ9rlguKux0y
 5gXTUeDBZq1N9GHIRxo/UINDYE7M6iRUbw==
X-Google-Smtp-Source: ABdhPJzIvvEXWrGMQ9FKZ0wfeJsFuBTqCmuAM56PUkcJsNVfl8zR1IoiMpo9B2TxvKd/2uBK5JmfBg==
X-Received: by 2002:a92:d812:: with SMTP id y18mr5271885ilm.286.1594911526273; 
 Thu, 16 Jul 2020 07:58:46 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id s18sm2757180ilj.63.2020.07.16.07.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 07:58:45 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fix for 5.8
To: Christoph Hellwig <hch@infradead.org>
References: <20200716144205.GA475287@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1e305554-0f7d-06a6-cd3c-689249a2557c@kernel.dk>
Date: Thu, 16 Jul 2020 08:58:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716144205.GA475287@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_105849_575464_2FB1C31B 
X-CRM114-Status: GOOD (  14.57  )
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

On 7/16/20 8:42 AM, Christoph Hellwig wrote:
> The following changes since commit 579dd91ab3a5446b148e7f179b6596b270dace46:
> 
>   nbd: Fix memory leak in nbd_add_socket (2020-07-08 15:42:18 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.8
> 
> for you to fetch changes up to 05b29021fba5e725dd385151ef00b6340229b500:
> 
>   nvme: explicitly update mpath disk capacity on revalidation (2020-07-16 16:40:27 +0200)
> 
> ----------------------------------------------------------------
> Anthony Iliopoulos (1):
>       nvme: explicitly update mpath disk capacity on revalidation
> 
>  drivers/nvme/host/core.c |  1 +
>  drivers/nvme/host/nvme.h | 13 +++++++++++++
>  2 files changed, 14 insertions(+)

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
