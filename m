Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49A2C54E60
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Mar 2024 07:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=FB7TC3pQtCQh6cja939zVOCLJE
	dbEhOgp0JMDWzrgsm9KdQyC+3ZGTVyvto6qiyb2IzRZRVOlQrnu/3MVbq4bjYrgZbXP1Ndv63YpRV
	ADc/nXF1qJSnPfPWlyd5lQCX+FZn0gLme+lVP1yQcrYs5ARTt7q7CqjizOfuAniv3uUx5J1ca9cMD
	MPy4jOL/4CSJ8/thP81Cr41l8qVnQf1hGxXnR671JBXACrB+4MC4pvYPQEKmOkeOhTly4CxSVTeMD
	am0VukWFAPd6P2DeWn4mAlKPoX8N+LBVqxEFyZqxQlOVj9iWoob9OwLem5/t6WN2UGuzLLvHbS714
	CALrInMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rll2F-00000004gBi-2gKc;
	Sun, 17 Mar 2024 07:34:23 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rll2C-00000004gB2-07WW
	for linux-nvme@lists.infradead.org;
	Sun, 17 Mar 2024 07:34:21 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3416f02bea7so25183f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 17 Mar 2024 00:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710660858; x=1711265658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Ny8OBYsYV7JR6UodVma/AOmeYQoMwAzj+QJPZAi1pIEbacqUSrVTvGCUwD8jzXhP94
         R2tEbu0VUGsrru8R+qgUQ60hshgJTH22zyEf2FTGeiT+jpphwPEeQ0dI/AxcGta7/ejC
         Iy+0XyiWkorzPpH0SGCOvTjh/vg2iLf5JtBb0vKoCGRwYdmgnoaxXF1aSPMfYmlhYzFF
         vtqYdc9p2n0QZmL1SHo+LTgmo4mQZhfN7xMkR0HFqzRYVvKAIC3zlBQhFhEMLzH4ZLMB
         7JPlhtLPir1k2An6GLEEY3ZttGnPNxK+4Q7TiZUVLbL0IDj9GGCmkxQa4PX2+009wHnO
         0SUw==
X-Forwarded-Encrypted: i=1; AJvYcCVG3+Zil7becmLsVQi47EnL/0XDRea2BQxY1+mx/xPbs/8X+itMz6ZzkL7Qwelm4ZtQXAnFP7B7bDicOu1tyTn9krkY0PD+297pBxaw3fk=
X-Gm-Message-State: AOJu0Yzg5rrb+EFZFWx51hsII6+gBhmPJFBmPRxmfwo7+3RBRGtqlkJd
	1+zZWzwR8JaeVhpWvSe5YZcPyV55LVMLOg/qjcaTOLGEFeKWsSar
X-Google-Smtp-Source: AGHT+IE/o7X60HvPX9bd6eKTj+xZxjK3TOTidyqM0UZRPlt80TdREw//a4SDFk6Qmj3dBm11We7Exw==
X-Received: by 2002:a05:600c:1d9b:b0:414:9e7:152 with SMTP id p27-20020a05600c1d9b00b0041409e70152mr1532656wms.3.1710660858009;
        Sun, 17 Mar 2024 00:34:18 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id d6-20020a05600c3ac600b004140b96dd4dsm1503659wms.21.2024.03.17.00.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 00:34:17 -0700 (PDT)
Message-ID: <b1f351b3-4258-40d5-9074-5d0390d2afde@grimberg.me>
Date: Sun, 17 Mar 2024 09:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 126f:2262
Content-Language: he-IL, en-US
To: iBug <i@ibugone.com>, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20240315192747.1749119-3-i@ibugone.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240315192747.1749119-3-i@ibugone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240317_003420_072884_31D93DD1 
X-CRM114-Status: UNSURE (   4.56  )
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

