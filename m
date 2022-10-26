Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4411FFA373E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=fpb3PWt/hEXf3yoJ4foTw1es95
	i4QToxYOJ/dO5mRtZgP8sI66nC44T0xn0I1u8m/RuBSPQotAUaf5GcmvzOvel9OK4bqxpsDF0iwxk
	mOOMy/cHafhkK8yoMKZgToYHL2JgpW18+yhjbHop7ahABXliaNaASU3K5YONfGSOoYPzQbmvmJ0ZI
	FjbZiWG47cjA3KFnkC2QGpgSYKiyb7gOEMQblIHDB5EXIFOxVr/VPNtb6kZATAMQN2L5inqebVtR3
	oj8+vY8HQQZEolhiNKV65Ji/pMDEFe3bSaeb3cnsF11f/dIJag8HDjSmMn1uL9BrlC3SEbpPE3rY1
	rutMOWkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfzk-009Ksg-IL; Wed, 26 Oct 2022 12:58:56 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfzg-009Ko7-Ul
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:58:54 +0000
Received: by mail-wm1-f43.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so1488161wmb.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=wjgjGFdzUhRf6RMpyta0ytKBJASihDT63RCp1I9XAjKBGJ+bu7J0yubzPrTHlOLyKU
         x54PYqCWX9JK0q42vOMZjvdD1+rqIjW/zuTIby+tMdozTxb0qfGJ6F+yRm0TopRKtj0z
         yiyykKGoHekXQpeoAZjM05+/2MLF+UxQd2Zv8zaZ9pS7iM5lbMl1n+o0i/vXBPEfTmkO
         NHNbJ2pXZYClyAhTBfWUlp28RbtTh8Y8Ref3NCYSw7L3nymAZKWtVk6Y4PDA8+MJpOYI
         Ih65MhfzwiNSIh00SQJ9RXfpXVkQCJq4lBAM7aMDZEtEHlOgxxBDT7SDpNHHI5cNXk/U
         KtBg==
X-Gm-Message-State: ACrzQf1rrGhOsbu+FbdR0AmlW+yHu9+v+f0/K1MOR+Dyusg512PSCvd1
	TnwUSrEGpZjMDthvyAd2/oBL2zOFPKk=
X-Google-Smtp-Source: AMsMyM5vTwNXD2B3fsKTpl+TMNn+mB3Xpe4zOea8a8MY9E3qVzdVXi9FabT62QrQg3zPFcNHrojVig==
X-Received: by 2002:a05:600c:538b:b0:3c6:b66d:4027 with SMTP id hg11-20020a05600c538b00b003c6b66d4027mr2289881wmb.146.1666789126359;
        Wed, 26 Oct 2022 05:58:46 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d58d0000000b0023662d97130sm5150608wrf.20.2022.10.26.05.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:58:45 -0700 (PDT)
Message-ID: <5d8a1201-554c-0273-351e-c9fb7e32509b@grimberg.me>
Date: Wed, 26 Oct 2022 15:58:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 12/17] nvme-pci: don't unquiesce the I/O queues in
 apple_nvme_reset_work
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-13-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_055853_024637_C5954AC6 
X-CRM114-Status: UNSURE (   6.99  )
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

