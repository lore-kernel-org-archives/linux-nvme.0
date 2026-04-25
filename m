Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F9FFF8860
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Apr 2026 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PQ1Sei6vl930U/ELSkImxPuDkDOS+Ar8SnFflI1qpUM=; b=dgEjk48AvbKO4qYDy8f1unRMqZ
	SIdA5swX0PXHKSxDYO4S0QtgiYIZfyMDV+71XOb4oygVkiiWNAuVNUNOURaLjIGX5j3znkz0nM6JC
	xcMkOpOZw9H0TplerTa5inf86wWpBofzBQ4UVtzxHFlZnv6U66c4k3GfM+chJ/SdMyXfg3n+XT2fv
	045as9cO1H30oI+TK8pMIKGWKkWq1WZHC3kL0+pC+Ckfu6uqLZAveqmersgG6GbQox/xwBW1qgVXp
	6V1LtNVSZFf5EEpOiZ8URuf5e0qX/yGJtTuB68LZ+yLewIDL6qzZhfdJFubZSlt0cTexmPHAlW9Og
	Bw5nS75g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGcrs-0000000ETFa-2cnK;
	Sat, 25 Apr 2026 13:16:20 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGcrm-0000000ETFG-2JgB
	for linux-nvme@lists.infradead.org;
	Sat, 25 Apr 2026 13:16:15 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-82f6b592fc7so3974756b3a.3
        for <linux-nvme@lists.infradead.org>; Sat, 25 Apr 2026 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777122973; x=1777727773; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQ1Sei6vl930U/ELSkImxPuDkDOS+Ar8SnFflI1qpUM=;
        b=OVtQyzfcSgLGC47hBSnSdpbV+wh0MEYKu5pK7roLKiXAPJ3t7uPWxACm1GKUWWd1iL
         GEHVqkAfhjkrOc4QncJh73aY5RViDCcd/XcsuiIQfrBB0LHw3DTiSBCh7zQkyCX2hkqq
         hUshHt5Xfyzpat6pYL+FJfP6kfeR4inR/AkHIK9DuWMs1y0rrJhu/CqlF+2+HhsFPqnR
         BRWZvmJEChQIXksY987mbsIzGfKM5G8bAv6PKA0GFrkm9enSvo4rc6WF9QeDV9Og8suK
         /8TZP+eeE/dbr4xBokaCGZYOQrLflhEXhMRu/48/q32lMsPTLyeCH50/D38WnqKA4vW3
         GUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777122973; x=1777727773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQ1Sei6vl930U/ELSkImxPuDkDOS+Ar8SnFflI1qpUM=;
        b=ZlwzgGOmYZYNruZ7qorewkxFV18DYkV8FAZfJlhvjDnriQjAibsPzp8SeGhKhL2rb7
         rjwEvpHc7Rol1WenUmaTJDQfNwVxjBs3Zw43TarbPrN3DASPvAoeAcPcooDAOQN97EAn
         egm7IVW0LllO+lj6762XZoL1Sy79SUoRDFBpXaFEReRwXez0DVPlj0lqfUMXJISZVA9I
         iHmAgTpTi0lveQaPdooLhYhvi+Up4Jy56js49/qMfDqlYZUUlIWme/a6TyYf/cBuCceE
         pBrUY1DbePvdvxdNqXRuw70fv4l2rmS/jq86BKjOBo9AeRFISN0FGF6Zao2TnrWPDifI
         IZDg==
X-Gm-Message-State: AOJu0Yx7JJUtR/jFyNtUn4SMhftQS5NTVN7eHUv2MQN4K4LcbEsF+2Bc
	860bjNhOprIuyh/uqS/TcXZPVCRMT6KFKh7i2Lbnro4y1oLXwf26CSFAeyHrxw==
X-Gm-Gg: AeBDiet3fWShLa7x9acEwXwsO3Cj7jkAJktQZmNy4eZAHcBuW1GLxG9QxyNt0iLhg1C
	uGA4jK7cmzOPLK3c2BSgshcKkKxfjzmljfCK5lmjQ/s6C4pqyAO/YpyjSjYsH0Oj1xLkROSHwPu
	hPOruo7+0qVsLYNJJ+L2w4YMyVYTAs7CPeRpiy9+b1NSyfTLNmOzooLaopmYgVKFb3NsQXWVAC1
	cZdcIdPbD2C3mNjOeeIQVA4Fl8C/RQi9OnmeQugmcOMgH0D9NqZ3z5bCOGDxiKdcVSlSrdo8fQq
	ZKDm7nmb4hwjaN7LqRWK2QE7UavK2tuWtpw3mckYrjaHdO5BKve+d4IVZbACzIzriU0DyhmHpsI
	cNZ+PDNOzPPbv3nWRWeO1zgbuug/F5Q6RlMzB8KzZgoqAb826x0K6d0CIiqprgc26XKmGjwkd/n
	gGMb3pXl/WmY1xEqyfPvs8KSxT4KJj8odSlAy/qXTZ1ZhrgPdwm9vVaAC7QczgSwuBylVoFWd/v
	/bdlJQ=
X-Received: by 2002:a05:6a00:27a8:b0:82f:18fa:1668 with SMTP id d2e1a72fcca58-82f8c91e3cbmr35482805b3a.44.1777122973607;
        Sat, 25 Apr 2026 06:16:13 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:6ec6:dcf2:7610:e61d? ([240b:10:2720:5500:6ec6:dcf2:7610:e61d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3fa2sm26684220b3a.29.2026.04.25.06.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 06:16:13 -0700 (PDT)
Message-ID: <9d96e920-e52c-4946-ba40-332bae38d7db@gmail.com>
Date: Sat, 25 Apr 2026 22:16:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme: initialize known effects to set ns_mgmt NCC
 and ns_attach NIC
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
References: <20260422141159.10881-1-ikegami.t@gmail.com>
 <20260422141159.10881-3-ikegami.t@gmail.com> <aem0x5CsghH7HoWd@infradead.org>
 <7af729f6-25e7-483a-9a5e-770d6c6e6805@gmail.com>
 <aetx7GZeKBoRCPS3@infradead.org>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <aetx7GZeKBoRCPS3@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260425_061614_597523_E805844C 
X-CRM114-Status: GOOD (  10.86  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2026/04/24 22:36, Christoph Hellwig wrote:
> Please document this very clearly in the commit message, and maybe also
> in code comments.
Just send v3 patches fixed for the comment. Thank you.
> I don't really understand how this is related.
Actually not related this to the nvme-cli issue as a result.
(The issue was failed ns_attach on the test.
Then at first seemed caused by the ns_attach delay from the test log for me.
Also from the nvme driver implementation investigation looked the 
scan_work is possible to be delayed.
But the issue caused was found as the failure caused by the test 
environment configuration.
So the issue resolved for now but still the scan_work is possible to be 
delay I think.)


