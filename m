Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B95C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 08:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8m4yOoCC4CbshXo7dZ67nIYTU6jSjvpFKcIZtpq+6I=; b=kTkQzY0+udJOEheIGJlrhiuJi9
	s8TwRZf+AKWnjNJUXNrAKmxbe3PbR8FudqxQ461JZMuq5lWE0kQU7H1Qt7jMGKRnPKaCpwIsfTUkH
	L7thrjbQItn6ccmHFtp2p0Q3Z6dua+puIPNtBZllframpeXUUVx/PQsz12AqJdMjGahhxbM99rSPk
	pZ0z7YyyzvbM4vNwnJ7SgHTLGA1gxrSaCTlAl0T0XI4nKqcV8TXD63H6I7MMb7U6c/UwBIdLjiXnY
	JQMRzL9twdvH9H427DZ33f04hsaV4sOTl5voSZLZlzTCjbeH9qONh29ZapIrMS1LXRwAGvR/qDcVW
	5vbNo5ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8xo-00000003ae3-3WLX;
	Thu, 07 Mar 2024 08:18:52 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8xm-00000003ada-1vhw
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 08:18:51 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33dc6df042aso135182f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 00:18:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799528; x=1710404328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8m4yOoCC4CbshXo7dZ67nIYTU6jSjvpFKcIZtpq+6I=;
        b=Qfj9Bc9FtWJgQBVFW9WL4HgmaVL+e7EvsLDRax/lX9fAqkAtScGvWKCQ4LWqo66z25
         9yKEZ6oC/SYdEYWa1eYbRg3lYxkDjWJd0VL19KMK/fZzK9V9/UYtXnxAEmKjPiBKOH2E
         bVtTJuh4ttJxtRG8T3aqVW4Z/rPHU8L2yjvXtYx4fmGvcabjkTx+B34sNQ9NbmkZztzW
         niNC79WB9KaUiNCSHxx7fleIh7OzFFx39OEbShG12iZXUWgEGe4rWkrBDWbDsmkHKKhm
         j/oBt4IHvdcwDk7cVuZRt3b6BSHKaJ1S6XF3YEk+i7SiopEWcx2hkW2E3sHFYapB0JZP
         7OeQ==
X-Gm-Message-State: AOJu0YyLukMcCaviH0pyCLvLwPCQlo8J9mVkI1X/t7Ac3/BgciVFvLPK
	iWGsk9DBAhLy0zGQC3PdH6F4cOKWTHpvYEeBrEFd7+zRNEoma0Uuj6SjSoNw
X-Google-Smtp-Source: AGHT+IEOWk8fAa7DvWQIWDFkX/cgzeNWRCIJ+i1kSlXAL8V4a9V8+vLnWfufS0k4bExIsloqA9kz9g==
X-Received: by 2002:adf:a3c2:0:b0:33e:65ea:cb8c with SMTP id m2-20020adfa3c2000000b0033e65eacb8cmr444453wrb.7.1709799528521;
        Thu, 07 Mar 2024 00:18:48 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id 14-20020a5d47ae000000b0033cf80ad6f5sm20083045wrb.60.2024.03.07.00.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:18:48 -0800 (PST)
Message-ID: <105d14ec-b4db-44e7-b98a-135787c17b10@grimberg.me>
Date: Thu, 7 Mar 2024 10:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/1] Implement the NVMe reservation feature
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240229031241.8692-1-kanie@linux.alibaba.com>
 <1448899c-6056-4070-8b34-da4ecd2bf470@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1448899c-6056-4070-8b34-da4ecd2bf470@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_001850_567878_B0CEDC41 
X-CRM114-Status: GOOD (  12.19  )
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



On 05/03/2024 4:32, Guixin Liu wrote:
> Hi Sagi,
>
>     Friendly ping. If you have no further concerns with this patch, I 
> would be very grateful
>
> if you could provide a "Reviewed-by" tag. Such an endorsement would be 
> immensely encouraging
>
> for my work in this area.
>
>     Thank you very much for reviewing this patch and for the valuable 
> suggestions you have provided.

Sure, I do think we need at least one more reviewer.

Plus, I don't think a target-side reservations maintainers entry is 
justified here, it is a part of nvmet.
So please drop it from your next submission.

