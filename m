Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304F7C77B7A
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 08:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rVptRixy6L9P37vVq6OCzJyhOYl45tI50f6hMUioApE=; b=VQsJ758lKBYovg/J25vcOuH+5g
	OJ1c/VRQv2PqG4/nWS9KDRWKbX2IfvHNsFtTRrTQdwbxYRgUtCordUtOyOLa3uqbGUcNbI0GXY3HC
	xituV/w3/64Mt/sml+qaR3QcTuC0mFglqRB+xD9tF7gG0DPKuAAEW7GOhbgpIGvuSK/gKKioYtk5f
	hANlPIW9HtL77sixBvVQbgietWgIfrq0VsotfBmrOyhO8sEaQ4iJYsSeGX46PFQf5nqelYPccWvBU
	KCV52JzbFh3s08XA4GE/rya810jykocYtUbPaC1PXEnoKAOX3YStXKB/exG5vlgwpJCmixJlYMKSy
	XV+L5lBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzZNV-00COT2-29;
	Thu, 18 May 2023 08:52:53 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzZNS-00CORp-2b
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 08:52:52 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f42b429290so2318555e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 01:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684399968; x=1686991968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVptRixy6L9P37vVq6OCzJyhOYl45tI50f6hMUioApE=;
        b=YcsbA12MNjlBcekiig7oIvmn3ikjbxx6IN9I8Z9PE73ZL95hgdxsoqm6zZBOTLxWIv
         a/0wH1A4oTzDRG5qSqxLnJayCqOY3dQAXMnOiB8Fe2Jip9WGyR9gpYO0e7gbv4gMY8Po
         mR38O0fxLQB2rRHzLkd0ptcH7yii4ZJx8kVrU4jzUIHeNalrwsKbpQZLtdohiouu33eG
         DhulZu0mMHlwzmRbYr2FrWEqBAepRGFulUN7xkgPzUVdpkg0OwWF4CJ0LuteBpXJwNqS
         2G4BpScc06K/nxKo296zjDV0OFJwHkUSmjFJOWVwLxWXhIlTLPnmtHx3Zf7F1G7wTu+t
         4z3g==
X-Gm-Message-State: AC+VfDxn2vfcNGQBAcEhi8WkpWR0iFY4LiRmF3nVAucK+bydWXNkr/aD
	Eza0fQYf6vsO3SOJCsr6ylw=
X-Google-Smtp-Source: ACHHUZ7mwKo4PPHyk0BYmII5AOGceWDTpSY5iYGWVfwXfD0Zm+btIBXQD79J6LvihGF/69UHEvIz5w==
X-Received: by 2002:a05:600c:3b0e:b0:3f4:26ce:e7be with SMTP id m14-20020a05600c3b0e00b003f426cee7bemr4751364wms.3.1684399967943;
        Thu, 18 May 2023 01:52:47 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y20-20020a05600c365400b003f42bb3a5adsm4737999wmq.4.2023.05.18.01.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 01:52:47 -0700 (PDT)
Message-ID: <d8eb1af6-9845-2520-48cc-9c70a7d23689@grimberg.me>
Date: Thu, 18 May 2023 11:52:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] nvme: check IO start time when deciding to defer
 KA
Content-Language: en-US
To: Uday Shankar <ushankar@purestorage.com>,
 Costa Sapuntzakis <costa@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@fb.com>
Cc: linux-nvme@lists.infradead.org
References: <20230424232225.1975793-1-ushankar@purestorage.com>
 <20230424232225.1975793-3-ushankar@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230424232225.1975793-3-ushankar@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_015250_846424_E9445CE2 
X-CRM114-Status: UNSURE (   6.57  )
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

This makes sense to me.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

