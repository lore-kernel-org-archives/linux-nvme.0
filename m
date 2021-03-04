Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20549C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 20:27:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0DB64F51
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 20:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0DB64F51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pEt4A8yhNkxxiDolkzJsFv9h/zWf7RzgYKewyoalY3A=; b=bD07vpk1yd0mtYSBZoLz88HoS
	AIRuVJ5LR4IET1k/OwPy01faZhgr8+8tb3w56E7n7A8wFJFPDE3ZUktmK4GB99+Y8X+TaUpyE96FN
	VZdhD1TYZ/rdr+YIw74x0EzW2vv0miI8IAy0WA+uaulY87N+uyg34Ca1N+xA8ZNsw4z14DjgduNip
	VLgbsJL62QxEXC0iCMgnbAMps8rOcgL8KtpZYlBwo9i/pRClZRjbarb0Ya/PgdkMEr+5h+6ZVOYeB
	wH4A05xCkjXXyPJns4JiYQ59E4kjkckbET/px2bEd/X75M90u4KnkwIm1YwmcmOgB8nWNS6ohydK+
	g7QuXUSHA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHuYr-009x7k-8o; Thu, 04 Mar 2021 20:27:05 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHuYj-009x68-NZ
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 20:27:00 +0000
Received: by mail-io1-xd36.google.com with SMTP id g27so29849190iox.2
 for <linux-nvme@lists.infradead.org>; Thu, 04 Mar 2021 12:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XFKn59CF1p2RXs/QYRNWRDnrQj3ENHOQmiAUNdwvt/8=;
 b=goAo/R7+UfioF8QKCapnUVAbDiE1D8ybcizf6fF+H1/dhyQJpR0Okh8peBp/uDi4g1
 /voaLbInCz3O/pxD9/cRPCP89mF7NQWHaesOZmw2xDeS9s6dr3k6OqAjvzkGMomAiV5D
 NHDdeNx/+o+lE7o5jSFKn2JwGZDv+JD95EL6V81iS5haFMGqE/oenUDESPXp+r2KJtO2
 WjeUswIzSEpLuqghJo2VGi7K9I3quUOhaQ3Yw8dXwjegLR6wDjD01Tm2/ZPJJXCWscan
 PE53HBYGkprlI7zmUUOtSlAnsHIuF+Ke5J6aFFbpnRFKMIy31m/yavKUaaoLKHyAgHA3
 gbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XFKn59CF1p2RXs/QYRNWRDnrQj3ENHOQmiAUNdwvt/8=;
 b=gKwoij29bAonGzLGqaqPceVN3Ml6BlGrXDZbhQ0drEAmGpmj0funfoQvt+ayjQZWtK
 AzLrF1FBUGgnK/gDizn/bWlxTVbKrhhBGxwT4AaQKCITBDSDC3xiK7aA9gf5LNI5AV2n
 UTcDxXIzjFjyp60EmfS9VKGYwkmK4lVU280twV1OiWDl/6wly3KAjY8Kz1Ev4h4PD35Z
 NZfxZqLX+Fjfl+5XJhVk/4NuZR48TYU95CLZdpo8nRT1jRYEz9JJRDhVxRqNExexwvAy
 NW2dzIdU7+DjUUCpkTaKE5Xz5gju5zmSxoRFsGl2s1eaHokkunIV0Bs/vv1tTTk8kXqf
 OYog==
X-Gm-Message-State: AOAM531Zn+TJ4ot6MPETmJqQzdtRqumjrx5fTiW0yVGMI0kx7pewK5nE
 wiA2yyHxhK1Zrqn7uug5h/xwDE3TD3EOnA==
X-Google-Smtp-Source: ABdhPJzHHwzOOuPqOOtNNPiTepGm3D6zLTMpZsCvsY80ZOdfAhQ1CplzfOYFKkFrYo1ne9Ip/jXGnQ==
X-Received: by 2002:a05:6602:2191:: with SMTP id
 b17mr5080325iob.114.1614889613494; 
 Thu, 04 Mar 2021 12:26:53 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id l14sm254530ilc.33.2021.03.04.12.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Mar 2021 12:26:53 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.12
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YEEf/hvMMuqpp63T@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <55b373ce-304e-f79a-6904-dc1c1205a9b2@kernel.dk>
Date: Thu, 4 Mar 2021 13:26:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YEEf/hvMMuqpp63T@infradead.org>
Content-Language: en-US
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

On 3/4/21 10:59 AM, Christoph Hellwig wrote:
>   git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-04

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
