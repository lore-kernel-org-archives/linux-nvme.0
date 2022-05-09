Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8314CC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  9 May 2022 12:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ar2Vj24oKrFskuk8K65yXVdl6lIbOLvc0eVWOcD6t+c=; b=JHUdk4qHCPoNSKYXVDWnFR7TJQ
	SP+d25M0WEVxdHtBXaX7jNcX99kTWkxH/OKJVvEnxp6+y8/Bh18W/3weR/kfPXWl45/VIviCW9UZM
	ryDfMgZL/V5vyZUrLDJgCrx74uWD+raUcBB1SHNF4ZaAcMdglxYvcYcdd1B0Ljhq0gxsIWtX/EZo6
	Jl35Paxg0XMYSekhn015Ev58x8yj6IBaDQO7pGivxhPkBa512cjg7PgKZfs8m5sUGL7LDyyMzeU7t
	j++Yc/3UEJcCWCKL2PHvGN0H871miAucJKrhQsKl6d7SaUwhh5sZGZkzs5QxiZZFGZNCie1RcvBAS
	dhRpcsPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1no2li-00ERqr-32; Mon, 09 May 2022 12:45:42 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1no2le-00ERoC-Cc
 for linux-nvme@lists.infradead.org; Mon, 09 May 2022 12:45:40 +0000
Received: by mail-pj1-x102e.google.com with SMTP id
 w17-20020a17090a529100b001db302efed6so12687668pjh.4
 for <linux-nvme@lists.infradead.org>; Mon, 09 May 2022 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ar2Vj24oKrFskuk8K65yXVdl6lIbOLvc0eVWOcD6t+c=;
 b=nnWuCyCgeU00gREk1DyCY05rHLgGLZ/rT9oZPgiZAo7Q+lB+LRyfUfW3eOYoImFpnY
 5HDPar0WbvEBHKvkHcZ0JGwuSrCRY1XkNLunyMFXBal2ElodsHTcSYkc8hsOZE6CBz/p
 KnXlRxU2KL5Lw/Sg+bXWAqqrGHBT2l8pq1x7g5pHKBK9TiHMcC10yt8N3Jm7WeaFGvEV
 0A/ptu7xszFMVk8w3PmZxtdUVwRKvEmfIUjmc8PuUg05uQ3Pa+W8eKWepaZMz0k+IJM5
 +Yo28iIe5NMhW5SFxZ+JE4hWWTT39sa89nUB+SjTmYSW0S5VNlpMbGkIgiNvgTNpQh3q
 KNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ar2Vj24oKrFskuk8K65yXVdl6lIbOLvc0eVWOcD6t+c=;
 b=mCt9s2oNwRYhhMp/Kg74vu7fDo1q4pGr8c7i+byxPDkfBj6CzLCCoA3TfGHf/JcYFZ
 cgXA6FqvogqoT3ZqHDGNyznQc3AaO/GH2NhIUrBmpGFjh7MRprRW38p6blanE/1JTqte
 DoX2vV6K1PXnWIsg2fR5ox8I00h1eGqNZiIX1Qpr8Z18oAshxxx9tac6fzVuEAAMAv5P
 IT0Cv4oUz3myCeCh0bJp5bLfWmag3P7cXMlcd6FRogrAp+sqyLYPuFCGNavVQVv+NnxP
 C3/JsNtq9C3nASvJ/TUZ3kGK+jwySI5XifSSkoIISyyBqdpW3c8haPURkEVlCqtSvhms
 Y+Dw==
X-Gm-Message-State: AOAM530Jm3UvDciCJdPt4loeBbLohqSb2pirIFSNHqrQY/pEpkp2CFiY
 jX9I8YGGwuaNgqusRJu9U9Qv3Q==
X-Google-Smtp-Source: ABdhPJzC+TQUxUOojLESFYPuEi0T3KKewg2ciEREu5Jl/wvbgjtQHHIfnvoI9tdvGUfpFXsF1oS6sQ==
X-Received: by 2002:a17:902:ec8a:b0:15e:967b:f928 with SMTP id
 x10-20020a170902ec8a00b0015e967bf928mr16511860plg.133.1652100334928; 
 Mon, 09 May 2022 05:45:34 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a656243000000b003c14af5062asm8398023pgv.66.2022.05.09.05.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 May 2022 05:45:34 -0700 (PDT)
Message-ID: <9d51e5fc-6ab1-84e0-9956-8a084e0d2110@bytedance.com>
Date: Mon, 9 May 2022 20:41:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/3] nvme: enable smart AEN
Content-Language: en-US
To: kbusch@kernel.org, hch@lst.de
Cc: sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220507065026.260306-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_054538_703859_E8BF1C51 
X-CRM114-Status: GOOD (  11.63  )
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

Hi,

Sorry, I misunderstand OAES[7:0], only the first patch "nvme: introduce 
bit 5 of smart critical warning" is available.

On 5/7/22 14:50, zhenwei pi wrote:
> Hi,
> 
> There are several changes in this series:
> - Add missing NVME_SMART_CRIT_PMR_UNRELIABLE enum type.
> - Add missing NVME_AEN_CFG_SMART_CRIT_* enum types.
> - Enable smart AEN.
> 
> zhenwei pi (3):
>    nvme: introduce bit 5 of smart critical warning
>    nvme: introduce smart bits of aen cfg
>    nvme: enable smart AEN
> 
>   drivers/nvme/host/core.c |  6 +++++-
>   include/linux/nvme.h     | 20 ++++++++++++++++----
>   2 files changed, 21 insertions(+), 5 deletions(-)
> 

-- 
zhenwei pi

