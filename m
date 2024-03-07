Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D96C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 07:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=WUhTZLnOOcN45pw/kBmw02m5yJ
	YRp1HLsqPLOlNz3meLaiJNLncvvMsjnVvqMSoffPs1DXXCyW2QA4AKqK+0BtQ3bjK6mL/15p4iXtg
	y+2zPJwGBq7+XxJzZmBVV0Vj180sS++frS0pG4KwKS45B8F4ZzoOx4QobZJUXfidf+YiVzqghvfl0
	dXqfcK63KVdVD7iBv/8VBrDGXw1obxeqrh13W1TzA5iz415mQbhpQE3RMUT7lMYTlaWD9pVJ8ahwj
	f1xySstRhwzyROdnm36eYSNlNPphvK/MGTqsRGfiov/lu/tuTHFz2j9RNtNwbydVx4LhYFzTc/t8M
	+lozPe8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8dM-00000003WV9-0YaD;
	Thu, 07 Mar 2024 07:57:44 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8dJ-00000003WUJ-210G
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 07:57:42 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso187209f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 06 Mar 2024 23:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709798260; x=1710403060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fCxJloi3SBqIOGQLxIxA7xBUnTrfl4MIfbrrYxPSvi8+BQ55ZDf2ai2wfOXEYy6vB3
         TyBnqQNtU1FcWu+qkyTyFKkolltKNFzxq3h3lyP6lGWnSPgDuVSPD2BDKAU+cHeTVbNE
         V7FchYUfJybyp2N9DzBjxt9If1Dpt5iK0J46zy47RIjR2zWcG2avr7UOHa/nLcxByPgb
         BdJOanfIHaOxX11G49mdv05YmRiY6jgiFUiDYa26pQgMGt/EBQ0I2bly3wHcdoxwtBkS
         milUv6aNsF5yi8iAc61ze8snOVRnrQA45QZJpiF+x+0oXmXAqrjaHWOloaybGJ4Apl4U
         BYrA==
X-Forwarded-Encrypted: i=1; AJvYcCWrhnwDWpDE1q+kBxkeXBxKAz+PyX+JcuaSvAz5+K1/GzvYXqVVTq7f394t5LRSsejw+U6ka5yaKIjPBeGK4PTw8j3+oRlxmjj3CQVbNls=
X-Gm-Message-State: AOJu0Yz8p2UXaOqqdTAOpzEkG/ieH+h3CVeSPEXPyS7FMZ9QonBje7vx
	/1M87oLCcEWUx7nW/1li10LJ8PE6P3PLhfXbzop30g/vfUmAac7ygEDZxXCd
X-Google-Smtp-Source: AGHT+IG5lhEQGNUkMcHR0vrpqkL2hcHyooZEhhfCFO86J+mbekVN1LkQW7Px8knOLKbrAhSuDLeJbQ==
X-Received: by 2002:adf:e883:0:b0:33d:9e15:12bf with SMTP id d3-20020adfe883000000b0033d9e1512bfmr3905344wrm.3.1709798259592;
        Wed, 06 Mar 2024 23:57:39 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id h12-20020adf9ccc000000b0033e03a6b1ecsm19487857wre.18.2024.03.06.23.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 23:57:39 -0800 (PST)
Message-ID: <2c07564f-6153-4102-8a4b-045795b63287@grimberg.me>
Date: Thu, 7 Mar 2024 09:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: host: fix double-free of struct nvme_id_ns in
 ns_update_nuse()
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
References: <20240306060303.2615950-1-shinichiro.kawasaki@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240306060303.2615950-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_235741_532035_CF86AC5D 
X-CRM114-Status: UNSURE (   6.31  )
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


