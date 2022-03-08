Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31906C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i2j8SLv3P7/SGHzTtFHb4UdzfUJIgb5gW1GNDYKszPk=; b=Ctvar1zkHOVqUAajoSLekCpX+m
	Una/9tfeE1UuMZNaqeIbGpZN2Q5C3FtPT6xvSaxi2yGJiWVM887RUFZC2XHLwP3d7Ec5kqFGqjXiN
	pIfWnMQtSvVysAKN21jJg3BSyq16l9jAMw7nderCJCcT7idscctdMVUOWCcXPIXTIPp9rM3wHL/GB
	pJ/TrhbNBxd4z9Z0RQasuJtz4MkzjZeuq8ht2NF/kUogOiQ7YokY1ELyjWpHRTG3Z41b9Lbe3W2bC
	ZduU42gMmCihJnq+RJicZB0a+BvDGYdjdy4ZNUo1ojVsT/UiJBNGSEJ7tbWCU9Bv1xQwLXw7UPTpD
	HzulB/7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRjKh-006YWt-Rd; Tue, 08 Mar 2022 23:33:35 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRjKf-006YWY-7i
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 23:33:34 +0000
Received: by mail-pf1-x435.google.com with SMTP id d17so718066pfv.6
 for <linux-nvme@lists.infradead.org>; Tue, 08 Mar 2022 15:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=i2j8SLv3P7/SGHzTtFHb4UdzfUJIgb5gW1GNDYKszPk=;
 b=DQQqJPjN3oYlQGTHJ2VJXj86x1opGPUz12vVQjRErckxzOuP04IqEFYLTOiFgzfcJ4
 mz7FsYmUTndZ7dOQSaduQRjPcTiiyD7QjaRGpFu+9KcfKDEvJJOgsVYFdT5ilbwJl8SQ
 tnaVTBOjaaiUVEKQyxYoUC0Eq/bX3A3pkyN4cL5LqW3ACNUI0GBCIXX9xmFkab4v42nw
 foIYn25OdouEnnSa0RYBaMXu2Hgaf414/oXEIa/v+P7lpvjDlqcVOBbjHg0TQw+yT/WL
 Z6yMrfZfyQ4+VEORoyCL/DV9lLorwADI43v7IfKgHqWbgOoPAH6XW7Hpac364qyEOXOS
 MGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=i2j8SLv3P7/SGHzTtFHb4UdzfUJIgb5gW1GNDYKszPk=;
 b=cqJ89X8kjojpDZsowfaDxXRmjftlHnZ9Yatgfut3dSYITGSjvP8imhR12wNvFb0xte
 GAJrON3M8Dw/+47FNTDlZhWUjZrvCYhDBBO5B0szUwxKiK9ppms17SeCxhLVH8RfUADe
 mEmVx/EEucdbH5ROnafkzih4i3xwurg8GkNRoxPfM2fnTIAjI5GjF/lXH4RdsGF2t3u5
 2Vjojwvex2lJcwHPs7vU0Gd3RToVaZ31rKTqSB0mCmeT4ADr/CthEFS8tZm9s+5cPCE6
 4qVt72psdybawHylQ7Ls8hPJfR+qXFwzZJvv/+asUqhJUvMTEwF1juq2HT48hBCgVrtq
 cdRw==
X-Gm-Message-State: AOAM531C+90Qp68jBeR+mfkgH2K0PfhNjhV7vOfjW15NYNA6IHq0qlVR
 OdtFgW5ayndWNbQvFsHLygf1zA==
X-Google-Smtp-Source: ABdhPJysspVLa66H3KCr6E4o+4W6iz5FLMEu8rOfXam6CcdWO0QbDr6NrOMgYspHehYQj08NxvCI0Q==
X-Received: by 2002:a63:1d6:0:b0:380:a063:660c with SMTP id
 205-20020a6301d6000000b00380a063660cmr2928612pgb.149.1646782411774; 
 Tue, 08 Mar 2022 15:33:31 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 nu4-20020a17090b1b0400b001bf497a9324sm4420524pjb.31.2022.03.08.15.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Mar 2022 15:33:31 -0800 (PST)
Message-ID: <ec24258c-6e52-8ff0-2cd0-ac25de35bca8@kernel.dk>
Date: Tue, 8 Mar 2022 16:33:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/3] nvmet: fix compilation warnings
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me
References: <20220308230022.8863-1-kch@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220308230022.8863-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_153333_385821_1C54F547 
X-CRM114-Status: UNSURE (   8.93  )
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

On 3/8/22 4:00 PM, Chaitanya Kulkarni wrote:
> Hi,
> 
> Fixes for compilation warning for target.
> 
> -ck
> 
> Chaitanya Kulkarni (3):
>   nvmet-fc: fix compilation warning for register
>   nvmet-fc: fix compilation warning for unregitser
>   nvmet-rdma: fix compilation warning

Nit - these are kerneldoc warnings, they are not compilation warnings. I
would reword those commits.

-- 
Jens Axboe


