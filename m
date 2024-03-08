Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FDAC5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 10:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ySmttbAdR7V1iYEWhFuMPW/pZF
	FlqPlbjdFOXpYLPWIJ3z1oq02T3a7HkoieS2FFaf3k8magMDGGHtEJSS6COJtJ7MtxY8C0X/A4k/f
	lhKbioIs6eA5Vo4Pg2r7QgvgOnqXd3LlHa7pnQVD1cE+wAG4+BCqHXXvnVXQUBNe3x1JP2BL7cQU8
	+NfKjBBzBWLANO0CAMnrhV0ONO5MM2JeWJQ3JcKZTb1Q7bY6BdSnzTciOdBBGLtVc21olHbcC0DqQ
	3EPE2jkoCvzCPj8uW0Vib8HVHtgiMIvCLSmBUUyHxhKxMQqoYLVvmUa1+BLPZ8Rje0IaZGp98vINw
	Jjo6uqDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riXAM-00000008geO-1fBp;
	Fri, 08 Mar 2024 10:09:26 +0000
Received: from mail-lf1-f45.google.com ([209.85.167.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riXAK-00000008gc0-2j0K
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 10:09:25 +0000
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5132bd70e7dso489123e87.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 02:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709892556; x=1710497356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=GVm4zDbSEOdp9SM1oFd03++O7rNg6N0gUezyBNtFAqgrFFMfmltXgfbknamS8SSwb/
         drhqyMLnHdkxC/1CgePZtTUo6ka0nFj0nWTv0zE5nL0z7alKkHJOHcffEBnAuG/AN2HT
         UTP0PG0poqzNWiUk3SiUYjrkn12X4NYkFxzJJBsv4zTuV5ktgYuSWTXbz1IQ5fauxrK1
         0kmx2cKJmjmaZxoPRROgFiJmmQIleet8WkzzmjBGLakFrtn9i6Lsi6g4YEL/1MkeoYmc
         mnryDTzsnndX3HU4/jHVSND+EHmQoOdaBznd0NstBUUFrD27NJ6K5GdTNP9afuC7u29K
         mMsw==
X-Forwarded-Encrypted: i=1; AJvYcCWleRRTZjApShwttXK4DgYzjIfYaWre4EOSppq9nHy9zkbrbensRal8zX/ADnpdjTJgT4wevE2WiTqmuf/mx/Lnkslktmr7GIlyiWVhU5o=
X-Gm-Message-State: AOJu0YxAidhfjBEVIT1XAiCjBYufPtenHZlF9ePrHIosKUhfNBKAqACU
	3y3dAdtqIRJLvwtngL86hDzihwDl4baGnI+Xfn+XnBEYDqRpboxT
X-Google-Smtp-Source: AGHT+IH/NgU2V3b/LOkq9eWM9NsEUWqNYhfmR0vsYS2ENBFeCJGeyjfDO3ZHuGK+StDtbFb0DbuPKw==
X-Received: by 2002:a19:ae09:0:b0:512:bd32:ed55 with SMTP id f9-20020a19ae09000000b00512bd32ed55mr930738lfc.4.1709892555798;
        Fri, 08 Mar 2024 02:09:15 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id ba27-20020a0560001c1b00b0033e68338fbasm3537593wrb.81.2024.03.08.02.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 02:09:15 -0800 (PST)
Message-ID: <3b5893eb-1e4a-47cd-a5a2-78d641dce2e9@grimberg.me>
Date: Fri, 8 Mar 2024 12:09:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: change shutdown timeout setting message
Content-Language: he-IL, en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>, Len Brown <lenb@kernel.org>
References: <20240307165933.3718589-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240307165933.3718589-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_020924_692449_5321E411 
X-CRM114-Status: UNSURE (   4.70  )
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

