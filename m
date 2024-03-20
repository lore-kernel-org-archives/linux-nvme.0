Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BCAC54E58
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 23:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mHhsJer1V/VYw6SPKO3Y+a8waXFK3lTb90rfObcGGlw=; b=Ro+s/YErNyNO6G2jyIhvK5rdyC
	qGtnpfKqOd+AY+CfiIu/Lmbq0u2cki6COP/SJuhbea9N9a/5S51jOhv7SyhLinq8YAz/6ENlvCiHs
	KIlPOiDWYLMyBJWR2Gq0s1mEnsQHwHzNeYkeB4g11wylJucbH7b4Z+jADsVEsI312IFmxUBvqJgwY
	JxQjn6ZcJ1xPNl4jvjRuUxf7UwnyfRbbsDP7VCWp6dh2IVKWGCqsPD9KjGXp/0URFfHF0kKvke8RA
	453syQJZ5UjtImp20EDfRq540NMjBE+fFVfs4tmTTd3/ehp3yTdeJlsG6Y9ItIWmbOLMt86yC1Ila
	ujbupiAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn52V-00000001DDZ-2au3;
	Wed, 20 Mar 2024 23:08:07 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn52R-00000001DCs-2mWO
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 23:08:05 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4140fafc27eso844345e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 20 Mar 2024 16:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710976081; x=1711580881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHhsJer1V/VYw6SPKO3Y+a8waXFK3lTb90rfObcGGlw=;
        b=Erte+XNS7y/PdyKPgwQtPsxETStifXREKyzYUaEnel0BF+tjxWI+0tWHMSJfyn+o8c
         t1w3tbvJN1D206CpMmvnc+rtEaALKxUly+iI3jKPkHDjUli0bUy/wuBictZ6viU0R6T5
         YGa3asXUEMwyECsw4dM7HiwJ+pwVrPiQRz5g4kOwlj1mBVs4VY5pw+kdDAEBzzmmg++Q
         KAdNOGQTk4Y/PoawEIhxb69eTANiuLx+JrblwFxfM/HEbd6qzVx7uUW/GMc6v07nimUv
         v5Oxum5njVHbxmgpiU9PbKkm3jaFom/tia+k+6EukK6JeXYXOvbMbHRJAPMEIDaImHUU
         AWwg==
X-Forwarded-Encrypted: i=1; AJvYcCWN2w0b7b1WvgK+GPPkTMZSw64C/kqW9x7Px1K9hd+CUN2l9Z9MYkosq2s+d3ZdOmbuJGeift3ZRQAEE1w99YEzENrxTgA5Rnhx3u1apGE=
X-Gm-Message-State: AOJu0YwFWb+1sSxWEROoY9+drK3HfBRLccKNDlObHUJ2xej7AuHzhqLs
	r+//I7Qj2V5Xd2BPYdW/hzVzXX1walaE7Q/FR1V7UjvtEA1LYF6bl7kd3J18
X-Google-Smtp-Source: AGHT+IEUqtzd/BaUT8YfxuenR/NsUrNY+//PT8gpK5Q0wKfWpQQkdeJpzCfYJU1A/ggVzaJKMEPfJg==
X-Received: by 2002:a05:6000:e89:b0:33e:c97c:a24 with SMTP id dz9-20020a0560000e8900b0033ec97c0a24mr4829618wrb.5.1710976080825;
        Wed, 20 Mar 2024 16:08:00 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id co14-20020a0560000a0e00b0033e052be14fsm2689149wrb.98.2024.03.20.16.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 16:07:59 -0700 (PDT)
Message-ID: <eeba8428-e5d1-49ff-914c-cfdf7fd18750@grimberg.me>
Date: Thu, 21 Mar 2024 01:07:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/7] nvmet: debugfs support
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
References: <20240320144017.106283-1-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240320144017.106283-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_160803_733816_EF94F598 
X-CRM114-Status: UNSURE (   7.99  )
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



On 20/03/2024 16:40, Hannes Reinecke wrote:
> Hi all,
>
> taking up the original patchset for nvmet debugfs
> I've improved upon that submission by modifying
> the layout:
>
> /dev/kernel/debug/nvmet
>    <subsysnqn>
>      ctrl<cntlid>
>        port
>        state
>        hostnqn
>        kato
>        queue<qnum>
>          host_traddr

Why is host_traddr per queue?

