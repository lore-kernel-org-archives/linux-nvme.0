Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1235AC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=XnBClLimHB4NY7Moo53zpeDrsq
	gfJKXu7MLw4YSjooFLRNLYnc6BrzaKFFMQXG7azpI//HdXOkUVKphEX8TcyPR+tUYJ1MZxZTvi7o0
	QRqeFxNtb4xfhZUjxbZbxug6Rqsr3XjANRAfw6RWrR3j/upnZtSttEEzEswxIPNFcTCCTmmok3JW6
	j8EH99bcz24zogytDEHk2bHHwurVJjurYJinmnhpEM9+FbOtxf0hGXUUb7koQXn6wNVJtZNZqQ3/X
	UwKOTPBdcp6oEOAt/MFUYwHtY7KAe8xrEXl2Tznyc2iBmGJdYU/B1sJUJFtZaH1LhITnYV6s3NP1K
	F2Fs49hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riABO-00000003swa-3S9P;
	Thu, 07 Mar 2024 09:36:58 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riABL-00000003suk-260C
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 09:36:56 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33db19538d0so160447f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 01:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709804214; x=1710409014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=IZxQ6zkqxgiI31LSSRRVHAV6r/iKEgAOAmhYua+or8/LhsPlU0srL5jjd1lzMKz07/
         VBWufJqYBoSIZ6B9WgVuPlyVSnBpcU+mQpyNXQMFppGKj+vVjqpeEni0TpWv+yQnzvE2
         uRS11M9eO0dVsD2nKMTzCsk11v91BkvMcsv4Izj24ifPjWt3dXgF/AOU4Xvs1dn5TrVN
         p3LX2C27xVx7wW2+vzzI3tPkILE4r3soTb8cbyUU1bSGb4OQ909IoSYn0gm5v08Rt06O
         1ce+0x0PMbz28IdXgcSIFow36CPhSX7iQPLGF6bc7tCEwfAhKVnaLaAOg27wg2wLtFTu
         0Fkw==
X-Gm-Message-State: AOJu0YwMIdMOV5zPicJbn3j9M7/uLuTmyrkIeNdD4Mn10Q8DyoOW1T0v
	uBV5S1otiP2vLnKALXeK9DC3ujwJ4gvlRTSbbZIpMrqOhW7gCId/
X-Google-Smtp-Source: AGHT+IEdadvIsEla7l8jY/oZKVem/2Yd9v7pMXLe6pA+93F95pbG//MR7XOKd4Mdpk8P1hsDpDgJ1Q==
X-Received: by 2002:adf:fe4f:0:b0:33e:55e8:5319 with SMTP id m15-20020adffe4f000000b0033e55e85319mr1093304wrs.2.1709804213879;
        Thu, 07 Mar 2024 01:36:53 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d59c7000000b0033e475940fasm7451170wry.66.2024.03.07.01.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:36:53 -0800 (PST)
Message-ID: <fb062f10-aef5-45d9-902a-91f215bbd8a3@grimberg.me>
Date: Thu, 7 Mar 2024 11:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvmet: add tracing of zns commands
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240228083755.125259-1-kanie@linux.alibaba.com>
 <20240228083755.125259-3-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240228083755.125259-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_013655_652142_ADC1F835 
X-CRM114-Status: UNSURE (   4.93  )
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

