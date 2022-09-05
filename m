Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2987ECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CfXvCTQvJ4FRajBqEN3FZDrnJDXPCaKLUZfc0vc6Ic=; b=fkA2FoSvQEEKsNUpQKL5fAMitY
	LtJKgtGLiiu1xYtSaKReWNWhnBVO9TNUKupqqsEqwIVxlo6OLHxeYbhA8GXM83kiTN23Sy+HFfh6j
	KSq99hpEsW8QP8ufCvwGo+ZyvjTZ3dPMHLOP0bCd5djPlH0O2Q5uO/w24l7a4naX6lX7wJ0ToOEJE
	qUc459ysMfVDf9hkYF5KDZM82xUDjydxPrYxIYHTp3/KuSOocRfuZ5SO9uoQcw/4nfF7eCho8GjyV
	ynuoF/8KXzfFR+oZxU1KAhGPP3zMOkYLBZZAZ4NgREU7vyEscq//4cUctyMD+eakdpBM004l2vvib
	75K7I3Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV8Tl-00GIlp-RO; Mon, 05 Sep 2022 09:33:17 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV6iI-00DUUg-UD
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 07:40:14 +0000
Received: by mail-wr1-f48.google.com with SMTP id bp20so9646689wrb.9
        for <linux-nvme@lists.infradead.org>; Mon, 05 Sep 2022 00:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9CfXvCTQvJ4FRajBqEN3FZDrnJDXPCaKLUZfc0vc6Ic=;
        b=XPLnnmtF1oPjJQoYxmmGZECWB/7ul4LQyYVgSejTVNwC7nz4cLpI8YXb1ABzvtFDHi
         409nJKRnG3emTYGObRkJJBNY0G7dfyzjAehyodQ8B4RU/3GLkLyKNuoONibyd5RqqggQ
         4STUfQwTFxRI8R+Vo9a0mY7BEZrfrIVAedRb543JacwS94+VaKRv5qEzw8tWnz1O6VTt
         ++L95/xJ7Lr/6sHYYsPsveZHSTuirYrEaFo7ptgb9xBh79PpOFIOC8VChoatFA6C0vhB
         aHYzv1QGm3JUVHznIVG20YR/iRNFtjhlI17AYmJ1Zm0vOHtuR7EiG6KYk2TUC8ZD8P4I
         uUGQ==
X-Gm-Message-State: ACgBeo39v0YqSSMYS6pWybpRCVTlGdzGqpxpSENLu38HTDjecwZqrv+K
	aC4e91SGBuPZnWnY8B8tjFYWZb33+xk=
X-Google-Smtp-Source: AA6agR5pA7tg++2Cg9cj6Z8Viluyte9BALghJtBhnrD1aKkj9+zeqVlKw1lcvXqihEi74nF/l8N8wg==
X-Received: by 2002:a5d:504a:0:b0:228:a1ae:2038 with SMTP id h10-20020a5d504a000000b00228a1ae2038mr1203114wrt.645.1662363606458;
        Mon, 05 Sep 2022 00:40:06 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg15-20020a05600c3c8f00b003a4f08495b7sm18095867wmb.34.2022.09.05.00.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 00:40:05 -0700 (PDT)
Message-ID: <e98a1c28-4994-470d-6fee-ed569de536ed@grimberg.me>
Date: Mon, 5 Sep 2022 10:40:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] nvme-tcp: Print actual source IP address through sysfs
 "address" attr
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 Martin Belanger <martin.belanger@dell.com>
References: <BL0PR13MB42919EA6B50B34A1A60455969C7A9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BL0PR13MB42919EA6B50B34A1A60455969C7A9@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_004011_096199_2F292A42 
X-CRM114-Status: GOOD (  15.28  )
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


> From: Martin Belanger <martin.belanger@dell.com>
> 
> TCP transport relies on the routing table to determine which source
> address and interface to use when making a connection. Currently,
> there is no way to tell from userspace where a connection was made.
> This patch exposes the actual source address using a new field named
> "src_addr=" in the "address" attribute.
> 
> This is needed to diagnose and identify connectivity issues. With
> the source address we can infer the interface associated with each
> connection.
> 
> This was tested with nvme-cli 2.0 to verify it does not have any
> adverse effect. The new "src_addr=" field will simply be displayed in
> the output of the "list-subsys" or "list -v" commands as shown here.
> 
> $ nvme list-subsys
> nvme-subsys0 - NQN=nqn.2014-08.org.nvmexpress.discovery
> \
>   +- nvme0 tcp traddr=192.168.56.1,trsvcid=8009,src_addr=192.168.56.101 live

I wonder how this works with udev events etc for auto-connect? and also
for uniqueness checks...

