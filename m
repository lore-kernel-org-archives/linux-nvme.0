Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809D1C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 10:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eGMtX5bq2CXEA7uX7oZNjMMx95I4cC1n8dbf9nmYM3w=; b=ya8CjThD3Uu9uVh/C59nKN+MbN
	hDD9glJR1KBUD4EvorfzCjAJ2K8Dn2E3W2zE21CHmLTyn7gocE1CL+1ateaNyVYav9UIdxYYyQbFr
	7UoyhFtFoPlynoiwuxdz8mwBUnn/fQ0jq9g9GrUnsiWsBoJvFr8iLClSIyeqMd6gU3GtH4TdLex85
	WtHdgkfA/JrTHGw4z4cWd9M6u3TXTq619cWq2wGgRqmDr+SnfPijaOad+0XzrVd0fg4PdmvtHyoR4
	wDFQW6kIsL4pdtKuq2WPebW+w1i1dSa0KoWm1N+wTG062rVZA6SWQ/g3ThPJVkLUzEaawPdhrKznm
	wOL6wMQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWyYA-00DMza-AF; Wed, 23 Mar 2022 10:49:10 +0000
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWyY6-00DMyt-F5
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 10:49:08 +0000
Received: by mail-ej1-f48.google.com with SMTP id yy13so2017268ejb.2
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 03:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=eGMtX5bq2CXEA7uX7oZNjMMx95I4cC1n8dbf9nmYM3w=;
 b=bdIMlUUpefkEeuqGPc3ZwUQKEdX11/OdpjfAUK80Hh63OGx0kqwrIClaZv3MNXuxOj
 +W6V17zDVn1V/Oyce97pLVAl0F/Sm6o+V1niqSDInCI+Af76SZ77VjRLCY14tfOWHWIg
 aFncSqpK/wrvDYd+8o9/LjyUEhPWOXhCdhmNHkpULg6Al4jodYgAkbyT2SZqsH4SOYjG
 Tu4mjwA1oX6AcIUCBzbMmYWptumIJq0NOHVOdxMsIQuopfXdJA49s9Cos3UYHAd7WZ0m
 jAKknDtjTY1L8rAJkXu64ac/pkfNlDAYTKOW5w8sRmqRwPFw0qMwOa5U7lbnVAHdDj+c
 tq/Q==
X-Gm-Message-State: AOAM533ZmZ9xRK29v4DdQbKNSm1NCVmsUw5wqsy6EUHYhkMWe61ASqDh
 KitkUCVHvVcCM5RF3BmnGtM=
X-Google-Smtp-Source: ABdhPJwG34T6cx3LbmLDYMZ/elUianiewDCWlaa/14u3rjClLWirnN0Wd5Ht+9XPWqvvETWE8i0Riw==
X-Received: by 2002:a17:906:bb01:b0:6a7:df9:d67c with SMTP id
 jz1-20020a170906bb0100b006a70df9d67cmr30264035ejb.733.1648032544598; 
 Wed, 23 Mar 2022 03:49:04 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 sa32-20020a1709076d2000b006df935924c1sm8400599ejc.59.2022.03.23.03.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 03:49:04 -0700 (PDT)
Message-ID: <154e0b40-7d52-fe58-fc56-d7c6f36b80de@grimberg.me>
Date: Wed, 23 Mar 2022 12:49:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvmet: use a private workqueue instead of the system
 workqueue
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: James Smart <james.smart@broadcom.com>, Max Gurtovoy <maxg@mellanox.com>
References: <20220321115727.774650-1-sagi@grimberg.me>
 <43893170-e958-3cdd-e01f-c766126e896a@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <43893170-e958-3cdd-e01f-c766126e896a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_034907_465278_908F4422 
X-CRM114-Status: UNSURE (   9.52  )
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


> should we have the same commit for iser Target ?
> 
> it uses schedule_delayed_work & flush_scheduled_work as well..

We should. Can you send a patch? Or should I?

