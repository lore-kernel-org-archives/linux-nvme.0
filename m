Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFFFECAAD2
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Aug 2022 12:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=o/H2VxNWQkSA8C0BzbEHH23aCb
	PH933o9foPffLTb2zH8uIkZFuPntzg7ROgF/M8PCsZC3acgL6oLuiRQnJafU4nlmdnApx2WrHy28Y
	5PiTcIFTFRmEwFhJkhxTgclt1hHSkCsixe4QGkUfDYpLnss11joEZqYVPx4ko3bp//fYhGCxdsvnz
	3I/d201fMr+t2/YjGhE3H7NwxH7w5xCFmhedkLo6AJORRIWjlCRQDJqxbdYihgeiGOoJ4rwsjCucw
	tw91CZHp70sPSzkWhcC4RMcDUeDBREUl6+2J7YwEigaPeMBprDkEaURCehCCpOKINLIkYq1nTfjyc
	db5J+z0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSH89-00GgQ8-E9; Sun, 28 Aug 2022 12:11:09 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSH85-00GgO7-3N
	for linux-nvme@lists.infradead.org; Sun, 28 Aug 2022 12:11:07 +0000
Received: by mail-wm1-f41.google.com with SMTP id ay12so3010287wmb.1
        for <linux-nvme@lists.infradead.org>; Sun, 28 Aug 2022 05:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=d4rTK497ylbqvL6daBK5acbfMBDGOYzdoP5fFo/ltW7nivKrxoogOt/TbCD8baXamp
         yUbNq+kp7YTmPgVDgWH+XMQW7v4oLBggP2xt7LI8DvuVZeMH1Rx0OvF7TJNS4c3hHOdu
         5m2UTRv1CpDKCrl+cr/WIHGfxKsKYVDOV5udz3bvFJ80zydW4XzhJOMDUX3ZF62Rcv6F
         S0f0QAdtvCIwmGclIkYULjyA2Zw8e2UcqYg75E+Ylhs7IFBkaMuqOlbQ1MFawes0bTjP
         ORn5vI1r4OILwghbeY3wbaUoqYWul+/c6c29uzmCVTTVnWonYf3tpqVse9Z3m/+0616R
         m3GA==
X-Gm-Message-State: ACgBeo1yaTj6HaJc20PLJsEHH6rzXrHWC1EBeoEGopzJehKuU3v5914J
	EmkCnIRkV8U2woEJBcSh64E=
X-Google-Smtp-Source: AA6agR6p1zky6XSF4QoN+jDhP0F1SbFBRo14c/DlWX/hsro18Ef7lHgSmwK3seHuf4VYsKAGiHdcEQ==
X-Received: by 2002:a1c:3b55:0:b0:3a6:7b62:3901 with SMTP id i82-20020a1c3b55000000b003a67b623901mr4348355wma.113.1661688663277;
        Sun, 28 Aug 2022 05:11:03 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg26-20020a05600c3c9a00b003a4f08495b7sm6251126wmb.34.2022.08.28.05.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 05:11:02 -0700 (PDT)
Message-ID: <78aafc8d-19c6-f14e-59b4-cc5a4c06c826@grimberg.me>
Date: Sun, 28 Aug 2022 15:11:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-fc: fix the fc_appid_store return value
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: "Ewan D . Milne" <emilne@redhat.com>, James Smart <jsmart2021@gmail.com>,
 Muneendra Kumar M <muneendra.kumar@broadcom.com>
References: <20220806083228.3826126-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220806083228.3826126-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220828_051106_428539_42167204 
X-CRM114-Status: UNSURE (   6.69  )
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

