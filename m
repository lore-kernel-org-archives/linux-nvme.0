Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DE7EE0ADC
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Feb 2026 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=0LTlBjVxzyVJcavbmkXUqpbGj8
	RiVIB9/yIxmBBtCTqXb5GHCm/Dd69ifok4zpC4we5RDjeOI3lLL0V9kwjLvoMNesoymTGTS19ZL7l
	AecGyYfKvbZh9jIT8EduR4mvfFu2Aneh8DFgtL9gvmmraSuEN5X7NYyqD+kPd5K+ThGDTWK5ZMVjV
	j+aHVOhWvq5HCRBq3iazKUkjbIcOBLgYJL0l1qtzcbG/nrQZmxLqPBrmfWvt04Nt60mKPIpCozUco
	je3woaBGrkXTgYUyQXdQhG9jxrG+SlOfu64puzsvWwJUynCKfm8CFv+YwrDgMluiUgheRqURv3AGi
	upTrA83g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voif5-0000000CVKd-3A76;
	Sat, 07 Feb 2026 13:47:47 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voif3-0000000CVKG-2afa
	for linux-nvme@lists.infradead.org;
	Sat, 07 Feb 2026 13:47:46 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4362c635319so1226173f8f.2
        for <linux-nvme@lists.infradead.org>; Sat, 07 Feb 2026 05:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770472063; x=1771076863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=lG+pojouj61EjnuEXSP89Ef9LfOdPMQgH04jUWTd0LGxJjs2CJOvpw1OW6Kr58ZlGt
         8fJ4tf3KbDGKhkjVVK4NDdAkawXGAB1022+BTUe8t1mQPR19fYL+kEUuNH5qc739NYhf
         JFzjM60lubf94BXW0H5amD2is5r0MqrQQXy73mBSnNdJqvIM0jsLrrMfpxg012t+lw7H
         m2Q0nWs+Ts4wT3Afx9JEGCQ5j6F9GkJ+O2UP1PKAg0GiRH5l5kQwn76V25Ffqdn5a+1e
         /zC/mHtqZ7/aLuKr4ZzNkMwexQ/XEGJpscbEB0C/fkRedcr4T6tL8BFRy/mtOz0c+pG9
         kN4g==
X-Forwarded-Encrypted: i=1; AJvYcCWaXvWfNb0AIZhjzIIwOKgc0PPMB/ZeAofHoXs2WYQwfXXBRvQFM2VLDcPgys9DExCnmU5KfafF6D6P@lists.infradead.org
X-Gm-Message-State: AOJu0Yyyg1fsXLnl6w7Hq0EnG63NzxCVoG/Ltez27T5RvD5wivjztiM/
	Jhx525grlpje9R2sVcfkX7vgXC59EQgZbyrkUDwbDbTV250edSBVZFTD
X-Gm-Gg: AZuq6aK2RlxKcJyDzSyrzzOB1f7tqKKJ4D8fKm2ASJpI5thV+b6V/NyqEY6OYYKvBRl
	WW7cP519RxT1JB0OffL0+gnHuyDC3+3YQh0L7sL+CnTLjubJWMJHVTCJQsFWJEoIC8hioPLTjxx
	MUGOiBOQdyi6P5u/XwSKRAN9TomAb7L17xTRGENbpQCRrXP4unffRI+IZprsMmWpy9DbCbb+gTo
	VE09SSIk8pquUuplkWtvvxmViQYrNIVm2gFWAsiA8IEpTKdYjd6jjxah53KyJBYEUwflmhCLyxZ
	kjTmBJOeOYfz3KPk3gJnFfitV2BOjRXY3L9TL6amknAr/3FGdjz1ZPFjc7usFtkh0K3fQplH0we
	oOiYO272fotp6iKqy3jn/ghuLhqX9+1usa1mRXoJkvU+qHlNfC7QnL8FLis911meT7/S8HQSUXu
	+FWiBrnVzYDDDbKtzb61qmpkGAK8FUR9F9fuK/TfM5jR9Uu56fTR0yJQ==
X-Received: by 2002:a05:6000:2381:b0:436:233c:c7c1 with SMTP id ffacd0b85a97d-4362923780emr10091708f8f.23.1770472063366;
        Sat, 07 Feb 2026 05:47:43 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-89.bb.netvision.net.il. [89.138.75.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974b176sm12342088f8f.37.2026.02.07.05.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 05:47:42 -0800 (PST)
Message-ID: <f7dfd41e-186f-4ce6-8c8d-80d1ed22f353@grimberg.me>
Date: Sat, 7 Feb 2026 15:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] nvmet/debugfs: Add ctrl uniquifier and random
 values
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-3-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260130223531.2478849-3-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_054745_664985_7BC179CE 
X-CRM114-Status: UNSURE (   5.04  )
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


