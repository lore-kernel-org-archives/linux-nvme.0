Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367AFC6FA90
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVXjEkchDteCE1zCDTUzpbpt8ACeKtrTbNbxuuk9ZdA=; b=gL2U7e0rUGXm9pOGOLcFHHvrcL
	GMTRfOAB5efg9wZU1zQm4v/NSwZtzIZV/nRaShdJdx+CFuzUppHz1sQVe2/CL/NjLAtyw4YcPDEvB
	seeBPQRbqiscXQkCbM5wec1vP61dLQjroDrSja0Vh0pQ99gevjx478Ay/vaOCVmQ1prVIC1CXMHU7
	rHgbdEcJEv5Ld/UN6pDlQ1f67WMg90zfYlz41lanVDrOdU4QsOD8NaoEAei58YEs9XGSPYYJVOq3s
	Y8roOqDpXmxgPIVnCbKo9mIYdYfOD0U9QLuHK5AVoFlzXiojqSZmGsp72z5Vkesi3KsRmOihZ0DPe
	CNC0b9Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaflH-0054Nh-Nx; Tue, 20 Sep 2022 16:06:15 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaflE-0054KJ-PG
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 16:06:14 +0000
Received: by mail-pj1-x102c.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so1775955pjb.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 Sep 2022 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=mVXjEkchDteCE1zCDTUzpbpt8ACeKtrTbNbxuuk9ZdA=;
        b=WhArmtdqs/KKDWTWMCosIdRxKr5Uet/gXZ+ddafXZpICoDfqgBCpm+m0BrBuw5VioO
         N01TiT3dRBp4xqgudzkm/sAl1qlY6gQRp0RC6rRz6Go7V8X64Hkj64kZuiRacglKXcCE
         L0xB0mvUGlbtRw3Byz1SGuCNldmz/jpLsQRM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mVXjEkchDteCE1zCDTUzpbpt8ACeKtrTbNbxuuk9ZdA=;
        b=dQ5stHf8+T3I+dbWpkgSOi8VL1cmL2jHpKvMGHPr0Ko4EjguOmwjwLNtaSzHQ9/76s
         r7GsYie6bbXi3K5lo5TZqG63DtKTjS0u6VmSLhvH2iStzFQmZQjZJvankvJq9nnv6bVW
         S3xxEE6htvE/6APeXpLsYMdPqaaE2VtA3iGoEV8dtqEh6aAniWebb6rgkapWYiq7IkIQ
         RzSGQJbRDRtVj1AiXjvgMEiQrCrFuuxsQdAO1cYtUAtGf+kZOanZ36BMvTFdjOdz5RCV
         UoTrAR3IXMcBY9b2OQjWdVMG+cedn/SfNaX7UrLZLex6O1IYT7541SnhAj9b3ZgAPPc6
         wVdA==
X-Gm-Message-State: ACrzQf11rf0uUfpaNVnoOBem2XEPI2GJ6DXMtp4lKR/YF60KfJv5fkb8
	5R1IerGS1lsVBsARN0kVeQT7jw==
X-Google-Smtp-Source: AMsMyM4CDISk3X5hd2+0a+iB0Ji58ldPnFUwavVGxhVfv8jmCnDVTEmhu9onCz743+5jWuUglxommQ==
X-Received: by 2002:a17:903:32c4:b0:178:5206:b396 with SMTP id i4-20020a17090332c400b001785206b396mr365485plr.99.1663689968516;
        Tue, 20 Sep 2022 09:06:08 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id l2-20020a170902f68200b001730a1af0fbsm102688plg.23.2022.09.20.09.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 09:06:07 -0700 (PDT)
Date: Tue, 20 Sep 2022 09:06:06 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>
Cc: stable@vger.kernel.org, Eric Badger <ebadger@purestorage.com>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Tao Chiu <taochiu@synology.com>,
	Leon Chien <leonchien@synology.com>,
	Cody Wong <codywong@synology.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Make sure to ring doorbell when last request
 is short-circuited
Message-ID: <20220920160606.GB3444537@medusa>
References: <20220918054816.936669-1-mkhalfella@purestorage.com>
 <YyioTUV/Td+yf0Z6@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyioTUV/Td+yf0Z6@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_090612_963990_147199A9 
X-CRM114-Status: GOOD (  14.16  )
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

On 2022-09-19 11:35:09 -0600, Keith Busch wrote:
> > Fixes: d4060d2be1132 ("nvme-pci: fix controller reset hang when racing with nvme_timeout")
> 
> I revisted that commit, and it doesn't sound correct. Specifically this part:
> 
>     5) reset_work() continues to setup_io_queues() as it observes no error
>        in init_identify(). However, the admin queue has already been
>        quiesced in dev_disable(). Thus, any following commands would be
>        blocked forever in blk_execute_rq().
> 
> When a timeout occurs in the CONNECTING state, the timeout handler unquiesces
> the queue specifically to flush out any blocked requests. Is that commit really
> necessary? I'd rather just revert it to save the extra per-IO checks if not.

I can not speak with certainty whether 4060d2be1132 need to be reverted or not.
I will need to carefully inspect reset code path and do more experiments. If this
commit gets reverted we still need to add `nvme_commit_rqs` to `nvme_mq_admin_ops`.

