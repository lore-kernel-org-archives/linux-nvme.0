Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A46C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 21:03:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC76611BD
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 21:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC76611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QQgCjX/pqzLkG0aXEOsjhu9kLG6Q3+7pCtrGBe6iD+c=; b=cjukjrJhkFUDyb/zM0+fzwYIa1
	/cdB7cTJo4zcbjfK4SX+SaNzHj/0SRhOyo8f7Qkpv+ip1+2P7YMTucafP6QJYQDWBMWg6/BB9AE/i
	qPiu0fbXnKZ9kIp3z8tpHAj+EluikuYah7anlMJVarxf5yShWmwn1L43WCBUBecb8YqJbX9TfhbMl
	9ELu26wC7oZbuAqA8WN7Y/7MwMRh/ZyHCM/FXUsqssvHFYuJqxRwcGwDRMZGCp1zxViMD7t53+wwR
	M79E2u7XxmQgWrRdc+3kGN1RK8FicZ5h/0hO6L8kXufibGOf3CI6tRi18GHZxXilmITaPYQ9eqq7x
	0Xebob3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqisd-00AV7n-18; Tue, 08 Jun 2021 21:03:23 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqisW-00AV6y-Jg
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 21:03:21 +0000
Received: by mail-pj1-x1035.google.com with SMTP id
 22-20020a17090a0c16b0290164a5354ad0so112991pjs.2
 for <linux-nvme@lists.infradead.org>; Tue, 08 Jun 2021 14:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DmZFNXi9Vb57vKWOGYkmfVM6okptY5Tt7Ef17kHexkI=;
 b=0/UlSN+G3zH9gxCNvvpz1yav7LWJPbA6qpyphaU+c/mHz0vPdKHCr1lIG6Q7zhw+Zg
 DbD9jiprSyR1XnJYjzAicNYkCvdA+ro/hQI8ZEEbbiP+li44rGagu1kI22Y2q+4Yjn/G
 jXJIAha9BY7S3djKmSNeMQkruGnq3nhiAhwE6ZxDo1TFypKPK1+i55CXQVBSN1o8yqIi
 CvA1mHqxl7g8zitMZ9vo3puW1+fNmgTp2kAUvrrXnaVTh9hjzrfFfKpmrUN3PnDBpExn
 VqmwyvXjHIkP6mM4BLRKRIdSked4q2TO9jD89qAQ5+Lt9NH7QSqM+VGoAl0em/s6zheJ
 z9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DmZFNXi9Vb57vKWOGYkmfVM6okptY5Tt7Ef17kHexkI=;
 b=NORvby8KvPUQ3EH2j+A9LPd1eP7ZSpujETImwGv1tMsfnX4XKWSWxRVEe04RhsZJ/3
 3TikcYoey+MrqrpQwjaPsFqLR8gFuf6/1kCbWMC1bBWtc62dZIeTiuEKdLPGqIuNkmh1
 GdTjGS8Jq9tiSV6rv6oe+Dh/OseBlI/XEN8lhNjrpruBSdIa6ElcRHUkvpWGGJXKLAoI
 TvhG8hpq1kUf4Is7vU8m6No40ecqtve8KLA95CeBc07wWtPdbVzncPOb/cmV2ZMd+0uV
 aLCCFPn/o89w8JpjXp3vUnUPxMAYLxJFdD9vz0xWD3Xogn+PL27xtKw4M/oRJKYZj/iH
 7ArA==
X-Gm-Message-State: AOAM533REweEsxIWuV8KlJOdRF8MH5MXzhhfGog5Xn3L5vEx/vPzl5cA
 zPzzmTjU9p7S+qbwoHyzD1tKXI5wUVlf9A==
X-Google-Smtp-Source: ABdhPJwPWtrMEbW76Lm545/yr9iAz/EEWCEGUEVx24jYSkJa/fbsRj8Jo5SxuHqeV4B8LfYRS09Idg==
X-Received: by 2002:a17:90a:fb4e:: with SMTP id
 iq14mr20413397pjb.219.1623186191772; 
 Tue, 08 Jun 2021 14:03:11 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 c4sm1770532pfo.189.2021.06.08.14.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 14:03:11 -0700 (PDT)
Subject: Re: [GIT PULL] first round of nvme updates for Linux 5.14
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YL9/KDQ2uGRVAh6F@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b3534f5a-133e-85c9-8ec8-49972a228fa5@kernel.dk>
Date: Tue, 8 Jun 2021 15:03:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YL9/KDQ2uGRVAh6F@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_140317_550804_940CFC7D 
X-CRM114-Status: GOOD (  11.59  )
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

On 6/8/21 8:31 AM, Christoph Hellwig wrote:
> 
> The following changes since commit 8184035805dc87dd826101b930d3dce97758f7b1:
> 
>   rsxx: Use struct_size() in vmalloc() (2021-05-24 06:47:30 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.14-2021-06-08

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
