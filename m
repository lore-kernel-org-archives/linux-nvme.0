Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE05C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=1BPOzIEx/vESrfJMgQiPHCIe5A
	7OqDmOEoLHB/FXkB4NKTV7FCxtDlMjkrG+SmeMCUjUyFsOJGoCdczzvtiU7VuxP7YnKEGa3G5gGsl
	hEEGkrM6XsXm63ghehJtJgM2RvJK+tFxcsAL2l+ytOgx39sNBIXvfe6Qy0uy3OvNM28qKOPyL63kB
	rgxZI8KvP8t7r/Ad32Qkd//yApzMSW/B8IEKpGSUDASMGKro/OlgTCuL2P8LDlt2qq6xGV2gE4gPt
	QQHCFGrrIGAFVm969Jrroj9AKfepzdIqRr8xJwGo8+E7LmC/DFDMslkBPuhbmdkny1FjIOs2rrCzQ
	zM0YbaAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFZcB-00E5jv-30;
	Tue, 19 Dec 2023 12:54:27 +0000
Received: from mail-lf1-f49.google.com ([209.85.167.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFZc8-00E5jO-1o
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 12:54:25 +0000
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e3b11f5a9so475516e87.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 04:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702990461; x=1703595261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=njzEnu5yNCV0+qoq/PiW6ZiZgeT+pSZvjvV/s3GFarBp1ywQa7ob4fBoMC/c+Pky4r
         G9AZzmsfdZ06/c5e/D+b4jbIb0ipv2Jt1B2qNkoQLYVoZp0MjbbezhqJB7OiJiCJ0pTj
         00Qui+ASFWDT6GU1KJjZOEq68HI+MZA8DfDQSpVhaBu+RhEJnaFsye+gnx5LiZJeiD5b
         eurk3xWfvxX/Bn/8oOGx+Vviw7YDCiRykKGdI95r1tEvBmEDbNcu45SNkSi+f23IDV1P
         qfisuJbB+2nlVDzlc44JTiQU8YahZeQN8g8/6aMzRODGeEy1k3cMKabOm2MwcIXWrtJX
         Tx6g==
X-Gm-Message-State: AOJu0YzTlBwA3VeiXxeaDlHUozEILM2JMjWut/WJ1aL5XETABUg7Xqip
	WxkPenQh7VrHfzvpMaT0S6g=
X-Google-Smtp-Source: AGHT+IExVGE8BZdfVTMiymTiwaOOwwrMWA8JMALId8k7GWu56mVfiHty5ZllMdTR/PkrEbadaT/b+Q==
X-Received: by 2002:a19:7604:0:b0:50e:3fc6:ef3e with SMTP id c4-20020a197604000000b0050e3fc6ef3emr2126318lff.4.1702990460887;
        Tue, 19 Dec 2023 04:54:20 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c311200b0040d2524270asm2605490wmo.8.2023.12.19.04.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 04:54:20 -0800 (PST)
Message-ID: <e6827366-4abe-4241-b928-d6f1fc019375@grimberg.me>
Date: Tue, 19 Dec 2023 14:54:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] nvme: move ns id info to struct nvme_ns_head
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Max Gurtovoy <mgurtovoy@nvidia.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20231218165954.29652-1-dwagner@suse.de>
 <20231218165954.29652-2-dwagner@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231218165954.29652-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_045424_598518_E5FE1928 
X-CRM114-Status: UNSURE (   5.71  )
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

