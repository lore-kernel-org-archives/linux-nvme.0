Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4027DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=sU1xItl/IbgAJguQ0EmLTHax7v
	PuIamNiCLOAC6ucNBdI8JRhruSiXW8codsE6arxzRgOf6/12ou6JokEL+sXHqhWgWwQzbaBDS6WVx
	P5kWJzTpwwmlKUI1FGxMCdrqy3PcNlBxNwn7Zb2T6YyHbAiYPaV5BdtVmfQXkZeIRS5c7UA9LVLdP
	DHqPahDomxjdpoJJQ/owYTCOrPxKZfgIQRfDOOV9YHqr3qNV9XtNyzyt7g/cY8BCk6TY3H+bBGkJl
	Lu1n3GX6yeLj5SfS43NdOGAoOjegqdIFc/ARvFmEvmF0C2LvcjtaeTYjcvdk5TicNeCVrvtGtN+5+
	WwjRKkdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njM81-00EzHN-Lt; Tue, 26 Apr 2022 14:25:21 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njM7y-00EzFg-AK; Tue, 26 Apr 2022 14:25:19 +0000
Received: by mail-wr1-f52.google.com with SMTP id i5so6663592wrc.13;
 Tue, 26 Apr 2022 07:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=COwhf5ppIMUAg1+HXc2xflcdwfus8K2qhZFuksO+REvpQGalrSeR5AO4PYpNtF91uE
 BRsQblav45UXCv2HjDixaYn2odyzszOOetBeCT7l4wGboIFQD45wbe7XgXykFhSTxYF7
 oecfsWYjjh2JlkoN3j1fNarSGRuwkyOqZLI4tWc07FQsILZWKTW278ykzf7LAwDZtAhj
 1Yxie/unSx18W6j0cozybIY0e9X/av+UVRYCs1foMaAbCVzKPiijU+m+pru4cMVGh3Ns
 MEDf4TFhmhR+z+jDW0RabOodKpv1GINe5/07hZ6vH6bs+b2KvwIXDL9Z3mNXcSlRKMs6
 VQ/g==
X-Gm-Message-State: AOAM5314JE6WR9ENT18jtWBp4HbVRMnmgYiCSXOCha3yED8rKGzAVauT
 NeqYhp5ggYxjY2bw+rzWfMw=
X-Google-Smtp-Source: ABdhPJx+tGjrozc2v+hkDAQGkKaaKd6tvj25GGtU09S+2P3NV6/kZmjHHHaKsKLq0MduUfwGvhoEcw==
X-Received: by 2002:a05:6000:1a8d:b0:20a:ab7c:efb1 with SMTP id
 f13-20020a0560001a8d00b0020aab7cefb1mr18901071wry.716.1650983116938; 
 Tue, 26 Apr 2022 07:25:16 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 j39-20020a05600c1c2700b00393ee3deaf1sm5525786wms.9.2022.04.26.07.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 07:25:16 -0700 (PDT)
Message-ID: <c658f5cc-7b9a-84ee-ac22-cefc03e3dbf2@grimberg.me>
Date: Tue, 26 Apr 2022 17:25:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 09/11] nvme: remove a spurious clear of discard_alignment
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, Josef Bacik
 <josef@toxicpanda.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Roger_Pau_Monn=c3=a9?=
 <roger.pau@citrix.com>, Mike Snitzer <snitzer@kernel.org>,
 Song Liu <song@kernel.org>, Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 nbd@other.debian.org, virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 dm-devel@redhat.com
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-10-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220418045314.360785-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_072518_362944_73F9461A 
X-CRM114-Status: UNSURE (   6.16  )
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

