Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6DBECAAA1
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Oct 2022 07:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XsJdSdf+bqB4ceqOhYHITapdH2
	IeDorcpxv/vG+tc/hYOXDUwl9s9zIQyl2rJTYAwpRxrGS5R0La0hgH7kX+nGvIU3yh/jacblg13re
	Pwp2PHBF10dhTuNUZK0wZ0Db1cEb00vjrXfLfOa5xYtc0euTCPWZD/o/Ontp7EX4P6Sbend85t99w
	FvTGObG8dAejNdG4Jn6q8mbqHE5Fu0j+N+zVofHMRWKLsW90jrHF291gwd66BhdlQunpMgTm1aHuk
	N8VRexnYVE/tjjOUjpvdzKeiA7IKA1Q0PuXs/rP7ACb4JvA8A3w5EJwGKl6Bnr8hXp7JQFaVXl4km
	/jrrjlxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omViM-00EeoN-7U; Sun, 23 Oct 2022 07:48:10 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omViJ-00EemN-M9
	for linux-nvme@lists.infradead.org; Sun, 23 Oct 2022 07:48:09 +0000
Received: by mail-wr1-f44.google.com with SMTP id v1so10979113wrt.11
        for <linux-nvme@lists.infradead.org>; Sun, 23 Oct 2022 00:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=6b/8Z4farnjUsGR4ZuscTB6diPZcFcbDswslOG02j8XsiLq3y4CbKooRQmQGYzsidZ
         Hi/leZUf6PgovPoCnFghZJ6Q7ad/9Ufpp4Qp75xup7Ie32jBPMomAOWncogNsd1m2elI
         azwJkU9G9mDVpoq5IrbkskBh4efmRB0NSUibsPaKuocfji+UfC2wQnOA1de+tIoeYHJI
         gqQdegj/PihZmO6Aom5C7oEvZqBfao/QkEaISNqA+MHRMaiKOPCLGBX+9i71c5czSzV+
         tuEiBiQ6x/5sl/Uq8hKfmpsUd8woPL7M+fq6xh/816xEeRqGClHguo3HuAoljYLZj1tx
         bMRA==
X-Gm-Message-State: ACrzQf2BgfS8Djqs0WJH+NVFi707N3YoD/c5mPcf6KnzAlTobNFoKK3V
	TbRWG4tcaUapaaKupW8eYog=
X-Google-Smtp-Source: AMsMyM5XSFqzw73AwdvbcrxsFx7bjgI89kEENwwOnUkZ+nl8/6H3qwUWSB9/FwIN3fAnvurisUVgzg==
X-Received: by 2002:a05:6000:1e07:b0:236:759:929d with SMTP id bj7-20020a0560001e0700b002360759929dmr10627230wrb.199.1666511283779;
        Sun, 23 Oct 2022 00:48:03 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bj19-20020a0560001e1300b002238ea5750csm7233376wrb.72.2022.10.23.00.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 00:48:03 -0700 (PDT)
Message-ID: <788e164a-4825-e273-d40d-4dd67e1b55d3@grimberg.me>
Date: Sun, 23 Oct 2022 10:48:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme-tcp: replace sg_init_marker() with sg_init_table()
Content-Language: en-US
To: Nam Cao <namcaov@gmail.com>, kbusch@kernel.org, axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221022174635.15643-1-namcaov@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221022174635.15643-1-namcaov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221023_004807_748992_4A1D14CF 
X-CRM114-Status: UNSURE (   5.49  )
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

