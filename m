Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77D8CD128A
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 20:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=x3NUer8eJnmDBQexy/9bbv025/
	ok1EVPN6xHm2t+Saybg9g/3QS03l5DVe0X7Ypq52YqzMnPbH7BzCU9Bf2QDhMVXmznjotiflWyPu3
	9hTrRFhOXyxNy3bQPGC2MGVWsum6PqQHRuDJ3m/PjZvHK2pdX0FWj58iT/zCAeRXuF2tsOY4yr3HW
	gL8mYrg4FraqR+X5WBBLMsZC+NPZKzyNC0JnWTqxe8WrJ2k1XBAppeyOF+hQ30+whmSBOcmR/T6tJ
	oLrwXHd7M2wBri94oacpcrLcQF+0M7b0uK82/CWQ8bfXPKPfFVUKcJ5q2LgrotE+HqF4qoJsdZ8iI
	xjkisvrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruHtf-00000003gF0-0fcg;
	Tue, 09 Apr 2024 20:16:47 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruHtb-00000003gDy-2J7y
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 20:16:45 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34666e92263so8247f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 Apr 2024 13:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712693799; x=1713298599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=apdtB9bu32jQJ7L89+8iFLA1Z3rzrpduqUs9BsSBZUhqfzlUor9tOyYdBpuWvJOx69
         15Fd7TceptJWwjIJjp8FsaZwj+p2WCRBqJR8xKWKIzgcr017NU24sMeVsQyTSPG6rDDM
         PfywLx0xourxWWD9WPtTpe4Hpv6vRtY7ZLUtzfsLFb+Bt6LhbQpngef37Z4m7lKntHe1
         5GyHX0ZnrWyz5IlgxtY74GB7xhbrRavmG9N0uzcAtad1CW+dESh71fsV+CuKweLJkUeY
         hFPz2/yfkEaNcUHX01TB3Emfiu339ZtyHl+X2htVtnmpcle0fMtzzAN4xMid59BqxDNj
         06Vw==
X-Forwarded-Encrypted: i=1; AJvYcCW395JQRV8wXc76IcgH0BcBzGxube1rXW8WWx8loqt2XouWBUh8Tzs8Ph56svB4zwBVWt2cuJwm1C3Y+ZDIgvi38DFEzPW7POv3kTuVH2M=
X-Gm-Message-State: AOJu0YwYAohte5ZenTsZUHllyJTO+5FCO0TS6a5rx6BkxsQnbJ+sz/RD
	YecZguTgy05z8zwfxxhhkPJit6Z/DvaZ7KnOxbbypRw3XkCsmBry
X-Google-Smtp-Source: AGHT+IEAw8Ud/DZYXLuF0Ti4Gwfc4RZM1GUl7VCALLm99aqqj02/FLBtuP4dF6uBPZfuojYb5ihDCA==
X-Received: by 2002:a5d:64e3:0:b0:343:dd78:d82b with SMTP id g3-20020a5d64e3000000b00343dd78d82bmr549821wri.4.1712693799278;
        Tue, 09 Apr 2024 13:16:39 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4c48000000b0033e7b05edf3sm12227562wrt.44.2024.04.09.13.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:16:39 -0700 (PDT)
Message-ID: <0677f10b-1f5d-4e0f-b83f-b59cc28d9dde@grimberg.me>
Date: Tue, 9 Apr 2024 23:16:37 +0300
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
X-CRM114-CacheID: sfid-20240409_131643_623420_5B0E3059 
X-CRM114-Status: UNSURE (   6.34  )
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

