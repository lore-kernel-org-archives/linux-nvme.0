Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30AFC4332F
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Dec 2022 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=w0nnRUK/hY8LYzIO5tTkJ0BP/nBa6PWbTnCZuekGWCY=; b=CjuSQp/Ub2n5nn
	0KzqBqYH5YVzJ+KMGkiUpAkoxRp5NMIQpZFhtPlJ20bgRFPCQ8yNxrgRWw+DkLMaTly0dVpfmtEhv
	dkaNLR5rmYM7AFjKH/rtte/nTM+JuY+wYOc3Gt2pzxa4X5eyqI/gEL/XLU6BhX6ylVg73CFvIs8fB
	oVbJwbJV87CVcUlYOAM4qjkcK4tiU2QdlZ51JEW3q3bdJYfN4mQGXnyD0f7yVjPgnGVPitSuafnqC
	IIcL1lIaLjsWVGuaUIRYsZmyX7vz5c35GZkR0NkR8fRME0lhKVTzDR8u3iGypx5EOQNjdUdx9XpsD
	MioXR6l1tl6Vrxa/lcDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6Ywp-00AY0P-CO; Sat, 17 Dec 2022 15:17:59 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6Yn2-00AWKh-8i
	for linux-nvme@lists.infradead.org; Sat, 17 Dec 2022 15:07:53 +0000
Received: by mail-pg1-x536.google.com with SMTP id b12so3569244pgj.6
        for <linux-nvme@lists.infradead.org>; Sat, 17 Dec 2022 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:reply-to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w0nnRUK/hY8LYzIO5tTkJ0BP/nBa6PWbTnCZuekGWCY=;
        b=iGViFTSNyVJRPl3l2rCXE8miA2PTx4SFMqbeJvDGjPXKkpaMKDp44XgC4lk1BFCQSQ
         S/adRR4nD8Jnyy9fl4fQBSg9Xs9HbyETRbQeYi/rlhoaOeX7q1ly/Ey0fGc/gzkLjb5n
         7yBhn1SL8hwGM2NnsBNnsSjr1eesq6pl0cwVeEMWlT5571sv+fYjhjbNmwkCcLThwtS0
         ZlT4VrWiEVuYc2FQHXYLSdLc2y2j5j9uTIn7q4tXEbvMuyNC95YTTIlhTayqtCf4fZPp
         7XNDM2IWhhGGcWcmx7EC+3P8NNBcFUQxe3Ti9/+pze+KASkoENsqgAnB4nlsORi+M6w7
         HbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:reply-to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0nnRUK/hY8LYzIO5tTkJ0BP/nBa6PWbTnCZuekGWCY=;
        b=EJ9kiuQf+OPxQebUgt+Mc+X25NHJx1mcJm6tqXbBB90DwkvFwPg5ne5p6hNTNS9HAi
         /qyYlSf9v6cHUQCH/B2esbvQUImtKaA16fVUKnvk4Y5/r4rLY2V0KxLoyTB1HiAw8+pK
         5VziYUL2N6hc/3Fiayf8e5lKpBV7WKd3cbKl0CYAIyZ5QdFzUu4MqZeIszDMfsEgCoZ7
         OC/a4gCPkYoQ8oYV9BRiV+1Xtk6bfbCdpjgU13Rjd8x3x5sRkw8IJgG1LbuepN9SenfD
         wwLP9fOBQewdxTCpSpUpXmioJogQ3bUxrFh1m+s+xDCeaXeGXq08DRFu5kyHOzF6APOi
         Ow1w==
X-Gm-Message-State: ANoB5pmEClpGzsoHSwC0LvIEE06FuDHoBG6SolSaSNayOqKUK6GzgRlp
	26dwoVuBD/Joa7hwLchrtI4xrDp29Kg=
X-Google-Smtp-Source: AA0mqf4daUJAGbTfOKhcaE0QLqnps9cR7KDruEbso0CM+c1jQqp7bVFehtbloawYkuT50YFqkcPTlw==
X-Received: by 2002:a05:6a00:1c9d:b0:577:753a:6af with SMTP id y29-20020a056a001c9d00b00577753a06afmr37829595pfw.31.1671289670153;
        Sat, 17 Dec 2022 07:07:50 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id c129-20020a624e87000000b0056cea9530b6sm3241854pfb.202.2022.12.17.07.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 07:07:49 -0800 (PST)
Message-ID: <26d4d46f-0ffe-44dc-de40-b18729ab3783@gmail.com>
Date: Sun, 18 Dec 2022 00:07:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: "J. Hart" <jfhart085@gmail.com>
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
To: linux-nvme@lists.infradead.org
Cc: jfhart085@gmail.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, hch@lst.de
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221217_070752_370234_5EDE387D 
X-CRM114-Status: GOOD (  11.18  )
X-Mailman-Approved-At: Sat, 17 Dec 2022 07:17:52 -0800
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
Reply-To: jfhart085@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I have done an fsck check on the /dev/nvme0n1p3 file system after the 
rsync invocation referenced earlier.  In the first run I found errors 
which fsck should have repaired if I understand correctly.  In repeating 
the fsck invocation immediately afterwards, I found errors again each time.
This was done using the replacement Samsung nvme ssd (Samsung 970 EVO 
Plus 500G).

Here is the output :

-bash-3.2# fsck -f -C /dev/nvme0n1p3
fsck from util-linux 2.34
e2fsck 1.42.12 (29-Aug-2014)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure 

Pass 3: Checking directory connectivity 

Pass 4: Checking reference counts
Pass 5: Checking group summary information 

Block bitmap differences:  -87163220 -87163384 -87187960 -122079572 
-122079736
Fix<y>? yes
 

/dev/nvme0n1p3: ***** FILE SYSTEM WAS MODIFIED *****
/dev/nvme0n1p3: 699563/30523392 files (0.1% non-contiguous), 
13841458/122079744 blocks
-bash-3.2# fsck -f -C /dev/nvme0n1p3
fsck from util-linux 2.34
e2fsck 1.42.12 (29-Aug-2014)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure 

Pass 3: Checking directory connectivity 

Pass 4: Checking reference counts 

Pass 5: Checking group summary information 

Block bitmap differences:  -87163220 -87163384 -122079736 

Fix<y>? yes
 

/dev/nvme0n1p3: ***** FILE SYSTEM WAS MODIFIED *****
/dev/nvme0n1p3: 699563/30523392 files (0.1% non-contiguous), 
13841458/122079744 blocks
-bash-3.2# fsck -f -C /dev/nvme0n1p3
fsck from util-linux 2.34
e2fsck 1.42.12 (29-Aug-2014)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure 

Pass 3: Checking directory connectivity 

Pass 4: Checking reference counts
Pass 5: Checking group summary information 

Block bitmap differences:  -87163220 -87163384 -122079572 -122079736 

Fix<y>? yes
 

/dev/nvme0n1p3: ***** FILE SYSTEM WAS MODIFIED *****
/dev/nvme0n1p3: 699563/30523392 files (0.1% non-contiguous), 
13841458/122079744 blocks


I also tried loading a smaller partition on the Samsung card at 
/dev/nvme0n1p3.  The copy stopped with a "no space left on device" 
error, which should not have been possible as the source device is a 
32MB partition, and the destination partition on the nvme ssd is a 64MB 
partition.  The two files to be transferred were very small and could 
not have accounted for this as they totaled less than 5MB. I found file 
system damage on the nvme destination partition in this case as well. 
It also occurred repeatedly. I am still investigating this last case.

In no instance did I note any otherwise unusual log messages or errors 
from the nvme driver.

I do not yet know if there has been any damage to any other filesystems, 
but I will check.

J. Hart

