Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2446FC4706F
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=GoxuGJafvdoGQRKbLMqcY2nVnM
	GMn08H3DkX8+2776VSfu4ndrgm2arRFEwHJXaGcYPGJeFnJSsWoNqqEl3s/bNkaQTrt8/sfOP16x8
	5A1HlPCOekirikXgr9Je/f2XMrBVO2wjk3G/vTep+jt54ykB4f1UhHR6eMpVx5+UTun1gd9Y80hBn
	ITIykw80emKp+h+8sSJfdNE4E2P3pw2A7ehzTpqfSNg19yjuqtqTjtnotajr5k55v3cPHNeC4rFvH
	p74Bt6H6A9aKov4qQTYzRdlt7LxMTaGxCI+/N2KJw07MPTws5xAypl8Ixe6TRQqOi/kJ9HjeV0ROo
	40hjqIMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEvH-005r3A-0B;
	Mon, 01 Jan 2024 09:49:27 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEvF-005r2n-0w
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:49:26 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d87e9151dso1925385e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704102563; x=1704707363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=plFWNzKCsCp3WxIOUDTBr11fjr0wv6TkoZa5Yz7cHDFneziL6apnfWBr3VRND6MCym
         kWJrCW9G7VCqyljpI8BHlG+80MEBpY+Pp5/OEnta3mTdi3k8YNTZ9l6wfQgP20ZDDMV5
         6DZlGqfzsdghdq+4zZxOZzmBjdx3anHJ4mxw5/WmL1OiXbamHeRd77Dzhm8eyFCSIIC+
         n/8meFdfRmOUp4BjsA7tTBynOk6187nlNOcqu0HFUVAl4QIibOKu/6Am/tprBJFGL1ZJ
         j+wZQ4Ha2TNBVoLUSCWrRGM3FYzW3kwTmDflbJaB9UQLGy7W7ylLDa9w0qWpqbHSiMIL
         MUlg==
X-Gm-Message-State: AOJu0YxVN7VDFu/8GTFfrDJJYDb16Vsa25sV1nMRdBLXnNdL76Zlg2s4
	m+tsIoPNGLIm+TChyHHpMPY=
X-Google-Smtp-Source: AGHT+IGui27yUZN74OhcP9SSIP44AgVUT5c1MFhREmKPUYJsLOn6jPxonjzaRYZbvTnuit9XdyzYYA==
X-Received: by 2002:a5d:428f:0:b0:336:fad1:ffd3 with SMTP id k15-20020a5d428f000000b00336fad1ffd3mr8415407wrq.4.1704102563334;
        Mon, 01 Jan 2024 01:49:23 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p9-20020adfcc89000000b003368100ff71sm25419409wrj.10.2024.01.01.01.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:49:23 -0800 (PST)
Message-ID: <c365eb58-fbf5-447f-9e60-caa5db3bff1d@grimberg.me>
Date: Mon, 1 Jan 2024 11:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] nvme: introduce nvme_disk_is_ns_head helper
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20231227093106.78551-1-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231227093106.78551-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_014925_352436_460B942F 
X-CRM114-Status: UNSURE (   4.84  )
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

