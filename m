Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE66C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NG+ffPYMj+yYCFSVTzmeOZMCnVORFngyqGQtpUEnSKY=; b=sgCjjzQyUmXvoxAZCJ0+yDUJTZ
	Z9KyU5LsKcQuXmwZ0zMqvk8eKcj9wR4/235arenea4UM+o5yBHkgDHSwbzjGvkUc3RBtm+mUEYCsk
	+5T0RjsW3I//TqYYj1yK9pzZKJAai+jNyEVYEYc2jcwaaWhyHMBkNxHtz5by8Ya/qjMKK8poZ0wm/
	aGjOITk/BXnDenzhEE4SsvBg4+GXOpZUgBZxu+teNIrEQ4zyO52fJI/bXkRwn53OOyqxrdAzocWE1
	DHRFTSSioSgRHTq1/zNrLWhci482VeLZLSIaLeTtwKSTQeYM2zVqYsrH3T9Bd7ocZ3CsRce52FwGt
	XmiTNutA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8fq-00000003WqC-2SEo;
	Thu, 07 Mar 2024 08:00:18 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8fn-00000003WpU-0ksT
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 08:00:16 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33dcc82ecc1so161174f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 00:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709798413; x=1710403213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NG+ffPYMj+yYCFSVTzmeOZMCnVORFngyqGQtpUEnSKY=;
        b=iiG5IyIEwPwPEGR0C18qf4RKNbq6l+XJQtWJ7XjsjrQ8jX/fuoz1BpC83ZNiow+jjz
         JxYRMkYDvJ1ceT+h/0FX/waA0y/uVdO5oxFsiwWzsG5sGrTtkJMuCUmPDb3J3leEG3t6
         FZXh9RmUAi6CZ1KmjV4y9bQJ/9C7SL53TH5P2q3QUQ+a/fZZTHttzXjEeQ2VpCJzbdcs
         YzQdEo/nktef7MtNRui+cyIHeBRVieN7yvHE7qpO+x8nwbAByJ/CA2Hpzhq3TciG+P6u
         j9GlzY//GtNL7Hpimij/azEmyh5n3UfToQCSMtBbh7dDmCzJe8RtwmdIWFRKHxadZnyl
         0FMA==
X-Forwarded-Encrypted: i=1; AJvYcCX3F95VEAZ0ryv5HBZWRMC65fa97AlYoGSDhpfT8r1eDBYoDKe8SrcD23sVhwo6w2uk+vvSFWAxw79Svfh0CFSz9hsLv8E/Xh0X4jGlNS4=
X-Gm-Message-State: AOJu0YyZjoMR5WnZoUEGkxPwZ/jg8zcHNFNF8FUNPlKfcL7DM0Ube9Yh
	obS7mf91wUgz9bEJ4y/FCgm/PEkfL4pXCvRkyuhhO4KHYj2WpyHg
X-Google-Smtp-Source: AGHT+IFqCG9cuATTRh+RSt/5YBfdLTIwxxq+1zc4f2qnjpmr5ufn7l8N3h9rppqbqjqgaSmyZPPZgw==
X-Received: by 2002:a05:6000:1370:b0:33e:1102:8fb8 with SMTP id q16-20020a056000137000b0033e11028fb8mr649046wrz.6.1709798413189;
        Thu, 07 Mar 2024 00:00:13 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id bj25-20020a0560001e1900b0033e49aebafasm6592114wrb.3.2024.03.07.00.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:00:12 -0800 (PST)
Message-ID: <22b01fb4-b543-43b2-949c-1873105dc343@grimberg.me>
Date: Thu, 7 Mar 2024 10:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-fabrics: short-circuit connect retries
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240305080005.3638-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240305080005.3638-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_000015_261359_AC8E1E4D 
X-CRM114-Status: GOOD (  11.93  )
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


On 05/03/2024 10:00, Daniel Wagner wrote:
> I've picked up Hannes' DNR patches. In short the make the transports behave the
> same way when the DNR bit set on a re-connect attempt. We had a discussion this
> topic in the past and if I got this right we all agreed is that the host should
> honor the DNR bit on a connect attempt [1]
Umm, I don't recall this being conclusive though. The spec ought to be 
clearer here I think.
>
> The nvme/045 test case (authentication tests) in blktests is a good test case
> for this after extending it slightly. TCP and RDMA try to reconnect with an
> invalid key over and over again, while loop and FC stop after the first fail.

Who says that invalid key is a permanent failure though?


