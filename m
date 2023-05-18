Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2D0C7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=hDaqlr2/CoHEDFsPBrpJplPS1R
	ZRHSxSRlzBU/Y9eCwdfy88ZhqceLEoZKJSeuMBXg0txoNTDEydxnhc0TP5vcu0LeOajIbDdyj57pE
	HAuqc6uHNdBLKToloVAWWLwvxdYk+ntQ1Nww0B6htWkyl6AsBsvdB4HC3JrPqXSo/XUm6gkKMckvq
	V+BtMLYcUu9ZAvUadDeQUyLfAC69uldbd3K7szpdrhXCyQZUskQEsfcVzJuXaLRY5/uNbFKsAP2QO
	RlXKVr9SkGmt+9/nEtpAtFw9voydKzu1GNhAUzxAMX+MZsrGO68WrDvqnjUAe+def3iejE00ykoz2
	wqDnc52g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzZGW-00CNTA-2H;
	Thu, 18 May 2023 08:45:40 +0000
Received: from mail-ej1-f43.google.com ([209.85.218.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzZGU-00CNSc-1g
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 08:45:39 +0000
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-96a2b6d698cso44951666b.1
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 01:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684399534; x=1686991534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=f2f/V5SPND0fR5TrNzHivuxPB9sNOI9VO+dpvEkDefw3lrqanlzdkfyq4va126Kz9z
         EA92ya6YqwaMo2onfM/ZWoK0TLKosb6F6yX6dBcEB4avs3mZsh7UtHqxf6BcFadkE3LB
         s+1FF0/GJJ8t54hT84BYfqIYoYjD4JGKIgEpcmV7fhCLGQYiMFWVlZ0VglZBixnXYK1+
         Y9nZx/kmapdQD178LMku92cQKh1VfuUYQ6+nqRirwRRrJXUSO424ghj63Es0Ks1Rpv1W
         FP3UsXpX2PNJQ6CzXw1ouCkc8+OuIM+LC+s0HRTlHYbzYVqGIxUehuEmpntXnB/+XLDb
         IxxA==
X-Gm-Message-State: AC+VfDwj/ay6GqvlfDibS8hvO5w3fdpKGU5S+dg79Mzp7jKwRIMKNNcl
	/Vko4nKzLzFTac1YBufzIG0=
X-Google-Smtp-Source: ACHHUZ5a5f7L6HRHfpxpcfvhk1QbUKKdGsBN4bRU620kbOl+2xKKaFj68X5XkLM2zqB/Pf0v01vMLA==
X-Received: by 2002:a17:906:20c3:b0:959:37cc:190e with SMTP id c3-20020a17090620c300b0095937cc190emr4900413ejc.3.1684399533692;
        Thu, 18 May 2023 01:45:33 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id kf13-20020a17090776cd00b0096a5d341b50sm673184ejc.111.2023.05.18.01.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 01:45:33 -0700 (PDT)
Message-ID: <50450efe-8928-2565-08e1-ebe3589872fd@grimberg.me>
Date: Thu, 18 May 2023 11:45:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] nvme: double KA polling frequency to avoid KATO
 with TBKAS on
Content-Language: en-US
To: Uday Shankar <ushankar@purestorage.com>,
 Costa Sapuntzakis <costa@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@fb.com>
Cc: linux-nvme@lists.infradead.org
References: <20230424232225.1975793-1-ushankar@purestorage.com>
 <20230424232225.1975793-2-ushankar@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230424232225.1975793-2-ushankar@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_014538_563701_3F3F88AE 
X-CRM114-Status: UNSURE (   6.73  )
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

