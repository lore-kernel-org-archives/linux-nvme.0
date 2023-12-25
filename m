Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C026C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 10:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=2tlEmOEVb3j1vC0o7jswysdWkN
	XyCei3RjkbnDHEHwfs7uTa7YpANxu9dB4nySnbcQ1+LfTIM9AOcC8/emr/tTAivuWseZUBf+GRz39
	Tdii9GRnEyinvyz2quBOZ0wFXhmsL/0C4Wv62wqUTS4JIpgs9Y2WRtREmvtBTMVipqbv1Kciw6n/W
	aCxHGdIszziuRKTMdeOZJ36uv2SLGehoczFB+SZmh6VkjvOQgRYhsHLSVuXu9gIAhKs3ixDMjAAMe
	zGbUnNZeZoniLX9en9K7btHe3C5/NVFtO3dNXRUrBuWbG3igfcXnu4RIs7q6MTF9iN3ShpLuYJRuF
	aevnQjVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHi43-00AWdy-21;
	Mon, 25 Dec 2023 10:20:03 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHi41-00AWcj-16
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 10:20:02 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d3ed1bf0aso7078695e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 02:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703499596; x=1704104396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=iQl4NPmsuiZVJYXO3f+HRJaBkG6jV6BUwpWsheH9+zQhFJzey2RwWXFKibW8ZKevlq
         qBnxm4qY1dvlg4lBFs5invqLPah/b1scEymYeQhisQJEY7pv2cP/bVU5V4UpL1URJzAA
         Hqtexc9HWu+WNGPsVl8eEq4JBUUyuyVrVJZeLRDSTGBjXhIk4SSmprhEc8voVrGYw2WU
         ixnPJa6Ei9dFw8NHGxRZn0yFHbfOYiQvX6V4Zp488kjbWg4u7pLUAeXZJWg7z0eTj55u
         kQDPGXew/ANajQTnFDF/wHMS2qzhu91QtIet7iBTkc7hojtMaiBovdH6n0c4WePKiFtu
         zjCw==
X-Gm-Message-State: AOJu0YyR69xA3CRNVkpXckK1NHeDvHPaaz7YfQRSl5n3aKHGni95q3J6
	qWVHgQlHblXbX1tMGTEzYIc=
X-Google-Smtp-Source: AGHT+IFTfY+Km4ieSOi2q78tW47CFkab8hHZNPsRitUtcKS+lw59XwsJO5EouTThaVvBEWDX6o0Xmw==
X-Received: by 2002:a05:600c:3b06:b0:40d:4dc6:2e13 with SMTP id m6-20020a05600c3b0600b0040d4dc62e13mr5297996wms.1.1703499596377;
        Mon, 25 Dec 2023 02:19:56 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id fb15-20020a05600c520f00b0040d5733d7easm1767264wmb.10.2023.12.25.02.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 02:19:56 -0800 (PST)
Message-ID: <686f186d-f616-4f9a-8150-c1a28103592e@grimberg.me>
Date: Mon, 25 Dec 2023 12:19:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] nvmet-tcp: Fix a kernel panic when host sends an
 invalid H2C PDU length
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: zahavi.alon@gmail.com, hch@lst.de, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20231222151750.655751-1-mlombard@redhat.com>
 <20231222151750.655751-2-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231222151750.655751-2-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_022001_392357_6F79BD78 
X-CRM114-Status: UNSURE (   4.65  )
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

