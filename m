Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0880CC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=jOw5UPLqQ4V24XFUvvfTK5t9n+
	CVOK6MUgtJRdx2G9ad9CIUuBbLrmJHmZPQoy8tQ2JTUE3CpmoC+REheagmP0GCUsi78E3TNPtnWPR
	Tc6qO7e3mTPcliwjYADfFAp1+tvMMYFutrgo+ryvsTrC1XRY6pBN7Z676G9ekewh9w0SoY7DV9Lla
	0lc3pMOftRsVquI4QXNZDp8KcqBDSPS90I+82X8T09Sm7k+YtYtmRjInn+il1hNMyesHolpOg1MCk
	SZGBLqwgz/xcTdXO78/cEU+6Li7A/aPZg3VNGmU0EO9iakiYhXtNg7XleQr9nP/7i4x37En99wJTY
	d9QA1cjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbPA-00AEYe-HV; Wed, 09 Nov 2022 03:05:32 +0000
Received: from mail-pf1-f171.google.com ([209.85.210.171])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbOS-00AEJ7-2q; Wed, 09 Nov 2022 03:04:49 +0000
Received: by mail-pf1-f171.google.com with SMTP id k22so15502423pfd.3;
        Tue, 08 Nov 2022 19:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=xmEgrusWXIYt2wgRF1OvlA2pJXbrPGKezGyeXyQ+5C0uKsJiHTqC1mgS4PqW63NTE6
         +EugStWrb9vUzr3Abx4+r1ZYpujQE4leMSuOF0kLUIUDnlT5C+iT9LcT6LGvOhBL3NkK
         aNID66EJmb++aVM6ZoQMg/ZOF9GmfMCrwgpXK3qM2nkK1yYHDNAmI7Fgq1e05b8plnV4
         OwMmk1yb9ta7+GWeA4dZuUo9ryC+uO+W+8ttvQ02oroWHrW0rik0OiN8c0aaoaj9YoyL
         VElUtwwnwdkmyW2P5EM45Cl3pMBx2oGTdbmqVgcYbK58Hv0AfpCg3MHSGRKfieBpH4LY
         UZPQ==
X-Gm-Message-State: ACrzQf04d+sRTVNijH3MNWzLPMDd1qUai3d0wrkMDUOQhlS/1OWEfZqs
	mPcu9TvgIHFCDiQW5bDXkiY=
X-Google-Smtp-Source: AMsMyM7/cykDVCGPc9CgHn1eKwI3fCFN+F+jOxzQfj+H42a2odAwFKU8A6E8xkBRjq+wMFB+l8xA3Q==
X-Received: by 2002:a63:4711:0:b0:46f:9f4a:2dd0 with SMTP id u17-20020a634711000000b0046f9f4a2dd0mr45668758pga.78.1667963087488;
        Tue, 08 Nov 2022 19:04:47 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b001865c298588sm7693334plh.258.2022.11.08.19.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 19:04:47 -0800 (PST)
Message-ID: <5e4f8c8f-0561-8142-5bc7-a47b29e56071@grimberg.me>
Date: Wed, 9 Nov 2022 05:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 09/12] nvme-pci: call nvme_pci_configure_admin_queue from
 nvme_pci_enable
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-10-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108150252.2123727-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_190448_143955_35F7BF54 
X-CRM114-Status: UNSURE (   6.61  )
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

