Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2618AC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 17:53:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A226A6108B
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 17:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A226A6108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9p13/YkpRTXjzH2LYau3CUEEI9IIK8GUPhCBMgjecfk=; b=hfAeq91ZI79M8alWkR6bPxrHo
	ETFXI1W9mlCt3BhcWSZ+FswUzR7aEA+SobUteCAuxlYtt1sh3qIScxaC8LKgD9ygZIYnGqJ23IJoB
	kvJ0vR9Lv2ARpTuipNmDWv1/fP+0wLgiFDNh5PxBs/QFqlXVG/dz+n46f/k+bgUtnu/JtsXDOFryK
	QS/ekG8vqDZ6PtibKiviS8ABDYWkYBXPdYZPR2RjkYtVRfe7CJ2a20seZ3w7NMexBUPRq3xPo8veF
	CifdBuYeR2KIThdQhN9GvIUxiu7dpRByxhNH5o7VDPgMrnEQfPZ/ouq3iw3x/XvACVf34Ys4Te/SH
	ZhjSXmo/Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUvJU-001EMN-K3; Fri, 09 Apr 2021 17:53:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUvJR-001EM7-Ri
 for linux-nvme@desiato.infradead.org; Fri, 09 Apr 2021 17:52:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=PeJGDcAYUDia58cpQxvSd2/N4rbuu6CYwBHVOHkUUvQ=; b=FFT5ldi791SgI/RYWEg55lQHaf
 7xHVIzubk0EstGCFijSVTTVlWiH7f5XmVlo/2Ua2vwraXOpx/SjAnbzil0cor0ER1NftJNy7GaB+b
 nW23hmnG5CqoobOAzPNS/TzofNV52HTwzwiwHvYFg/TVoQdAeuGZSMq0UYr+qIfQflVjqfkmqsThO
 yVWurD80GX8w7IZ833XbZlNnCF5ktpLcoktQY9xkYZHBQIibjjhvsN0f6l7haffAaDiJw5loujBH0
 WEadqPAXaoJB4/XptdJXlkO8tTR3RMNIcLhonSsENCVArNM655jtr+OZ0TB28nh0HP899V8IHv1qs
 lAk2anGA==;
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUvJP-004hgY-DI
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 17:52:56 +0000
Received: by mail-pj1-f49.google.com with SMTP id nh5so3253272pjb.5
 for <linux-nvme@lists.infradead.org>; Fri, 09 Apr 2021 10:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PeJGDcAYUDia58cpQxvSd2/N4rbuu6CYwBHVOHkUUvQ=;
 b=WaDFuoZkycQMTVaXJ6K6JRLx51kTfiHBqK2O4Gk2VTbnVTd2Cte+O6VPdYWQ1QwOE5
 0BXroWen4f0YTLiRU+++GFM484gq/PuS3xPm0HXZr7tZNMga5GHEMpXS96HqwTIaAhVx
 x2iI46V/EI9SLC3LqXUhbMwl78LwPeYS4DOkl1Wh1wc5K5e3SFU63Ua+IfiX7htB8wkJ
 EsQ3Z5YpFupbSGlTJd5sqCrdg8fCi5SSjBCn9AwbP0XLqcUukplrlz5nWgEGnzG6qhPU
 tq/jVixvLT6H9krwWMUHHomTg+VBVPQvBQCpRVRL9jAprhZ+ZzN6CdGIHll6Z03jvjbA
 qrHg==
X-Gm-Message-State: AOAM530gEmYI0e4Kx42ndb3tGT1PflrD/SwMRfAFEY4dalyjrmJTgNvG
 DSP1YU6Xl1jNF63VxoJwC+WKyo/QuLg=
X-Google-Smtp-Source: ABdhPJxerMU5VSjTL3Gfrpt27Wo2iJhcaED/J+TZTQyL5MTXbdfwStDPd5tYWvSVRea6T2QIhcHIvA==
X-Received: by 2002:a17:90a:7e4:: with SMTP id
 m91mr14266698pjm.46.1617990771518; 
 Fri, 09 Apr 2021 10:52:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95dd:20b7:6d40:bdc3?
 ([2601:647:4802:9070:95dd:20b7:6d40:bdc3])
 by smtp.gmail.com with ESMTPSA id lw16sm2815489pjb.41.2021.04.09.10.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Apr 2021 10:52:50 -0700 (PDT)
Subject: Re: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing
 error
To: Hou Pu <houpu.main@gmail.com>, elad.grupi@dell.com
Cc: linux-nvme@lists.infradead.org
References: <20210331074856.46966-1-houpu.main@gmail.com>
 <20210331091314.48925-1-houpu.main@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <02a00a10-bc15-ef58-406f-270116c4822b@grimberg.me>
Date: Fri, 9 Apr 2021 10:52:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331091314.48925-1-houpu.main@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_105255_477707_A58492AF 
X-CRM114-Status: GOOD (  12.51  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> From: Elad Grupi <elad.grupi@dell.com>
> 
> In case there is an io that contains inline data and it goes to
> parsing error flow, command response will free command and iov
> before clearing the data on the socket buffer.
> This will delay the command response until receive flow is completed.
> 
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Signed-off-by: Elad Grupi <elad.grupi@dell.com>
> Signed-off-by: Hou Pu <houpu.main@gmail.com>

This looks fine to me:

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
