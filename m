Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DD9C43219
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 13:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6RLWOOup9LlQriHzt19UBMzaX71ZxRqkksjwbbdgwVM=; b=DT1vqzsCvThZa5EBwZVAcWqUy9
	k0RbcwLzGelKE1N8mvl/5eOd7XLejCR95sQ2TluWBhY+9eTMZjLxdHTnuIj7CSGKLWS9jc4ydctu8
	v6oJRb8oczRggGrjWXP0Ry+HJsN6OB18o7QwBDVPDHW3pr0adh8ZOvDQlJpq0jOgAwjnDrIxKiioE
	RpJ0pU4y5EfJBSP6kBwHHYcJOxUYbYm48W+Q3AGgkibPgPsUFsCHe15UzmwJiQqyZFi1Ac3HkGGld
	bPUPgIykfG1cdy54CvfH0dsR2k2jw+yvXPjQM+3q6MbZxMeW4ffwui5yweIY0UE7+VNh2E3y7QYBl
	Cw2Hh4lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovIOY-003rsx-Qa; Wed, 16 Nov 2022 13:24:02 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovIOV-003rps-W0
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 13:24:01 +0000
Received: by mail-wr1-f52.google.com with SMTP id w14so29884977wru.8
        for <linux-nvme@lists.infradead.org>; Wed, 16 Nov 2022 05:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RLWOOup9LlQriHzt19UBMzaX71ZxRqkksjwbbdgwVM=;
        b=6MnFQxJ72dXyWd1OZCE5ZMf8pe6skdW+mMkFL13G3PndnN60HW07kHGgiB+aaVWtJw
         VMUmcpZZpc5wn7XrKTo0AgZ+5OCZ6nUOsgl2bVbAewtNRlzaael31sXr0tuxwLbe1qbW
         PofZLpS7MI0Zr5S8hvWp/WhXXXAj7KMN/Q/KAwf1EuNBeo4RLxPLY0mac4mfQsk/4Aku
         1GmJ4Agi9WL5QpvEs+0U0M+YRVQfW51jrD/AfY2181ht/70w0i4FuvYV9Qpm00BUUY6f
         OvtnlteyFC+N5lAiNqO35SmkH+/nTnKNfuO9lnTOsQxuC1MMHSjEZBTwmP+K5p1ZNAjL
         2yOw==
X-Gm-Message-State: ANoB5plWBtlIH4u6DPVDl7o14RBJmF3e3NYRPI4UxuNc/f3wwIkiTQOn
	4SVRyFXXexXru5HDpAe4KsZv0WrYTDM=
X-Google-Smtp-Source: AA0mqf4B2i4AkSIE5/XnAHS4Ttyf2Uk8xIUabLZxEKftk/UIlRdSqbShleF/26bNGqNmJnwwIbQENw==
X-Received: by 2002:adf:ee49:0:b0:236:6324:5365 with SMTP id w9-20020adfee49000000b0023663245365mr13681113wro.565.1668605038086;
        Wed, 16 Nov 2022 05:23:58 -0800 (PST)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b13-20020adff90d000000b0022584c82c80sm14860375wrr.19.2022.11.16.05.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:23:57 -0800 (PST)
Message-ID: <1ee364d8-4aef-acf6-1cf9-38787ddac288@grimberg.me>
Date: Wed, 16 Nov 2022 15:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when
 ctrl->tagset is NULL
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, lengchao@huawei.com, linux-nvme@lists.infradead.org,
 Gerd Bayer <gbayer@linux.ibm.com>
References: <20221116072711.1903536-1-hch@lst.de>
 <e5de54b2-4906-9902-c150-732718a77571@grimberg.me>
 <20221116132225.GA8071@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221116132225.GA8071@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_052400_052031_D5DA4AE0 
X-CRM114-Status: UNSURE (   8.49  )
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


>>>    {
>>> +	if (!ctrl->tagset)
>>> +		return;
>>
>> Can this be placed in the pci code instead?
> 
> There's nothing PCIe-specific about this case.  All fabrics drivers
> support controllers with I/O queues and thus the I/O tagset, e.g.
> discovery controllers.

All the other drivers check that they have IO queues before
quiescing/unquiescing them.

