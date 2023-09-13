Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEAACA5537
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fT3l7i+aaLrI/+eQTFzmHILyA3PGI+5lHDaISXZ0F9A=; b=PPXDifqJCI1iM2cyn0cazD0yZA
	pMC+P7/jCVu9GlCqidFmMfgsNGlqQyDNOOqsp2aMaFiGln48ep/5s5FvIf+qbIHdVgec4wSVN44xS
	V0lQyyRfIw1PxpWxbXNMa4Y0Tktczc53sTg+XjabJc0P+FN/6uNM6qe2dK7D7RVIfeiTjg8SqhMfo
	8IrMJY1PQS9wJ31Fdjn0bXe2gFm8e32UA6k6wRe/CNcfD2UKE5g/9Gp4pWyKB8gh+NP4z3xKeYlmY
	SU5Glx2XoaXNe3R2yDyr4SY/uJ0oDYdISLKojAEV6UfFs0/eZ1MFBuji9HJcIUAYpot4eWE7Pni3b
	OF1JqmrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgNSv-005f3p-0x;
	Wed, 13 Sep 2023 10:51:25 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgNSs-005f2j-1H
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 10:51:23 +0000
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5221bd8f62eso1353248a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 Sep 2023 03:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602279; x=1695207079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fT3l7i+aaLrI/+eQTFzmHILyA3PGI+5lHDaISXZ0F9A=;
        b=f+SFZrNPhjP7TGWytgeX4QeO2T1sYnZKtFEP+YNK7fLbhW5XhmTABA6Gze0mT8aNtn
         GHpa9zesN4c6omnVa3Jl3cxCi5zaV3HqjDKA5SDh4fT2YguJpwhIJPqz8SGNOWtwFZ8P
         iPM73vuniBIOM87GshepXWve8iuuTGe3woB2n6xWVUch5T7rcmxiQR4T3Qge+nv7gkfd
         RaRc0cVleB8qBG14yNkcjkPZPRYC2tP3yfRd3y3kpsmW8Feuw5QF/OchEJ54nWPOsMNI
         hc8Et41i9MRfjQTgk97xSPsQD+0N2pPKTT6GxzunNlo60tgEu4ibrLDvqfVE9pU/AbMO
         Eo0w==
X-Gm-Message-State: AOJu0YzGSAwp3d2NoMjILxGPp8PqO+uL2mYha8YdYU74scNu+SYChB4T
	5GPwvpQVPoG3IvnajpiIvrY=
X-Google-Smtp-Source: AGHT+IEAyrfqpWpyxAVoS13uAEsG0q/J7bO9QB2vL2sYr9c13QouX2BwWVUN1EXe3xxjxm+RtTyWxA==
X-Received: by 2002:a05:6402:3493:b0:523:220e:a6ca with SMTP id v19-20020a056402349300b00523220ea6camr1797766edc.3.1694602278902;
        Wed, 13 Sep 2023 03:51:18 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bc3-20020a056402204300b0052348d74865sm6964078edb.61.2023.09.13.03.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 03:51:18 -0700 (PDT)
Message-ID: <ef66595c-95cd-94c4-7f51-d3d7683a188a@grimberg.me>
Date: Wed, 13 Sep 2023 13:51:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v15 06/20] nvme-tcp: Add DDP data-path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-7-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230912095949.5474-7-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_035122_496258_ED0E8DA4 
X-CRM114-Status: UNSURE (   7.56  )
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


> @@ -1235,6 +1330,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   	else
>   		msg.msg_flags |= MSG_EOR;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +		nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));

Didn't we agree that setup_ddp should move to setup time and
not send time?

