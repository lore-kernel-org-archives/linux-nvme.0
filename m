Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C38C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 22:19:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A19960FEF
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 22:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A19960FEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8YMDAB/MkxVHGs8EJxiIq8NJp1FNDaJwHm80UrADORo=; b=jG50MF7hkzL1z/ABgKvFkrAz1
	r0v2kcVwocguyikGxDfPgPzXQZ0mNdBnzX4003hfQZV3I0uMNCDBbds9/kNE2NEVZoK4loPSRl6ym
	0Ho/WwBh/XNTyQKbUkGQ/OWlFXkbmeFQeTTrkNNPog28CZvMNMWSucf/8xgnPbsbACM+29iUyZVWZ
	/gQ08FE1AzDBmzHZLNi2Dr/HF0il3gRZAW+Qplqw49HVWUjmwmP0FzXk5ZKvUzyuj1JbtOV7l/z7L
	m6u4lfNSul/7c33QHWtRLZmYbxoaCyKgCYFwgL+iFhDLuTaIaC62enexa8PfNQoLKE+GrI9XCSjaW
	ZNScR5WDQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRjAq-007qCC-Ts; Wed, 31 Mar 2021 22:18:53 +0000
Received: from mail-qt1-f171.google.com ([209.85.160.171])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRjAl-007qBb-Ff
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 22:18:50 +0000
Received: by mail-qt1-f171.google.com with SMTP id h7so152260qtx.3
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 15:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=42GNiTs6u9/3h9NB0nsmMf2dhowOKz9ZqnpAgcs+X1A=;
 b=eWai4yBvnGFuuLTN9AqiA/jMGpfpq6gqQ685DGIhyzihEzFuJ4Z0ibElOrvwMTYvK7
 tJcJsQ2uC+FswCPZlgC5BAoLtG1Nk1ywWN7p0UrSvcQalKAiaSjg5eaEwq6MN7HiAjuL
 14iMzfJWB/TuLx2GBOGgBDtUZwuGaAyvAPMxbrDzXdpaxA376gdEueTlng+0rSpDqxoR
 06QAWsoG7wcDkJH+8Ys8wh2cZX0P0D/PsUiO5TKLhhmz+FVcT1oGSd8fcF8u/Qu8ZFY9
 RomS2uSLn9kLQ4+SlRxPhOj5NHBZ9OxG26FIA16F7UH7KK1Avx8+wj9giQSDYnPYh8rA
 jYIQ==
X-Gm-Message-State: AOAM530S0XHba6tHg8ksnI6dpOjgsMT3V9DunfH7Qecfju9orw61kkN/
 cz+AlcJ3+S3CszXHorcvn0fYqqAAM6c=
X-Google-Smtp-Source: ABdhPJzbVxnSV5Df6cHgAnUG0sveWTuyJ83d+JwCG8ZUBvkGJWZXxLQpRtakPjv1lai4oUfRHLD9Yw==
X-Received: by 2002:ac8:678f:: with SMTP id b15mr4611676qtp.262.1617229125307; 
 Wed, 31 Mar 2021 15:18:45 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:6302:5415:8f3:c3fc?
 ([2600:1700:65a0:78e0:6302:5415:8f3:c3fc])
 by smtp.gmail.com with ESMTPSA id c7sm2281379qtv.48.2021.03.31.15.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Mar 2021 15:18:44 -0700 (PDT)
Subject: Re: [PATCH V5] nvmet-tcp: enable optional queue idle period tracking
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR11MB28695D512EFF1D501BF407F2E57C9@BYAPR11MB2869.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <770584b5-848c-6fd8-e3ae-83cfada66451@grimberg.me>
Date: Wed, 31 Mar 2021 15:18:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB28695D512EFF1D501BF407F2E57C9@BYAPR11MB2869.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_231847_702967_99CF3DA1 
X-CRM114-Status: UNSURE (   7.63  )
X-CRM114-Notice: Please train this message.
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

This looks good now Mark,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
