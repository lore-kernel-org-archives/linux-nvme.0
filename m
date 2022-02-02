Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9924C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4SeKf0Pv3KI7vfINkFZfYLytziKJBKAleO/0SVcLdYY=; b=0WirxnPHUOyPZHjFHiqiBP5o0u
	j5T57eGlIzIs/6ly0dLAFpFghuHYH5SqeK+hPZuWLlg46TuKls1PsNb98HY64zq4dy3V8bXqkOB9g
	iPZ4h2iswuGVkEIIkG1GVmOX6XYDLYRCoDeOHYs0PcrHmMyDd4XT3KhUXvP+CifcJP+HY/2YM+4lf
	KKV01BSYhHGYptlj4OrHQBFIqNF+/ptNFFZLVmcVICu7UkggRNLb+4OCX19NwqGAWc803HTJslHWb
	Itfli8pWudFznHo/r8a8mXxn2aiYZP6xerDZSzm+vjrv0uaQ0DzbWZZL64OteEUz+iaxE1BGM0Cwd
	3kUfCYFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFKZ6-00Gc4U-1A; Wed, 02 Feb 2022 18:41:12 +0000
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFKYy-00Gc2a-Op
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 18:41:05 +0000
Received: by mail-pg1-f177.google.com with SMTP id q132so242707pgq.7
 for <linux-nvme@lists.infradead.org>; Wed, 02 Feb 2022 10:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=4SeKf0Pv3KI7vfINkFZfYLytziKJBKAleO/0SVcLdYY=;
 b=su+5ZWl7+aphWmoSfC/TKTdL8Rh8nVw04y+14eEU0LhsEYOn0PwqE4sJgYVVGvKFPq
 7qoOCLfDnUFcEFkY5mlDYkTp5zvtkvTaY8jBJerFW9JPqCyPgPbR11VATfKCy5zld7wb
 MS/dqqL8BVqoM4v2dEYcBpZKZmQMZlg2X4QnpHh70vc4HcjAh+SEi9v6dru8jJF6Im5S
 hw4iuBFVyNjuX4J3k4vMZLu7OLlM88SfHWqaMfyTIHMfqe5vs0pwYLSXyiLDv2Ywr9hz
 ejk3RXH/uDxoL3NgxOFN9K+V1CYweP8iM0oNZScLwEXKjqbqpWkb4hgHhjWrYLmaQ93j
 jAYQ==
X-Gm-Message-State: AOAM53375Yxn+Sq6TugKyY/U7TshnHQPTiFRdn/XBhNQfjM0b5dD3XeO
 TCrBE2XWLg8T3wbrwM+OsPc=
X-Google-Smtp-Source: ABdhPJxKTvuMXBDvU4qW2/15ak/LKcMtqbqZF8vB1gLRYjaQ1c1OMJyU+DSvLA0785Up6vFD7FG4mg==
X-Received: by 2002:a63:6844:: with SMTP id d65mr12349403pgc.56.1643827263302; 
 Wed, 02 Feb 2022 10:41:03 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id j10sm26668742pfu.93.2022.02.02.10.41.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Feb 2022 10:41:02 -0800 (PST)
Message-ID: <60060901-acd0-5b39-6d0f-13b0359b756d@acm.org>
Date: Wed, 2 Feb 2022 10:40:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv2 6/7] block: add pi for nvme enhanced integrity
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-7-kbusch@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220201190128.3075065-7-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_104104_845356_BF9829FD 
X-CRM114-Status: UNSURE (   8.12  )
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

On 2/1/22 11:01, Keith Busch wrote:
> +			ref = get_unaligned_be48(pi->ref_tag);
> +			seed = iter->seed & 0xffffffffffffull;

The "& 0xffffffffffffull" operation occurs three times in this patch. 
Has it been considered to introduce a lower_48_bits() function?

Thanks,

Bart.

