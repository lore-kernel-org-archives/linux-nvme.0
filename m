Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8AAC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 13:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XSheYqBW3WhpF+waYcdWVbhcpSJfgidzZKeoCy/PpPU=; b=s7aFC7BHBl+LttSb035rNn25IK
	B2eNoagJCBlmjkOn9cBBRa3h4xtucz1xHFL8BnF/o5DzP0foAzht7yEEr7BA1fIkbzZjVFQdR3uoi
	uka1eRpY4y6IfUeWjhfd7WJ6/7vbSa8ZxG6fmE8d6Ec2O2mxM3LFpkZjreLj7z1mva8a6RfInDToC
	2iGQUGSTJ2wprdnYT6kLZNUDcO4487cBVBVs3c+hajc8peB/+zLCZKjylNZmaXWlJZhpvnilbdr03
	WPA3L3Sv+WYtMYRVirnmdyAtpT32khHC3YFkIekQEwKvN8aBT4j5UhbOfmA2+Kr2yhAyqUFmyFTDH
	fi2FZNKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncSLn-00CBzu-3L; Thu, 07 Apr 2022 13:39:03 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncSLk-00CBxY-8s
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 13:39:01 +0000
Received: by mail-wr1-f52.google.com with SMTP id q19so7902658wrc.6
 for <linux-nvme@lists.infradead.org>; Thu, 07 Apr 2022 06:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XSheYqBW3WhpF+waYcdWVbhcpSJfgidzZKeoCy/PpPU=;
 b=IFyZCANXmCG2SD9/HNS4149jUnUvRofVszk7b9wVqz8mLoJE+hRhDhYSI0jn7Duaug
 6qErbR63TEeIwUcDW/OQySd1bMc8rlGU8rpefqrqRp5wRdZITxWx81m5oI8N9la/e6pN
 LAFtBPxBEx6jLeI/ACuBy/VbTewEKZYB/59TNi5KNyViL5nvsBSOIoJEv2bs9JhO+7Z3
 FNqn+g9lyqZu2lt+tcpXQte6Fg/CQwlSn6+sQjEdiGQdaJdH/GHWBnRWgRs0dfzsyE/a
 NC7pUHX4QSMSqWSWXu+pRfFGuwFFQ4Dlrdb8HP/3zAthO7ePwP1HYEDuLLxN7IA8Ld87
 DE5w==
X-Gm-Message-State: AOAM530LhriSB5FPojLVJqIPufZZXM0OxgzBsGFdW+qCfhcbeZOo003a
 2aniW5UQ4h8bseF/d1NCHR0=
X-Google-Smtp-Source: ABdhPJxAiYowzj70GdEZTXNCBWhVUQwv9u/C0XN4MhkJ+ObRmQ0RckTsxyWwL0e24XbhrSGI4IXV1Q==
X-Received: by 2002:adf:e193:0:b0:206:e88:cb3c with SMTP id
 az19-20020adfe193000000b002060e88cb3cmr10854435wrb.461.1649338736790; 
 Thu, 07 Apr 2022 06:38:56 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 i14-20020a0560001ace00b00203da1fa749sm25495339wry.72.2022.04.07.06.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Apr 2022 06:38:56 -0700 (PDT)
Message-ID: <f7f1e537-ed14-5ed9-4274-ab60f18dce60@grimberg.me>
Date: Thu, 7 Apr 2022 16:38:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in the discovery
 log page
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-4-hare@suse.de>
 <81dd2585-3c71-370f-70da-302072f3e9af@grimberg.me>
 <f28bed4d-a5a5-b1e4-020e-c76ded479c5b@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f28bed4d-a5a5-b1e4-020e-c76ded479c5b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_063900_404427_A5DFC445 
X-CRM114-Status: GOOD (  11.00  )
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


>>> When a per-port discovery subsystem is used we should include
>>> all configured ports in the discovery log page, not just that one
>>> through which the controller was connected.
>>
>> Why?
>>
> Because that's the whole point if it being configurable.

Maybe I'm missing something. It is one thing to allow configurable
discovery NQNs, it is another thing to have discovery subsystems that
are producing a log page about all connected ports.

I suggest that if we want to have discovery subsystems that will
produce entries on different ports, the log page content needs to be
programmed explicitly in some form. Doing that is going to produce
routing issues for sure (subnets, vlans, etc etc etc will cause hosts
to get log entries for subsystems they can't connect to).

