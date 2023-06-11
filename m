Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1038EC83005
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Jun 2023 08:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=R1NmXtyjzkGuUAWBDr5LeKwGfx
	1sX46jwK1JZqN9neORYD6e4uzKu6ZHfuBVbLoqVH5ifoKElLZTfTQ8Nbwsmv4WpgUJQJnHmpSFO1J
	cYtBfrHplVCcKp9pZwToIDVBRDsQMpWRWWtVGbP/We/XG5UI16HLyXd0UKQn21ct2X1hSkGY2aaKf
	IXfo+6Yk44e+jEipQ1Z55QLit9mh4AEzl2heJLxYrDx8l7TrCsOUmowowfksSkZFomDYvPV3K3FUz
	hFFfPPfd+EwZVGazM2P0galSAQMzj/c+XoF/NoLL/06Sm2wCDFf18II6h7umls0TTy03u8tAjDD6s
	Q2iFexRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8GBA-000K5e-0H;
	Sun, 11 Jun 2023 08:12:04 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8GB7-000K54-2P
	for linux-nvme@lists.infradead.org;
	Sun, 11 Jun 2023 08:12:02 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f7f67e8f1dso7802135e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 11 Jun 2023 01:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686471119; x=1689063119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=QB7LWddkjVS1xLov+eZvWLrv8VgmYMrQvPn6rrzCapKG0L+KCvg6sdBhpjHOcuF2Dg
         udwkRJFdHMysWxPpkNCIuksrhjcK30RWcX7ZCefWeYJM227L5Pv7rwerLP3zzFk3smFW
         giGfFRsdScZOVitrdilg0n+Vllh6XQpytg2zsChjMu1sFVji5q+tWU+S2JLhmVfB3vc7
         Ev4Mfi9C2+SG+V1KNvQoz/J1AgCZF1OAjlob+m01TDsk/PWEZkJlfzmByE4z+QRGYdXF
         AZSTZRQ6ngZzbcC49DBbLkQeSjVZr2Mn05AZ/Y1a8J9gwwk2kp3jkZBY288I8CnNKeLE
         7cfw==
X-Gm-Message-State: AC+VfDzF5LeAYg/qYJJ7DTpHRnuHXmwQ1pJqbVzuEL+sHYOA5q0VNTVC
	f8mErgQcpaCDDkm7LJroMHw=
X-Google-Smtp-Source: ACHHUZ64frQa+gMpcjF6rcObCQafPY4X/Q7kQS32yU1aAfWzdv9vipvatKYvGhgIIc8uqziiaG7ZjQ==
X-Received: by 2002:a05:600c:468a:b0:3f7:f519:355f with SMTP id p10-20020a05600c468a00b003f7f519355fmr4980461wmo.0.1686471118935;
        Sun, 11 Jun 2023 01:11:58 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c024e00b003f8044b3448sm7366451wmj.9.2023.06.11.01.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 01:11:58 -0700 (PDT)
Message-ID: <9a43577d-5e69-88ee-62ab-e92524b1ed87@grimberg.me>
Date: Sun, 11 Jun 2023 11:11:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv2 1/2] block: add request polling helper
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
 axboe@kernel.dk
Cc: joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20230609204517.493889-1-kbusch@meta.com>
 <20230609204517.493889-2-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230609204517.493889-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230611_011201_781203_5D4A3940 
X-CRM114-Status: UNSURE (   4.94  )
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

