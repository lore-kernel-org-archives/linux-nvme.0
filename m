Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ADBC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 17:23:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F7061378
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 17:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8F7061378
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=1dqUlo3QS2f+VZ7UnnOE6jeHa2
	1SSaBZy9u+OEoB395E5O+1pi1zDiMc8JUFuPmlWgjJZSKY8KczC4jjaOikjFnjYU+H8r4f+OySSFi
	3OmY/jm+MdT0vrehg3Y0MD2W6WSMwXmDNYzgWVHUA5own78VOl0wH3LwKFAxAT0Bg96HbbeBlJ8Ir
	XD5+7cs+2qooIMPibJ6Adx/r/8ulgUvt/54HTNlR8ozHDgRwmSulCR9xvLlTHfXJONIMAm8S+gmfp
	VFGczBfYGW0a01xBeMAhO17cD8l91UB9qlGIVG1np7gAIQu1vaP9lg+TJg5CSEiHUmDltuaFAPV+l
	j2pu0DHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIDf4-0008qR-8X; Mon, 23 Aug 2021 17:23:02 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIDf1-0008p0-2B
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 17:23:00 +0000
Received: by mail-ej1-f46.google.com with SMTP id ia27so16341822ejc.10
 for <linux-nvme@lists.infradead.org>; Mon, 23 Aug 2021 10:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=M1vYhPQvNyr7hihY+VBGZb4ECf6Ix3ctmc7DGF33Rwkqyiceh07TRq+xVxSCW0BraE
 /FnAP+V2g+MELVx1WrAKQdzX3ktN/YdkJp8Vnom81cGv6Lh61a+xRu3Nrm6U6RD20oJo
 3LOcQ9aghJO2z6fR/e1MzqK+C3DNCktsEr6CkTCZyHCHcjOoy4fNYehAyUk+1Uf6ywzK
 UNyuvbgY2ZfLtENHttYPzCgRyEgJ9kMn4tGJ7pyU+cCM5z4bWxuk3huGkbNSQq0vpDv3
 v1kMNXqkooL9jTsVe62pOFtjNMs6SHckgQNshtHYfuWNzpT4vwMD1Akcmx80JpcGn9mS
 mPBw==
X-Gm-Message-State: AOAM531PlI1oOS+VtDzBFKixsUOCRlU1EFX7qRrMYNSFtU6i+vwZRZaE
 wj5kj/qiz7FpaXe/yztZhqg=
X-Google-Smtp-Source: ABdhPJzhQQj+1FbUSkhXJlv4z4LCBoifoOuwSSVN/lL3GU689ibnE7T8pYP3tbn2sySj3BojrvwNtg==
X-Received: by 2002:a17:906:8258:: with SMTP id
 f24mr6605489ejx.375.1629739377321; 
 Mon, 23 Aug 2021 10:22:57 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id 8sm7775687ejy.65.2021.08.23.10.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Aug 2021 10:22:57 -0700 (PDT)
Subject: Re: [PATCH 1/9] nvme: use blk_mq_alloc_disk
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>, =?UTF-8?Q?Kai_M=c3=a4kisara?=
 <Kai.Makisara@kolumbus.fi>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20210816131910.615153-1-hch@lst.de>
 <20210816131910.615153-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <40e534a8-ebcb-73ca-fe79-9170819114f0@grimberg.me>
Date: Mon, 23 Aug 2021 10:22:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816131910.615153-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_102259_163583_1C793005 
X-CRM114-Status: UNSURE (   9.03  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
