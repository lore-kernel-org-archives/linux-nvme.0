Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525B1EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 11:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=a/gJLXkyw2M/CA4r6/V06UsUs/
	UShaj/XYFKumlpDk3nzgSpA81JHiFrhPSG3j0ZApX97nx/GxTtu8KLjGYcnnA/yz4fvev6Tj8dFBJ
	zKy0c0mOywmWP2bDO99xjdf19/K7eEWOZhOXWhva2AZLOfuobYXdqvWyABLB0vcyw/2SGdagGzJIl
	QdANH/nbECEe/SUvaWKwSxhXs4yX9k+UjJbI1E0JE0TTA2i8IgnOzA7nxFZFBAi2tAkmhi78CT5EO
	NyxVkq2eCASpc8VF1H+BMeZfvVWRU2pqvyh9A/DNumKcIAd6LgMUcj5EYrDW/ttoFNycpIMd/X9mJ
	G1pWVSvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5mO-007Kmi-15;
	Wed, 19 Jul 2023 11:55:40 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5mM-007Kkt-0x
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 11:55:39 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3159adb7cb5so1636766f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jul 2023 04:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689767734; x=1692359734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=UnOhRNwcf46wE/5bpcjKIp2CH7r8W6byC6+yGcg9l/Kwx2LLBh+2QG0PBEbwoAhAf6
         KwKTkZ1hR2hZliXu1p1xuKt8X3Zlh8whtTWWFdxft1EgixfsB//PK/fhjKeQ5IN6bzNj
         PksAvDB2RtOZT0KsffrY1bA/g25F7T+ArxWSO3c2vwUXNCxHW0CSEWLf4ll2zzgeIfwi
         7DG+TCygqsai53LDcwBaZP0TgTCmGxQcklMsr4BCa+Z/UBGGGS7SoLwIuiVDZA6ooUKp
         tc+76/PxVU8r5ntygcenjQIBh1HwyImqZ7wrNJ23L8ZO7cY0DxsMRixZwMGV9rYJiuVr
         PkIg==
X-Gm-Message-State: ABy/qLZZ7YIyeX6O2buqKauAF+rLo2tebjVp62ibnREQLTGCeC5eSpkm
	Bgw9Rml1aD24+XkaXM830R8=
X-Google-Smtp-Source: APBJJlH7gcILuvDgVDV9JO5o/DGB1QwafkQlP7u0x7eqMAt+VWPp/xc+Wz1AyeQEVRS8PmenMpT8aw==
X-Received: by 2002:adf:e307:0:b0:2c7:1c72:699f with SMTP id b7-20020adfe307000000b002c71c72699fmr1845368wrj.4.1689767733874;
        Wed, 19 Jul 2023 04:55:33 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id y16-20020adffa50000000b003144b95e1ecsm5135684wrr.93.2023.07.19.04.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 04:55:33 -0700 (PDT)
Message-ID: <f2b4d732-6168-4582-5aab-f3b335df31a2@grimberg.me>
Date: Wed, 19 Jul 2023 14:55:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] net/tls: split tls_rx_reader_lock
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230719113836.68859-1-hare@suse.de>
 <20230719113836.68859-6-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230719113836.68859-6-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_045538_332256_9AE6A84A 
X-CRM114-Status: UNSURE (   7.19  )
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

