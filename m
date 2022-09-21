Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D4EC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 09:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=hUOunBOdQ/VFLbWChk2EqpMwRr
	AqwDB6XtRtJmxpLG80TwVIWbP44Es7Yg8od6/YF3hndbealY5BYk/TZpWdXPTqRWL1bwPDD606oUx
	bNAuuCXAOeTfpdM4ElTJTvR551YjB3/410eSUJZBR4alXhUkrqU6GuqpjmazKsRTwYw67iNp+Dfwc
	btvWjrFUM7FyHTennvkcmtq5z99oznaHevh6tUoPo4rArUXacsoba8IIQ800gc4o/hbvr4xAs0LN0
	XxK5NJaJG64KK3WfGWEzQEgfv/T/KW35ptH/xK+COwvjvRVFOGfNhIsh+meDvoE7fydnUU1etYqLR
	yqFZ7ziw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw8H-00ARpu-Ne; Wed, 21 Sep 2022 09:35:05 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oavzq-00AO38-4F
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:26:23 +0000
Received: by mail-wr1-f46.google.com with SMTP id n10so8773287wrw.12
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=bUmPuCyeZJbwF9UkoZMiigeIPdZLsxZxILw4wJoLJ1zjzYAYcgFihO6Mvggq6aaFXd
         9jMutHE9UYzDDUETo/UICxHBJXZOamZL5pDG9Rn/kOusE77CVWBbdzZ5+95rQU1VD6b7
         CFlxdymaaS/BTMMAOlj81nb6pAGPTReQafC4YI0SZTRPdeJ1LpKXm/Sw0LZRUHPFRdOv
         0a0mPyxCA0QO1Wp7sZAcVhlwK8xHLBlU7/I9HxLGkFWTPQg5t8t+m6fHXf1TD1slkKlh
         HhShez5jEaeyFYk/zReC2IR4Gej2qq1NR10xNKQkCB+W6MQpE8SYldlEv3h8MDFpgMVB
         qKGA==
X-Gm-Message-State: ACrzQf0W+B9vpMRFlA1/FIy85+m/tymrmxkh44xDzaxnhBFxPVXlQ3r1
	xcMoM7ryCdBpdrRxIsNj8fw=
X-Google-Smtp-Source: AMsMyM6D/NKS6FQXGn2/p1XWjHPiDTrly6Bb1AkP22dz8V6CboKuCdiwcIg06bLdayrFQhzsFzdvTg==
X-Received: by 2002:adf:f2cf:0:b0:22b:e4d:62cc with SMTP id d15-20020adff2cf000000b0022b0e4d62ccmr5773300wrp.27.1663752379539;
        Wed, 21 Sep 2022 02:26:19 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b003b47e8a5d22sm2452995wmq.23.2022.09.21.02.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:26:19 -0700 (PDT)
Message-ID: <be7c75de-db41-a0e9-212c-674ffbe9f32d@grimberg.me>
Date: Wed, 21 Sep 2022 12:26:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/13] nvme-tcp: use the tagset alloc/free helpers
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-5-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171611.1289361-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_022622_184192_6F9E1D42 
X-CRM114-Status: UNSURE (   7.32  )
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

