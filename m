Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E6CC54E58
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Mar 2024 20:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NQ7XhuvTCmoTrpu2wGxxi3X+5ocq1YrC9sTrLrIg/Xc=; b=euPkugrWx0IzjaESj6pywThH2T
	Ph6eBkv6k4Ig2NKKCxfDMBbJfIp6p7C/BcSFWX3T212JbfVZ35FyiJPY0msDXa2E71Z+CPT8GZScB
	uBnDgKnyY7Yv3ErQEbr798Jb2VJRFUe/DA1bSUm5+7+g/wC2C8mLOXu4zO0nGWh7X83le31XJ7LM+
	jW59Mjy1Ko3z14bCa2NRskNKCRggUCKhi8LIfvL7WYVttfhy+mtrc4mCPm/1cEDOL5+dhHjoU1wED
	GEEsZNoGs3E0Gd1CVNJpMRkaPmbVC8ldTb7NyRakDj+MwXEAjxTH/CF6HnOm5guW1xoRFLAzJwsIf
	ItBirjWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro82o-0000000B7ll-1WIi;
	Sat, 23 Mar 2024 20:32:46 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro82l-0000000B7kd-33zH
	for linux-nvme@lists.infradead.org;
	Sat, 23 Mar 2024 20:32:44 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ec94c7ca1so215248f8f.0
        for <linux-nvme@lists.infradead.org>; Sat, 23 Mar 2024 13:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711225961; x=1711830761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ7XhuvTCmoTrpu2wGxxi3X+5ocq1YrC9sTrLrIg/Xc=;
        b=u3kPriRNbTCs7boNJkTlHbYR4sjyAJscxjkNxgx7QT8tRyBVBFNbMGqbtyXoA7uyF1
         xWsXiNSQBgIb2pJtE0kklxzw5VcvRjjv0lPtwLHRjj+9LOljGrjr7wduDML3uGM5nIdM
         dJor5F1PD0ceNYVsR1sfFYz94FGHYIZtmGM+Y6F7FEHmDoU8cjVEp3KI9vWJZLhCc8MQ
         QRYogqP2+ghFc1Ts2LjBCYXxG6pZ8ULw2lKHmLn0czu6rOsxd2LQz+mvUiiiVFHPX7Np
         I6UJ4ZlE5HOO0whw/B8Yk423yXJwSt+LrOvpWsIeicGpSOToXPAwBKJsB1yQkVvq2Hm1
         SRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz0clfeBGpdKl3uCz0JVTEOpapB2nDssVZRr1Xs9K5HLmP1ppuj4veaMk6zNu3OX7Xqkrue2xNPa986MtlbSMLz87Hsx7fKRCEDUSooUU=
X-Gm-Message-State: AOJu0YzvUGgdfaOoaugHj6Ykg/85xEAEqqTBQjsgr8zeIJXbZthVASh1
	E7br8VFfaUytA4c1NpRwX9/FCB8GO0z0Z4RXhrx6CF/qAqDPh2PAEhdz/97q
X-Google-Smtp-Source: AGHT+IENUjzmeGJshO6Q4U6shwOpxdfNUZ9CAG8DXpOysWDXQZwZl4Cur7KATw1xXRwqc/s/mShFAw==
X-Received: by 2002:a5d:5749:0:b0:33e:c7e1:e1c1 with SMTP id q9-20020a5d5749000000b0033ec7e1e1c1mr1915744wrw.2.1711225961442;
        Sat, 23 Mar 2024 13:32:41 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id cc19-20020a5d5c13000000b0033ed8643638sm4215012wrb.106.2024.03.23.13.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 13:32:41 -0700 (PDT)
Message-ID: <91d2ff30-97ae-4bb5-a154-382f8c3089b6@grimberg.me>
Date: Sat, 23 Mar 2024 22:32:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4] nvmet: implement unique discovery NQN
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240322070927.30454-1-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240322070927.30454-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240323_133243_826797_EBAECA04 
X-CRM114-Status: UNSURE (   5.75  )
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

I think I gave you a review back in the last iteration, but if not
this looks good to me, outside of the review by Chaitanya

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

