Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73743C6FA82
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 16:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vnSOT79vZm2Z1X3vBb9NByt6VpxGbBF310FVdgigcRo=; b=mQpGvZMQdbHDTymx7Lroz/l/tc
	7MfG4SZD7625wveO4YOkiwqALomvCMp8mJuV5FjNN7JjJNJEVhj3HbfsJgdsqkEK9h0Sv7VzSpUKW
	VI8DbV/IDlm0PWiIMVdrhG2WP99R+S4Vgsr7hYOpHb2hPNlgV9T/fVHdcoSnBXgBATijygeUq0OKE
	57/FgkWil6U1gk7Jtz854GSH54Qxi4IwE1w/lH7GDGWhXiCWLqpk+6qeoXQbIBKnCO0+myUBNIoPZ
	nGStu4EWqHxGOcEG+v6HF1y+6kJkcgbtFdZL9/6u+W/KW4sCIJz9UDKc08ITpThC/UEL5IhEtRxXK
	6l1/XZgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oblPB-004x4F-9d; Fri, 23 Sep 2022 16:19:57 +0000
Received: from mail-pj1-f43.google.com ([209.85.216.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oblP8-004x2q-2n
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 16:19:55 +0000
Received: by mail-pj1-f43.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so6342893pjm.1
        for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 09:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vnSOT79vZm2Z1X3vBb9NByt6VpxGbBF310FVdgigcRo=;
        b=SIuBDxiHjUcyL9DGUTB8HMNjhLB+15nTMmiaLvRTjUvsHXwFwhX6g6NmJ7SDYdiAr4
         Hd4xjRcRdL1c63UbtfMJaF5Yz71y1xl+kgo3kkBZpwDMwb04QoqYvKowTtVDTq2klXAX
         Y3lt6Xr913CXqre+2A0gW+mT0z0uXFZd+UeOMgssWabG4/N2NMT9TVrNzGuj461VZCZc
         hbEpJGYakR2hg+hJwRRkQ16wPD/goOZuyyGiq0yUCLSTxzi77V068sxtuaFd7qGp/0yH
         Xg/w2mfOrv++Nn5BOUCrWCoREqpacg/6wePIWWZX7L6PL3urdcqUqBqHPN6GMPFaIVYz
         I4Wg==
X-Gm-Message-State: ACrzQf3eqhCTR2nBuuGl3w7m/OoyDDFMtOKNihbC4Rudgf2/DxjRw6qv
	JliwDoeoGMnogtIrvEJQkyM=
X-Google-Smtp-Source: AMsMyM5CMCm0D86HYnpQDo/X7/UqnWT+5BzKuiOzTeV53omgR+X965yxoHmyOZ/dbkOcdr27tB35Ow==
X-Received: by 2002:a17:90a:c782:b0:202:c73e:5488 with SMTP id gn2-20020a17090ac78200b00202c73e5488mr21574508pjb.202.1663949991522;
        Fri, 23 Sep 2022 09:19:51 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:aa13:bc38:2a63:318e? ([2620:15c:211:201:aa13:bc38:2a63:318e])
        by smtp.gmail.com with ESMTPSA id x18-20020a634852000000b004388f33b80esm5811710pgk.2.2022.09.23.09.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 09:19:50 -0700 (PDT)
Message-ID: <396ddf4d-5a81-f6dc-b98f-a6cdad553e91@acm.org>
Date: Fri, 23 Sep 2022 09:19:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with non-power-of-2 zone sizes]
Content-Language: en-US
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Mike Snitzer <snitzer@redhat.com>, Pankaj Raghav <p.raghav@samsung.com>
Cc: "agk@redhat.com" <agk@redhat.com>, "snitzer@kernel.org"
 <snitzer@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "hch@lst.de" <hch@lst.de>, "pankydev8@gmail.com" <pankydev8@gmail.com>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
 <20220920091119.115879-1-p.raghav@samsung.com> <YytJhEywBhqcr7MX@redhat.com>
 <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
 <8fd1d8b1-9f43-eb03-4a7f-187723d1c483@acm.org>
 <BYAPR04MB4968EB5E341049DFF973B9B1F1519@BYAPR04MB4968.namprd04.prod.outlook.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <BYAPR04MB4968EB5E341049DFF973B9B1F1519@BYAPR04MB4968.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_091954_193637_2B8E61A9 
X-CRM114-Status: GOOD (  24.16  )
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

On 9/22/22 23:29, Matias Bjørling wrote:
> With UFS, in the proposed copy I have (may been changed) - there's
> the concept of gap zones, which is zones that cannot be accessed by
> the host. The gap zones are essentially "LBA fillers", enabling the
> next writeable zone to start at a X * pow2 size offset. My
> understanding is that this specific approach was chosen to simplify
> standardization in UFS and avoid updating T10's ZBC with zone
> capacity support.
> 
> While UFS would technically expose non-power of 2 zone sizes, they're
> also, due to the gap zones, could also be considered power of 2 zones
> if one considers the seq. write zone + the gap zone as a single
> unit.
> 
> When I think about having UFS support in the kernel, the SWR and the
> gap zone could be represented as a single unit. For example:
> 
> UFS - Zone Report
>    Zone 0: SWR, LBA 0-11
>    Zone 1: Gap, LBA 12-15
>    Zone 2: SWR, LBA 16-27
>    Zone 3: Gap, LBA 28-31
>    ...
> 
> Kernel representation - Zone Report (as supported today)
>    Zone 0: SWR, LBA 0-15, Zone Capacity 12
>    Zone 1: SWR, LBA 16-31, Zone Capacity 12
>    ...
> 
> If doing it this way, it removes the need for filesystems,
> device-mappers, user-space applications having to understand gap
> zones, and allows UFS to work out of the box with no changes to the
> rest of the zoned storage eco-system.
> 
> Has the above representation been considered?

Hi Matias,

What has been described above is the approach from the first version of 
the zoned storage for UFS (ZUFS) draft standard. Support for this 
approach is available in the upstream kernel. See also "[PATCH v2 0/9] 
Support zoned devices with gap zones", 2022-04-21 
(https://lore.kernel.org/linux-scsi/20220421183023.3462291-1-bvanassche@acm.org/).

Since F2FS extents must be split at gap zones, gap zones negatively 
affect sequential read and write performance. So we abandoned the gap 
zone approach. The current approach is as follows:
* The power-of-two restriction for the offset between zone starts has 
been removed. Gap zones are no longer required. Hence, we will need the 
patches that add support for zone sizes that are not a power of two.
* The Sequential Write Required (SWR) and Sequential Write Preferred 
(SWP) zone types are supported. The feedback we received from UFS 
vendors is that which zone type works best depends on their firmware and 
ASIC design.
* We need a queue depth larger than one (QD > 1) for writes to achieve 
the full sequential write bandwidth. We plan to support QD > 1 as follows:
   - If writes have to be serialized, submit these to the same hardware
     queue. According to the UFS host controller interface (UFSHCI)
     standard, UFS host controllers are not allowed to reorder SCSI
     commands that are submitted to the same hardware queue. A source of
     command reordering that remains is the SCSI retry mechanism. Retries
     happen e.g. after a command timeout.
   - For SWP zones, require the UFS device firmware to use its garbage
     collection mechanism to reorder data in the unlikely case that
     out-of-order writes happened.
   - For SWR zones, retry writes that failed because these were received
     out-of-order by a UFS device. ZBC-1 requires compliant devices to
     respond with ILLEGAL REQUEST / UNALIGNED WRITE COMMAND to out-of-
     order writes.

We have considered the zone append approach but decided not to use it 
because if zone append commands get reordered the data ends up 
permanently out-of-order on the storage medium. This affects sequential 
read performance negatively.

Bart.

