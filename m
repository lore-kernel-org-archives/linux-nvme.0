Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212B3C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:19:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDB0610A6
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCDB0610A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=qeF8ndeZ30KiUcg7BbgElyLNqH
	RxyFfMcVxvy+M28Jhn47gAG3m0BWyWKx5JcF0txXtSImT8SERC6N8FYiUAWJ0Q7WH34aESsMJpymW
	onypVxKQQT3zs8h/P5YOQEOIfaDEo0RENGIPnJeXL9vgqALjyUMhrUVKtYE55JPPpEcTaviaGuQBI
	m82YhsY7+O9Q85U8y4+TiDge87QJXelpk5vn04VaCCtv8+qIyTnPG+qfJtd5pWcExoJRHBFkj+HMH
	6H5m0nOqxGH98oPGIX5V7UbMVQTIjGIh7prHWxv4ucGlZM18yMJ5cKexiOdFuWo9qZibFK1fqsAap
	Jnx/KqJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ2jH-004RLP-V1; Tue, 14 Sep 2021 07:19:43 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2jF-004RKD-Un
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 07:19:43 +0000
Received: by mail-wr1-f51.google.com with SMTP id d21so10829959wra.12
 for <linux-nvme@lists.infradead.org>; Tue, 14 Sep 2021 00:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=sDpLzUsfcwlZHg5J+x+sqYr7tCct+kxuXNsmp+HmeRGUf9YDHPcDZGl/o34AqiPWk+
 5Ohtfc1s4q5oMP/0nII2hZmbQ/wNvylcLqlI5qA/x5JT7Br/TuSYvOlDrA2ga7nJh5XJ
 LAntbIt51sr7ZIuWnQmRG59fRthT+h1UZXLg8TzHaTTn0G9xjQkCK7hJmEbxQuNaPJzq
 MrJgf3//gG5IRQp95wnWJEtq9YJVFe/C/ITBFMwmnKGTLJOTlUsHGRNVD7VKqMUkaxXP
 bJROt9VpH84YfDIT0Y1OT6UrIx0+CqBheOgqsQfv7yGkl01ac068FFdO1FZBHPdwKrwP
 Nimg==
X-Gm-Message-State: AOAM532Ef3pc4wYA8GLe3M377XTmuEtyAmgNLZ2BJLZIcgLwng6qJl/F
 JZKmT7vuFiBHINXEYV9Wp0IPn3J57Q0=
X-Google-Smtp-Source: ABdhPJy9z6CpITP67ev5Ol8EfatoT8ipd25xq3VsulzVTvvzDTCzJ1JtAavl6Y6hJgM8XBImgbNQUQ==
X-Received: by 2002:adf:b748:: with SMTP id n8mr17074321wre.133.1631603979895; 
 Tue, 14 Sep 2021 00:19:39 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id k17sm9500325wrq.7.2021.09.14.00.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Sep 2021 00:19:39 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: remove the call to nvme_update_disk_info in
 nvme_ns_remove
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, martin.petersen@oracle.com
Cc: Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210914070657.87677-1-hch@lst.de>
 <20210914070657.87677-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dbb48ddd-dc90-782f-c129-275ad2f96ebf@grimberg.me>
Date: Tue, 14 Sep 2021 10:19:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914070657.87677-4-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_001942_030805_7B7607D4 
X-CRM114-Status: GOOD (  10.09  )
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
