Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B92C001B0
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CIJajdd4Yc3wo/yJr5hUql5qY0jUL0/PgHadt/NVtZQ=; b=KY31jJZkjIKnAGey4roahfFd5f
	aewxqJnHlL5rWFjuf7Ago2JKHRYnqlqqQyP40V9Tpl1i8X+urFw0fkCTZHP6rmPRTjQTfwXbNbeeA
	ON2ylYsH3Mra757WYH96FOJU38CYVal/FciazKlbkDOry05HUjgjT2va1P1uRMWlgGRrJHb7x+WW7
	hBSIa4+0ctgOM+1qM5XpioqyZsOa4s7NUNE9wULmx5ksCfACgoqZbvxR+9pkHXUcMmSVtK6mGDwo+
	MmpyK/iyA4H4/LLWzUy1GVuhduRoRw7VCA6MCkxC4tRln11CTFArWYebQLij4Snl3IP94IXT7UUQ+
	F3ktXlPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKIB-002OuU-0j;
	Tue, 08 Aug 2023 10:50:23 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKI7-002OrQ-1B
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 10:50:21 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fe5c552dd0so3301565e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 08 Aug 2023 03:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691491817; x=1692096617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIJajdd4Yc3wo/yJr5hUql5qY0jUL0/PgHadt/NVtZQ=;
        b=Za5NYeArLJ6JHBxykeMF6Wivffsdv8846lFa2BdetJ4inUBkRnnMdFsJla4SRjy9hW
         Jaf6GPMvXuls76JsvzaT3BxhoDQa+Nb7wJJl1xWEZsObVfUCOZVfs7F45D3v22GdLC9Y
         WpZhTHJ7EM7hOtdFS5j6QTMwmaogGZHH/vHF88K70Y8Jr6QLINwTCF9rGXBgRS2gD2cD
         4m+ksT4wSxGWSAf1d68TEpOhJ969drll3GPlJo4lzEWn2x2FztygglnhZeSMGrs34j8h
         cqglQ4+NBskM+WCZ6thPIMjcTdxvMQNF5fLGrMLQdyDUXZejYTV1ATbBSVGwe3mStWYg
         AWdQ==
X-Gm-Message-State: ABy/qLbmGgQQYAU0IX7LKNlJqG2C7/5wm7tM4O15p1kpnV7osDXlyvj0
	c63V3pFMKP7ZLVgXYspcyhk=
X-Google-Smtp-Source: APBJJlEoiyO37RduZ7UBE8MsP6lQX9+dGJ+PMsujgLSdn/gByNmxC9FfTmJiAV5YnY2h1CjgpXWYlA==
X-Received: by 2002:a05:600c:32af:b0:3fb:aadc:41dc with SMTP id t47-20020a05600c32af00b003fbaadc41dcmr25000550wmp.4.1691491817395;
        Tue, 08 Aug 2023 03:50:17 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe0c9000000b003145559a691sm13581437wri.41.2023.08.08.03.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 03:50:16 -0700 (PDT)
Message-ID: <14286c1a-b6cd-24bb-0f9c-7943c97b8304@grimberg.me>
Date: Tue, 8 Aug 2023 13:50:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH libnvme v3 2/2] fabrics: Do not pass disable_sqflow if not
 supported
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Caleb Sander <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>
References: <20230808091550.25349-1-dwagner@suse.de>
 <20230808091550.25349-3-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230808091550.25349-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_035019_408772_53F71F9E 
X-CRM114-Status: UNSURE (   8.41  )
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

> From: Sagi Grimberg <sagi@grimberg.me>

You can make the patch from you, you are sending it after all..

> Only retry a connect attempt with disable_sqflow if the kernel
> actually supports this option.

commit msg needs update.

