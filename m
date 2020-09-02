Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBF3C433E7
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 22:02:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A0920767
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 22:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bNcUwhcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A0920767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4Xq2nse6vLUvZVka6xXM6QtSQxB+bQUQpX3qXyH4xSg=; b=bNcUwhcZ00VR1dbD1AvYnt2SK
	XGiItOx64vUChb/zCXtZZXPnEDGAqb/9AD2v2bggW/RF4OroSw4K5dXJsQMkWhpoQH29XnlgyM1of
	yT/BKA1eFjYDhfMbr6cGu0oDIgKFYmIXqv83ZqjBGExP8atfOrbMtlD1AWwBznlsFVKnxbRw35C5R
	p/J3t2Rwg/1Ly981VITrWEglBwIyD7yrxkb4p+vgNLtDlIyis2PqexxMFkFUl3sco47+KaPzwzWPn
	jjh9RErVq8Yc30uPMBJpprjTJI5vo0XSNoqhVsvg3HYunQGp/Xcybvvyj9XsklvW2YgJimODymMtL
	kHjoQ5icQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDaq9-0004mu-ER; Wed, 02 Sep 2020 22:02:49 +0000
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDaq7-0004lO-CJ
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 22:02:48 +0000
Received: by mail-pj1-f48.google.com with SMTP id s2so443489pjr.4
 for <linux-nvme@lists.infradead.org>; Wed, 02 Sep 2020 15:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oNHC9XWrRgBwMqwOj6NiwymNW3a79qMrKw0Fsqu5AH4=;
 b=XSerm8L3+IVPsEsQRZVqgfUKI6GQ28rPBto8K1eu+TvM/8+SWsJRbWMJuIrQi4RIaa
 pAUOQra7fMTwOuCnRVqgEnhjGTmj9TY0A/ph55VxdRYampknYHKlFxL7MGbqZ5ePQInj
 8WWcITpL9mwNeHt2dUHrgYQe4m2cjNMHZJB2Tdw9ONVYLjwIiJqwB6HAFFKvum3ExXDo
 6c/FyX60tU6J2A1cjq20PV9Cx1Yy07tvXn+iKs6ida61mDs8RrbaELLKH85dmresqHy8
 N1coccmiHrqi55mzERsCWDQ0MJ/SrAN+nQYEPwSGmi60luHHlXD6l95X0eQY8HxMXMlK
 jv1A==
X-Gm-Message-State: AOAM531m1MsWPIH2wDHeNI6IDgiQBbLdLnqVEwbphk1bhZQ/1RVrDMdA
 W4olGL3+oiFX+XpSMRh5NGQ=
X-Google-Smtp-Source: ABdhPJwEVY0HixMAW8Ighl91gkwapNPXtjUip/8+WWNNGYXqOAfuinK6PrVikppnBDNMRn9VqdgpuA==
X-Received: by 2002:a17:90b:408b:: with SMTP id
 jb11mr1994058pjb.164.1599084164312; 
 Wed, 02 Sep 2020 15:02:44 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4025:ed24:701e:8cf3?
 ([2601:647:4802:9070:4025:ed24:701e:8cf3])
 by smtp.gmail.com with ESMTPSA id l9sm331308pgg.29.2020.09.02.15.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 15:02:43 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: cancel async events before freeing event struct
To: David Milburn <dmilburn@redhat.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, james.smart@broadcom.com
References: <1599075985-70180-1-git-send-email-dmilburn@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <85ecb479-7087-5137-30a6-327c1fdbc1ce@grimberg.me>
Date: Wed, 2 Sep 2020 15:02:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1599075985-70180-1-git-send-email-dmilburn@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_180247_439268_A34AA10C 
X-CRM114-Status: GOOD (  11.75  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Cancel async event work in case async event has been queued
> up, and transport trys to submit event after it has been freed.

Can you split to 3 patches please?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
