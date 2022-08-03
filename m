Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4FAC19F28
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o2afx9aZmzEdoWwdGDbShaY9b54ZclDxz5tctOo//Fo=; b=gFi5VQBnFGzjbqlsVr5ZVeIEAD
	9SJKd4viV7LTPs8PP3I+VpTLch03/QStK4PGue/6oVEZ3tY0GjZmWn2s0AKaeuON9cDiuc7rgG4zd
	oDT+FNPU0q5CkGw2WQrlTA/QVPEGcViNPSXV4dzirzV+mwd/FU4o7M86Df7BtILCKdeI/QrdR/Jz1
	YQyKuryruWkv5mvdCCipwnXDZyq8dDFqVm/qwKrvVWZO1spmhfI1wrL8HwnW5OBMTRWMprA9ENPz9
	sJnhTeafLkAAGWfhOFK4uajW0CFxGeaZyt7NEGnM6sr7v387rOGsrDAB8GmYbvMNGFvGwbBEFc6Fw
	3zXL1MlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJHtv-007nbq-Nd; Wed, 03 Aug 2022 17:11:19 +0000
Received: from mail-pj1-f45.google.com ([209.85.216.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJHtt-007nZB-3q
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 17:11:18 +0000
Received: by mail-pj1-f45.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso2771430pjl.4
        for <linux-nvme@lists.infradead.org>; Wed, 03 Aug 2022 10:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=o2afx9aZmzEdoWwdGDbShaY9b54ZclDxz5tctOo//Fo=;
        b=q8Q2N0IR80xHuHtXXbGJl/NghKc56hMtQz3CRnK1zzbZwhokTmNfC6N0t+zGOi2k+Y
         TtxYHT6JpQRk4LsWI+fzgFBdtTPxiYyiKm/+CubbUyjD8fHRkCGuvIlQPnOn1ghzo/zv
         7ELqOwIathQBjIBCCuXsh239ITbUY3CrKEQmQL4LKhdML5/v7FE+SPTBlejLIF/ZAWJL
         Rxy6eSNmFfRrqKIf1i4tFkUnKisSZ9HzlPGGXGXiU5F/N6V1QTrQOautMvQ3rr8+LAeK
         MYxloXgDCY1ihSfDXD00W07wKaf0N7+FkLX9pH9TOBvwUGkM4ALKeZoRJi76hd2ypLhj
         dFGw==
X-Gm-Message-State: ACgBeo0vj53SKWa/HiX/eFjda+mSeEW0V6rnpk8ZmcazTpEiJRxcevHu
	RacZjau4fSkKyvTvJ8HxmIE=
X-Google-Smtp-Source: AA6agR6EBIzKze1/rFrYedIXXEbWGppFAk1TLH0M11oAyd1FFJw2h6QmbM00Fe9GucsJfuqW4gRWhw==
X-Received: by 2002:a17:903:245:b0:16b:9c49:6b1c with SMTP id j5-20020a170903024500b0016b9c496b1cmr26089750plh.153.1659546675071;
        Wed, 03 Aug 2022 10:11:15 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id w127-20020a623085000000b0052df34124b4sm3552742pfw.84.2022.08.03.10.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:11:14 -0700 (PDT)
Message-ID: <d091dcf8-ce01-06cb-bff0-b41a5bb1ee86@acm.org>
Date: Wed, 3 Aug 2022 10:11:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [dm-devel] [PATCH v9 02/13] block:rearrange bdev_{is_zoned,
 zone_sectors, get_queue} helpers in blkdev.h
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
 snitzer@kernel.org, axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
 agk@redhat.com, hch@lst.de
Cc: pankydev8@gmail.com, gost.dev@samsung.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, jaegeuk@kernel.org, matias.bjorling@wdc.com
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094804eucas1p1feea4b1bdae819f4c8750994ddd94803@eucas1p1.samsung.com>
 <20220803094801.177490-3-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220803094801.177490-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_101117_192918_64AD3B93 
X-CRM114-Status: UNSURE (   9.46  )
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

On 8/3/22 02:47, Pankaj Raghav wrote:
> Define bdev_is_zoned(), bdev_zone_sectors() and bdev_get_queue() earlier
> in the blkdev.h include file.
> 
> This commit has no functional change, and it is a prep patch for allowing
> zoned devices with non-power-of-2 zone sizes in the block layer.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

