Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC38C63697
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 03:53:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE9A21741
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 03:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YosPxDoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE9A21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iANQk/oTVevWyxRUVP61JE/c/WO67vTjMWzql/fd1Us=; b=YosPxDoCL0C8kE5UswCKsAETC
	gy8g3Ufo2a9/ygDO/R8IhNa80MNwPlmKOxD1r/0QR1x5VzMw23z5xixCwETt4NeTsOebTS587/4RN
	/QJumB6XbaO5Hdyan3KwYUluGbC8nDCMLY1/FH+33riF+GItjgRrEfHoeVWGcQ/SYSQnBT2TkioIB
	ZZRCiIAgEnurgptNbXad/z0mY4fT43ORCpVxaRaZ/XMxAgvCs9TZekXTJnOUS1aHnIVpbf9y5af51
	QHi3azp5+pxkzkN3nqtmMakMgNLnIKojx6nl+/wX7Cq+Z3joQ5db0wdBJq2s+Fbx4ICihgdn6vp6x
	JDTL74u7g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki8Ll-0001Rh-Ms; Thu, 26 Nov 2020 03:53:41 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki8Lh-0001RB-O4
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 03:53:38 +0000
Received: by mail-pf1-f193.google.com with SMTP id n137so445190pfd.3
 for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2020 19:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ldTIy2CMGfYkBOWCGfd3sYGKZiM6s+iN2m8B8BP3BS8=;
 b=n3jFWtG99jlLMDzQiWLhsUOtHf2ULrjCIa/gyVjgm9egNXCWwkbL4MeX8UYyV6SFC4
 W4PEaGt7oGEiBN/ebVLPlbAW6ERoWODUowTvGJV5GJ1LMJ6Euw2WzvQphvX6Heo7cApR
 YAtwceSgmUoQuKb7yuKVGMsk0UoMD4h25e3VMIy17WHBnX+wjBQ2Y5LddbvQZn2+4GMu
 O01JiRGwC2TEeOuBEwUSPS/VnO2G9M2hAsxrSE2Uev1KiMnILUnrTOJ2vY4EIowev+vl
 FTsIy83we/ZIqRniAh83rUzG6LLyFensHJwVsO+kpRv6RpOBJjinSwthvd7Ukw3GjpJ4
 Z9wg==
X-Gm-Message-State: AOAM532TFlFMoyiwJBCa3Bosj+/Lc0mOlGFwc2AQsves2u0slv9OVi4v
 ANJaeRiIBOFTSN8m24qV8LDaurMthBs=
X-Google-Smtp-Source: ABdhPJyLA8XaNr/oTGB+7Naxqoreg0cWy9hfHrFFYWJKW+OQl8EfKOp//2Tgn8Vd8XiU+o1q//rlpw==
X-Received: by 2002:a17:90b:19d2:: with SMTP id
 nm18mr1310355pjb.159.1606362814679; 
 Wed, 25 Nov 2020 19:53:34 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id r14sm3242673pfc.121.2020.11.25.19.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2020 19:53:33 -0800 (PST)
Subject: Re: [PATCH V2 blktests 1/5] tests/srp/rc: update the ib_srpt module
 name
To: Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
References: <20201125073205.8788-1-yi.zhang@redhat.com>
 <20201125073205.8788-2-yi.zhang@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <75116622-4d05-f889-e55c-f253e67988d6@acm.org>
Date: Wed, 25 Nov 2020 19:53:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201125073205.8788-2-yi.zhang@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_225337_845687_7BF24B81 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/24/20 11:32 PM, Yi Zhang wrote:
> Fix the ib_srpt module insmod failure as the module in some distros are
> end with .xz, like bellow on fedora:
> /lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko.xz

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
