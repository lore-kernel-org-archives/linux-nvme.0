Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41133CD37B2
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 22:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=tpfYM9uzY/u6o7uSsHkSNULdj3
	as9YfK8KPIGzgxOu1hir6UZGobnJO1qmUC5dswTYsyMvoxvDvg/BDcMhkZ8L1QKHJeMxbbKSTEs3i
	JFe4eyYyBop95OgXe7LWSMmxBoSRSoh/ba6ymgiTG3gHIRq8cJROHDNRWyFnUd5AWjLlSGhYwAc/S
	T2GPNoZUNGIaIleiIC0IBGvM7AmioLtlTnd3bygzLCot7V7fwiNxKdc3f7PSGfguTjLExS6MsXCJV
	/IH8E+cCaXDCQcavxHDQfBQrBqKR2pxwuSMuMv5gtSPrt2OwY4gNavnbyMvuK6GjI4BE0UNr6dC2P
	QdP5KZhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCVw-0000000BkPk-2aOe;
	Sun, 10 May 2026 22:20:44 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCVu-0000000BkOr-1zJy
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 22:20:43 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48d102471a4so35929735e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 15:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451640; x=1779056440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=gn1N2XDtKN5vHGMBjV1ZGFDDUOyP7azq/fl1MHZENp0nx6Q6KXueENEEMLAhgatT21
         FqRy16HDRCrdNDNiW0GCa6o7eFDbJ8MWvtk5XAa98jWtxH2MXXokPbK4x5gH7vfpc3CY
         iB/sWqIktuf09mdjEMhjSXZNuWPr+RoSwGjJKD53g+5Eypfa5LbLSyhTrOGKBFz6z14F
         l3iOL3YVwkRQ36nOewFNUagcjizCzcLA+IMLci7GhMLmmEbAcgDfAI5SLXYqpuxo+Mo8
         zEt8UNWSZpNFlplAhj83zZQgXyU8Fji7cpMuGQiGuC6Th3LFz7CWaZyWrrBIn6OsZKnT
         /+AQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ECCaZd7ZmFAxQpVixYSx9cJdSWllgqD0CVXVwxjkzezOYnaIrtdW1CxJgYugm9Q4yeDX2k5hTBl/B@lists.infradead.org
X-Gm-Message-State: AOJu0YzAF7+XRZqLPYaXapB59HOChazahUe+3j7aYFRKoiumtSjwco1j
	bl5KH5adG7NvR720uXS+qwEgW5n/dzalAAuYQd203BtM5k6GEyILFT+E
X-Gm-Gg: Acq92OHFFDVxRlrcX15bR/vfVrb+axFejndgBjzYFCLLYolb31DIr41rY2iqRsHW+nr
	X1YJXIolRD9fKsAV4hI0ttcv0y4gst9Q4715pN9R+35jmHvZInUlRIcVabuAFikYZ0N3QJPnV1M
	09v0l3tlvUAyWJbOSIZrm/3M6HYG3sqCrR6VSsBjKh+fn6xrXGxKs947papJYTaGzTsjp/D9cZT
	PZMTO+JeMcQWlmSao/YYojmsAps6K/ZQu1coZfCDa4+6ZRTlkWQ3d6izeNn3lPqZgbA65ynY/OM
	1Reil5hE6nfrrjX6Lxljzedl/cLCmbu5RYb1hX8T74dq2S+fAbjbt3mnBHRwZ3pZLs/Lfr9y64e
	k58ifnFJl1/V5ZFlicGL7iIAfBLy2dW7mSyDj2RJfZsFheu87ncU21CMafHJ0czirDvDO06w8js
	pJSoGHfnAbuL7uqJ+jdy8=
X-Received: by 2002:a05:600c:a412:b0:48a:525b:e148 with SMTP id 5b1f17b1804b1-48e6748a724mr117231395e9.4.1778451640519;
        Sun, 10 May 2026 15:20:40 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8d6838sm48789845e9.1.2026.05.10.15.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 15:20:40 -0700 (PDT)
Message-ID: <894fd072-8afd-44a7-874b-bd7f88f053cc@grimberg.me>
Date: Mon, 11 May 2026 01:20:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: make prp passthrough usage less scary
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: me@alancui.cc, Keith Busch <kbusch@kernel.org>
References: <20260506131839.2364791-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260506131839.2364791-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_152042_508674_CEF08E6E 
X-CRM114-Status: UNSURE (   4.16  )
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

