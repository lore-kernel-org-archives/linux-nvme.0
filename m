Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F68BC67861
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 20:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GsSOOBo7BskdQReYphJ+zB1eNZZh6oDLqHlP86aPuOU=; b=W3QKoegWTdBPt7NlM1fEbGfrfL
	Fw5u5on3M5JjPs5ZSgmmJBkLoW+Tt8u1+OrUqbAUmVTKcjDnbdfSAszzq0oRaZwmv4T3+TAwbb169
	sI/3x9DCZWkcG86/UCBwggJXpCPRqrkhsGxYL/3ggbHEOIH9dhLyzucf5AE1IDP5LBJidLj2ypgVV
	wrsHsq3qXeiyRq2L5gBh8OKBKdnvGphGFvUnxJ0kstc8Hv2igkbzayfSThxqhZLmXgQxqBW/gn/1I
	ey8ZqlUzY38Fonx0BWtjrPXHrPE70gjQbKmqd50FeG89EHiPY1JjwtGDjYXiDEXGrOEDmPlT9K7ef
	MBKJE4wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruI2h-00000003iFV-3yuQ;
	Tue, 09 Apr 2024 20:26:07 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruI2e-00000003iEB-40M4
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 20:26:06 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34602c11302so229968f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 Apr 2024 13:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694363; x=1713299163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsSOOBo7BskdQReYphJ+zB1eNZZh6oDLqHlP86aPuOU=;
        b=YN1iy7+vLWTsp8wOKMXnswvntoYwfVrg9Wx1hvMftx/cO9YW73RLNok5fuZ45MmprK
         E5ruZnQyRBAqxeZoZRgrP6EXOCTp0P5sVenhTjjMBRw7jb0atD8CFImpng2/M7tCu4oM
         20dAeH55oM8T0p8aheeNBj7gYSilfFWUUM8VE9RlSGFzW+gnbXWOIz7AbFV1Xb2oR+vj
         PjSvAWIZEZLNHmJaocHXUPy3W3v4wFOL/84HNoAZFrsaLYLGyoCpNuS+R/BtMGTsBk01
         jvg5SYwHVdq4mZhgu/iwpO6lG0t3owNu6h8BDcQEHjk+NZtrO6CioxGiL77uvK8vi1bm
         wjPA==
X-Forwarded-Encrypted: i=1; AJvYcCV/I/xWTq1t8tD22il+OUyd3pUcUrgTnSrET22ym7spltOtPNn1dOBogeHr9/gfamDwSsoBCc2DD+/xXh5hebFFyjXJjpGVRbxt0k6gdZM=
X-Gm-Message-State: AOJu0YyPHDaB/f8RslfV6ziWuELdbgdKuuczu/d5pkK10J0YktdNfjGT
	CvZm1SB+dUT9JjDW3voqpZqqu7RIKfp7c89Ow0cSDcU+DtR1NEic
X-Google-Smtp-Source: AGHT+IGzGXnDM7mT5hLOWyum+cQbDzz0Wlemyd3ZAbiTkKJ8Jp5bcZrhbdd+hdqW7Phge0yFk1tHIg==
X-Received: by 2002:a5d:4a4e:0:b0:343:c3b0:ee39 with SMTP id v14-20020a5d4a4e000000b00343c3b0ee39mr444775wrs.5.1712694362397;
        Tue, 09 Apr 2024 13:26:02 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id z13-20020a056000110d00b0034174875850sm12329296wrw.70.2024.04.09.13.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:26:02 -0700 (PDT)
Message-ID: <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
Date: Tue, 9 Apr 2024 23:26:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-2-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240409093510.12321-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_132605_028883_9276ADBA 
X-CRM114-Status: UNSURE (   8.87  )
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



On 09/04/2024 12:35, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Any authentication errors which are generated internally are always
> non-retryable, so use negative error codes to ensure they are not
> retried.

The patch title says that any authentication error is not retryable, and
the patch body says "authentication errors which are generated locally
are non-retryable" so which one is it?

