Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B958DC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 12:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=U8g9DVACg0FVPXXGVDtgd4kUVP
	d2oPigC4e2xuFW30aBhcNBX7HFIe/vyZ7Dob3HPw9ZzEHVhb41Ungwvu2v7NqOYf0j+n5wXuLXqIK
	5TyhM41F83eD2cmi57pACpQhOCvL0GpEnVu2vDqBB3HhRpwFUgOATMmzB1pF05BkFNR8BESCrFZTF
	xDeuYI8XrD2GExhmyJiHyMW/zbsq3ZMuqufZ6W/ZsEHqKCGX18CONGt3tVdZSAG6Zm7ZtOZWGQ8Uh
	VH3H3fdMrp5CaqPgtVOrwGQH4WuJTPabhDEwzQh2ZvtEUhftlo4qvfD1ohi71NeALaE4Yhnej1cp0
	eekyyCTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wgm-008wV8-Gh; Tue, 06 Dec 2022 12:04:44 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wgk-008wTm-6O
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 12:04:43 +0000
Received: by mail-wr1-f45.google.com with SMTP id u12so22178692wrr.11
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 04:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=07du6Bn066DbAlqoX+TcbAZmeLTJYQyzjO3FiT6lKApYXJj8s9bRGrAHq7lp98S/DU
         flV+2gzLuJWn+8IfHXbp/0GgiKvCd8wHPbUkx5Befh+ABQUOI8MI5T388bJdGVAjV8fV
         ffr4raJOQWGx+/d5KO4U/OUnu0esRuIjZGbMu/BiF9P5z5hyJFAdDTQRTUJassMK+Qq2
         gr6nbiALW236QLME2lWHEX7BWqiBPgBlfU4YoQT+MY8ZSomZg2w4SiZVFJMtqcPasbYr
         k+Qtv+IyjeNu8tTdSTJkGxLgEWR1Kcwr7zNn84NEFqol1ePCc9wYzDfJwP5zUiR8ezyw
         L4rg==
X-Gm-Message-State: ANoB5pk+n7gqcyBEoNROjBIP+IkFyGx6IPX8br3Z44548xTF9kb2PGhx
	/XmSuskRiNAy81DIDsEjjW7PGBBJdpw=
X-Google-Smtp-Source: AA0mqf5FNpVrV2CVMS+UI+mb9O0LtljAhIl+oB/wJsWPx39qh+/ign15NbQqabIVkfwj5k2w1r+CPw==
X-Received: by 2002:a5d:4c4b:0:b0:242:1bdf:910 with SMTP id n11-20020a5d4c4b000000b002421bdf0910mr23796358wrt.79.1670328279721;
        Tue, 06 Dec 2022 04:04:39 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b003c6f8d30e40sm26957835wmq.31.2022.12.06.04.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:04:38 -0800 (PST)
Message-ID: <5dbf6db8-0704-7e7b-fde0-8891e31b25ed@grimberg.me>
Date: Tue, 6 Dec 2022 14:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/5] nvme: add the Apple shared tag workaround to
 nvme_alloc_io_tag_set
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <20221130174240.227616-1-hch@lst.de>
 <20221130174240.227616-5-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221130174240.227616-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_040442_237375_9D2B24F6 
X-CRM114-Status: UNSURE (   7.46  )
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

