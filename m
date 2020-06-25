Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BFEC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 13:39:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C11207D8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 13:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HHyCHU80";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Gncokegj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C11207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vUR8MJ69VuglkOy7C1klsIE1PpiqS4rxEY7zK7t2Qug=; b=HHyCHU80FoscIrwl3bIIR6zF1
	Q31QA65VPLu5aASj2pWQMvR+nRVTxxDve6ycmW1Ydo6T2E/FtiUI8ygHUe+rP3sA9UyXItT8rwnoP
	4Nc9uo7LA+G4ZkaK8tbLRuX6XEb756koBcvmkzFF/IutmWI62g5U1T5AZDPX+TmiXXJyCjd/ZGush
	CI8C65eVBFuqlXCpghlzVWJO1GmxfLlxM2JOZMTS8VDi996rrRi+AsdkS0PsVSVTeqWKH/vcNM8sA
	FQV5jO/rNLMzmmdmt8f4Acu0+bqsl1as4+G0Bt5O7ABFNLi0r3Fq/Z6UWLMiSl5IywrVGu8oCyfwa
	BfoFpfT7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jooZF-0008GB-Cd; Fri, 26 Jun 2020 13:38:57 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jooZB-0008Br-8z
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 13:38:54 +0000
Received: by mail-oi1-x242.google.com with SMTP id p82so8102652oif.1
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/r+jmviS0T5Cngld+cIbW/oeILUuFOjszb7gCMcsBFk=;
 b=Gncokegj/Et5KXnljvNxiVT0vSjrHyQ4INSnPy3RQG3xjuZnquQo2zhUglWv+zJyDn
 pdK9iZvRc7WhaqXVU/jkXlsu7AUJJreppYgxcdvpGS887uVH9VYhksJAQPKXrq7OsNf9
 4yKDjixQ5NMgmJr5PKOSuG8lK1gOslyNlXR+L4PJG/LPo4gpsndG1gB8wSiBM+jRDesp
 iCiLcPn4gqlty6kgMUfdNs+zcbZu6VXR7noJN76CXK18I5Aee0k4rGnf0z90F9MjLs+K
 wCYjRyzCyd71aaBXCzZC0KSBRx3/Ohmyn5rVBnyUXscrP3q4yDlq5j7bLP8lPCNIZXvx
 T75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/r+jmviS0T5Cngld+cIbW/oeILUuFOjszb7gCMcsBFk=;
 b=k9X+12h7JdCoXHcXq0PtcaNq0f3td0Q1e48v9WrsgJPETEBKBo8nJDYO3wp/PJg0Vw
 hWX3CDc68Y9th1IUIrxFRZY1DoemKYIkSZ2nozePjg0iyCx3UMpqHopnmnr08joft/x0
 SilhWcvrxbBR70DUOm4xNmGyKu6dKE8KTS4eB3jboqRft2/CtuDRCBEPFS9+Cj6+UktL
 uvGp/ZuMdNrUDnIah/BCA/B2evzBY3ks94AEcPQ/mMgZNf6wr2vpPThd6bAr3o/7NTs3
 6FsJBJ+0va7ks+uqZp8a9DkyxaQB15zXpu7qHplCGpjsQtkBDcIWdiJo/Su3Zfg8nXhd
 z58Q==
X-Gm-Message-State: AOAM532R+2CawQ6DihUXMK8zSwwVn6zSUZ6ZT/YINLGS4pnP+DA2jHvO
 LLAB8GqHdSr2c4bljeTzSh/y49sI8a718A==
X-Google-Smtp-Source: ABdhPJwqj2hi624WpRVRcDX3+kgITvMH5tuQkynazXybRdwiIeSCnW9WtgoH+gHSS8ENKcicn1qHrA==
X-Received: by 2002:a17:90b:347:: with SMTP id
 fh7mr4870854pjb.64.1593111466308; 
 Thu, 25 Jun 2020 11:57:46 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id k2sm20662765pgm.11.2020.06.25.11.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 11:57:45 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.8
To: Christoph Hellwig <hch@infradead.org>
References: <20200625165333.GA1982738@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1ab79476-516d-d7b4-74fd-89cd70d43a2c@kernel.dk>
Date: Thu, 25 Jun 2020 12:57:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625165333.GA1982738@infradead.org>
Content-Language: en-US
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

On 6/25/20 10:53 AM, Christoph Hellwig wrote:
> The following changes since commit 0b8eb629a700c0ef15a437758db8255f8444e76c:
> 
>   block: release bip in a right way in error path (2020-06-24 08:49:07 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.8

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
