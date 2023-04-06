Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839E9C7618D
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bqh19fkOr0pi7dX65UY+GAAk6xTRxBZRTJ5c5VySkMM=; b=g4NUCMZhCiCQl5t3S1txhD51Lf
	+5EviZOVAmaGI+VZj5q015QS5soNAtVC4CvUUZHenD9voW6zz6hBCTB+oJX31chCU7wcYclMCia42
	wA95I/XS/a/1WJ3X055mnHzGBsSeeEbC9x9NfPjt6XEHdYh7SjK8U1vGEyHFJqPd2Tp495byJ9pKt
	MJjiWGz/PmDfYuiJPZ0yKV4H/G4oIcsKi/bmBNaNNuZgrsl7fSFR5FiharWJkRC1eyhFGOdmRGzpD
	6GFRZVcPN0LqGkh0k0wOkmhlU6gSj+GhBz9c+dXvyRGxf/v01LM/oa/I8npIpn16qOiORDNBr46pM
	+J/j74KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkQMF-007Xps-0f;
	Thu, 06 Apr 2023 14:12:59 +0000
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkQMC-007XoF-1Q
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 14:12:58 +0000
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-325ac3266a1so263295ab.0
        for <linux-nvme@lists.infradead.org>; Thu, 06 Apr 2023 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680790374;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bqh19fkOr0pi7dX65UY+GAAk6xTRxBZRTJ5c5VySkMM=;
        b=cIpruUuxWqhYJ5N7xSwL0s9breWS1dch+YX9FYKKx9Q9tNVGRtAHiIY1VPGll8X+35
         dVBwLSkSnWBLU0te63OGQ+n2BBPw+x39v8+UaMt2AlfQIFWD08Z9j1DDWuWvc0flJAML
         ubswh+oGaO7G4nP8vJmMDDDsTTGdLIoSrwqklaSbNbTY97c+AuaouR12Tp7LRk2nJcwc
         eE7cV9pmJ1v9Pt8btJk0DEE18+QPV0vlZxafnc5OxLGtcFFsXISktmcYi2DDruskYMAz
         NB62Ba+JNB/1TIIV6HLdxLFshTCcaSaddlbeJpORqkRD8fPrzJKCQ13pMAShN+QViqVY
         P4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790374;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqh19fkOr0pi7dX65UY+GAAk6xTRxBZRTJ5c5VySkMM=;
        b=wqdi28azpBbkAjKAovqwxrVVtg7Ql0xYa9AoDAn/Is/DmmL8JUnBMjLjiVEiMFohhC
         07raYlhhrDjNXOLj31CzTaRfISEvsjVqlDyqLYxnpRfUIAiw4sEhovKfbrA/ZHQtNtto
         NkXmg3ilAHoFCf9DGG0UR5/TOOf8u0jVIF2j3gBEQr9igNHBxbLHQVjAg8kVgM5WEmKy
         jE9FD6t/SBFlGMCzTm4UINlx453Lnvnw8S6SSrSf2n0ksCux0t3ZkV2vzdYcPMk9UNCW
         vYBe+Iu/3KMoxOX6tzuZrCNN+91tFGSQMQAw67gHUQifzcD2+OVlOF79xmnbeJdVAUFN
         cbwQ==
X-Gm-Message-State: AAQBX9d65aSE2Nbta6h0P6KqB/BP+kowsABY+oYHbVONpotfpy8G9Zi8
	nqvXlrzJ0I18yb2cLfGt99RZUhGPXpk2fF6+9GP55g==
X-Google-Smtp-Source: AKy350YoLHhKBysGu8vXUaqghH7yrxoog5J1+Qw5ElQjnE8a0scXGNxxVNcHyB66T7XnGcyQDYykHw==
X-Received: by 2002:a05:6602:2d11:b0:75c:f48c:2075 with SMTP id c17-20020a0566022d1100b0075cf48c2075mr4232485iow.2.1680790374294;
        Thu, 06 Apr 2023 07:12:54 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 62-20020a021d41000000b004051ff71eacsm402443jaj.144.2023.04.06.07.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 07:12:53 -0700 (PDT)
Message-ID: <e9c66380-40f4-9ed0-4cf6-8de0c8b5f26d@kernel.dk>
Date: Thu, 6 Apr 2023 08:12:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] nvme fix for Linux 6.3
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <ZC7PkTumUFAzsKNJ@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZC7PkTumUFAzsKNJ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_071256_478894_F002A9DB 
X-CRM114-Status: GOOD (  11.57  )
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

On 4/6/23 7:56 AM, Christoph Hellwig wrote:
> The following changes since commit 38a8c4d1d45006841f0643f4cb29b5e50758837c:
> 
>   blk-mq: directly poll requests (2023-04-04 16:11:47 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2023-04-06
> 
> for you to fetch changes up to d3205ab75e99a47539ec91ef85ba488f4ddfeaa9:
> 
>   nvme: fix discard support without oncs (2023-04-05 17:13:17 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.3
> 
>  - fix discard support without oncs (Keith Busch)

Pulled, thanks.

-- 
Jens Axboe



