Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1A6C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 06:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z5rjmNSwID+QzFbd48SMNJPC3OAWd2XHMFHg1l0kCOA=; b=U7MPXZ8l8ui5pqYxFM0lID7Zca
	tSTJgLBilkKfedV+YQtA3GkHicc1sbkZ5IAsZHs8O3DdtBsEzDYi5sHbUeoPLOP/+V6QUEtBQ4pm4
	fA+KXGGeyK1RGlzSP6R/7MJGqUe1f+UTaEVgXxlYTdQe1HQLdc/q41RiGdYbwVYDX39pD3RWpZIi5
	AN/L2gUn7G4R8iRxyW6VBaaTDNena6zUpqEiw1bjqO5/difJVlbsVKxoFwY7yUakJ3sXFySXNyGY3
	fhV9HtEJa9OpGgXjSsPOImQdA7uyHYRkYSFw4lq39IVswg369mYd18keURJgOrnD3EmrmBVnAzdPm
	GX6wkR1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQrX-00EJoc-5c; Wed, 28 Sep 2022 06:48:07 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQrU-00EJnV-Il
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 06:48:05 +0000
Received: by mail-wm1-f45.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso467684wms.5
        for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 23:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=z5rjmNSwID+QzFbd48SMNJPC3OAWd2XHMFHg1l0kCOA=;
        b=p8n7nFjgIg9gyeNF/bTvdjnwpZwRcWcW+hPYqyO8WSqwzeNiEfcFdPWyP0XoF7/nub
         iLyKGoyJJGVjfMqKX2mx9CU0MC/IPXu9I3CgXaGjt/4KR5vZFz1MzqiEMI+Kym/z46NW
         ZBZYE0rWaME7h8mvT+Hg23dj8hIhBkuyAIVzPGHEGa4EqU+fFv0sA8yNG3mx14NSQWH/
         MZYhPn9sf7vuVRZMq1GLfyxpq0peBkvdUpILTITLN9l8eFezQEfip7pCUQMXzwRRPeRG
         Vt2Pi/MOkR9pyF01T6traqMafEdV24Yj3g0OWcRBkRG5irNvRNZ/UyXyhqW1zJHIMHG7
         CG2w==
X-Gm-Message-State: ACrzQf2UaHgBZCERnYfiMP9qc76fPFoE2MXAC6i25jnwcwYWJX57ofC6
	ZPbbDSBF+IyzZb6apirI4kP2SoYyxW0=
X-Google-Smtp-Source: AMsMyM6imUsfTiK4x88KIZmgmOEba3Tw4Scmd3YjFztTZDi8OIYSXqtYfK4PtZuI8EaHLZXyo7WyMg==
X-Received: by 2002:a05:600c:4fcb:b0:3b4:a4dd:615f with SMTP id o11-20020a05600c4fcb00b003b4a4dd615fmr5783680wmq.160.1664347683156;
        Tue, 27 Sep 2022 23:48:03 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b003a5ffec0b91sm827832wmi.30.2022.09.27.23.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 23:48:02 -0700 (PDT)
Message-ID: <70a7cb12-a170-1f7b-9f15-5966ead1a87a@grimberg.me>
Date: Wed, 28 Sep 2022 09:47:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] Fix missing AENs when discovery controllers are
 disconnected
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 James Smart <james.smart@broadcom.com>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220927071823.GA16121@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220927071823.GA16121@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_234804_641553_0A9DB8C7 
X-CRM114-Status: UNSURE (   8.83  )
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


> Thanks,
> 
> applied to nvme-6.1 after fixing up the bit positions.

Thanks Christoph

