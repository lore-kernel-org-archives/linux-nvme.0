Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8DEC7EE43
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 08:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Y5ziQCu3n0Q5XIw1pr5BjjzuuU
	jK1wqZM/KgHdbrx3L8e3wmtxPa4H0WOhdA838J2/tsfFtSDRxte8VGGyxbE3JNLt03KJ0ooC5eeFm
	QmKcEPVvIzxP59QpneLuRYpKvL12uXbIXRVgIjF+23+h+w/miV3T7VW8k28msOPPbGsr5qiXSEdHf
	ankGxg4DYGXojYaszkoc+DGCCcuHY49VbHWVQdih0VDHyqhkoPF3hbn9VrhnIa2zhwS8MlsWeXAvl
	raw6w0LCmYy/O+KNgh54yuMbry1jXClSEilom0CVRYDVnYR2xnlzD+Kk01xpCX0tJo2R3IDW4zOxQ
	WMe7aiiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8cYn-00326s-0V;
	Mon, 12 Jun 2023 08:05:57 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8cYk-003269-0g
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 08:05:55 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-30e528eef6dso345277f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 12 Jun 2023 01:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686557151; x=1689149151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AjohutceaSa4/J4J/sLY8hT5JRTIU+EHa+Pd6ef4Ik8vQjLFNEKPuv/JAnBCtPywz/
         jmo0AkfAFp76FM4RPH+ORTuuhpVTkCbaKxx3zMXXBQO+oxCEa5uW4u/oMdOWblkzLYJY
         45GXFiKthouBNBJwF+VVbdnd3/IrPpZWfBZ5KrUGx75F0fjCvtfDrQrHy5hT6PMFQ/6v
         SVN5aMvY+pk9KmEm+8MarhLSZuvtPChEYLMZ+4WxzEsegIAwFoSIVvMQ+zga+Nxayxkh
         Tkc9+KyI690DBAitWG//F7uE+dA+y1yVd3eGi0F62lb8LBpEeQGnxbzsZce1mo1ygLpz
         8FkA==
X-Gm-Message-State: AC+VfDzkovlDuGbnu8WmIWLnlw+khE7G/KYs4LX9DyQ1ICs5//7lT9FS
	pFO0EylRWOl0vtZ2xyVPVYk=
X-Google-Smtp-Source: ACHHUZ4wjm9FjPeTJpQG1i/GtNveCrILsDXAQuVj4C5FEnWlCtxLHZjk35Qpm9fvQDs7ysmim3ppEw==
X-Received: by 2002:adf:f881:0:b0:30f:bca7:9f4e with SMTP id u1-20020adff881000000b0030fbca79f4emr2319250wrp.6.1686557151258;
        Mon, 12 Jun 2023 01:05:51 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm11658301wro.98.2023.06.12.01.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 01:05:50 -0700 (PDT)
Message-ID: <54787ac6-7e30-d5f8-2ee3-f52df8123c0b@grimberg.me>
Date: Mon, 12 Jun 2023 11:05:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] net/tls: implement ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230609125153.3919-1-hare@suse.de>
 <20230609125153.3919-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230609125153.3919-4-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_010554_254239_01AEBCB9 
X-CRM114-Status: UNSURE (   6.23  )
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

