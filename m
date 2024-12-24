Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AB8E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=H/qK34XU1GjQBGY4TICS6sNqg4
	4ExifyB/5qRn9rih24sC5V+qZe9Yt6RYGo2g0ru0YtzB/3jNzBAUafmmPXS+SM1xA7Nj83MJYOSYb
	sNmylbY/v1FOvWjmQSFTsIAjo1WmbnT+P+BbxPOyjT+v2AqRXe16POtRpSqgPYpdu/Fihpq1+uRi+
	VbtFdLy5A7ALfc8k5xJNxr77IfiSZ3rX9EXPEn+YbI45j1fmsUuCTt/KsXu7UG0f3M/Zxti78o/04
	bAQJJ8vgSlKgirXG0xLY6XSY2OPYeMTgCrUlTOrFQQoaRjWw63h00EzZARSCD9t6V3o4lMJVPOXe+
	wlQiCL/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3ND-0000000BtPd-21ut;
	Tue, 24 Dec 2024 11:46:51 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3NA-0000000BtPA-3OzT
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:46:49 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso49932815e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735040807; x=1735645607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=V/h8YTjKPgWBNvt9+/zQQ0CmnYdC5niu/YO6rXb0c8EJBzsWiqccW6ayMTMgC32aY3
         q77YPyWpWtrfmJ92wBvzaqey8GOFBKU8kTPq1WYRCSAPeEefV3BrWdSWWrOVPIAeR7U3
         18cRR68oNIbAmCQ6uHaKTW5WOCeQnnbmzm9X4GShugjaG+4Ra0xjiDfCKjyEMYp1YXfj
         RsnSoI0DIvPaFUG90m62iaf2+ySh46f8lQzCVW8rNINUWbkczVYy50vWKC4gM7BG8AVF
         zlgQrNKcEsS2NYE/jy0yZTyZZNnoqiIwktOF4trjJXAGDbLx0XxyB+Jn9Yc0nBm6lI3x
         LYrA==
X-Forwarded-Encrypted: i=1; AJvYcCUy8Bc0ZdELjNsjkfDdefdhtQyzZN9u+AiTo9GRbiKqC/nLeZVmnJsf7A22QDqhoFqNh6nTFLZXVT57@lists.infradead.org
X-Gm-Message-State: AOJu0YyXtipSulOK82dagd3ul+VgxvaYWTkF/Ho/cUhWwNVIoaExcykf
	PO+Nug6a2o3fY/1BlKpfLFYbQ3NDW2W0eYWDJP/D0HiXQhInIcgI
X-Gm-Gg: ASbGncuOezVqYKcs5zyNbajesZHchk4kjnid7XQwW3rngUE/ivdM95UvdYSYy8881QG
	NG8zptyccRvQLlmA4ilP8gcVcSI56aBedouqdsD6FPB93q7tZCnrFoEfmeOiSQqn8ULD0ykwMTD
	/BPoME6URWg/9xd6jFckwzMMgD+MiLOUjSs/4eYYo1+YxjJvpxt/IURxWqx3ju8A1lCu2/LdJid
	cE2fzU/awwpIoaoTT//cj1N/5oG1KEFWispC3ND7jna1Ae9p9B8jlnErJiDTQ3QVWWujFTHYlS7
	4xhDAM37xfNZF6t5oLj+kyY=
X-Google-Smtp-Source: AGHT+IG3mxhdxIBHpizO7P3i8DBlrTThWV893mRxCOCvHyRAk7XseYv7/Ui68XI4LgXPotmhIyjLuQ==
X-Received: by 2002:a05:600c:35d2:b0:435:d22:9c9e with SMTP id 5b1f17b1804b1-43668646335mr138640265e9.19.1735040806820;
        Tue, 24 Dec 2024 03:46:46 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c84840asm13931504f8f.61.2024.12.24.03.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:46:46 -0800 (PST)
Message-ID: <60e0f387-f6fb-4af4-be48-f380528553f8@grimberg.me>
Date: Tue, 24 Dec 2024 13:46:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] nvmet-tcp: support secure channel concatenation
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
References: <20241203110238.128630-1-hare@kernel.org>
 <20241203110238.128630-11-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241203110238.128630-11-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_034648_847124_383D2C3B 
X-CRM114-Status: UNSURE (   4.88  )
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

