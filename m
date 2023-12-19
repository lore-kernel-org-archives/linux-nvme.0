Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5811CC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=fWCQ+pUzxodCLHt40k/nPRHc4B
	2Hin6ascAtftun5fmvPfcFCcnYmQyqR5Z/HhOD21kezJtHfdBfQUtmyC22bud4yo3nyQ7jK9S7SXv
	BvwUt/Qe8FN2DWulaYdfJ1kObtTwibuzTUBT3d/r92XYO08oR0h7HHnRbekCvsr7XJYm1WtQOg3iO
	JVkLmbvqkpf2cQo4TltfyUkHr2RtGEDoa5gLpkIAj8DOCISbDMR/wPgvoawV/Ft/1uYAJU5xGnhxR
	a6PLoAQuR/hOblp9BtYxv9xQf+0SsT5PuJKw2DosTN3GAHWv+RHaaejteYEaCxWJAXR3O1dK7lu8W
	ckqOkVjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFgrq-00FQkr-2h;
	Tue, 19 Dec 2023 20:39:06 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFgrn-00FQkX-1p
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 20:39:05 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c317ba572so11984665e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 12:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703018342; x=1703623142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=aiMnKNXZhVSCZ11TopBlOYOsrzcQFNtPGLXgRmyZJIenw0z6Tzg914FtgqBu4+r9V3
         Y5zZ3q3yQkPAp95H9s/ldpHXxfPxtqJ8Cdyf79W/U850kEw3ZoEpBxgdfMove5HzIoY/
         mDAblbSYHdtTVJMVaIzqwznqul6lgDJEggZsYPu5hpdYDSlOCq5BWI3JdECV6nl6pTWQ
         jjDyT0xkCMAqY9+o/NJdsN3GBWgd16SiVnG5Yqj4LmniCFMfPlGuyyo8qyDRte7Ws+RM
         tVrsd4QOivLDPovw+Dj5gcapaQgJjcTg/H+EFLceatYlsHIvQAFWGGK+Yn2ew8Cw+mEr
         04IQ==
X-Gm-Message-State: AOJu0Yx2Z61z0XMFMEF0TOl25LnUFjPf1kLltlBc+xIzPXWCG5GAUC70
	wXeOyf5PgrkcaLr+Lwamrrc=
X-Google-Smtp-Source: AGHT+IFBQXBGOulkjU0NEcwezhrMJ3St63sa9/oM7uJXucfSzblCjDmWCEqBZm+Liuj5EvxIaVYlfg==
X-Received: by 2002:a05:600c:1d25:b0:40d:347c:67eb with SMTP id l37-20020a05600c1d2500b0040d347c67ebmr37616wms.1.1703018341652;
        Tue, 19 Dec 2023 12:39:01 -0800 (PST)
Received: from [10.100.102.67] (46-117-87-214.bb.netvision.net.il. [46.117.87.214])
        by smtp.gmail.com with ESMTPSA id bh20-20020a05600c3d1400b0040d15dcb77asm4472443wmb.23.2023.12.19.12.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 12:39:00 -0800 (PST)
Message-ID: <e9bd8248-35fc-4687-a09a-0dff94f8328c@grimberg.me>
Date: Tue, 19 Dec 2023 22:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] nvme-pci: fix sleeping function called from interrupt
 context
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: axboe@kernel.dk, linux-nvme@lists.infradead.org
References: <20231219164823.442687-1-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231219164823.442687-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_123904_102306_2E794229 
X-CRM114-Status: UNSURE (   5.15  )
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

