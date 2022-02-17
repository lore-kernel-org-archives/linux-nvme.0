Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9776EC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 12:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=1SFOAm6ZSDjMFltvU34Unj8Hye
	a5PxJkFKAz1hhEDgrLU3M83+yJzNk3T5ypCvIATgOvzdFEs6syI7ViXgOdom+28QkCr5VxqzRzag5
	bk+JnLunbXVgAxCxVLuVxyQmQIlUwbSqWgs434x/wLu9BG5ugTm61bDfT2fnwSagoblKriX1lqdwC
	tXUNr2egyMQ4KBNohBXkXu2y+EfPMK9riqqgsfqAzqksnw5bfBvTPPIoh8A7M8pm9Iv7ATr7+tP8F
	FNK+7ECAUPSostXz8/blYpnzwbPj8cueQlMJLGe64BAKU8/99xSEvJeoL7AOdk1LknxxMka7BD/K2
	MlcfqLDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKgIV-00AUgs-RJ; Thu, 17 Feb 2022 12:54:11 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKgIT-00AUgJ-Av
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 12:54:10 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 l67-20020a1c2546000000b00353951c3f62so4000146wml.5
 for <linux-nvme@lists.infradead.org>; Thu, 17 Feb 2022 04:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=y85lVEHjF3r0OMbJuHX/catfHrb2L0uW86DpXJaZgvSqHsO9qoDshTDq+sptBHV6Z2
 KucqicbrWRT6IIHdGPhmFedKVeu0lU1d6jqWdflw1QxEH0eH06TGjXwyhilPm9sMH8tg
 ruON3LNQ5X1VnZf0j+9Eida5EKNDIzq4pieQFy4HeQvaPnIY5r3PRw++4vGzGVJbG8CJ
 +XyUZPhC3XAHXdEE66xjyGjuRNXIMhGfkOhUlDillhF3zYZqIa6QAHR0q261lHW+Nf4H
 L0ZeG4d+yU2G0Tar9iPHEb0axyhkAetCPYUHns34/3F5M14pfttX5j7h429frZhTFE5j
 zg7Q==
X-Gm-Message-State: AOAM531X6imZsvlNRywwxdMX8FPr8i9oBtaByuXzOAD7JmWd+tuAR8ep
 gNUJ+AY+DIs6vzugzGJXbttSxWkZJQ8=
X-Google-Smtp-Source: ABdhPJwqHK1mcwHOtWnhj2Zn0qY/XXaoU2Xqb4f0AF05uGu02xnYqvO/rGZcFfY8cVDRx6mMhXFBNw==
X-Received: by 2002:a05:600c:3b83:b0:37c:e735:ad87 with SMTP id
 n3-20020a05600c3b8300b0037ce735ad87mr2574445wms.120.1645102445164; 
 Thu, 17 Feb 2022 04:54:05 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id r2sm28534947wrt.65.2022.02.17.04.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Feb 2022 04:54:04 -0800 (PST)
Message-ID: <98b5a633-0b78-f3bb-f9c3-a2f1f3f13bc5@grimberg.me>
Date: Thu, 17 Feb 2022 14:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] block: fix surprise removal for drivers calling
 blk_set_queue_dying
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: kbusch@kernel.org, markus.bloechl@ipetronik.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20220217075231.1140-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220217075231.1140-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_045409_411614_4E97E69E 
X-CRM114-Status: UNSURE (   6.38  )
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

