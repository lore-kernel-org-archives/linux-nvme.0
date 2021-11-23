Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E53CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=euNS7buxTNSC11mo2zOmuU8qSC
	yhDqOPJqc2XwibvL1RgMhfq6JrVLSE+wYw3QZ6GtlrDQGTexEU0fmU0ipsDqtQJFFrLVprwhqmxQ2
	wQG/KIObPOVLgGcVWhnSRexqrZktuWq+8g4TUJ7iUIcpte8CT6ZShAL2naXJGwrTL1MwXP+Qkc9ST
	gTI5efOk7fBb1YZeejI6Iuu53REcbC4i7GTT+ZqEDal792vlC2pIa4nu+BCiZL8igubS6LStN8Wky
	fWpM9H+SRZ4HaFpqk4ey+Hty8uEB00Np6mRcWDAphMrPOv0W/atJP8n/aSBrBYCDTWFyjoeqyQ63L
	Gr68fpxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpbxY-003O51-EO; Tue, 23 Nov 2021 20:00:08 +0000
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpbxS-003O2q-4K
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 20:00:03 +0000
Received: by mail-ed1-f41.google.com with SMTP id r11so96977706edd.9
 for <linux-nvme@lists.infradead.org>; Tue, 23 Nov 2021 12:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=qMPvCJMYexoRdtwvr9BIK84PEg2B/ApLj8UpQM1J0g7wV2HXhxBbZFslmkGXqPq77p
 5TvOcBNa3f28QkvZid0OW7Uy6Wj24iyPm5xMQHI0c8aJvBWI/FVQ8uTTumD+R7ZIwJ94
 qg1sz782Oem4xTSfIF3U6vqS6YdAwEbQEEIQ1y8X3DvO3r9RXxaV9wSx6UrRlGHk6xtt
 vNa/XZmQbmvVisrtLG6+xD6ruJFdLi4I+BYL2CGJZLpLbW1sUfZaNw/J3TFrLqkBPoRk
 MxmaBs8fcqIUNPmpt3qlXintKh890YZd4EagW6kA1Ny2RAiu5DlC88sLLT5/ydWAOk8+
 skgQ==
X-Gm-Message-State: AOAM530aitewCKnl6mPhwCE+j472nFr/abt2Ahf7UmmzYWBRm/PDmbIa
 Dh2ovPd1Ha4LcwoPBQgMJ18=
X-Google-Smtp-Source: ABdhPJyQ/1h+wusbHL4FpVVA7r1HJOJd8CIr5zuQiaLidwokprB4BjuDDDoAq3eP6wnYLjOapT08fw==
X-Received: by 2002:a17:907:72d4:: with SMTP id
 du20mr11683976ejc.419.1637697600693; 
 Tue, 23 Nov 2021 12:00:00 -0800 (PST)
Received: from [10.100.102.14] (85-250-228-224.bb.netvision.net.il.
 [85.250.228.224])
 by smtp.gmail.com with ESMTPSA id eg8sm6287922edb.75.2021.11.23.11.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Nov 2021 12:00:00 -0800 (PST)
Subject: Re: [PATCH] nvme: disable namespaces with unsupported metadata
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20211123174554.3574990-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0cf4349a-f84b-130f-c454-0d3229d9dc41@grimberg.me>
Date: Tue, 23 Nov 2021 21:59:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123174554.3574990-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_120002_187383_6DEEE04B 
X-CRM114-Status: UNSURE (   8.25  )
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

