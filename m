Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F2CC54E67
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vJNTc0JpEuIjCT0YU5iYMSiG3l/DVEvQGufEpeq9RVI=; b=F2rq9TqttdABEo6Z5SmTBPrHmL
	dfwk7ZzMLHNGX2CT/Zkl/wj0aMVcTrgXogTA9wFuMd+ogePLq9T0SkHZ5HCUDLyvMYVKDXUt1LEKd
	df2z36wK9Zv7F/dA1jPDzIoWAAmp0JzLW8UNjqXDDwkg1wCqESjZC9noIrWd3Z2bUyxwmTI5aKqFM
	oqCCQ0ykAdh7d77NaFsTixQPM2eGraONxaMOu+GBg+UrkZpInlR6RZCE2Cy3RmVzkhD+Wzh+bkFGC
	tFTg9Y0RQZNpSfpTfLkvCiysi2GLtM/AXUaXGf3uh9XjjW9XhNOErDOSKj9hS08LNQAw12sG1qk8Y
	2sID+cTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmrff-0000000GIcg-1KfF;
	Wed, 20 Mar 2024 08:51:39 +0000
Received: from mail-ej1-f43.google.com ([209.85.218.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmrfZ-0000000GIYB-28n4
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 08:51:35 +0000
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28cfca3c45so175213966b.1
        for <linux-nvme@lists.infradead.org>; Wed, 20 Mar 2024 01:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710924686; x=1711529486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJNTc0JpEuIjCT0YU5iYMSiG3l/DVEvQGufEpeq9RVI=;
        b=jcJb0p5qKt4Nq/MaVu//SD01hHT3Df8h2NTOUG54/2oBsK26OBvs27Y8K3II02BklM
         OmWuA0X/+fx/8gdAQ7NG9EILnuszwg51cNc4doZy9mAheb3W6vj5ie53tv02HAzYejSa
         7jTncFqu0/YWT/hHw3r+mWnJwhgjF9dP+TZ395eu0ULD1znK6DKRnfU5TOPN9PNwfzmp
         gNCggkdMMdFKuhq0pYH7AR8XxOcWB5bL6sizRnFNsxQGIWR68Wb7Ue0X+XeKGfpJoL7C
         gU3NtTIuII/T3ocufpshxzy0NMCOyFmlDLfKLKrIJPEqD9oGjXtYNaz1NYCq5neO+zDu
         Eh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAIFsJADxuUF+gy78wF5IFO2TRrFjFTlKI41T2esHYBP4oUgBmFQ0tv5jJX2A9KVJU4VtWhsx41erA0GxhVR8F+1iVMjKE7XyBQVLuVxM=
X-Gm-Message-State: AOJu0Yz1kQUr9CO/lTcItRuQr/WU3bioTMXh07B7Vi97z85Lf8qYtpI+
	QWx4BFUZYA+olHe03TxxIZ3hOMMdU9rpc57xpz0nlVCPBxcbPF2/
X-Google-Smtp-Source: AGHT+IGfiM7OXvkfM1mMzVAbAj35GAy6tJnCyJV5b69pQjRTTKdruBGZlNdSoiX/VdR7cq0exj+jlA==
X-Received: by 2002:a17:907:7d86:b0:a46:fdcb:eaec with SMTP id oz6-20020a1709077d8600b00a46fdcbeaecmr148962ejc.6.1710924685474;
        Wed, 20 Mar 2024 01:51:25 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id hk22-20020a170906c9d600b00a46fbff47a6sm190439ejb.168.2024.03.20.01.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 01:51:25 -0700 (PDT)
Message-ID: <68f99d6e-b79f-42a9-bb19-ece27d35dfa6@grimberg.me>
Date: Wed, 20 Mar 2024 10:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
Content-Language: he-IL, en-US
To: Jirong Feng <jirong.feng@easystack.cn>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, peng.xiao@easystack.cn,
 Christoph Hellwig <hch@lst.de>
References: <a99971dc-9157-4a0f-8fb7-5fa495434b99@grimberg.me>
 <b8cd8de7-9167-4b8f-b255-c022376a7c9d@easystack.cn>
 <dda859d1-41f5-423c-a9e2-900a1573c3a9@easystack.cn>
 <ae40ced9-9f30-4e93-813c-5b94d0667d66@grimberg.me>
 <e27ef3fd-d43c-4dc2-8969-4a0f86d9c64c@easystack.cn>
 <a688834a-99b1-4dd2-b698-c9e54070f78f@grimberg.me>
 <89b542d3-dedb-4d5c-ad7a-279467d28e51@easystack.cn>
 <53b68337-8370-4deb-9a90-bf5dbb7d6d33@grimberg.me>
 <6b345b99-3dd3-4c96-8644-e9b40d387b58@easystack.cn>
 <b3821176-b6f6-4617-92c9-ce8ad9f1118e@grimberg.me>
 <20240131062526.GA16177@lst.de>
 <08b936ff-10d0-48d8-aacd-6ae1e2659600@easystack.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <08b936ff-10d0-48d8-aacd-6ae1e2659600@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_015133_980767_E1C52782 
X-CRM114-Status: UNSURE (   7.82  )
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



On 20/03/2024 5:17, Jirong Feng wrote:
> hi,
>
> just kindly ask, how about the previous patch? will it be merged?
>

Hey Jirong,

We do not yet understand if this works for Linux nvme-mpath (which iirc 
requires a suggested host-side patch).
Once we understand that we can take the changes to mainline.

