Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA48C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=fOtcDN2QIGpFnozqc7Xr5X7EFI
	6qobNvk1fJYE6JEdg+cF6aISDYAKiVc60+8lOobKH63Yec1K7p9u8BcOxTQbmCFezGLaKVBBk2MKw
	3eMRiGlj2FP4o1GBcNWI4LIHJR1vuju20NzPnUbppgzdfLQM7ttP87zEqxX2TEXygpCzpjGfUcOBm
	yGyqcXjm86qh0i7NzNfk1SwAbMIqGUB3XakDDUI4vY/rIbh1m5AWDoxKTIVer+TCcTjDPhFGNEqt1
	dgdZTNPdbID3bebXlMXrwE84/T7qZOVxsBwy3W8H2PFTJkuxm63fgYOJwa8a0gQCL+8ZzAeyIfB2o
	XVRgjJEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJsx0-00000000roy-3o77;
	Wed, 19 Jun 2024 10:54:02 +0000
Received: from mail-lf1-f50.google.com ([209.85.167.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJswt-00000000rmy-0Xpk
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 10:53:56 +0000
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52a559e4429so844832e87.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 03:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794433; x=1719399233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=TalIZvMUDK1c/CWg6kxKO51SP31flydSC7XvVF3C9tZvsRintP1yKRfH0ZYvTSz4r6
         0Ao5gTukRUX6SwcKx2AqHPRtysMszfoKOfIcMjB0kNSbXshx0Vki0dkXGdTsEYOS2jDF
         jW3q1ZUJUmZ/d38G00kiCjSoeeI5JGHHdcoFlFiY7Ir9a2uFE9sPP8QCxeLuzUL6bp4p
         txXaS15J2fXrYw973AyLZTca+egaBHP8yDqYQvzYVKhFegs+njCHSwmUi/f3wP/GjrqV
         YfJIxNG5uMRol5NXiEXQsDGXbLoDXgtjnn5xcLXJ+HtqPnapqxC5A1kCXSE/7PiSSI0f
         ag9g==
X-Forwarded-Encrypted: i=1; AJvYcCWlhHU8lbjbrbTK0tEnpSh9wHrKqWff9JHMFjYhgdsP5S+yUYkJNcBj5Nx6WWy/6sLjZhSudzCmhLPk6ixjF9isQIO46sFATZwTzJzOIl0=
X-Gm-Message-State: AOJu0YxTlQISYYCd42pbDuu8emvFgoTBr4oneFPmpKjMfVandpmoCh3c
	zvTrUAXCgWIYDF+HMx0KuXDcrkRlArrUXDIQPQ4G5ZEvr6sTHdQj
X-Google-Smtp-Source: AGHT+IEetUrZ1T30ANSPYnS8A6L58+q9UHO8TWfOeEexUWnhNKarZDwYihTQn70QXrVZADkwHmtmeA==
X-Received: by 2002:a05:6512:3baa:b0:52c:a88c:1db8 with SMTP id 2adb3069b0e04-52ccaa59183mr1425786e87.2.1718794432956;
        Wed, 19 Jun 2024 03:53:52 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-364244948fesm189269f8f.61.2024.06.19.03.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 03:53:52 -0700 (PDT)
Message-ID: <4677b042-3d82-482e-935b-7ddbce2ef0d9@grimberg.me>
Date: Wed, 19 Jun 2024 13:53:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 blktests] nvme: add test for creating/deleting file-ns
To: Nilay Shroff <nilay@linux.ibm.com>, shinichiro.kawasaki@wdc.com,
 chaitanyak@nvidia.com, dwagner@suse.de
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 venkat88@linux.vnet.ibm.com, sachinp@linux.vnet.ibm.com,
 linux-block@vger.kernel.org, gjoyce@linux.ibm.com
References: <20240619104705.2921801-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240619104705.2921801-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_035355_341864_D4C6FC72 
X-CRM114-Status: UNSURE (   4.73  )
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

