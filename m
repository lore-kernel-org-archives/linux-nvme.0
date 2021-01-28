Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640ACC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 18:58:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D817964E21
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 18:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D817964E21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=g/aty3HrN/LmVb3MylGBtaPRZ0wwzxzmoHRhcOLQ0DI=; b=adtt57s/Dl56W2J4/UfLFRS9j
	6KYUCfA1+63aeJ55Oorc8KI2etcw1YGm7PTCLSXciL7THL3/oW4jG362PJKZ6nhLucbdFgeBm5dIN
	O7MZGU9YwHQowCDj+4iW9Af5gjhW3tr3w8zZAjdb+QM5iw3PVQqOIcZBQA15MbTJ2ciWI5dsnqhif
	1Kkh3JL3dP+B63Ijz/Rz4gZypg4DC1WB0qDQSRK5taydN2iCWKuf6+qORw4CBMfzAFbc7mim1UnUM
	IXfUuW74nhTVOhLGxlN32uTVw44ZGKowPCtokcQkNN3sQDzPrqP+qWW+gBhQuOgaFsw2n5xbt7ebW
	Oygsu+Vkg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5CUe-0004TG-Bx; Thu, 28 Jan 2021 18:58:12 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5CUc-0004SU-5E
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 18:58:11 +0000
Received: by mail-pl1-x632.google.com with SMTP id 31so3851409plb.10
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 10:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tvUWarteWpbsdH7x8KNaOL3xT912q2nH04jHPmZbkKs=;
 b=FEJv+GEOVPI/QG6bn/9wdUD25EKdGhgXj7W4QvZxv7w/SZ3Nx6UldosqBibX8eHIHl
 0dZMRVczIDcp8E0I19Y9QbuxD+VpM5dV/QPIpt7ZBA74B+FTTf0tWDe8Kc4HcOz2n6P+
 JpnNr+iG519qk+xM6BNBoi5EtcjsT/F5WTCYBYsqdzf3yGzGCK/Ke7FH+9LZJGG8PhQy
 B0INmmUn2Bw6bRwQYOrhfZWsCQvpy/WbGz+LJNQA8+eDXZVyhZuaeNICzVL2YsCr7ukC
 znv3FS9EHxR9iKHGRg4L3+aXkbHJu8vA3zPWcLzIQJiPK7AM7ZXjipBzqSJUkVic1VSO
 gfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tvUWarteWpbsdH7x8KNaOL3xT912q2nH04jHPmZbkKs=;
 b=opgCMROoAQbcO+rJmkdpuQ3yOr0TFNHshLHZtdTIfCI4Yyng4nra5v3ii06T/fHKGd
 ftKxKuwBfJDD6xW41FKoi+u2EamOWKcJ08baaJsog/fjSlGu7remGpd1zI0jmEcxNO3a
 tDv4L9W8Va8AivKWncRKy5sZGCxCpuTm1aIXIhaQKfv/R7J0uEzIGq2gW50XG5whFuUB
 emiT9b2j3AM254GU95d6W5RoxqIxA795osdVzFgyWPNtEPV3TkDqXbAUFVG24m9we3jn
 NKbvUO+RJsMjEyOGI6hayhuW2XEaGNBVq0h1NrqliUVgv24cDeBRq/r7CsCXBhylq32h
 1mrA==
X-Gm-Message-State: AOAM533UWFy5+W9OtuN0z99NvgCfM36pYlZ1Skeu9vfHFT5OGBCuUqZH
 E2V4B531J5Hx81/CwiObZyR5P02VlrjTww==
X-Google-Smtp-Source: ABdhPJxUIYVkTxyOOg3YKHp2UWHC5BofWy31LX31pC3mvJQS3GD7oYRNo+1eOq3u7JkGGTLPfuBQPg==
X-Received: by 2002:a17:90a:5317:: with SMTP id
 x23mr578278pjh.154.1611860287708; 
 Thu, 28 Jan 2021 10:58:07 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 w205sm6540204pfc.198.2021.01.28.10.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 10:58:06 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.11
To: Christoph Hellwig <hch@infradead.org>
References: <YBMI8qpv8l/vKOlx@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ec942804-628f-83c4-6cbd-5c1a9ada6e13@kernel.dk>
Date: Thu, 28 Jan 2021 11:58:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBMI8qpv8l/vKOlx@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_135810_247635_1C4CACAA 
X-CRM114-Status: GOOD (  10.69  )
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

On 1/28/21 11:56 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.11-2021-01-28

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
