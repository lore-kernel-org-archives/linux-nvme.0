Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CDCC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SrqLT0kXpAlJD8TZzx8ujBa5nxZPe+zl7PnVUm+RbhE=; b=EY41zn57qyEj5K+FEYWPyKb55P
	7nPnbEq+m/GJ4kVZhc0acpoSHybooP84MQ85bFUVRB+6z4RkUiJIN0EgHvheI5RVjPM4qmQ3Nb+Jc
	xIsN64VePXFE+ZVBBX4L2SvEaW7vWwlquGskrkG3PiL3eu7Sg8sDCTw1fHwmalS+Dfz1WlOgPl/GH
	w0S9WAxQZYRaBXG+Z1SEcZ83FOR9ir4/TfVx1sqcnhItbJ42yG0VhCqIIpdCGjnHVktkkRn4Mg1Dw
	IDQku7vFcE1nsMJ+FMuh0V4px4qil5LlpkxjrAdai77+LptMqhKqfx2XrUEh+rf0xSa01JynHmx6D
	J/bRJQ9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odbYw-00HWyT-Vu; Wed, 28 Sep 2022 18:13:39 +0000
Received: from mail-pl1-f176.google.com ([209.85.214.176])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odbYt-00HWx8-Fo
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 18:13:36 +0000
Received: by mail-pl1-f176.google.com with SMTP id n7so3678174plp.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 11:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SrqLT0kXpAlJD8TZzx8ujBa5nxZPe+zl7PnVUm+RbhE=;
        b=bC1pb2Qmzm1y2P+uagI4Ac+Op64Wip9qnuFpmmE0KH78XO6oCl1rmEhFQyhlJh6Ajo
         WwQyemVNPojDlOStII+aElmX7VN3ipdI/gv2V8Q3xIUprf1hcKuCv/KrbHCPV6Nllkhw
         4T4v3LIZkR4gcqizoExAsia5CHdjsypzbOFt1veGmfBowT9VDoT0siKBXLPcgpJUQOhL
         XV9l6kuDqEyg+X0IystSEbhOoZ3m+RbqlpT97oEgN5QnjNKq6meMRlMmfwrmMvJF8juR
         zqDyaFlof0I2bj3Fyb0ynAFKXQ5FRbZSNzPSropWQzNcW6oJbXHqWkF6/NDamoXSd44m
         QjtA==
X-Gm-Message-State: ACrzQf3KPplU/+cxw8AcUSTNzjruexGJ69byGeKiZx6ynCJaSyTBLOm6
	ZDr7xEtU/NOP5MptNIbF8ao=
X-Google-Smtp-Source: AMsMyM5phyXRHDoV48KwWkEssjx6POVAM7KislIcpIimObHNjJBChVYQkrXS8krHgOsN/67JiWvhEA==
X-Received: by 2002:a17:90a:4607:b0:202:e22d:4892 with SMTP id w7-20020a17090a460700b00202e22d4892mr11629503pjg.220.1664388811703;
        Wed, 28 Sep 2022 11:13:31 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4cba:f1a9:6ef8:3759? ([2620:15c:211:201:4cba:f1a9:6ef8:3759])
        by smtp.gmail.com with ESMTPSA id p15-20020a1709027ecf00b0016f8e8032c4sm4014341plb.129.2022.09.28.11.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 11:13:31 -0700 (PDT)
Message-ID: <d7004ae9-ad68-cb61-9ca8-0bf61efa0c21@acm.org>
Date: Wed, 28 Sep 2022 11:13:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v15 11/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, snitzer@kernel.org,
 axboe@kernel.dk, agk@redhat.com, hch@lst.de, damien.lemoal@opensource.wdc.com
Cc: jaegeuk@kernel.org, gost.dev@samsung.com, linux-kernel@vger.kernel.org,
 hare@suse.de, matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 pankydev8@gmail.com, dm-devel@redhat.com
References: <20220923173618.6899-1-p.raghav@samsung.com>
 <CGME20220923173631eucas1p23cceb8438d6b8b9c3460192c0ad2472d@eucas1p2.samsung.com>
 <20220923173618.6899-12-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220923173618.6899-12-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_111335_552190_2CA7BA7D 
X-CRM114-Status: GOOD (  15.74  )
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

On 9/23/22 10:36, Pankaj Raghav wrote:
> dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
> uses either native append or append emulation, and it is called before the
> endio of the target. But target endio can still update the clone bio
> after dm_zone_endio is called, thereby, the orig bio does not contain
> the updated information anymore.
> 
> Currently, this is not a problem as the targets that support zoned devices
> such as dm-zoned, dm-linear, and dm-crypt do not have an endio function,
> and even if they do (such as dm-flakey), they don't modify the
> bio->bi_iter.bi_sector of the cloned bio that is used to update the
> orig_bio's bi_sector in dm_zone_endio function.
> 
> This is a prep patch for the new dm-po2zoned target as it modifies
> bi_sector in the endio callback.
> 
> Call dm_zone_endio for zoned devices after calling the target's endio
> function.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


