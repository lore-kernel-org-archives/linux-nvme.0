Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97671C54E5C
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 09:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XxBRbxPFMvMsQjje3u7kVaMU+G
	bjpExdLkloyJSANOzmuD/1ZHH8fb1J0qm45tHJdpElPrIeAj7lUCr2KUAfNukL3djMm+pGVzjmVPI
	iJjtntXXZ0BxUOQXjAv7YN7xTBQCjXpsKOuvW6WOQebwPuHV1S0vxhFWLQWFePo3hb+NT+PxIsoRr
	OG3hseMLDJKWI8RoW9LIcSAaCo+LOG4qYB9apErobjVrWjcvcWFH5VfLeLMx0XmyCrFXWa4jHKedt
	NU3p5ImYjgk4OqrNvWmsTTvdMJLN7FcqMxkPA7hABsDcxyBCcXwHpUC2T4vrvAL9GhV+SCjUj7A1o
	r7D66j/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riWyp-00000008f1S-34HB;
	Fri, 08 Mar 2024 09:57:31 +0000
Received: from mail-qv1-f45.google.com ([209.85.219.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riWyn-00000008f0o-0BMj
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 09:57:30 +0000
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-690b5be8caeso1125316d6.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 01:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709891847; x=1710496647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Z8++iOnqZ9gupzDTC7kG/wp6WUQXxbifxoC998RJINWNV9wIyzLJrJbSKwHbusQhji
         6s72DdK8fSIQePJ3wptkpYXuLyCMjOoGR6mWlzLFow/k++OsCuw4DOeGGhXHy/fuE6Dt
         F4D8qLcBWHCL4RbHmN2WsPvhzXLD8DyTPYUIuQWvvfcCVA+q+nfd8uD2WvQjosR5yhKS
         vTcSQDanlEX3yoh4QzGFpUdKLRf0N5/j0L1fEitfy0cEwCTDrmgy/gg9UfptAgsEItzQ
         7dgacK93srVc1eKRAl9/h6W0j+SQnOlThuKK9YtOEkp1tjajh9gIeolppONbtey1zoLa
         fhHA==
X-Forwarded-Encrypted: i=1; AJvYcCX/O6JXoDg1I5KNb7WSSPTFKLeoL7rW75/PGoGmlkwwe9jUey2d9eEL1ehERZ5Ol1dUbU4ZXH0tasrnNbLsZVWPGFk5vjvixEBm10x30Dc=
X-Gm-Message-State: AOJu0YzZ8+LCKiYXLEKA55YZNv/iz3L7whHub5XOfKM0HzkF1iGa9cDE
	WFnvY25Xz+buflGm8vSHEYgYFIGyY37uPElR/aAs5n3F4Vz4bCB0
X-Google-Smtp-Source: AGHT+IElTbGiqk2sdhbtmg1jdyyGhYGQY+l2z37bbahalfnz8aLO7medvjupOLDYHfRCb8LL+E4QMQ==
X-Received: by 2002:a05:620a:2456:b0:788:497d:ddb1 with SMTP id h22-20020a05620a245600b00788497dddb1mr1782012qkn.7.1709891846942;
        Fri, 08 Mar 2024 01:57:26 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id g5-20020a05620a13c500b007883ec38bb9sm2697746qkl.81.2024.03.08.01.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 01:57:26 -0800 (PST)
Message-ID: <98ffad59-ea38-4a1c-b969-b2e8909ebbe4@grimberg.me>
Date: Fri, 8 Mar 2024 11:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: do not continue for invalid icreq
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240308071105.6175-1-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240308071105.6175-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_015729_292478_2AE78287 
X-CRM114-Status: UNSURE (   5.50  )
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

