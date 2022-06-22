Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7CDC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 08:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TMLcY9quGOfnDxt6uuNq8IRoZDX/fRTpUh9O97Gywes=; b=tYum2FJKTd4m2Rzh61+c6r7mIO
	ECQ/Pz1rF8xswhXmc22GwNwVofuyGYKMIEvA8bylam3skO4dvmLkluSIgLx9XeSSavgTstuspuF7v
	KFyDprRdYgUE+khvS9NaHLa59dpYsZSvBRZhx0hwISq7dw5TS/LFNyHMCVhYsg8M8tqZO+r/YkEYr
	NrR+WFS3VIt7X0GaxU47mAHKnb/dlLc0KZdSX3FdywtighQSsC2ZgesBY3NTe2dEnOOJEpRNASEUg
	+kNarswrukRxQHhbauRHOhThoTRA2e1B+4FCRAFc79Fz0xE+RpEWpTWp8EwtIPeC19KhigTDms3xT
	3Bq2Zpfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3vxU-009KR2-PM; Wed, 22 Jun 2022 08:43:32 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3vxR-009KO8-KJ
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 08:43:30 +0000
Received: by mail-wr1-f41.google.com with SMTP id m1so14573108wrb.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 01:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TMLcY9quGOfnDxt6uuNq8IRoZDX/fRTpUh9O97Gywes=;
        b=j+Nk15K0BsqK9QgHkfefM3AfeGbFpQ7/JpmnCynwqyOoPZnzrncKZSy9LC3jAtTJOv
         2DvuTDo5grac/usB8QGrAKnW+ojm071+iL6XPIBeDohR4xm2h0viuTC9VgafXZOySb7b
         fG+ikhtu7cP9eMSKshLcmGSsPT6Ma8d518h4EwjdbWZo4KDMjUvbpr6/5O7KjGteE0sS
         KXfhGyRzkUPCL8/7S244R/MxtiZWPQavYo73na1G7y5DiZVsSr/l3z+FrnVXOcprPYrU
         YIezWPIZBJ3B5dUeqy3g+ZEjlPYmAmR1sELuZmKUJy1Fp6AiQW/nD7nMgd9exlagsSoE
         XKXw==
X-Gm-Message-State: AJIora+gMqJFIZfRCzzPAZgCCp3RSxnc6ODSpA6FfZ1t4o/IzBoYXMWP
	0ev9ygT+AGq0Pv3wfJ9aOls=
X-Google-Smtp-Source: AGRyM1vYkDMs8U/1kEMlWA9YwE5YaBRqKYMZKUNDED1Iz92h4yt3dWIrEu5wDQDxvJkendv5O2xT4g==
X-Received: by 2002:a5d:6d8f:0:b0:219:b5cd:6516 with SMTP id l15-20020a5d6d8f000000b00219b5cd6516mr2148992wrs.246.1655887404363;
        Wed, 22 Jun 2022 01:43:24 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b0021b90cc66a1sm7776735wrq.2.2022.06.22.01.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 01:43:24 -0700 (PDT)
Message-ID: <b0e6fa33-ed59-eaa7-3629-3d72430b8ad6@grimberg.me>
Date: Wed, 22 Jun 2022 11:43:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621090255.69549-1-hare@suse.de>
 <20220621090255.69549-7-hare@suse.de>
 <f8f0a631-6752-096c-4e85-bcde9bb2869e@grimberg.me>
 <22236c51-90cd-1707-05b8-3772ef4c548d@suse.de>
 <ab4aaf2b-444f-2b3c-091a-396de62afbd1@grimberg.me>
 <a32afeac-983c-2ea4-e693-2d46411e7f4a@grimberg.me>
 <3784f492-67f8-c75a-dccf-7f7272e0b4ad@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3784f492-67f8-c75a-dccf-7f7272e0b4ad@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_014329_703657_F1F2F875 
X-CRM114-Status: UNSURE (   8.68  )
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


>>> Looks like if I pass a malformed ctrl key to nvme connect I am able to
>>> crash the system:
>>
>> This was what I used in this:
>> $ nvme connect -a 192.168.123.1 -t tcp  -s 8009 -n testnqn1 -S 
>> "DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:" -C 
>> "DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
>>
>> The dhchap_ctrl_key is the offending string...
>>
> Right. Should be fixed with the attached patch.
> Can you check?

Yes, that works.

