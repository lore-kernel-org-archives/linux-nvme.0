Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74082ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Sep 2022 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jQndpqP8W6TO9Vf994myujTqgli97qSDnYBmLqLQy/w=; b=ya+YmjoqrWlsSnYLQMn3OTkSvn
	xfXYJN64xYKZyO7ZXagAPXK/+TDscdDUHVYTYUUnZ+La/XG9YgmvLwqRi+PKwU2BouqSOf6J2svVM
	HBZJrs+iI/bG+dnv4frwYxEYhVFr8Sr2JfPOjXZUkeqxZuenQa0dWPEgk3I+vTuAwHxJ6DUZn7YwF
	0eFzxtwZHl9y5TCQQfUBK8fC6PsmMdp4tjMIB50imfM9F6XNK09hJEwRi356BPa+PQTWbLDN3kNF3
	om11SpYbvtiLITaWj64X3H/+wqWcShZVyQ5RQI5l3G6ApSk9FKtoQDrhuBxuHtC7P18UbAO6vc8ca
	A1qccL5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXiUJ-009ieN-Tp; Mon, 12 Sep 2022 12:24:31 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXiUH-009ibT-OE
	for linux-nvme@lists.infradead.org; Mon, 12 Sep 2022 12:24:30 +0000
Received: by mail-wm1-f44.google.com with SMTP id o5so2964517wms.1
        for <linux-nvme@lists.infradead.org>; Mon, 12 Sep 2022 05:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jQndpqP8W6TO9Vf994myujTqgli97qSDnYBmLqLQy/w=;
        b=C50uCgpr+xi0ePv8kLe87d2RUJ2Kl+SQXheqeBDnqF3YpUTognGZ3QojLENtWGWIpv
         BV7bcoFAHCfPPiU1WsA4nXHoTSyppbh9/0ENcglMcJi4S8Y/RCx5mkOqcNphsvKGzntU
         GLpLPYqtnwOJPiaMFc7qaEc1DALZX+jIzC/r4ZpjCyb+gfs2qS5iMX4gZjM/julx560Q
         oSckfCmKwBW7FFbqna0NvU3e/97Gekcnb0Y8l6w7i0xM6mzyG0/ga4hBwj60EuaRDm90
         188b4+64UPLCeckKmm0MsMt3bK5ByDCLwtMd8MEX78bJ9EcBRdWtSbAEt8lRX9lJvl76
         rwXw==
X-Gm-Message-State: ACgBeo3i8lb/UYOdUm+nw1edyc2CtRlrOYGyae4fvwYbzYNQ+MwECqRt
	K2YJirDd1HPC+IThcTLwQBA=
X-Google-Smtp-Source: AA6agR60MEdz7tkA995P5KkMeSCKwyj7xY161HjLZtyNocEt9ROYq/EhEhfA0rrYKcvVGUjcSnYZcA==
X-Received: by 2002:a1c:202:0:b0:3a8:4197:eec0 with SMTP id 2-20020a1c0202000000b003a84197eec0mr13831958wmc.83.1662985467249;
        Mon, 12 Sep 2022 05:24:27 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b00228dcf471e8sm7164395wrq.56.2022.09.12.05.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 05:24:26 -0700 (PDT)
Message-ID: <47a2cf67-6ec2-4d14-cb45-95c402dd8086@grimberg.me>
Date: Mon, 12 Sep 2022 15:24:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] nvme-tcp: Print actual source IP address through sysfs
 "address" attr
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 Martin Belanger <martin.belanger@dell.com>
References: <BL0PR13MB4291260D145FAAC1B2B5C4859C419@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BL0PR13MB4291260D145FAAC1B2B5C4859C419@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_052429_812870_E128C010 
X-CRM114-Status: UNSURE (   5.75  )
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

OK...

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

