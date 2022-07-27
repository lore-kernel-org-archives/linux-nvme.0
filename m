Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2094BC04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2is113T+H7tuYz2Yy/ETQXQPmWiDz7jbUDdoPkmDrDE=; b=GXNKe6D10V9rFHNhH24T9L/uUv
	QRr/Cm+YbYs/NndJVeU024/4jv4ZQiXo3ZI5tt0zOIo75ruHv21Lf+mXHeWI8XXL47duV+XRBPrGK
	0s8e5W4cz6PX6EYY0xAU+H4pkU2PguIWMR3A0VpnZYvPXz2fulALRelFjitxpofKDZZ6bGzv+DuF4
	o+VdmSrZFvE3RE3nYa4OanVzd/qjNHb/633E10t8KVUgn94OXcIIBIff8l+NloH4nKFlaYhNefUaP
	ds52DLyqa7OjW1AAQV0XsDTto/ZphlIJiDoYSLANOpy9J8MllTLC7MDSQ1auwBC5Dc/mnObWyTLi7
	dWlORPBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjZn-00FMvE-RQ; Wed, 27 Jul 2022 16:07:59 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjZh-00FMoc-Iy
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 16:07:57 +0000
Received: by mail-io1-xd2f.google.com with SMTP id v185so13873272ioe.11
        for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2is113T+H7tuYz2Yy/ETQXQPmWiDz7jbUDdoPkmDrDE=;
        b=IP5Zt4I59DWqtfmyYmvGfhDRHifPoE0KeS4+b4rsrh7//j99Hrrc3aJs/EPoLRGCwq
         /+E4UxGqfdukNFrDZW5v+tsguyXFVmiES53YoWlegQwzLvtz6JT49YaIOqPjUNq27hEx
         lW13ZPuwID8te4GjYRH1LSSg7b2dtuDGwSBgcmuolhUl2cde9So8pXboWZauAQYkC64o
         bTnwoBxfTI2lSlgcSbw8Wj2DEL67FKkfxg+/ThJ/k5Onx46Yj9njXOgbRK2NAEkO4W2H
         UlMTQktgDCZG40CCrrclZDExby723fgyufwfjN8yjexClHrJiGFjl+mSsZboPpPjYJ1c
         Q4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2is113T+H7tuYz2Yy/ETQXQPmWiDz7jbUDdoPkmDrDE=;
        b=pPr3+FrTBjYqDpc8us+TjgpQFzmqBQ8aE9+jKXag4F9UExL6HkvflJEeRBts3wRLqd
         2UsvLKwgqVJD4XuAHjFg/BXL/fWw0lakDFrKT8xOkV6bIs6qvYnCNfp/PAL7/sWblQse
         NFdRDY5AAkvc92PNyf6cwSx+qkMdAE0ymmxGPqq9Up3g1jHqaPk4kxA6wjdnfsPbP5Uw
         xu16a0OVv52wRzTx1aAM6xFlg1dDXihcNEmG173IU7+RAGzBUSkL6M9dIqlgPsm8/Ljg
         n7Sjer+9DVrp2KMaEHx6ocA3Siy/TeWomkdxRRZwUMLOZtL2UG3lbK+6afAuQFDQbqS0
         TUjw==
X-Gm-Message-State: AJIora9CVWaO51GJRe1Vzg0nMUgnL/94W4/ehcWBx2buLvqjSM8U/wF7
	ktqQu7NcnQXEBFHLb69nCPPq+w==
X-Google-Smtp-Source: AGRyM1vHgE+2KLoYwpkgiqSGyw9ioNrX4EcF9+jxtFksdN+dMltzuL5i95TrOnLIwHNNIxIiyxOYeA==
X-Received: by 2002:a05:6638:1a13:b0:33f:1f32:6248 with SMTP id cd19-20020a0566381a1300b0033f1f326248mr9086808jab.53.1658938071754;
        Wed, 27 Jul 2022 09:07:51 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v5-20020a056e0213c500b002dce9ddcb08sm96761ilj.30.2022.07.27.09.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 09:07:51 -0700 (PDT)
Message-ID: <d428e19d-6c78-1065-8687-c95e54d71816@kernel.dk>
Date: Wed, 27 Jul 2022 10:07:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] second row of nvme updates for Linux 5.20
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YuFhR9OoPvM9VsdT@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YuFhR9OoPvM9VsdT@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_090754_749297_20450014 
X-CRM114-Status: GOOD (  10.44  )
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

On 7/27/22 10:01 AM, Christoph Hellwig wrote:
> Against the for-5.20/drivers-post tree.
> 
> The following changes since commit 2dc9e74e37124f1b43ea60157e5990fd490c6e8f:
> 
>   remove the sx8 block driver (2022-07-25 17:25:18 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.20-2022-07-27

Pulled, thanks.

-- 
Jens Axboe


