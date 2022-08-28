Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31237ECAAD2
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Aug 2022 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=lMWrIW17Xpkumf73KD1SguayU3
	2Y9lb43cTdOEUFI5Bmet6Duyqtz4/+uuUor/b/B+mBAHvRemmjZ3vUez4/GzlQzpa95AJuHmog68y
	EoJzbKAY/cQP+8ozjdnwHYDuDK9Lm16An722fJTRev4vGm907qWeiDogphP0jL6wXQjyiMTs0QnQf
	3Wsb5wv6sCCTX5NUqrsbyAAKK5Lq/qHYkkG7u2O8brIn75JWaLxRyqUHBi6aaOGKbHiVYg6aDQ2ue
	SWpPu87Xtm9jGOJkuvS/gEgt/zTUGzInznT0wiDXlowRNm9IikVjqWRHFbz0vYL3nHrOqrewcxDhQ
	saR3cjxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSJjz-00055P-HF; Sun, 28 Aug 2022 14:58:23 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSJjx-00053V-C2
	for linux-nvme@lists.infradead.org; Sun, 28 Aug 2022 14:58:22 +0000
Received: by mail-wr1-f45.google.com with SMTP id bu22so6945104wrb.3
        for <linux-nvme@lists.infradead.org>; Sun, 28 Aug 2022 07:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FWMJeDbdpt0M+bEmDN8GiyIhMxAiFu+BCiGODIbwhR5P2cMa2sg4BQHeQp5zweOLWt
         MaZHjE3iwDUgmH1gthY8Px4ob+FRWR/youlx8W3hnYbc1i7g4NxeHYryOv4AMEk9hjab
         amDEIlsMcYys5EBwggAmWOZ0Air8Tit440ll/DdSAY/E8s5tbrxRV76voZBzk5UysNdE
         98yVubZXMkFIH5efOupurMeZr6v/i1f3w0fXO2C1vBE8utpTkldWKHy9pnSq4uxxIp6P
         C9HF+pxITxKlT5maF0REj3l7VzqXUM1GHU2ydaKg9a+9GYWNwWrB2onU7EHolsH96W2b
         ddyQ==
X-Gm-Message-State: ACgBeo24Vm0mqkWzbGE6lVsYkmGiXsfj3zoabzeUu67eA3Jj8a59EN1q
	g3MlmQ/BMeBRz7ODit+eWOCKKoZc4Io=
X-Google-Smtp-Source: AA6agR4L3gLo1naKhqtacGF/6IkBuBsdWbnVh4I9sjFBMJEvrlqLo4aZrMyYj6SV2yQBq6jSJ+2ONQ==
X-Received: by 2002:a05:6000:1d9b:b0:225:56dd:f060 with SMTP id bk27-20020a0560001d9b00b0022556ddf060mr4140603wrb.580.1661698699620;
        Sun, 28 Aug 2022 07:58:19 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4108000000b0021eed2414c9sm4682635wrp.40.2022.08.28.07.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 07:58:17 -0700 (PDT)
Message-ID: <ebb6edad-4df0-c032-3801-95e18d2fdb0b@grimberg.me>
Date: Sun, 28 Aug 2022 17:58:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-target: add missing goto in nvmet_setup_auth()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Tal Lossos <tallossos@gmail.com>
References: <20220824072316.44389-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220824072316.44389-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220828_075821_456850_0C89E7F8 
X-CRM114-Status: UNSURE (   6.56  )
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

