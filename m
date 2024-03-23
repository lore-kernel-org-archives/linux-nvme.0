Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93800C54E67
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Mar 2024 20:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8PFF1ALdD18tKsf2ODXQuJZZKPYp4fqk3eHNofM9oHI=; b=DQvyO8ftzabo60at52hYnWOQ6W
	lWeDzKg2V3PzH5HGwnQ5tubdHJtCEMO+3kVmaO+ir3G9lRRqPhcGfdjQg/dWoPpMhkGZfZFzuQlDy
	46ESa/JWyzuxdWhvBUvjPhy1gdkcS3lxGxvGeT2odyku3jCqGYES0FcdtbVWOZd+gNaGc2lZSnjQd
	VeIY5+/L1+bWmAScl+9ifCzNBECD5seuarWBWGJUOiVPf/1BV/RJtZYWCUFQa11e7JWI01a2kl2KM
	DIUuINCZeBY/zFT7QQdKpExWZEThRzSWN0zs/zb3Y02oIbliqhqlRZtF+wT9C1lMkh7bP3dTw05TC
	5L8b7swA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro81L-0000000B7aL-0d8f;
	Sat, 23 Mar 2024 20:31:15 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro81I-0000000B7Zk-0VQg
	for linux-nvme@lists.infradead.org;
	Sat, 23 Mar 2024 20:31:13 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso582701f8f.1
        for <linux-nvme@lists.infradead.org>; Sat, 23 Mar 2024 13:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711225868; x=1711830668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PFF1ALdD18tKsf2ODXQuJZZKPYp4fqk3eHNofM9oHI=;
        b=dOe3xyb7GoqcHUMLeUXrwiYgwYyqZPpQF2y+CGb1J+DGLfzSh7Blq+OKHo2JZfTLzx
         7s+OQhFJmCLBXvvUIJ/bMsshFbwUB0Er9wIG7Q8PzJhyhN3wrdRJuKA3VZZ12zJfdRsh
         /iGZvrUUkOvzVdg91fuLrmHexCct8f1XnyOuMkHP2AvE1M5FPxvhNG1iBUwu1egtXZJt
         PtGi9ovSvE/BSAMsx1UKiYYw1wC1bqx1xJxK8fnuCOD5VBbugmv8sZezkgoBcMidXzkQ
         TW0PAqiF6Ww0LWTHvxXtDtFIEtH5u36H+CTG/RNJFwfxVPYnlCNXy39tklLspYwU2/0J
         8pdg==
X-Forwarded-Encrypted: i=1; AJvYcCVA+ngwQaqZN1KMLv9UH6ZSUZFLSGNGdMnoCaaNNFAYI+oBahe/cTxzTc68i0dZkIitQosucQhwVsmWBOUNsGy81IXMhXhIRoaUMXh/kp4=
X-Gm-Message-State: AOJu0YzEqKmGjTzfsKQjujjeMjGo0G7zwMhWeOqF2KCSUJhy83sl3nY1
	BPUaEMQU0gniVc+yyoRZWulAvkynTWxmGIkN6ZDZy/FtyNSuXNem
X-Google-Smtp-Source: AGHT+IGMatvtXQfJ7xIIWP+xpAM0cG00k4SLleFCkwEPfafplCuQyMLLWZ7wE38X5wtqPI6DX63yRQ==
X-Received: by 2002:adf:ec4b:0:b0:33e:527:e1a7 with SMTP id w11-20020adfec4b000000b0033e0527e1a7mr1828100wrn.2.1711225867787;
        Sat, 23 Mar 2024 13:31:07 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id cc19-20020a5d5c13000000b0033ed8643638sm4215012wrb.106.2024.03.23.13.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 13:31:07 -0700 (PDT)
Message-ID: <efd797cc-2c6a-4d08-9100-762052a9c788@grimberg.me>
Date: Sat, 23 Mar 2024 22:31:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] nvmet: add debugfs support for queues
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240322070333.3820-1-hare@kernel.org>
 <20240322070333.3820-9-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240322070333.3820-9-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240323_133112_204572_F0BABFC0 
X-CRM114-Status: UNSURE (   8.70  )
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



On 22/03/2024 9:03, Hannes Reinecke wrote:
> Add debugfs entries to display the status of the controller
> queues.

I'm questioning the value of this. We can possibly see lots and lots of
queues and I wonder how a queue entry will this actually help.

