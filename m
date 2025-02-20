Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98880C021B1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 10:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=1JdoIlh5iKA6oID3Y6nybPkcFK
	/OIaoUXjuG8pEE2Val9+orQxHnEr/yumha7XkP6U/vbF9/NYCbTLKKpzGqOVdcw2WUpHWTcZEIr84
	tMnhp1abf41urfu7MGSDnPevvuBv6TALrPBJoaQtqjmSY4mu2brys3x45pLAOEb5XHM82W7NSX8BI
	biYmh4bPFRamRv0hnC6Jo+qHs6k/aBOpve58W2+pQF3+AOvKz5VZmtnAcme6s3ZaJvngm/qosO9UD
	mbFKO263y6FcPYdJvt8ymXF4lWhjf+YgdBHlg+P9kHcYBV99WBtcbuPtfVB9YvezIzeNkQpw12fGL
	lV58If6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl3vK-00000000K8Q-0cGM;
	Thu, 20 Feb 2025 10:36:54 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl3vI-00000000K7e-13DG
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 10:36:53 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dd9b3419cso406930f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2025 02:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047810; x=1740652610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=NWQJ7J1QlWwLzZsepFU/Jv7e+aroJRrYhc0HKoGgdRY+iediX6cPFUqv1bSU0ZYoU9
         VC8b9ZKVZxW6YEROAvv/JL66zrjhZE2YYVV0UScafN3B6kxgTQ1y8hq62QLvwLyiPTLd
         yYWDsy3tWzMitvmK8/PTPvtMWB+DOPnvufddeCQQ/NH3BcZ3/5W57ukab6x5bPp7NIky
         SlrU3ENCpYCdRINjJiaUyyyfey/IlwRvfjQzLUvWmLiBiAlRIZJS6ZjcpTytCTSrqzKt
         JMKPabqv648tOSnVT3ItEkmaIXeqfH+WYxzjnCcP6bAqVU41LXqGrMfh1fzUCoFYVJoV
         3w7w==
X-Gm-Message-State: AOJu0Yx8pNKbNULEwJdss4LrBt8oKuH6Z0PP7tjGXb2/n8P63YAUkdf2
	XK3JxNUVoBf3oG8wYivM/cLeRL6WovXS4qTYMt5hPxrs4XWiFGeK
X-Gm-Gg: ASbGncvWyO8Qms9UxcDz6D1NxZ599ndfNZZGM2vzvfVGoRe1uDzQo+pT54yAxvYaCgp
	gEr4eoMQ5ZbuDfONXVLFrXGCdFouILhUyFdI96YBlgh8BJxeaEn3oE2Wdmytq6hGcn7gTiYI+Qx
	vrthY8Bj1FBjKGxMPCL0O6pVrR6RFkhdjTTg7xPf5C10L1uT/ApXVowSIyuyLHWd1TyCzH9hgKl
	pMO2gu2c3PyasPufNIGAlyyfSyw9TNRnJ0I7StL7KWfDJ+tOFEGBVSrdasaZhNviRxTcelzQAO3
	LnP2QwsVziNf8Np+Ov5IqTBTzJAD0tgqZwNLy25x4rr5m8NvUlA=
X-Google-Smtp-Source: AGHT+IH+WsYkeZiU0mPcqvV8ektXE+C84F/4T4JseUt8pjcNjNbQ00MxZEwmZ04LscaLvifAlaWJBg==
X-Received: by 2002:a05:6000:1948:b0:38f:218c:f672 with SMTP id ffacd0b85a97d-38f65145d52mr1367990f8f.41.1740047810058;
        Thu, 20 Feb 2025 02:36:50 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b412esm19908811f8f.1.2025.02.20.02.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:36:49 -0800 (PST)
Message-ID: <4881fc9f-4d99-4a5d-9182-c003c855b972@grimberg.me>
Date: Thu, 20 Feb 2025 12:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-fc: rely on state transitions to handle
 connectivity loss
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-2-7a05d557d5cc@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250214-nvme-fc-fixes-v1-2-7a05d557d5cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_023652_283240_79E9681B 
X-CRM114-Status: UNSURE (   6.78  )
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

