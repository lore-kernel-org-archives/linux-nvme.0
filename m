Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721C6C47258
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jan 2024 11:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kFPDTfJhd4fTrleHhw1b/Yu9YKrNTHG5vjvHZzVrhGQ=; b=SgyeRRwSwqa+V/7+dC9NXxzhNR
	LH2ifKfACXlIObUR90K4TxBzuwEfY0X3s7z96rj6BkKDJslbZsb/0f1ZRmP52U29R6HWRyFK3xHDE
	hw3z6DaKZfpDAC7KSJuQKb9EzbDzr64h0TKGFpFelmwHoX9SElrbznMjeSCIfqeshVgLpAWe0TJZM
	sbNV5ha1qOy5ENLKlsiBLxhIKN3mHuYvObp3SpRn0IWYo2KZRu9VIsCDGZiUkV/Jqzwt9hRPo/uyL
	MdfQ6aHhJxf88mahlP0u4E/nxmzK5aAEHYgdhfeky/2FeGKFddbonDTaHm77QDyyX6c0WzoCCHFCl
	FOFq1r/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU2zm-00000009HkK-3eyW;
	Sun, 28 Jan 2024 11:06:38 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU2zk-00000009Hjg-0CAq
	for linux-nvme@lists.infradead.org;
	Sun, 28 Jan 2024 11:06:37 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ef107b38aso2056385e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 28 Jan 2024 03:06:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706439994; x=1707044794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFPDTfJhd4fTrleHhw1b/Yu9YKrNTHG5vjvHZzVrhGQ=;
        b=TiQyB6r/jZVk0FfGNX+y2eDalA2waZrJ282KQxfCaALJPpwkUuBEUxeFEFY1kTdMp4
         g8ja3JJ6xwgstTBmJSdklZ1BsMNMDNTLNVwzlvixrUqjp1ZhlEAYBMbM1REt7mH2Nq/z
         JQ/sYr1fpZYjYqJyqSIQLK26EFk7McBwwmCNrUVTkmP7SheiYjpqIvkZmqfy/B2iqYa7
         vz959MnDJ62/LniBqt8z4Bszq9BVMcIolojARnlHPdkC0sWTXLHq1HBSgn+6c5VXtucs
         ZjFjXgOcSL4mG6meByOF/HuEAEpSoxM4sEZy7wH8kB3hFOlTQ6aUtr0LAw/Wf+LXNWHY
         21Fg==
X-Gm-Message-State: AOJu0YySWSzJ1lGSMyv6290LjPTcPGZdEVPs+nulQJ5/SV47A2PxQkgW
	MryEx/EZ3owC9N6Tgzb3st7PZppYl1/2MHQEdvyr9DsxDvxUEsX8
X-Google-Smtp-Source: AGHT+IG7vTKempMUyAnU0iXK/Z2ObO3EbUMh2oGPXwE0nykR6mDff6tmqiDXfjRQrJASsj+Lf7Yz2Q==
X-Received: by 2002:a05:600c:34ce:b0:40e:ee31:33a2 with SMTP id d14-20020a05600c34ce00b0040eee3133a2mr3172245wmq.1.1706439994191;
        Sun, 28 Jan 2024 03:06:34 -0800 (PST)
Received: from [10.100.102.67] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id he9-20020a05600c540900b0040ed1df542bsm6993636wmb.20.2024.01.28.03.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 03:06:33 -0800 (PST)
Message-ID: <6f1067dd-a000-4d4f-b19b-4eae6d219a47@grimberg.me>
Date: Sun, 28 Jan 2024 13:06:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] nvme: use ctrl state accessor
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: chaitanyak@nvidia.com, Keith Busch <kbusch@kernel.org>
References: <20240126171608.2136149-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240126171608.2136149-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_030636_117144_E5DF0738 
X-CRM114-Status: UNSURE (   3.31  )
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

Reviewd-by: Sagi Grimberg <sagi@grmberg.me>

