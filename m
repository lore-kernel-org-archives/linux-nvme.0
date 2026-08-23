Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA5DC5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=4CSsALpHk5cmsT8mPoSqumpZLL
	Auv3Gi14zEoAVEpDtIYz5PsX/FRcIqJ9p3J04UlROMvhtADmUsYAiv+I2bhIXo96Jnjl4cKfU/DpV
	JXDfQz2McbT0cE9L/nH6L3PrfAKfDIwZpHQBoJg8Yo2am9/QsuxAr14HWdBKZ7r2tV9CKDhVnow2Y
	OryWprKYwSWYodf0JJ+eRay+j3bdKKnikDJIIuUeS3/necsRGYV7kp8h4bAauINx0/Ui4zKmwJlqh
	5rZ8H9GZhjdH0l//Y/KFpbVT5ARpfp7ScC0m1pwbMIrslbbGEzwVusAC+BsU4BEzTtaEio13jsBQ7
	G3OGXHcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwPJ-0000000EwGr-1S9T;
	Sun, 23 Aug 2026 00:49:53 +0000
Received: from mail-ej1-f52.google.com ([209.85.218.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwPH-0000000EwGE-0Vjh
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:49:52 +0000
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c20e70a0962so341908366b.2
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787446189; x=1788050989;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=TvX6O4Ba9HXrtY6a0FwBG6JBLJMThqTEOVQM7UVgBHak3dG38nUnI3z4AvvAyeeegw
         KQUv2gpjgyByaNbdMfdAArSflp108QxQnzFNN9E1RLYBBLqq0ij1coIKcOnjygJii/CS
         E147MpdHPd2FUiyxEqcwa3ws4lujJBs7wDUwxtlE/ap0VJhNdeY/6HAi2oXx5LJ0HZNB
         990V7EFjTD0mlel8SaXHfeCqpuM/Zh4ruk3SzC7CnJzGcYKrJ85OJouMRFMzw/5fr+T8
         Ax3ClFPFtdWCAbfNBy6rMdFPprejR9m+84w30tAoucpHJswwA4maY4+2eMgMYGJm/+pY
         cd0A==
X-Forwarded-Encrypted: i=1; AHgh+RovouK0TT5qoKSMf9rRQepQ4nUd4QM67lvaJeQH3iZvdLeIdAKpM+DZt1VdqL6SuHctZKC+wz+HkwXK@lists.infradead.org
X-Gm-Message-State: AFuF++lzyzFMNN4wEBGFe4GWRzKWJprmhLa9qEFCiROsN1qP0/eR6cqk
	2KTBc1oQt27GD7Fw4UtQZQQOMcX6E/gx6OKj7JoUtdc0B+lPDS1mLLJI
X-Gm-Gg: AR+sD12OVOudKIs7JP+IkY/gKnLd4i8hszvBrgeZtQL/bqCCwbNcXi7vD5JgUMzTloK
	oEWTMJ6p1J9k5ob1oIi5I51fAu+Rczo9mqowi29Nu7mg6ziwFu54t4YmLTZYpbP59+PQN1wJdUC
	Hj8Pxqp2rMPEaopZNxVGYNgzwGX8DcTWg83RTgkcTjlZK98nkYkiKVxK5q4RJkAYaM6MNg/zU0W
	OxZpwFg8D7ZVgMg79eELk67yVCKpwKUpxOklKUumWg60baKAljTu9tSYVgsD/JQZ95LWh7CxvUz
	VphlxLvZTK7Qh/UZYWFqudp7cp9nzwJVxaa3GsCTuBB3UA4etx10TOgTix7IP78hj6MYSK04BND
	0dNfozbYUqBmFYuB8kjBBNgmVDsQR5FLGiWSS6rTWBJe2JaX8TAP0nfVYEGL23GjOIjVcJnobUg
	NQlikvU68OreYdjcWZQDzID8lnlkISF/DtRuR143RzHkJgvVUBN2jYPOD8VPNmo8VSA4P8ahvGP
	axAdpkp6anY/fsXAX5B6ng=
X-Received: by 2002:a17:906:6a25:b0:c16:12ff:dc8d with SMTP id a640c23a62f3a-c246a69a22fmr1846083866b.14.1787446189092;
        Sat, 22 Aug 2026 17:49:49 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24968a2183sm531706266b.58.2026.08.22.17.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:49:48 -0700 (PDT)
Message-ID: <236e66a1-2883-4d10-9b08-045ba0662760@grimberg.me>
Date: Sun, 23 Aug 2026 03:49:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/16] nvmet: Rapid Path Failure Recovery set
 controller identify fields
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, James Smart <jsmart833426@gmail.com>,
 Hannes Reinecke <hare@suse.de>, Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-2-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260712022437.3743117-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_174951_169104_AA19B973 
X-CRM114-Status: UNSURE (   4.78  )
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

