Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBCEECAAA1
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Oct 2022 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=FFd0SMttI1V7EIzxcWcPupIUW3
	VNZgHvH8C2QIlHHY4uMd99R4jTiWxvh6aS/1nnLh4lICVheunuVQM4a7fporuPCJIP9aPeaA7TUL2
	iqD+lChlbyBc3xpe2MBxWIUvTK/ILZuQHYwjK2z/1/zJ9H915GnyqS6bVZ9cc7Uu6PEdI0yN+0/W3
	V1oz5jqS657sw7afmS+ff3I1Nh0tmTwWz7QCn+O5GuWrOl6xNERzHmhkpIG64tR/ATQiy485/a04n
	7oM7BYxv0j2xRh9GRdNlhVcEJzLIinjylO4R3gEOgQ6+SRtf1nZqwiMKcqgaEEdBsKEKdDEgyx2/X
	Zwt/4AJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omWFI-00EhfK-6P; Sun, 23 Oct 2022 08:22:12 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omWFF-00Ehee-Od
	for linux-nvme@lists.infradead.org; Sun, 23 Oct 2022 08:22:11 +0000
Received: by mail-wr1-f54.google.com with SMTP id bp11so10683254wrb.9
        for <linux-nvme@lists.infradead.org>; Sun, 23 Oct 2022 01:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=k3CWL7xwtmlHci0y7Q6KRuWpzSaH2x2CD7fjz4vVFxc+MQOcutTvT4qwHrFYNuEM8h
         JSdfJga6WCl5s7mpIu5ab+4my2pvAUcB/QzrwLCnMNaFUtSCBF5E8WH29Q99RJVB7FT4
         TRiuguctpXSuZciQlDD4wc8NKw73ffT16GFxeGlb9Mqx3cgEg7eqJs7WhWzqdqQcc+qw
         KjzjFEWLBPGsHSow4mXhB5wE6p58xhAQTkD/FbiJwkZLVoxopV+KAhO7vhGeLXsfyT8l
         P45XKO1mp8FKyRtpET5FfzCpL3iLGachWQro3jzJNOBTbMiwuiF8A8wtxQ+zmTMA9Fqy
         HWcg==
X-Gm-Message-State: ACrzQf0H3dcVbvFW5jnQnmn9RGoM76DxJY+RvHdvqm1+0yMDCWCDLufm
	HLXzbVWK6yfad9dpRSxkabM=
X-Google-Smtp-Source: AMsMyM68X5PsBPKNMzR0gTgAo/dRfkj4XW1d7ZOsLfr1huNVWiG+V+jvTBzflTVuoTGafkGEXWWNGQ==
X-Received: by 2002:adf:ec03:0:b0:22e:4d3:bb37 with SMTP id x3-20020adfec03000000b0022e04d3bb37mr17278380wrn.665.1666513327901;
        Sun, 23 Oct 2022 01:22:07 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 1-20020a1c1901000000b003bf3fe1d0c4sm7459807wmz.22.2022.10.23.01.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 01:22:07 -0700 (PDT)
Message-ID: <375f492e-6080-9b6a-a1a9-a552649e2229@grimberg.me>
Date: Sun, 23 Oct 2022 11:22:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvmet: use try_cmpxchg in nvmet_update_sq_head
Content-Language: en-US
To: Uros Bizjak <ubizjak@gmail.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20221020153540.8226-1-ubizjak@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020153540.8226-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221023_012209_809724_BD186ABB 
X-CRM114-Status: UNSURE (   5.94  )
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

