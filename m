Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8624C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 14:22:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243F964FB2
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 14:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243F964FB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RNa3DNw411/frUlEiQyZVEyXTmpEvO3FRUGNaKDqidk=; b=ZrFDHc9N+4csgVOhHBg/lZM6K
	3bhhfWYLUr4DdL1lHfIESG9JNGKYs4h1Yi2n9neQIKTaHIdHpLM3B1tm6Cy80aN8HX/jwWvh1BRlD
	sAKuYYnUd8BSOS6ehnMsld/2cYSGaF4afpCW+/+3OXAJY+2K6bRaEGN3lOim+JIEvy3TWFHbX5nJW
	q1iCuNVA35pLHzPId93eMYfXcUvfLHfudl9r4LxPDjrDGv30TG/0zCUufoiv+qRbCeioB1BABXL7F
	XaBrOtTCNi09JN8PuwVAxIa9BI+/86tmvsSVdynl0GgPAz8ZSfMQwyvDdxI56LR0DusRUOHAtTkla
	AVp70Mxtw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKifh-00BcSM-Fk; Fri, 12 Mar 2021 14:21:45 +0000
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKifc-00BcRB-PR
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 14:21:42 +0000
Received: by mail-il1-x132.google.com with SMTP id z9so2730982iln.1
 for <linux-nvme@lists.infradead.org>; Fri, 12 Mar 2021 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=E61zkshFErZvXwXXuG6eHT/uAMrwiprKwUlm/Jt8qKA=;
 b=UFvsmMq8GC/8RpJgAwOoqBuWirjkiwtoO3aTyOSlf+jZEMSzQvpbygbWeJDs3Nq96F
 PGETCYGxDq4j+QKuZr3RU8S0bH20bpWKemt/cyXlSG3Nx7hMMdPBSQ0E/spC1ct6UVq5
 25NciDA2wxhJRplCMFcGM3eRNjQI9n+ZUudeVHLGxwBDxPmXlHYIYgHjH4Y5YveGtxF7
 lHniiQtsuWosvtrnpgtQZ9wUnuSqHsI5ZcZKTOII+0b3EYXYwjNbi4EsBzM58LicUXXi
 n6haLNgHmNvQKXdryAdcxW9KZossNXMSVjLP+AeXJNISVub2uGUjDdDqQ9raCqKbcdaa
 8ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E61zkshFErZvXwXXuG6eHT/uAMrwiprKwUlm/Jt8qKA=;
 b=jV9TAgxa0Kp5nsRsw7HuLQwmTamM1k4VPejXsSQdzu7WqrBRqLCDXtAgBbCxvbvS3b
 zsuuE2O9E3vlQhim4jDbpvASGjfafAjhULzk6Nc3jbVo2kO10wahP19vjRhQIyHQZVKU
 5gAE3KYIp61zNsK1Rlv7tAq3LcUvPtvvtPoF1CsZjMpV2JvZCeUazrcJlURaKOQgY7hq
 wP5Asfgd/38rp4pJoF7891v2TY1xHhIjvAXjG2zbQF3b9iT6k8T2XjaI/R6s8blonq6k
 zYty3YdgVydiWA5Ah8HKyPyUn+KnVeOkDBuTwGUJ03wL/OX/I0vHCcfAnYDYd5lej62x
 hoMg==
X-Gm-Message-State: AOAM532NX/3OvzB429i8qXc0ZFbSBlVG+RCMIQtL7Im3hxMZvAC8CnN3
 jWEPJXZw76epMM8VPI/MdLPDKT8cVtY5tw==
X-Google-Smtp-Source: ABdhPJz3ST4OLgnhxfMSrAKuyp0V67FNBCcu3PSlX/U6NVi94ExgQoTRrdvtdqgdWgOzwVEOn9wI7A==
X-Received: by 2002:a05:6e02:ee1:: with SMTP id
 j1mr2834065ilk.179.1615558898838; 
 Fri, 12 Mar 2021 06:21:38 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id c9sm3098343ili.34.2021.03.12.06.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Mar 2021 06:21:38 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.12
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YEszeMEAQyfTPgHH@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2a34717a-b5c5-0a3c-02b0-eb8a144aba15@kernel.dk>
Date: Fri, 12 Mar 2021 07:21:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YEszeMEAQyfTPgHH@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_142141_006056_D2936A44 
X-CRM114-Status: GOOD (  10.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/12/21 2:25 AM, Christoph Hellwig wrote:
> The following changes since commit df66617bfe87487190a60783d26175b65d2502ce:
> 
>   block: rsxx: fix error return code of rsxx_pci_probe() (2021-03-10 08:25:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-12

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
