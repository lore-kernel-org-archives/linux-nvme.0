Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9B8C10DC3
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 08:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Ms1JhSqnteRt9D0GpmRQaeWY2p
	EVlBS/N9TWTxvFScG1k6yAZwkC5KmsjHvu2tEuDNNGYtd5r9B1UHkk5rQTKhwzQYMY0bxqfjhjDtc
	yB/b/+dRPeMtYxpQKXR0zyAXfhBqDqcBUIEH1tWWPcRJwSU4WIDNI3FWd7iiR7y4qd79/HqebFtY2
	uSGQmvWg7dtsNA9cmkkb8HaVlBbUzbtkkom8bLb8KbnQCcv4h32n8P7b41+DTPG5z9sK+/E9d+8jY
	RUvTWhPEN/PC7K5evRRq0fpixGDbp29TVlDtYjFuzRVAv1hZAgN0HY1+kHN3r6G/UtjkTmVDFM6DJ
	2amhQlfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4co-003KR5-1o;
	Mon, 04 Dec 2023 08:48:22 +0000
Received: from mail-lf1-f52.google.com ([209.85.167.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4cm-003KQ8-1P
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 08:48:21 +0000
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50bfb930dbbso29380e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 00:48:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701679697; x=1702284497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=h+HTSU8ANc3pW2hYSkReVzf82bA3nIFq+xts6uZEd8OHQO1nrUFtENJZlQGmny7mHl
         +saWq0rz4I7t1SyOWlpUl1qoV0Qx9ZjmtQjPL90znkg2gwrEy1kKHJSYDEAmLkyXtB2m
         4L9X42lHrB3OYlaAFuqevvcYMFcts8js3Hv3kQGujDr1eFflQOqT6Cv30nlXBlfA0A9m
         hz7ASVkq/kprXCjdaY1PFAO0b56eDkZz74If432HAq6lKSHkpqyfwqQW71WQ0zXvYYm5
         odMegwdMTiXbJfLmRG0/buvL1d7rxiawewM8IpuV71NVqQ+O0FpCkQ7kTtZWIkzzMoEB
         fzuQ==
X-Gm-Message-State: AOJu0YzCJxEm77B9bMOa2i6RaZ/fCuG6UQbptifrQBVTXFgssHmckNbz
	mMYKvT1aJXJw+EdB9GIZulM=
X-Google-Smtp-Source: AGHT+IHo2vwdWW1D29AvtzuRbUja4YE5rhmSMUTlmHPKq97SUL+UoHsYjc2vQAYcspDiszlsqDRftQ==
X-Received: by 2002:a05:6512:3b8e:b0:509:b45:8879 with SMTP id g14-20020a0565123b8e00b005090b458879mr8618530lfv.3.1701679697440;
        Mon, 04 Dec 2023 00:48:17 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b0040836519dd9sm14146448wmo.25.2023.12.04.00.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 00:48:17 -0800 (PST)
Message-ID: <c4311f72-7beb-499e-90d2-2e136da45388@grimberg.me>
Date: Mon, 4 Dec 2023 10:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 3/3] nvme: add csi, ms and nuse to sysfs
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231201092735.28592-1-dwagner@suse.de>
 <20231201092735.28592-4-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231201092735.28592-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_004820_477128_0B016F80 
X-CRM114-Status: UNSURE (   5.51  )
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

