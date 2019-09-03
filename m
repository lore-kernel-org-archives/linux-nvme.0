Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7D6C3A5A2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 19:15:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38068206BB
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 19:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MzxNUmGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38068206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=buP4xDdqS2otj14DlL1/LDDZ/u+z83tBcxTZa6u9J5g=; b=MzxNUmGqekS6VxOtU13x6MI5R
	2eido73sjEdE5ePuNRYXmIjWvNrJf1wrQG9/LIICxcfMhappBA8qxqhWpj9iYjcDwEbiAvjml9/F1
	J4XP3rfRd5Jl03cna1DLO+crz5r2i5tmFg1ETT2y8y+3KSWdZIC09Xp+CUjw1WfeHrwHGYbVULBhh
	h/HLIJkrZL0h5oMncXDpBknxeoeSeeiDsYEqme6+EOc55DJ7rMb37ZGnhKpvW8w0UqAfbTz3irK1w
	2c8dtKLJmK7q7+HMeuQC1Q85oiGe3j38sfn1jS6XpT38k9KeT/QM9B+/SLu0C34ZwyBnIAWqh6ayC
	rR9yT/otA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5EHS-0005ri-CY; Tue, 03 Sep 2019 19:15:54 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5EHP-0005r9-Lo
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 19:15:52 +0000
Received: by mail-oi1-f195.google.com with SMTP id l2so13759942oil.0
 for <linux-nvme@lists.infradead.org>; Tue, 03 Sep 2019 12:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mAOsk3v+mGWoFMnNBMYGwd8dnmyJmNgXPI3w1pcXB+c=;
 b=j0SIEY7Y7bnC82H1XBeouX2pTN09S8F9ZAuaFXB0r4rZJCgF/yJ6oEbBadsh133n6b
 x7pN+CKuEkYW2zGNHL+1x0JmTCCy16pn2N3WPHgDsCJZVoaTy4TaPpLh56sPA4C7kOI+
 D9CGN0zjDtotrP7dSksHpbvUajoDA97zu66Lz1g6nOBaG8EMffVf5g3n6gpmTozSzvbZ
 ++jFye/Su1Zhruv60KoogCUhGjbwSugh55VXNm5LaMPN87Az8+97xNCi+OHGkKK2bhdf
 LtjrifJIxqF40XteEHJ64XMF3Sm3dn+DhUu2zE5QbQ6eNsJeY1JS0dPOsl0tv8/k/DvO
 Q38w==
X-Gm-Message-State: APjAAAXBBHXssC8bG4oIlBjtDo5SmVXP0vDejwyFkcusWbCzpggjABnl
 Td1Wo7wiEGJ7xkWpBs2NBR8=
X-Google-Smtp-Source: APXvYqwE2C7oaOtRtmT8t2Z8lATUvZSej/eQ/Z51Mp1OstlAFQOhFD07S4XgepHERL72YIfHU80nPg==
X-Received: by 2002:a05:6808:7c8:: with SMTP id
 f8mr615332oij.118.1567538150702; 
 Tue, 03 Sep 2019 12:15:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id 36sm94811ott.66.2019.09.03.12.15.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Sep 2019 12:15:49 -0700 (PDT)
Subject: Re: [PATCH 3/4] nvme-tcp: introduce nvme_tcp_complete_rq callback
To: Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
 axboe@kernel.dk, martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
 keith.busch@intel.com, hch@lst.de
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
 <1567523655-23989-3-git-send-email-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c5757c95-2a4f-410d-a275-85d8c9da737f@grimberg.me>
Date: Tue, 3 Sep 2019 12:15:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567523655-23989-3-git-send-email-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_121551_714961_029DA369 
X-CRM114-Status: GOOD (  10.19  )
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
Cc: shlomin@mellanox.com, israelr@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> The nvme_cleanup_cmd function should be called to avoid resource leakage
> (it's the opposite to nvme_setup_cmd). Fix the error flow during command
> submission and also fix the missing call in command completion.

Is it always called with nvme_complete_rq? Why not just put it there?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
