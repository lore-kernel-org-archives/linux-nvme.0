Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED51C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 14:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=usYiMG8jrTUHwqA4J/uyKBNKD9f4rm1uw//n4XFuqzI=; b=XS+yExsxnGnZ5Uvc0iOvc54Pmm
	WN0imiZ8BcCbxzouGYE7xI9xSig7wCffDvF+hpjycwXPFmZfvMssl20Gw2mgFpT6GwlLCt/Wt4Os7
	N7rNBBqqTgnFdfIzx9cXPY7C5fyN3W0moMFvsW5+NzSMHOT/rgVRV1Te8M+hI6Bml4Va/Y4z4g021
	+oRidi1BxghtTmE9dwjNL5QG2Rnz0YRZvNAGuk/zCBDPogcNr5jorHPle14mAw+VXtrIftM72cnTo
	pJtfQYxh7JSw3/GydNHpmqjR+9ILDA6wkzTG3E0Kx4pFvIvhLIBSDg9umZ0GMh3z+eq7gXV6fEKtO
	F0p7aN6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUSSs-0000000D2D2-3nHs;
	Mon, 29 Jan 2024 14:18:22 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUSSq-0000000D2Ag-1bz4
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 14:18:22 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40efb04f8f6so799255e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 06:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706537897; x=1707142697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usYiMG8jrTUHwqA4J/uyKBNKD9f4rm1uw//n4XFuqzI=;
        b=Y2nk75d1pxh9VcehPz2hjUpi+TtdY1cEe1DT9CmFqY67Ha62t8i84l71nahrrI8eBa
         vVXvrqa31d6mwKGzMyyHpuBduFZtWSq+v1+X8YFDqZjOFNe0QF3Q+On4QLcCqQLXm9hD
         7DmDjgj+43N9m4MfbDWuCzdI9KkAkAzJIE29+H+a+csA1ie+Xx/Uex+JMQbP42zJ9IwE
         XUQ3PEe9J6bwLA4IW9me8AQ7VnIkVWmRBpVQirAOHfxm3zTsggQVw4nFyL9VbdOTEBlG
         R8KtsZDbPeFd7eDZIeKTBh3VAnlxZQCXp4hADzutX0dcgCN1OHzVmwedN9q/w6Hh2i3X
         2R5w==
X-Gm-Message-State: AOJu0YwwlP/3H1i7mDcowtvjVTWfifSSfMBCKrhdohLbjCSC+4gkUsnw
	rXE0IPt3iSjxR2zpWiJtPvyqlKkXqMPKYqIpIwAuEz7G8kUz0sAR
X-Google-Smtp-Source: AGHT+IHuA35YPAtd11Q2JiiUPWn3/YwNI5ANUscluYfcpqoQ+oesXNrzZPoK75txqn00BkSShgLuuA==
X-Received: by 2002:a05:600c:6020:b0:40e:fca3:9692 with SMTP id az32-20020a05600c602000b0040efca39692mr156224wmb.4.1706537897334;
        Mon, 29 Jan 2024 06:18:17 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm10395092wmb.1.2024.01.29.06.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 06:18:16 -0800 (PST)
Message-ID: <501724df-de9a-4b74-bdee-eea7c3507f51@grimberg.me>
Date: Mon, 29 Jan 2024 16:18:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/3] nvme-tcp: show hostnqn when connecting to tcp
 target
Content-Language: en-US
To: "Nitin U. Yewale" <nyewale@redhat.com>, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, jmeneghi@redhat.com,
 loberman@redhat.com
References: <20240129110639.45542-1-nyewale@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240129110639.45542-1-nyewale@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_061820_589230_2492B75C 
X-CRM114-Status: UNSURE (   5.91  )
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


> Log hostnqn when connecting to nvme target.
> As hostnqn could be changed, logging this information
> in syslog at appropriate time may help in troubleshooting.

hostnqn is available via sysfs, why do we need to log it?

