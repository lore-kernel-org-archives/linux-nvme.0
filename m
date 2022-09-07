Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09E3ECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VclsBwWMPwSSc6WG1ScAeZK/qI5bpa4P2BnllCMhjRU=; b=gz4mO2Jaj9yVr0ZlSOJwqQ6IgC
	N3gU0fGSI5sbPuTd816IdWDNrUD6OHFlVTisNcoFpaP7xBODxDXsl5Gg4upqN5PCb+LUHFOjraocC
	ck6fDb2JnXjpotuNy8DrSbDOBaGAKn789VOjN0A9iENulsQwch1PzjzwuoFvs5VWlTGg//hf5rM4c
	hFXU6TlqmZ5JVg8MOOaRfxEGNuGb3kxyZWOHe0VjznPvtRuSyNuQ5pnYbbdnJ2sxnjGOagR6Ai48x
	TnlLEowss5vR0Dy6K1YgNVVNquyyYuueql9GnIk0joO3rZumixeVvQ/sbFEN8Sx+6TXqHUutpzb0R
	I+WCwJZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVq6T-00436X-P6; Wed, 07 Sep 2022 08:08:09 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVpw6-003wbz-Bk
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 07:57:27 +0000
Received: by mail-wr1-f46.google.com with SMTP id bz13so15614378wrb.2
        for <linux-nvme@lists.infradead.org>; Wed, 07 Sep 2022 00:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VclsBwWMPwSSc6WG1ScAeZK/qI5bpa4P2BnllCMhjRU=;
        b=4sCl6pMeTuSXnwUlM7PQD54Zabow57fA/i9E+Igjzyn5VNXutfr6KqhPWWS9psYWo2
         6KiklnUmnHfMus7ikg3Jt1053piFxnWgaLLMEi/EmdT7KsLQAxJlPDasmEaWXvd7aF4z
         feYd6Td2TCp4mlk8uLKYT1caQJaTb8g0/JTH+pWytO4IQpr+vW8WgahaCZd806CCYLx1
         9bsDeKF5O9cAmKI3FSLr15CiLLy8lPh7LWzjzuw/bLig5Fu9GUC9ZqBlomQRPrEWuoGR
         XAJssMKLR+JM/YhmArdBP7T/I/2xkTf7243gBINJDZJcjlrh75W8ES002twOjimWQ6bs
         0vpA==
X-Gm-Message-State: ACgBeo2krTN1nIcT4AVMx5J+0y7cUZJ8VAP+Qin+wD0+bccVdS7F+80/
	jUx2GmigFa0c52n3RMnFhZc=
X-Google-Smtp-Source: AA6agR5yYfzBcHn+ZDsCq/iPLTjzyVntnuoCxrIpw0nBbI7Yikrjp0RQ95DvXVzGYvZZitM7z00eUA==
X-Received: by 2002:a5d:648c:0:b0:220:7aa9:a13c with SMTP id o12-20020a5d648c000000b002207aa9a13cmr1174255wri.269.1662537443231;
        Wed, 07 Sep 2022 00:57:23 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m5-20020adff385000000b00228c792aaaasm8533471wro.100.2022.09.07.00.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 00:57:22 -0700 (PDT)
Message-ID: <2a5f39bd-c545-1224-12af-ce16feab4b5a@grimberg.me>
Date: Wed, 7 Sep 2022 10:57:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-tcp: delay error recovery after link drop
Content-Language: en-US
To: John Meneghini <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220714122703.67621-1-hare@suse.de>
 <86f1824d-72d4-72e3-0071-4a07aeb04b7b@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <86f1824d-72d4-72e3-0071-4a07aeb04b7b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_005726_452006_F6E6C500 
X-CRM114-Status: GOOD (  15.70  )
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


> I think the problem Hannes is trying to address with this patch is: the 
> Spec currently says:
> 
> Base 2.0 3.3.2.4
> 
> If an NVMe Transport connection is lost as a result of an NVMe Transport 
> error, then before performing
> recovery actions related to commands sent on I/O queues associated with 
> that NVMe Transport connection,
> the host should wait for at least the longer of:
> 
> - the NVMe Keep Alive timeout; or
> - the underlying fabric transport timeout, if any.
> 
> I'm not sure the NVMe/TCP host stack obeys this rule.
> 
> The problem is, when the host fails to follow this rule, some NVMe/TCP 
> controllers are found to corrupt data during cable pull tests.

The delay needs to come explicitly from the controller, not guessed
blindly by the host.

