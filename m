Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB2BC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 02:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pr8jpi42XLrkYS7gdd3XLY6V5/KTVZL2wfJp7gJJnoo=; b=D7y2Q4cyGWjql3Pcb7Zc1UOJaK
	VTX16o/JvKyTnasuf4OJDIzIq87V55PpoY0nOJnlS5Ib9qCGosvA9wSil2EG0g5bE7zHjbLrU4NyP
	Whd2aWCTy3uOLUD6TS5ZN4TLD6cnO9qkb5v8frefo017F6LOem58XDNK/HfgIc5d04itzUAMu2bG7
	0BQBwKdSPVJlqPzmZBytnBMNWU56Qv6x91BCArZdN3okq0w+Am2mGsOhIFfFM0qZcerG6U4sd/RRM
	RJmbRWsX72Aa3xoj+14pwSxR1LwPUH9Z+epA87YIUyX+saf03UpiW9ETkkPyK4ALBe7QzWdhwBddK
	J7EVOAgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbG2-00A6ys-O8; Wed, 09 Nov 2022 02:56:06 +0000
Received: from mail-pg1-f170.google.com ([209.85.215.170])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbFn-00A6ws-DR; Wed, 09 Nov 2022 02:55:52 +0000
Received: by mail-pg1-f170.google.com with SMTP id 6so6921712pgm.6;
        Tue, 08 Nov 2022 18:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pr8jpi42XLrkYS7gdd3XLY6V5/KTVZL2wfJp7gJJnoo=;
        b=M6AYH9dkjAR6FCIYm5TBa3sgR8GsdQWuUQnQQzyKuh+bbqG4E6/cyuyf2fuueRcmDX
         NUzpqG7jkuemV286BOAWqLfJb6LKb/yP0gD3dD96TLtu/qu76ofHwb+JlOkOdNkSQq+b
         g3wx2ksd8knhEnPteVicTJWhWc/6HuzvxhTbXSSABFsnHQiKzgOzDYWhpfLE8h4unEWj
         EbZPvrj7Hx8oFx+L06uConOlVOFwnWluYzdS2fD99eOI+ruxJWrghN3bTZHxghHX9L56
         WV98vFO+2LKumMrI1UNgAmlGTZfr45BokDU99TEiZjtyDW1RTh7osknq21c08OhRe/Kz
         Maiw==
X-Gm-Message-State: ACrzQf02mlHU/E6Tuw0jTme67xkgq3yClNirnOajlexXG/LVRJd9q9bi
	V3pvtFvXK+HtVCksY8Zzx/e17YYy5Ry4/w==
X-Google-Smtp-Source: AMsMyM6NTXB3au5qSi0Bg4jg71pvryW9B3UAElRci7agl3s/I6jdzrQt6DGwjKOVChyr6f4HStqZ6A==
X-Received: by 2002:a65:6c08:0:b0:448:c216:fe9 with SMTP id y8-20020a656c08000000b00448c2160fe9mr49250562pgu.243.1667962549303;
        Tue, 08 Nov 2022 18:55:49 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id q9-20020a6557c9000000b0046ec7beb53esm6532227pgr.8.2022.11.08.18.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 18:55:48 -0800 (PST)
Message-ID: <6f12b92c-a117-9c27-cd67-8c9fd9571a06@grimberg.me>
Date: Wed, 9 Nov 2022 04:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 01/12] nvme-pci: don't call nvme_init_ctrl_finish from
 nvme_passthru_end
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108150252.2123727-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_185551_480089_44BDB8C4 
X-CRM114-Status: UNSURE (   9.57  )
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


> nvme_passthrough_end can race with a reset, so we should not call
> nvme_init_ctrl_finish from here.  Instead just log that the controller
> capabilities might have changed.

Can you explain here what is the problem caused by calling this from
here?

