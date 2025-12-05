Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D337D2CE1A
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Dec 2025 04:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2uBkOXbqrfsRv0VxrfmsMz/SaBGIa3wJWXH+BOAan68=; b=ktFvL/BtfRmn9gaBSNZHHPD6K2
	4mmwATj31mz0Sqq99TzB5qK/L8S6PM4e46NGd3jrsVfNWLCaWV9g7iuNK7WTgxQByWFVImRd8bquB
	Du7EdiZhQp8lulUSPuKO/YqGNIF2LhNr0uaSGbWmFKkVVGAPx7jKnN9MOJhon816YKiymAr0drLfp
	iEMLPtCOGWYuL6e0WBf+unjLHh3N4O/dDck5WSDcI3mNQxfWYQgEECaa8ufi2vPR+YBsB4uJWnkMz
	6Ty1+Ix/mU2vmHZkJieFDAxxL/g1pCexsaI1cxGM7iOJGeEKR5Ze7s2ARBpAgAWtOCAoLXZ6jgFjb
	18B54jtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRMzx-00000008zzh-1cQx;
	Fri, 05 Dec 2025 04:00:49 +0000
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRMzs-00000008zz7-3C8z
	for linux-nvme@lists.infradead.org;
	Fri, 05 Dec 2025 04:00:47 +0000
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-3ec46e3c65bso1739177fac.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 Dec 2025 20:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764907241; x=1765512041; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uBkOXbqrfsRv0VxrfmsMz/SaBGIa3wJWXH+BOAan68=;
        b=dnmcRC2eMBW+UllZB/rx2/Gp/8WRFXP8wPsd9BdtJCfMw3QVMyupLxNRmC+7TDrhHB
         dyZ8IZsWRneNeJUVycnqjyBiXr59wjr3cWUAIi/tMBHT+xnRHze1WXKOfr3vUkKlso0W
         l0b917sb7KlQH/d6WUvY5qHsqPT+i2xWwEsBrC1hdL0XvgUFz/HntkVVA9+oMLhzqkig
         zNBmIWvl9Hr49ipZ3Ho5rRieLKikfsabGrU6m2ztqBtooqx8cMPH+8SHYHlegWgJGdo4
         DmA5Em8wPYI+raNu+DsqRFETJrQtcezSxyO+ZttFivnNQGa/OoGtV5JHptw6We6T3VVa
         Y96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764907241; x=1765512041;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uBkOXbqrfsRv0VxrfmsMz/SaBGIa3wJWXH+BOAan68=;
        b=ryuH5omuUc+cQAJNtnwOw6xtJAYIUYRGi6sdfmiRQ4vn9RtfWG8PCJeUsC/biBL2lH
         dOUUQhivkOjSklAU4c45a54JOwcArkohG+a22GVfTLfAWiRstMTeFJA2XE9wyvgMj4Gr
         pDqGOvewSoAYlNNjjyVp039GHzzKjfzK4y75ZKMQhzpQ2u+ixRL6SK9swZwJmxiHHZgq
         P+kzQRSQn/B4QwYGRvDN8NiTp7t4S5TPXim7CnQMB1GScq/KJG4QzfEMqDZuY/6+zTH6
         ZCgfmTXHHABVGJPMGo5eQakicEQ1v96cKUY1pV6kdWBEU/eG1pjPiewXdpaduFgwxEcQ
         5c+Q==
X-Gm-Message-State: AOJu0YwR9Z0k9DU0QyI1TQHD+KWRZNZoOsr43bRY935OnKOIBqIF8nkM
	aa4+I5alL418gaM7ftKVg/BQlzokAvmVukvkXpYpr347/wsawEsdnrii9V268duP5AM=
X-Gm-Gg: ASbGnctkqdAORKrnUIPfthfGaEQJcojhi8kl7jinkozHhk8wQnM3vc97oRUfcPdGaIZ
	Ei2eez0PlFWwgKCrOW29hWNXhf7kxq0KjrTdnHhLL2zfWyyuePqDcj6ckOG//kdKa8D8N+0mA+d
	R5IWj5fXyouz2H/ZheVO2/CQxcorhXXVzfDWTZ/snI2ly4L2sJ4t0ZMEtEy+JWF6OBqHLhO8R/E
	sztkgnYMfkZ2Y786D2yMwGq6ZfiTrLUWux2KWSFqrp9Ykwi92Z/pi9IWQ6E81jtfmwGeRldPRtM
	J6n9Q1NwJYAXU6WztfBhVFutkHlsp3mrbWLi0C80qq3LJkF1V6yh6bjkgQYHL/Ij8DUzu+Zduiq
	kQZ2zFpF1/V4qkCvlmbm2/1rwVxHL5w/ndnWRZhvVDTVkiP/+yPHJP3EozYluCpYJF+gJNVzMCM
	mO2hv05OqF9441E3A9zfI=
X-Google-Smtp-Source: AGHT+IENnvUTJdOSU7OegUDbQKQjk41vGlSI4pgfg7XHyH01F4b8XJMlgoS/gahM35eD/K8pP1SS3g==
X-Received: by 2002:a05:6870:b686:b0:3ec:e09e:454 with SMTP id 586e51a60fabf-3f1693bc2ccmr5752224fac.37.1764907241012;
        Thu, 04 Dec 2025 20:00:41 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f50b589105sm2602770fac.18.2025.12.04.20.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 20:00:40 -0800 (PST)
Message-ID: <efff834b-2dd6-44b8-916d-24bc9b266050@kernel.dk>
Date: Thu, 4 Dec 2025 21:00:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL v2] nvme updates for Linux 6.19
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <aTIQ78l7TLpOGPWA@kbusch-mbp> <aTJQslM569DYXXkJ@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <aTJQslM569DYXXkJ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_200045_047665_4DD140F4 
X-CRM114-Status: UNSURE (   8.41  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> On Thu, Dec 04, 2025 at 03:53:35PM -0700, Keith Busch wrote:
>> Resending due to missing Sign-off-by tags in the previous revision.
>>
>> The following changes since commit d211a2803551c8ffdf0b97d129388f7d9cc129b5:
>>
>>   block/rnbd: correct all kernel-doc complaints (2025-12-01 07:19:50 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.infradead.org/nvme.git tags/nvme-6.19-2025-12-04
>>
>> for you to fetch changes up to 13989207ee29c40501e719512e8dc90768325895:
>>
>>   nvme-fabrics: add ENOKEY to no retry criteria for authentication failures (2025-12-04 14:46:17 -0800)
>>
>> ----------------------------------------------------------------
>> nvme updates for Linux 6.19
>>
>>  - Subsystem usage cleanups (Max)
>>  - Endpoint device fixes (Shin'ichiro)
>>  - Debug statements (Gerd)
>>  - FC fabrics cleanups and fixes (Daniel)
>>  - Consistent alloc API usages (Israel)
>>  - Code comment updates (Chu)
>>  - Authentication retry fix (Justin)

Re-pulled, thanks.

-- 
Jens Axboe

