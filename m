Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE68CC636CC
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Feb 2023 20:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=lyBLLJjOySpEQu7JxqGkY5pR32
	maIAYQjL7zqJHGFPanwfYDAN6gFQ/RyDSkJFPDbPlYUU1ey0Hl8pF1FjpB69vsNqj49/ZV74UtEDq
	FlU3Jlr5QjfDeS4h+R7mrzhBScd9bcYXTL5Uvh9KdEPCqFHputOG7GD2l35eAsE4EI4peknRmdliX
	ODRjP5mkviLVFCINLOY/GFGjIl2PAY3LBif4fGf6Tai1KMUXIbug5dIVFAbLhY7abs5oGSPjGMRqa
	mRrPeLbP9Myd3zFW4pegv66G5WyrRrSXGhEdipNHTT8k9TByyxwozxEy8pRCH/A9aC9/bcKkIF77P
	JxnMOZ6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSl9Z-00Bq32-4a; Thu, 16 Feb 2023 20:46:53 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSl9W-00Bq1g-B8
	for linux-nvme@lists.infradead.org; Thu, 16 Feb 2023 20:46:51 +0000
Received: by mail-wm1-f54.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so2679922wmb.5
        for <linux-nvme@lists.infradead.org>; Thu, 16 Feb 2023 12:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676580405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KWjodgOdSJNYrBtmrqzMhzhVtRS//p+otrqaHzlCCdW+yn8OhyBRW7gQM5PCyG0veq
         OnwQWbMG7XA2AhwunLWp4dxTosDdn+SHFLsHFxM3H0AQ8AzR1rvGhy2QmHfFY+Lhj+u1
         mB7DLxz9MBHVq7EJqKlFarVFSCHjZDE7k8WBYwgec6iZRUzAEjIYQG2sJLSTzLQ6Q8JE
         Rw8t6eHpv+24QFb5lA2gOtuoOoYPZaGulBoerQzo1QsVBEvVouTlyMF73YPaEMEB3EDS
         qtw8oZOtRqumUXcmyO1uU9y0Hsr/8SHgTTWlz2BQ35kcy4DT/CxSiH+FE83t354Fhfzt
         k1zA==
X-Gm-Message-State: AO0yUKXoeyKV7iVpodMkLdAKckS6ucQJCawIUf3sK3o8BNgE/pankD5h
	exiMIEthfHz2s4rUokEcBHRudWyEksk=
X-Google-Smtp-Source: AK7set/cYdOF8dkLSA822TVD/layGGEsbsDpGFhPCNRXgkBaPvl61xpinkqgJ6ATCWs6kAxkSw/ZMA==
X-Received: by 2002:a05:600c:3acd:b0:3e2:1163:b043 with SMTP id d13-20020a05600c3acd00b003e21163b043mr2481563wms.3.1676580405461;
        Thu, 16 Feb 2023 12:46:45 -0800 (PST)
Received: from [10.100.102.14] (85-250-17-149.bb.netvision.net.il. [85.250.17.149])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d52cb000000b002c54d970fd8sm2373082wrv.36.2023.02.16.12.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 12:46:44 -0800 (PST)
Message-ID: <0f6fbec7-ef41-3678-bb1f-af1700c3f482@grimberg.me>
Date: Thu, 16 Feb 2023 22:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] nvme-pci: refresh visible attrs for cmb attributes
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20230216164403.501894-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230216164403.501894-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_124650_404838_C7B55EE8 
X-CRM114-Status: UNSURE (   5.83  )
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

