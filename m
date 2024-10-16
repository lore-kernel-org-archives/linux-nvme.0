Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD70D2F7CE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 21:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o7/oQzTmfl3LfFdw1gRVGm2Z3esJQ//sqqa+3PijZtU=; b=wZ6aoHv6mg28ppsLupOFETZKwv
	CSr6kWUUBfCbRGJ33l6ywQO4nsf/uOELdB6VYMsznBwKBjhqV1pQCU3MxJlKuCN/N7HJX70SLliQI
	LgFeSp59cX3n5OzTfHqTEbnCfpGrwJ1Bb36hw1sBSgtSLlOKiCKd1Dm25EwXzQZLJLi2JvudXhY2G
	b9jLe88Fvuf2DLNkgzc/0ZgfRKyKYvweqLWu1nZmxeI3YdZyhChNIjYoUzmMz9hyuw6zX3o48rYR8
	y/uDmen+8HUKHmrDHOnWhW+6/AcSr/HWLrDX44zWgXEoF3DKxNcMEK1h4J9X4fxC9vKFH5fpWL6xR
	AjdswcGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Bzg-0000000D6Sa-0EMv;
	Wed, 16 Oct 2024 21:55:48 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Byh-0000000D6Ej-0dQp
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 21:54:48 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4608dddaa35so103631cf.0
        for <linux-nvme@lists.infradead.org>; Wed, 16 Oct 2024 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729115685; x=1729720485; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7/oQzTmfl3LfFdw1gRVGm2Z3esJQ//sqqa+3PijZtU=;
        b=dlRex6wT0Jq/T7lKaOeJhlelIvfVB86mzJ/H8GoqjpGVc8G9pssWsQuWs69a7Ax/uS
         EXmhByg+yKR+SX6FgPkQDU+YWzvxhIB2zVpGEiACbAkH2Mz/qJ3bPzQQ1+V96pDW7Szn
         RECYM7pLxyI7jBxb1MWxdVwPJhruIcb51ILLqZjsw9p2IrY6hKS0VKZmYQsNrpekX2XZ
         VedfzuMaMiiS2AoQISsRE2KhjiWbc9+HiSN0+6WxjjBUxPRYWoPjaNSYd+GYt+newdua
         DIY6dfgbeH6Txml/cx4xiCssZElAGob0vbHn+L4QUx3TqdQdAPd+Qtfu4XIJgEy/OqrO
         tzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115685; x=1729720485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7/oQzTmfl3LfFdw1gRVGm2Z3esJQ//sqqa+3PijZtU=;
        b=kZ7v5HVy3I/XBN70lWK0oSpPnAa1XCVtK+wr2Bml+wOg4eE4JtRmVqnIqiQifdzoMw
         cZiPTRmU3QBLVtv53a1NBvKEsM+CcdgeEUcRxO9ifLImA4QJHER2CBXPlJOPk3j5/4/J
         0V0xrayt53gxtwkvTC4A243afbkw7ePoJgqHObIO9lOV2rtmCChSfv+0gpfYv/ZhPN3E
         0E3Elcu/DvyH1E7qcSBoiatWKex/EVxUr/FYr6cfeiNE+Iyqi8Ds0Znnrp4nv/W69iwB
         EY/I027wLyUL8w8wQ6aJZSRe3bGJ9PlfPe6E2n+UCasqZB4R9Z3gxunlt+FYiGn7qTPb
         DMcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOZXt+7KZKk2TL4Ti77dFQmb9sXF7MZN/K+4RFGAQYoDBYo+CbzwfE0E50bZ4+MRpy/vPOWupMkeZT@lists.infradead.org
X-Gm-Message-State: AOJu0YyCgWEKZPpdgn0+vvkdXu3Bsa0DCHTHVwRBFjy4pS97zMrxod2d
	JGYpWphL4xyvKYfMxh6fjAFcX5eagR3XB3mK3gK9sbbKyXUOzZHTjLrs3cO3swUcltI62AFsblp
	GkMX/WhO7lmXmomnKs6/ZrQNWi369Hvu4HOPU
X-Google-Smtp-Source: AGHT+IFy4eP2e7VM8x8VpzDnjFM776EvF7lt/iz+aEfiSQIQGkaeGC8XAsuXirjXZmS2PP9I7nmto2eqySCSyQGwff0=
X-Received: by 2002:a05:622a:5b08:b0:45c:9eab:cce0 with SMTP id
 d75a77b69052e-4609f693bb9mr363231cf.15.1729115684454; Wed, 16 Oct 2024
 14:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241016213108.549000-1-abhishekbapat@google.com>
In-Reply-To: <20241016213108.549000-1-abhishekbapat@google.com>
From: Prashant Malani <pmalani@google.com>
Date: Wed, 16 Oct 2024 14:54:29 -0700
Message-ID: <CAFivqm+mJ3RTo4ArrkjPJLj8m3vh=czt=sAXZ0iPN7n6=F4z3w@mail.gmail.com>
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring namespaces
To: Abhishek Bapat <abhishekbapat@google.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_145447_210348_1241B5E2 
X-CRM114-Status: GOOD (  14.00  )
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

Hi Abhishek,


On Wed, 16 Oct 2024 at 14:31, Abhishek Bapat <abhishekbapat@google.com> wrote:
>
> From: Abhishek <abhishekbapat@google.com>

Here and in the S-o-b line: Please use your full legal name.

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index b68a9e5f1ea3..1af2b2cf1a6c 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -546,6 +546,17 @@ static ssize_t dctype_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(dctype);
>
> +static ssize_t max_hw_sectors_kb_show(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     char *buf)
> +{
> +       struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +       u32 max_hw_sectors_kb = ctrl->max_hw_sectors >> 1;

In what unit is max_hw_sector stored? If it's "number of sectors", is this
conversion to size correct, or should SECTOR_SHIFT be used?

Thanks,

-- 
-Prashant

