Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8BDC67861
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 20:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dDKLW8Vda1EOTDIWVyntcnhV0aZcCM3F8o1fDN0biGo=; b=uaDYLiVlcFLQjT4O7ez9Fl+llP
	Anv7unbTXeYNepcuaPPmtnrDu1vytwiKKxhL3+Cor/VPsAgYUYTO4WFvokBD8aeQPgAI/vJKDhf2Y
	d6XK0VzMKOr0hQKXSH1XGtfHGT+tMO70IQQbSXeAP75Z5Aak+fxYb614kEYg7gFV35xCkKHhE3jGt
	fxVtuaMhCVv0o8F0woCufDh51w+ZMeCtnnpwDJx4WVJHys1ErAFOUAY/yubltxd5g2QFV/cAJE59R
	KJgp3F2vOq+GJ9g5ZZZhxQuryBBbrKSYqB07zGL1LfRj7UvPCiVouE3zUPy7Z+BJf5LQ/DtshGTOg
	nyxoolng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruI4h-00000003icI-1Fpm;
	Tue, 09 Apr 2024 20:28:11 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruI4e-00000003ibo-2sOi
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 20:28:09 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-416902dfb4bso3675855e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 Apr 2024 13:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694486; x=1713299286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDKLW8Vda1EOTDIWVyntcnhV0aZcCM3F8o1fDN0biGo=;
        b=Bnfu4flUiquRgTmzw9TCpW6gIoS59NYrQN+jU7/zxB3g8x3E/Nc0YTKBTm5h+8YSf6
         bCMQz9GS+fOXVIQYE+HdDbpE7+FelIGomqZCY6pH+ScwpDeYpzwkJ7kFgJHfGCWqW+iA
         +MoPeZnOYZcHYeFzzv9sN3itPJqvKDzrQTxO1LEEZlmwP7S95BVO4i+ogGeytWYhRbzq
         KpzV8M4aZXgQH/WRG6JcqejF1CYg0PlXbnYoVVWns7+x0+F2Tt0zgm2VObZVPVIDN272
         Pl6sJKxVnN8GJEcNiWEtxEHeBgE15yWiEYGEMAOU3sTdtaAomBaZQmm9p6HyG4ak86us
         8IuA==
X-Forwarded-Encrypted: i=1; AJvYcCU0n2bECI+PncOtYlHIpNYDSMm7tIGsp/6b0HdnCZTRWL687ixELXbyNoS+fGwDDM9sFuOA4TsxcjYgITYM+9kWIdF/hZzgpNmK2Zjyq98=
X-Gm-Message-State: AOJu0YwpU4SVHYGFZWni9s87rJFC6AUj5QV+zGZ/dwhctvBC+a//jcOU
	6eykqLtAdFWZorqBC9JSBjwsuDtkaoKmsK+f/T/XmctoEuV1lEbN
X-Google-Smtp-Source: AGHT+IG2oKybZ/vpNLz4G/LmBDYs1vE20g/HCsYkCpwVxafRYg4FBFY0Z6es4kdn/mW5M2qNYJpkxw==
X-Received: by 2002:a05:600c:1c89:b0:416:9877:c8bf with SMTP id k9-20020a05600c1c8900b004169877c8bfmr546930wms.3.1712694485444;
        Tue, 09 Apr 2024 13:28:05 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00416770871f7sm16077wmq.25.2024.04.09.13.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:28:05 -0700 (PDT)
Message-ID: <50a7e52a-c590-4281-9168-55ed7d5f2f3b@grimberg.me>
Date: Tue, 9 Apr 2024 23:28:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] nvme-rdma: short-circuit reconnect retries
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-5-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240409093510.12321-5-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_132808_758664_61904E97 
X-CRM114-Status: UNSURE (   8.13  )
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
> Returning an nvme status from nvme_rdma_setup_ctrl() indicates that the
> association was established and we have received a status from the
> controller; consequently we should honour
honor ?

