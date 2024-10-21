Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74709D3C935
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 00:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Ws7CtYqE+dBLq2cmLlyarGZxW8g3pmUbSS7AsYX+rI=; b=UwbaEzkmJvCb6N8qPKksLOstzH
	fUHj5hm08zgt+UhkAcWO80hq4TnSd6OUoteMQu3TwYa+Awa5gG4HJbXrEAyokVlKE8uf02d28IhHT
	NJPLcPcPl6IQysO4+Vht5EZDIuZX+5ilebxgy7WO9h8PjugEDt5i2uDZcLDbZFVU/G9Y01ytYrjT0
	TboR338aHi/D65aJXTRTjZJxRmWxfQvz5qmEuo1PiQjty4uYLXonJSGPuJTAuJmFK26i3Fe9o/u+t
	htD1PZZp16Jyk8rU9UI24RCmjq6zM8+T+NOwxHpCqbV19XXXyhwT+IFKdL2yfcgFHZ1lLMaBwBBnl
	5K5H4zVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2gA2-00000005gzu-3MKB;
	Mon, 21 Oct 2024 00:20:38 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2gA0-00000005gzU-3dm2
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 00:20:38 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so35908385e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 17:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729470035; x=1730074835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ws7CtYqE+dBLq2cmLlyarGZxW8g3pmUbSS7AsYX+rI=;
        b=WrZ8Dqrh8usL0rBFqKGDbGhaeS8FXKd2Dfg+CmYiwLqQ7FmTY3KLJBZwaq2PKoYcOO
         iV+PwVux+tbiJZ07VmSATxSL9ByGMee9k2bbnWQftXW6MS/Z2LuVuk//b0nQdLsBZttx
         ttzK+GlDkax+lyG3g0MVDyVKlrmSkYWE7Q4AhNyOXl+5X3YlSRdWtwr/NADA5Giobz7i
         jRXwCOJWwnIiNPnIUkf3DZx+HH+UM07nrWMxm4435xsoJCa4fa80RL6IZsxaEmACjp1O
         8ofouA89i5+XXpmMdrqVAq5nv3+KP33wToMmzKDD8hkuLMjYFXnlhazk+MMpp4zpjioV
         r2cw==
X-Gm-Message-State: AOJu0YwxUd7AsaqYKGBR/TrcS+N2cS0fH30He99mNOme+9CZFnJBnUgb
	VTEQWWa20R/skEOosQ9CRZziMNEdZsqeWCmQl6oYkJIdgDfZ1Ay9Bd3xpQ==
X-Google-Smtp-Source: AGHT+IHb/G3HPBpVClkT4LUSQXTfEp4ueOb/VwTjnvCXinaifkxXY8M4ZBvcA5zdLW7eF0RN99dl+Q==
X-Received: by 2002:a05:600c:1c0b:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-4316165a097mr78283235e9.14.1729470035141;
        Sun, 20 Oct 2024 17:20:35 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57112esm38984225e9.6.2024.10.20.17.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 17:20:34 -0700 (PDT)
Message-ID: <561bbbc2-94ae-4458-9c1b-200648796836@grimberg.me>
Date: Mon, 21 Oct 2024 03:20:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme: enhance cns version checking
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20241017181231.2937468-1-kbusch@meta.com>
 <20241018051201.GD19831@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241018051201.GD19831@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_172036_941694_93161F37 
X-CRM114-Status: UNSURE (   5.58  )
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

> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


