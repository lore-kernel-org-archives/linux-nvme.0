Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDE9C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Dec 2022 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZMvZYtPhQ6v552st1+0PUsxnupmJDkG0HBS6Ub4WQ4I=; b=HxY85XxJhpC7LnqokwcxcLFmIE
	YATZjbyZMkzxwdvZfUZauZdgFee94r35MloPYrX8NkJZF61/YMD/4U+Ohngpg6rhTEf+RtHcFbZMI
	KB4nOERu1OYPO+vHcIH9ifNBv53d1kChSiuJ2v8CGeUnr5QPR/el6gRuzkfM2GmllHSFo5OUc2k/T
	J86YzNY+GfbWCIUZcqgsSfY3MqzsyxOMKd2b8uWZbiKOpQ0IKUpC1aYbvAyXHhXbhSSWpPWCr2K73
	2ixtO/57BkHzHw+DcUWw7Mqme5wHpIDKxvWhkmCbkxch7qZgd0aTF/EU3V6LkzxZBArU4ERnGB3cX
	zLq8WyXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pArh0-00FQhM-IU; Thu, 29 Dec 2022 12:07:26 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pArgq-00FQYk-Sb
	for linux-nvme@lists.infradead.org; Thu, 29 Dec 2022 12:07:24 +0000
Received: by mail-wr1-f45.google.com with SMTP id t15so8378729wro.9
        for <linux-nvme@lists.infradead.org>; Thu, 29 Dec 2022 04:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMvZYtPhQ6v552st1+0PUsxnupmJDkG0HBS6Ub4WQ4I=;
        b=6BOXrglEsCtAS06f93Rpl5wF8mpStuEiWGbGISavtpQZV2YuCWAjywuYLCZnbxMMYa
         Iwh02vSJZflo57AxKtG0kuMw6576o+Pbfm7KrpTEHqCaPDXcBEWeNiHYyRW7MIos6wLw
         0ILFnuGcMvAPu8/6H16GfvKZtSZL2NYIgIp6siuNxG1Cz6vmt8dVLfPw+NhBtSsAnFq2
         XqaTBCg+rv1SGmptPR4wAK2cDTGnD/QwbOMY5l3eDltoi409FPr0nDFe283HD3RUbCIO
         Xq0nacRV8PmXln+8Y+E40aLc5PQBEdidyzBdgZSpL8d5VfN6XDT4OuXtnxMX70esyBWQ
         XI5w==
X-Gm-Message-State: AFqh2kpAvZ8OctxbjOe2UB8v6CY43YdKS0S3pUgbB1OXuyu9kpVno4+1
	oejzNpQ25yD8ZMB/hQtERkE=
X-Google-Smtp-Source: AMrXdXvuzdT51KAZ/yt6xqX+OUrEsou4DYRXOV7fx/CrBP6Wipk0EVM11Y6do84a6rilYKogkWtHMg==
X-Received: by 2002:a05:6000:1373:b0:242:30b3:3ca7 with SMTP id q19-20020a056000137300b0024230b33ca7mr16826847wrz.11.1672315627440;
        Thu, 29 Dec 2022 04:07:07 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d594a000000b0028663fc8f4csm5093473wri.30.2022.12.29.04.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 04:07:06 -0800 (PST)
Message-ID: <c1f876cb-5004-c91e-398c-83fb007bb697@grimberg.me>
Date: Thu, 29 Dec 2022 14:07:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/4] nvme-pci: update sqsize when adjusting the queue
 depth
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe
 <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Hugh Dickins <hughd@google.com>, linux-nvme@lists.infradead.org
References: <20221225103234.226794-1-hch@lst.de>
 <20221225103234.226794-3-hch@lst.de>
 <f0d3c027-d793-8266-7c69-30a85f884b23@grimberg.me>
 <20221228161050.GA849@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221228161050.GA849@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221229_040717_439217_693115F1 
X-CRM114-Status: GOOD (  11.53  )
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


>> But if you want to patches 1+2 to be taken before 3+4, I'd make sqsize
>> to be a 0's based value of q_depth after we subtract one entry for queue
>> wraparound. So others would not get affected from patches 1+2. Then in
>> one batch make all assignments to sqsize 1's based like in patch 3 and
>> change nvme_alloc_io_tagset at the same time.
> 
> 1 doe not make any difference in the 0s based vs not values,
> they just reduce the queue size by 1 intentionally.

Not sure who is they here...

Anyways, I guess we'll have to wait and see if someone happens to care
if his/hers effective queuing is reduced by 1 all of a sudden...

