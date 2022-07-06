Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6847FC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hW2431492sCVZamN/p5cUoH7v2KxbwYiYFtMhbuxSSs=; b=eTTED26uLYBXh1W9JsV3cqVWSl
	9HDz2jTsiX/x3ST8B/prJyxUsyXX/ZZBVJ/vKxc10UDud3oyBi9QfCyF/LX5KQfH+uTt9Z0Ba6c9x
	lIMCc13ELv9SijLuT9517/O34iUzExwlLDQPeIkKEfOl8LAMBf2jIWHp4xH/RoMUEvyDy3gEKQycI
	lgFEJGAwtmIXuxVOpDAVMJcBQKvD1H2UbrBeNa3+hMnjfVKEFohwpKRR73xASq/MOaAYin15SRGbM
	L5HPmzg2/hXx1g6ml+zxJpZcF3nIhTMgWQHYm+PfAaQo6LAZVYxbuGH6O9PJwvc7hQTpj0B9m/WD9
	kWp6eIWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o94Ew-009wvI-Mt; Wed, 06 Jul 2022 12:34:46 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o94Es-009wtI-RL
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 12:34:44 +0000
Received: by mail-pj1-x1035.google.com with SMTP id o15so10622793pjh.1
        for <linux-nvme@lists.infradead.org>; Wed, 06 Jul 2022 05:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=hW2431492sCVZamN/p5cUoH7v2KxbwYiYFtMhbuxSSs=;
        b=aO/ZC+U5LATGWzsMenvtODpWhcejLQ4DmRLha/4SFn11Wf8DcIrFk1B5B3fP0AvXUg
         F1PUOqzt04jGHL+kW42wdhfxoatgfieaCaFTjTsg/0aPS0d1NSqzbVAWUr48FwKbi2kk
         bNQBektjLeeE1K2U1dLcbw68C5O909m3ltoYOt5psp5Gsf6ooUgQxbp7vtkJxaFCNVLq
         JB5JDSboVX7gNuCr6BqOEB2T1vnXsuL9FxkeVt6f0+RSoxgWygebchQshMWMnbZdv7Xg
         QtsTjaAJP4QGjnj40SClqvGtAh7oHGQx9EV2mY92w7wDa5vthlOb4om9GVvEhy9g8Ujc
         ZNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=hW2431492sCVZamN/p5cUoH7v2KxbwYiYFtMhbuxSSs=;
        b=t+qsSdhDQQAGO0TaKJ3OC9YyvswIQ3R5AAnAbMYDbEKdvy6inst9BLdY9OIBJCpBHE
         zuaiiJZQnq7m11t9krHCxrd5kpcAwGSUdHcxT8BFcPjD9FbqnGw9yQlYFOTuBqTVv3QT
         VBXtfjRnkBL5X+7bDySalBibYp+pw3bxLDzEfsbd6DWVqKR4UHBTSue4Kes/+bM3HO1u
         JgMtz4BCnVcusTtmFZEbKcmUlnK2WDQwYUdgm8I+HGcGg+CNgNuqdWzOiuqzS4zJl01a
         uRMIDTMRCdFXuXwUp+sONRYDSMqMCH9b3h39J+PkbX1/0XPz2vOPYJD0QSJSMz89OjkI
         ADMQ==
X-Gm-Message-State: AJIora+8Xfu8WP+gEyxs5KfMBjaFr4K5x9AIYMPA37gJlSjOTX7TbqTG
	u0Qu5L7Jfyi7S06+P2nAkhx0TeoENz3f4Q==
X-Google-Smtp-Source: AGRyM1szJSqnPFX6luEMhyzzQ0Aeywhddc3vVY3+ZKqUe4ppobSQfJg1kQYfqyNYWH89tB/Ll0NihQ==
X-Received: by 2002:a17:902:ab42:b0:16c:66d:c44d with SMTP id ij2-20020a170902ab4200b0016c066dc44dmr1314197plb.125.1657110880402;
        Wed, 06 Jul 2022 05:34:40 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 84-20020a621957000000b005289cade5b0sm2634560pfz.124.2022.07.06.05.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:34:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: jejb@linux.ibm.com, hare@suse.de, kartilak@cisco.com, Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com, satishkh@cisco.com, sebaddel@cisco.com, damien.lemoal@opensource.wdc.com, john.garry@huawei.com, bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, nbd@other.debian.org, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1657109034-206040-1-git-send-email-john.garry@huawei.com>
References: <1657109034-206040-1-git-send-email-john.garry@huawei.com>
Subject: Re: [PATCH v3 0/6] blk-mq: Add a flag for reserved requests series
Message-Id: <165711087866.291548.18135186803736478100.b4-ty@kernel.dk>
Date: Wed, 06 Jul 2022 06:34:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_053443_103114_728E8962 
X-CRM114-Status: UNSURE (   7.26  )
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

On Wed, 6 Jul 2022 20:03:48 +0800, John Garry wrote:
> Can you please consider this series? Thanks
> 

Applied, thanks!

[1/6] scsi: core: Remove reserved request time-out handling
      commit: deef1be18e3fc62ddf04fb3e5e8ff6a301693dcc
[2/6] blk-mq: Add a flag for reserved requests
      commit: 99e48cd6855e9535488e3c90d65edd46c6e6fc1b
[3/6] blk-mq: Drop blk_mq_ops.timeout 'reserved' arg
      commit: 9bdb4833dd399cbff82cc20893f52bdec66a9eca
[4/6] scsi: fnic: Drop reserved request handling
      commit: 1263c1929fb8c375494666ec6d1bac838ff02c25
[5/6] blk-mq: Drop 'reserved' arg of busy_tag_iter_fn
      commit: 2dd6532e9591f201e7571b30915db807603ab924
[6/6] blk-mq: Drop local variable for reserved tag
      commit: 4cf6e6c0106bf6e6d034fa6043b4428ac2f267fc

Best regards,
-- 
Jens Axboe



