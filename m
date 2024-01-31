Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3820AC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 12:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=kErb5Fm08V0Fran00K3JchfVmr
	5nx6ejVMCdLFEhQ67VLXvPENfDN0X9Ah8V2arq/JQ6hJDdvwN6UTf2vIyBNXFfAqjyGdQE6KrnIx3
	JkBA8AtiwMYUKmcDXEBbE6IZUrk2xZRyoiv/2mtb64qLz0j1a1MI09bJ6/0AwhE8fqBKCg2KobeNF
	ea9d0Ggj8+v2lSRcpMT4P+b7jLY3w/nsn/SUExw/3rY5Nw/sbJSv5AxQ8RVlIZqrC+z0OnSdXNcLv
	dc8IvnYq9+S4y9LyntL3wvK4giKs28zm6YHtRdvFbhsjFOehrQQru7KDa94lPpIJ0xpnKbaCLxIhy
	VaZgVaPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAC5-00000003TQh-3iCy;
	Wed, 31 Jan 2024 12:59:57 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAC2-00000003TNz-37TD
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 12:59:55 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ef107b38aso7400505e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 04:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705993; x=1707310793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=oD+8lfpU7M0R+4yN328BrbCZWGSCsS85HprkJlKd23VSFjGxm7vlLwkSd1lMkiOv+h
         v47eNcTSt7nF2XSXVdpMMOCHUHI6HiZhiZx6zeY/pGk80RcOmkgd0wOkCgS3x2JgHWUi
         kFGlGpuQH5FPH+NZbRWIdPC692Te/yAkKTvF974EeWafX/pCKaI3Eaz8HZF+EATcnqy3
         CGduDWnojCw9Q8EzUxrbJDIkrwMjy9k9RB5rFh5NCvifHBZEqmV8SlAHzzCBcQJNkS68
         a1xxWozgavxofXoxXw/uI3xEb81Gl19Zg65pPL6YCZ2dJ/aFB2MIGGgzP9byg57HGyWe
         lXlw==
X-Gm-Message-State: AOJu0YwhIAKU5b6irC8rS1gujoQd5i4i4aB2OOOUpCPnM994bnXRuV7J
	37F0n1nh/pY3NE+0fdB8A2NDeQOAv4nWnvsp2uVVvMdDjJiBayTXudk+GZAL
X-Google-Smtp-Source: AGHT+IHd/NwriKTxsqXMIzha4VUjlC+9RSzynL8X9FnqIlCochAU8dxI0aJMPkev7jfROlVRXGoVUA==
X-Received: by 2002:a05:600c:1e12:b0:40e:e9dd:c290 with SMTP id ay18-20020a05600c1e1200b0040ee9ddc290mr1306468wmb.0.1706705993239;
        Wed, 31 Jan 2024 04:59:53 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c2d0300b0040fb0c84c64sm1510879wmf.14.2024.01.31.04.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:59:53 -0800 (PST)
Message-ID: <ba9a8232-ee09-4944-ad17-a4ca075ea2c6@grimberg.me>
Date: Wed, 31 Jan 2024 14:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nvme: parse dsm command's attr deallocate when
 tracing
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20240131091222.116190-1-kanie@linux.alibaba.com>
 <20240131091222.116190-3-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240131091222.116190-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_045954_799539_ECC2974C 
X-CRM114-Status: UNSURE (   4.68  )
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

