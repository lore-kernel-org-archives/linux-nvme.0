Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51BFC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Dec 2022 07:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eZvBZhSqFq43U0oKIXft+9fPwUOVfBQ5TAyrtEpczGM=; b=vlhw6AzwOGObZV
	WqHIw/ZYxM3OEDmqwbHFndCmVpUbHlkFNrzzFFqrinvPVtiUfGAMiDkb3BAHoTGGQkrcYU3oQrtdV
	EoJXCWESV60MkKfoCdpyDLbtGXyJRh54eANHiNXew6VDuEazHXuBIifOeD2c8pRB4lx0JBereACM9
	9DKk0xCLSEpGdTGq2Z9RmlM7Y5JJRpgr1sHCOp4S1TTR3xGVqOW6f/dXRkpk3o/VYeqSlYD55Zbra
	2WT20Fb6fRIspltO2pEPeeolJlvrv0ddSr78vr3mxWNnAEBrf1rYj4IzyNvXlU7CNbPR9ybHtWk3D
	ljbSsOf6UIgSlIl2guCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7XA6-00B2Uf-50; Tue, 20 Dec 2022 07:35:42 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6sSv-001EH6-1y
	for linux-nvme@lists.infradead.org; Sun, 18 Dec 2022 12:08:26 +0000
Received: by mail-pg1-x533.google.com with SMTP id v3so4520737pgh.4
        for <linux-nvme@lists.infradead.org>; Sun, 18 Dec 2022 04:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:reply-to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eZvBZhSqFq43U0oKIXft+9fPwUOVfBQ5TAyrtEpczGM=;
        b=jcKkzkgxhBsovhv3MG+jhkaNyjgkhpxo2qqkE9F/t7tcLTERKqVn9d8RRoFXdAhMAX
         mzivCKroqbRSyJIyv+U9hVp3PK/pms8t3F6TRieVboAzILWuzJSTymhXreoNFz/etLDx
         ehuCLp0wMbN6qFZ8qznZVWPyXhORn5cthOjLdun2gOV1WKAF9aNoetHH1denMQcoEw73
         YDjiSj7IFJXAgSh4yb3lSqDuj97Ph5yAsPslwvZf8CKbRxffZHxKZE9KjYTuOFyP0r6l
         0SomFJHGHEmct6I6++EXGO4LuMoCu+Rk425UMv3lkjT5jaDj8AjeL5ppy3iNXNoY8ipL
         6Mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:reply-to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZvBZhSqFq43U0oKIXft+9fPwUOVfBQ5TAyrtEpczGM=;
        b=ZLYHAru7EoXM9c/rxVaFfNByR+RkpQ49+Pzfi4kL54UHAc3MzJHFhzcOg0mXHm96R1
         hgj6PinSwdXdmkIyNNdZgrJRjbZSrtCyC/lsBjiCqi4oywZyHQycuuMI2A+sXYtckxBv
         dJ8udftav3HCjPr6CVrO3mm3hD5lK7h2HAm6n31YETl9BIfVbvAPboF3e7+K/LubACeL
         +7f+1Didg5poPxc94DmI8bkELs2XbdUS0tTZHkFuHf2RSEpFxq6jI/vLypB4fz8Np3BO
         S2HSgCJl/xpl6yzTl0ve5N+vDoyYwcowagVTD1waBnqr7iIeQ8himuJZVYLnp4ojEqzy
         YrSQ==
X-Gm-Message-State: ANoB5pl8C/Q43Of0tzRcOKvFGggRACa3zB8B+gK683VHv1oGEzYojeyK
	eMW2/H6BgZRnvZLAFk4fj0yYfuGcw/A=
X-Google-Smtp-Source: AA0mqf458YhRanxv2rwEcN8s2ic9cwpoWXOrSw4DPnTcQbrvW90VONli4lVug18esaKVjzf3M+6aHA==
X-Received: by 2002:a62:1a94:0:b0:56b:dae1:e946 with SMTP id a142-20020a621a94000000b0056bdae1e946mr36723934pfa.28.1671365303898;
        Sun, 18 Dec 2022 04:08:23 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id d2-20020a623602000000b00576145a9bd0sm4462305pfa.127.2022.12.18.04.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Dec 2022 04:08:23 -0800 (PST)
Message-ID: <b302409a-f3d3-5bf8-2f84-01788d15267e@gmail.com>
Date: Sun, 18 Dec 2022 21:08:19 +0900
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
X-CRM114-CacheID: sfid-20221218_040825_127191_7B744A88 
X-CRM114-Status: UNSURE (   4.39  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 19 Dec 2022 23:35:40 -0800
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

Here are some consecutive fsck runs done on /dev/nvme0n1p3:

-bash-3.2# fsck -f -C /dev/nvme0n1p2
fsck from util-linux 2.34
e2fsck 1.42.12 (29-Aug-2014)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure 

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/nvme0n1p2: 335/16384 files (0.6% non-contiguous), 7496/16384 blocks 

-bash-3.2# fsck -f -C /dev/nvme0n1p2
fsck from util-linux 2.34
e2fsck 1.42.12 (29-Aug-2014)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure 

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -5716
Fix<y>? yes
 

/dev/nvme0n1p2: ***** FILE SYSTEM WAS MODIFIED *****
/dev/nvme0n1p2: 335/16384 files (0.6% non-contiguous), 7496/16384 blocks
-bash-3.2# fsck -f -C /dev/nvme0n1p2
fsck from util-linux 2.34
e2fsck 1.42.12 (29-Aug-2014)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure 

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -5716
Fix<y>? yes

/dev/nvme0n1p2: ***** FILE SYSTEM WAS MODIFIED *****
/dev/nvme0n1p2: 335/16384 files (0.6% non-contiguous), 7496/16384 blocks
-bash-3.2# fsck -f -C /dev/nvme0n1p2
fsck from util-linux 2.34
e2fsck 1.42.12 (29-Aug-2014)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure 

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/nvme0n1p2: 335/16384 files (0.6% non-contiguous), 7496/16384 blocks 

-bash-3.2# fsck -f -C /dev/nvme0n1p2
fsck from util-linux 2.34
e2fsck 1.42.12 (29-Aug-2014)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure 

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/nvme0n1p2: 335/16384 files (0.6% non-contiguous), 7496/16384 blocks 

-bash-3.2# fsck -f -C /dev/nvme0n1p2
fsck from util-linux 2.34
e2fsck 1.42.12 (29-Aug-2014)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure 

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/nvme0n1p2: 335/16384 files (0.6% non-contiguous), 7496/16384 blocks 

-bash-3.2# fsck -f -C /dev/nvme0n1p2
fsck from util-linux 2.34
e2fsck 1.42.12 (29-Aug-2014)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure 

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/nvme0n1p2: 335/16384 files (0.6% non-contiguous), 7496/16384 blocks 


========================================================
There is a very similar partition (same contents) on a SATA drive on the 
system, and this does not happen there when I test it.

J. Hart


