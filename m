Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182C2C25B75
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 07:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9SeW7wtN+uEZSGbg96+83NWHx73p+C7mqGdmlVQIBi4=; b=oGN/vbGpG49n1Yk9c1uwxHTb0U
	ePgPNJ6Hw7CUyzhlrMXcAavhzjPI2IllBHIvFWbkZdjp0SFNw995CxuzfczYct6LibYt05GMAkfjY
	p/0QBfGG8CiHf6J3DP7kX9A/s06intl8N5ImzM680FuXQKHcw6L+x1S/KpXdcMWP41KR7331kzwmT
	X7endc3t8ckKsSmvmDXz6bkFVQD49GIm/KocemVKRiq/AxyxGkC+1vilz4EANcTQr4fTnmpX9/FyE
	GkDbDUV686XYOzgsH/P9RcLycKa7iBwSpKZt68UmpyMIW5baPl27BpaXEZ97EGwTU7OP8DEnhYgyL
	QAHLjXzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF7cp-00000008gYN-432S;
	Thu, 06 Jun 2024 07:33:31 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF7cm-00000008gXv-2DXp
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 07:33:30 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42111da672eso1040885e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 06 Jun 2024 00:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717659206; x=1718264006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SeW7wtN+uEZSGbg96+83NWHx73p+C7mqGdmlVQIBi4=;
        b=R8xrQj8JovqXIXDjEkhgw/XcR297C3xdkQtkhaA40jg8xcajDiZQ4Mp83e+J4xNKzI
         WjLka17akXmehmmAyOBvkxnQqE+TNexKqoJZk5LJ4cEbE0ldVSEHNSr82NYRgzho8SCB
         TbfSNJsry6GErIr57mtw7Z7u/uvZN8jQrXOiKKDiM+BNu0UGir4mLGkUgyUpPKjqDfea
         cccq440HmLKegYOliCVma2ZQo/ULSAQ/ERwSA+/UKV08/sW8xHv7AlJrn8tFXf5GG9DG
         Bhbq47Rur3Yp5TOY0qKRuAwfbL2j0fjsjT6unJi3LxuLkuSyozaXdX0OgCYo1lTzuoY6
         ECtw==
X-Forwarded-Encrypted: i=1; AJvYcCXS0WEVMGDvLbKRiueN42x6S/3ITXMJ4fUNGlO/euzjK/yqWiOg/RBrek+RX9XOm2t6ZGc8TW1m5+ARL7Ixmyc4NVF3JfiIolEuSkteHBU=
X-Gm-Message-State: AOJu0Ywrl7ujMCzZAc0fpP8W2NRReFvrU7sIFJjE/cafWS108PpWwXXz
	g20aThXxdMJlfq/ARLHkHObwNjBSX1MgDp1I42hF62v4lPWu99FnSWH53cL7
X-Google-Smtp-Source: AGHT+IGXBTUQ7HGWLyOE66lT1wMw2W9BvEc9kRS2Us5FnknI2BUw9IcTiTDLSHuaEzRzsTdCWUXB7A==
X-Received: by 2002:a05:600c:3b82:b0:419:f241:6336 with SMTP id 5b1f17b1804b1-421562d9dbemr36705335e9.1.1717659205847;
        Thu, 06 Jun 2024 00:33:25 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2a544bsm11871655e9.21.2024.06.06.00.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 00:33:25 -0700 (PDT)
Message-ID: <a5cebba3-8beb-4c23-bb02-5a2c1e3cc711@grimberg.me>
Date: Thu, 6 Jun 2024 10:33:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/5] nvme: fix initialization memleak
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, mlombard@redhat.com, hare@suse.de,
 shinichiro.kawasaki@wdc.com, james.smart@broadcom.com,
 Keith Busch <kbusch@kernel.org>
References: <20240604185908.3703052-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240604185908.3703052-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_003328_673151_8CEB4BD8 
X-CRM114-Status: UNSURE (   4.20  )
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

Looks good from here too. for the series,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

