Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9102FC77B61
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 13:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=kZcIE526UH3mhtbtxgBzLz3MwK
	FzHIg5LIzb1LLgzVxS3e6G+KHdoF6ftYsNCh0JfQXHgCtmKtAvkVPFwakQmVoixmsniKdYPCaCXe8
	TWI8rzgpJZBPcuhfZqZZsNVYsoTze3trQ6LIgsSYE/BFmQf0CfJSWHJcF4Kk/JAp4h2k6GNhA2rxF
	AGj2Ub3LsmcihDVRgkEqjkvRk2vSRVOcoCqXxKG+fSHyF+fD8D98uiRZRKT23NIb0sWyR5lGuxiVV
	w+11MvtvFh7D3ZfQPDexXqqpaFx2GZaqpZTcd9rMk7iCtK4WYmoKsj66hnwgx7TeQadNkrmEXEurV
	EfJxsunw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptTMd-00G3mt-2h;
	Mon, 01 May 2023 13:14:47 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptTMb-00G3m7-1J
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 13:14:46 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-2ff86a12f88so81578f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 May 2023 06:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682946884; x=1685538884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fvU+AdjIUtm+mu6tAQaIr3FNtio5wrbq740/LJVGuZMaPY05KovD2mXm5g+oNVJsM6
         zUggc3ETp0FPieTjAkNIy2QkUVTUWd9HAsOnMYZu2bxm4jkBCLBrILM5rDeDSuz0d4Ce
         OgSXr36yRBGOQfr/2do2+R4oyodEkvLRgtpMzFJ07ii/4XXY653wULL8JWWLr0EZTvOE
         kcReoJ2V6ZaftZ9W2HAP+FZBZe5lKEoFmkGWBGlObBvrDre0NorsAv3YuaCjziYO9Tjw
         IsbOAQLOIbSxIjH4ETbJjPlEahYcEIacp6TR5doD6B4e4f2r8NfAtpWtSsK1oxvo4rZY
         0gLw==
X-Gm-Message-State: AC+VfDxQRVrVOiC0RKhKPUBfQXpAxPIdl/1YiBnxpT7rhNjYI/Dlfh09
	5ucgrFuDv+2JGHc47f7JF9c=
X-Google-Smtp-Source: ACHHUZ7wzrV8qejYWFqXXJMp8I5Do93otwutNBbpeFtItROaif6AJGFq6/+9s+cwUXBMLmUFcovT2Q==
X-Received: by 2002:a5d:6208:0:b0:2f7:dc6a:9468 with SMTP id y8-20020a5d6208000000b002f7dc6a9468mr7469541wru.3.1682946884187;
        Mon, 01 May 2023 06:14:44 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k7-20020adff5c7000000b00306299be5a2sm4329250wrp.72.2023.05.01.06.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 06:14:43 -0700 (PDT)
Message-ID: <b922d8b7-952e-8eee-75bd-864edccab4e9@grimberg.me>
Date: Mon, 1 May 2023 16:14:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 4/4] nvme-core: fix dev_pm_qos memleak
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de
References: <20230428073115.22987-1-kch@nvidia.com>
 <20230428073115.22987-5-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230428073115.22987-5-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_061445_440351_AAF8AECA 
X-CRM114-Status: UNSURE (   6.34  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

