Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70452C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=goqzYnoRPUgbVjOUfuw22yajzSTj9btikvdeOWAdL9A=; b=pcApmyqPRZvn+yK/xE8eDD2Q48
	z8nATyJFpRMCTe6pfscytt/S/vb8L8GQcF+uT2ndZbieicNpZ6Fv4RBsi691PkXDSLP+8WgMrxrKk
	W1qSp/LQjaW1gySM5ZRmlO7r4cttqHlTxJYagQJcKl77L3lSOZAIP0GfT5ZYqtnzFHpYDjqfY3Gpl
	mk7CNd5lebs+yc7uNdOglizFPpAHDlr41ZdxiP4HtM7oGvSDeBRJg2pxzpLd7ymQa2/eI58T/sWXH
	AnPh6Qc8o2UQmX6Ml5xOUl4FrqVj0T2Ph8ftqQ3tYebg+Eljzyq6+FakoDFFQM1xK7a1vFb62UHoT
	euJdIrfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQfK-007wDW-QO; Tue, 22 Nov 2022 10:38:10 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQfI-007wB9-Bk
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 10:38:09 +0000
Received: by mail-wm1-f45.google.com with SMTP id v7so10416921wmn.0
        for <linux-nvme@lists.infradead.org>; Tue, 22 Nov 2022 02:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=goqzYnoRPUgbVjOUfuw22yajzSTj9btikvdeOWAdL9A=;
        b=koAfiUe2q+cc/Z8PISOERM+pz0k4xAfs0SsBsRTMQ8lIszk/Zfcx3c6ZaTxwX/OHhr
         ZfnoAEEKVxcrE75FRmxpO2gNmXc8dchGSgLRZva8S2rwmphgshadgw8n6g3tZWXn3iMA
         /llNTblXdj9IT/gNOyXfoelzbr9dOoinHOQpENEw82L9Ui0HzUoS3KxSHzdrGjxkowGZ
         VHSwFJdZoa61+iutl8luPJ4ZphLXJVbqVrAktEyz2jNHUDJGb0D70Fw/tAbZ0W6XXSWP
         PdeSGdES9JQH5y3xGLkLzFyB0gdFz/X7oXF2V2Sp8kD953YX8O3vDfZXlfBw9/dLIo8Y
         UmVQ==
X-Gm-Message-State: ANoB5pnWbfTXEZR74sUBGuAHrFWlC8DayxkcbwOMN8DROiaA/JsUh+UE
	NvuwK/QbxuBefPQ4MHKJZw+vzvqK93E=
X-Google-Smtp-Source: AA0mqf6FxwyoBPdxbxIWNrexGa5sMQBTrYAc9tnvjTmxHuillBdEyqdEmhJ0+oPomSfrfbgNOgIvGQ==
X-Received: by 2002:a05:600c:4194:b0:3cf:5080:412c with SMTP id p20-20020a05600c419400b003cf5080412cmr18568888wmh.99.1669113483303;
        Tue, 22 Nov 2022 02:38:03 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id g34-20020a05600c4ca200b003a1980d55c4sm19929274wmp.47.2022.11.22.02.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 02:38:02 -0800 (PST)
Message-ID: <a3bca9c6-f9d1-fd30-33c1-60ef00107997@grimberg.me>
Date: Tue, 22 Nov 2022 12:38:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: block dangerous passthrough operation
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org
References: <20221116130104.2186334-1-hch@lst.de>
 <256d34ff-3979-9780-4426-6d913a3a9707@kernel.dk>
 <20221121074647.GD24507@lst.de> <Y3uazieJ5xRR8jg7@kbusch-mbp>
 <20221122064743.GA14698@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221122064743.GA14698@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_023808_428712_95E76BA2 
X-CRM114-Status: GOOD (  11.60  )
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


>> It's not like just anyone can do this kind of craziness. It's like a
>> soft equivalent of pulling a cable. There are usually access
>> restrictions for untrusted people.
> 
> Yes, there are.  But that doesn't change us having to deal with the
> fallout.

Maybe we should do the inverse?
Whitelist what userspace is known to be allowed to do, and anything
outside of that, we don't prevent but rather log a big fat log message
that the driver behavior is unexpected?

That would prevent loss of flexibility, but still tell users that this
is not intended to be supported...

