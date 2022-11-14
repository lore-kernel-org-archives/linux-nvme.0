Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E63AC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 06:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=vdZfijMntgU6TUJzZEPt+pbEsV
	ldaXgL5g+YO1A10wH6yNByVa4vRKVEkvs5LyYqeSptSvhQ/gus63YimyI40M89vcqOHqcuIODayW8
	WQUTwH0CAXXnoPR8ZopDjKNabSuOvrS8uf8yaiLZq/wd87t9xLV2fI0OTHrJN6UhvfkL6hll3N+vF
	Uh1DbpmS4bkzi9quuKhNAK5RnbCw9WxiY0hIkSOdtm3aUpFwO19tmzdc+P7UF/l18kCBGuUlXNXou
	NHAd/Sro9z/4Rwd+B8iujQ5RawU+0v23VN5zn4f4SzvYt7qXi0JJEM0xXnqV8SY2MgB2nBuCcj9d+
	G0gE3uuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouT1A-00GHBF-Mp; Mon, 14 Nov 2022 06:32:28 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouT17-00GH9f-Jt
	for linux-nvme@lists.infradead.org; Mon, 14 Nov 2022 06:32:26 +0000
Received: by mail-wr1-f53.google.com with SMTP id y16so16245611wrt.12
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 22:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vJXoUe6bnlXhl04gB0lHGGctCmWAj09LQjfMBG3QERO5MLq6iQ3wzkw50rdizfch8n
         kKWyRfDP6odR1aWkIlV9ap9WIlkRUN5ajXVds3N0OeS9PAn8PkPJHQojraXb8y8zXoJD
         6ZumwiCBlDst/b9gjiETmc788bRsn6JafzXCleBBf9eYv+CWriZScitbzwKshFdCHwUB
         Ql5YIJyFZiIf12JJBo4g8HxgLWvLS7PQ6xWe5Ahu1hW4/P/G253DHfNCloj9SM4sGu9w
         SNoGdmpkgT8XL0NwdyLhmSlS2FIJM23+vXHdXsgDZj7U9S6Zcz5NQDIVbFaU1G67rPK5
         Ksfg==
X-Gm-Message-State: ANoB5pkXGq784jX7bm3FV+v5hhqnbR50eC7tohv4uN4119EvzH5+YDZS
	xrpstakTHg3bHviVdq51/Uo=
X-Google-Smtp-Source: AA0mqf7WDKccuVmk/zAud4HA9xAgeKTDvQzWA+Ollpk4we7CvgOfB6NI06ZJGAXrFHTRE5xR7egHyQ==
X-Received: by 2002:a5d:4b4e:0:b0:236:6deb:4498 with SMTP id w14-20020a5d4b4e000000b002366deb4498mr6663711wrs.52.1668407544330;
        Sun, 13 Nov 2022 22:32:24 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b003b47e8a5d22sm19304583wmq.23.2022.11.13.22.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 22:32:23 -0800 (PST)
Message-ID: <e51a514c-d19e-71c5-cc30-b226f4eb7703@grimberg.me>
Date: Mon, 14 Nov 2022 08:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 13/13] nvme-pci: don't unbind the driver on reset failure
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20221113161138.883195-1-hch@lst.de>
 <20221113161138.883195-14-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221113161138.883195-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_223225_660041_D4FA630E 
X-CRM114-Status: UNSURE (   6.87  )
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

