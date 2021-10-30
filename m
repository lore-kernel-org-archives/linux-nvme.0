Return-Path: <SRS0=xH1B=PS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75887C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Oct 2021 17:08:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F1E603E8
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Oct 2021 17:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42F1E603E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cj7b4WzzJcmZ+tVCjhkRXyXcKv7YSLzrxMjWUHMImLY=; b=LVU8wrYWDodpNZ5ym4LmY5Eimf
	CFqudZqIt0NoOll9EXsAQ5zYJOtgQY3Zb7M2chHVS79vWc/XogF8vszUSLslY8iMFS4lDiGtrn1B5
	i3DuYSNdrCZXRm295gTsMiHAHQei16DP+WCHQFJ6EnKzCZuJ9LG8uYP3DtWAFu4DloxYXP0ZaVibr
	FVmVCt3Ro6vThq5MP5HrVi6nEAnLqJ7Ik2VHVMQU9gTJvDYa+sZWKpMm5lHrDHsCbmC36a8F/e9o8
	tgmcX1PVHQgjxNcE2QlBz4tjOitWJfBCg8ty9Xban3mJLWngHTUSFMf8LNA+oJxK5wx61rkNPbdkr
	3wDkgftw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mgrpk-00DHeq-SI; Sat, 30 Oct 2021 17:07:56 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgrpi-00DHby-Gt
 for linux-nvme@lists.infradead.org; Sat, 30 Oct 2021 17:07:55 +0000
Received: by mail-io1-xd2a.google.com with SMTP id i14so16367257ioa.13
 for <linux-nvme@lists.infradead.org>; Sat, 30 Oct 2021 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=cj7b4WzzJcmZ+tVCjhkRXyXcKv7YSLzrxMjWUHMImLY=;
 b=Wopv4tcWqOAJZGqYx1oWAbH++R5QUK3biTMI/xiKmgq8kzd4BjfbTwqyki2cw/dKMZ
 zMePBAMmf+SLZ1e8obk5O2B8EqEDPivRKlRqkehfknMQ8MNLufX0ul/cJWZhewILt5Oh
 6lHlndFiey7eEaiN0hgGC39LpO35JqvHs71OpDs0TY9XL4bVtIavn6nIEfmea/hq+LZm
 LUd2MMSVR+UBeThxm8no9AVI+Lkwbvjh/Wd3YPAJax1gQlPv8O8NjJriy/LoIbj10SRd
 9zfUre2XtVMt8acixbfHpVQ/bS6vxPEHVT/7jgMGiywvDrcUkISQerA52lYJTtjCW/Wj
 XOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=cj7b4WzzJcmZ+tVCjhkRXyXcKv7YSLzrxMjWUHMImLY=;
 b=O+//ggscn9G0Zz7YmtbvMLY/LV8+9lk57Nus5kiQw4ZlXsouvQNStqXVj9WlBfX4jD
 LE/Ab+THm3FviKkBbORWSEjJ7Sn3wJyPxAuL9UvRVc/poJPG36w2zTFacPQtxhIspbYT
 1yO94MigOzZJ9tiDT5iYXbxM7AHNnpf35ffLH3YzG1MUKertXAs2efOzFUHOw17yi0sk
 iFUVelCuHttNvcksHrS7HdQoQV+fzFrnvPFhhHmDjSn4CyjPPoanODLfr47e2JfKSD7U
 TxV2yQFFhvqSv03i1YXRsJlNaEjw1QcFmmpCZdCtMKdiGdLrUQ8Acbrj4aKNYbvkVEGy
 4UYQ==
X-Gm-Message-State: AOAM5310pNGy3riZKh1EsEqXmy+PP0Q3k/l/1YmfdsamBjifXOidDHBT
 5ZjsLvz3DRh6ZK8iXgRuT5nosQ==
X-Google-Smtp-Source: ABdhPJzTVX/ZyGI7Pmdgi3Ji0UX3geoz9OnmwOkoYIKCEwZOPpGwJ2EvLzYUymZf8Uzb5XEpGHWwDg==
X-Received: by 2002:a02:cbb1:: with SMTP id v17mr13623686jap.51.1635613667880; 
 Sat, 30 Oct 2021 10:07:47 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id o8sm5504963ilu.2.2021.10.30.10.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Oct 2021 10:07:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: vigneshr@ti.com, richard@nod.at, geoff@infradead.org,
 vishal.l.verma@intel.com, kbusch@kernel.org, sagi@grimberg.me,
 minchan@kernel.org, mpe@ellerman.id.au, ira.weiny@intel.com, hch@lst.de,
 senozhatsky@chromium.org, dave.jiang@intel.com, miquel.raynal@bootlin.com,
 paulus@samba.org, dan.j.williams@intel.com, benh@kernel.crashing.org,
 jim@jtan.com, ngupta@vflare.org, Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20211015235219.2191207-1-mcgrof@kernel.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
Subject: Re: (subset) [PATCH 00/13] block: add_disk() error handling stragglers
Message-Id: <163561366669.77445.6593243934116934390.b4-ty@kernel.dk>
Date: Sat, 30 Oct 2021 11:07:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211030_100754_579890_B81FA193 
X-CRM114-Status: GOOD (  12.51  )
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

On Fri, 15 Oct 2021 16:52:06 -0700, Luis Chamberlain wrote:
> This patch set consists of al the straggler drivers for which we have
> have no patch reviews done for yet. I'd like to ask for folks to please
> consider chiming in, specially if you're the maintainer for the driver.
> Additionally if you can specify if you'll take the patch in yourself or
> if you want Jens to take it, that'd be great too.
> 
> Luis Chamberlain (13):
>   block/brd: add error handling support for add_disk()
>   nvme-multipath: add error handling support for add_disk()
>   nvdimm/btt: do not call del_gendisk() if not needed
>   nvdimm/btt: use goto error labels on btt_blk_init()
>   nvdimm/btt: add error handling support for add_disk()
>   nvdimm/blk: avoid calling del_gendisk() on early failures
>   nvdimm/blk: add error handling support for add_disk()
>   zram: add error handling support for add_disk()
>   z2ram: add error handling support for add_disk()
>   ps3disk: add error handling support for add_disk()
>   ps3vram: add error handling support for add_disk()
>   block/sunvdc: add error handling support for add_disk()
>   mtd/ubi/block: add error handling support for add_disk()
> 
> [...]

Applied, thanks!

[01/13] block/brd: add error handling support for add_disk()
        commit: e1528830bd4ebf435d91c154e309e6e028336210

Best regards,
-- 
Jens Axboe



