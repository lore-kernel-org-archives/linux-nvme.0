Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFE5C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 13:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cUb7Ym7YiBit1oW7mIGdDtc855Srmaz5LFm1bk92JDs=; b=oMY2tZyaVhOj5DKWcn42w7rkxy
	rbCJNwtqP1XP34aZggN8mBF+38C7u/jHAnqYXnoAZ5yDWmBn/h+whn+v/OeGCCt+/jFFAz2jHvl0H
	I1u3SWpnPshgLWecIl2MVMD144IQJipFfnsRqKqOmqMSLUNDaxapFLCwsgXKntPhs+2p3N3rws6Zm
	rSd93DhN6Jh5aAKJxteIAHyJYk335h4+IJtGZGdiZtl3unP2asTquiKudsDNBra9Gj/Vkygk49jKx
	CaUdNFrzQxhgx/GpdRDS4WIjGNzicGTOeVe3o/BOqcPME+yLWHA9Bufyw/pMDtho36cU4WC/zfPUw
	6Hg6hMbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU7WV-009IRb-NG; Tue, 15 Mar 2022 13:47:39 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU7WT-009IQe-Cj
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 13:47:38 +0000
Received: by mail-wm1-f49.google.com with SMTP id 19so11281299wmy.3
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 06:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=cUb7Ym7YiBit1oW7mIGdDtc855Srmaz5LFm1bk92JDs=;
 b=5dpagRfkeu10iwLZfEYY7sW/yQOZSE01GTAUAsb588aL8ZYPdB6QLa+4YKaoR/f4nk
 Es8qkTLF+f/2kFL1yTYGuVKzod3wu/+qheI1Quu3Dx1dkoiF2P+ws+CjlkI9zFuTGKkH
 O921a+Uof2V7HiXyh31hNAqRdspk4Vc4D2bA6pWAbYZJgwCIIaTFSMJeT57SHB9EpPNd
 zhjnOnToAfKeNfHeoD0CVQvY7wKjI0hsSlprzoqvhlBxN2Tr2TdJ+acMySH32fGqJsUJ
 QpQBg5Fa1iB+rrID39e3iqTTEH0n24zJ5sbKcIGugq0E+qjNzOFYK09GK/xPQOeNn6EB
 s2gA==
X-Gm-Message-State: AOAM531KZLfSnMXMv/gjoTlRq6K/vVIb1bomURMmEtxcmTZQ6AU60eS1
 bzU+XzFCzFyOhVaObtmDizY=
X-Google-Smtp-Source: ABdhPJytT3AnIUgNmrWcCS6eglCCV+Fc0mjQURGc3W7lyrFTalBhR8Aju7XTZqMSC2tY0lfe/6nBxA==
X-Received: by 2002:a05:600c:4f47:b0:381:6c3e:19dc with SMTP id
 m7-20020a05600c4f4700b003816c3e19dcmr3423857wmq.155.1647352055447; 
 Tue, 15 Mar 2022 06:47:35 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 e2-20020adfe7c2000000b001f04d622e7fsm15562748wrn.39.2022.03.15.06.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 06:47:35 -0700 (PDT)
Message-ID: <90024a31-ea50-74fa-1ad2-db6c1db99fef@grimberg.me>
Date: Tue, 15 Mar 2022 15:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] [v2] nvme-pci: disable write zeros support on specific
 SSDs
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
 Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 axboe@fb.com, kbusch@kernel.org, alsa-devel@alsa-project.org,
 Mark_Hsieh@wistron.com
References: <20220315132059.12747-1-mark_hsieh@wistron.corp-partner.google.com>
 <20220315132202.GA12452@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315132202.GA12452@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_064737_474181_145065D3 
X-CRM114-Status: UNSURE (   9.32  )
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


>> Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
>> Write Zeroes command"), Micron has the same issue:
>> [ 6305.633887] blk_update_request: operation not supported error, dev
>> nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>
>> So also disable Write Zeroes command on Micron.
> 
> This still ignores all the questions I've asked.

For some reason I cannot find the original patch(es)

