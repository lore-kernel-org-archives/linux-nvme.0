Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C6C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 16:30:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A24A61101
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 16:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A24A61101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QbavvutyyTn1YOP+HNcrWpWkoOH8nwg8nj2IOrifwrA=; b=4KRaVETq2vMrKL
	mVoL+ZGu5EdGzBi0UBGg54a3N4tR350fLoBtMKNYo5nPWZkE73nD22iSqwKyJXO4FBmkg9dJkvgTh
	64DnS4KrBWV8kRM1XIT2G4C4l/lW17p1FiyZRxeRA4nNfE1ztEmq4JXL7xAg+2OTjnDPsawfg/QpG
	endJ82bSuBDyTVZRu8fSNZtZSOsk2TjO+X0fA/c1uvyewTCpC+dSCARUdUNf09UzkT474MVhN23zo
	8I4R4qU8yq0t04zctPRgI04ftvGYeEh5rNZW9cqiTNr7BCM1wrLCnW1LGfCzuFOefDpMLuU21qF4U
	76/HlLxiXqzwv2esJYYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNdzM-004CCH-C5; Tue, 07 Sep 2021 16:30:24 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNdzK-004CBc-6k
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 16:30:23 +0000
Received: by mail-wm1-x32b.google.com with SMTP id
 z9-20020a7bc149000000b002e8861aff59so2355159wmi.0
 for <linux-nvme@lists.infradead.org>; Tue, 07 Sep 2021 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iILwEWNPAP/ZwzA04gTn2kFE9oHphWElVaxSzMMP9v4=;
 b=UDrYa861nkB/ZsRK8DEngNt+FAbwyMTVy3rYAmn/PPMFVPouOriYX9KlIJhbyKrrnu
 /mCeNUmcBO3PTFojO1v1SUAJovrugPYTWU/Kt5cdJ8nYDWwXGBQrKqye/EIMO4LhjHLH
 I3+FgV7gsBora+P4l+3Mp3zkGq/9SpKVSq/Gkl6y0B55YF94X3oY8Dh3/PZRnhpm/SNR
 2xJaIPgflaE9PehodgbztWweUdrLRFqq8dm3YgeCHiHhO8obwhqsUMdQHP/rAOjMezVG
 J1bziQW9j67D66SdtbxbAJE4vo4CEHcypaNkMBSf8uc/UbuL9kq5Rnqp9xAsq+yzv8Ny
 L+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iILwEWNPAP/ZwzA04gTn2kFE9oHphWElVaxSzMMP9v4=;
 b=SiB+dfnRLzEfC7PIhipm3GV87D7ftEBXP68ijEqXvy7xBZhVSPT0ALshQzSJ+2Emix
 q21gaicdHW6GOP6ct15yHuAoYC4E9JrX6lBsWOfPeVb//VnqCqCGBpB7LdoZmjpTLgS5
 ljR2xhImJ9txmnTQlEYizy9cbjUsJPe8fWJaeHSAcixs0sHjSYBY606Oh78zdCF7q6Si
 ih/UTG1daBdn+w1vcE4JLXUj8RLQZMZLJUcOiA9Ji8DDVeKa9WV+N49Gi+qb5HbPfR9F
 tzeHvaBU4FApHe3dvp2/ZJqM0ZehBcACtxF/WcyAInYokcOuW/HQD0F2Ut+7JAZHHvkJ
 li9w==
X-Gm-Message-State: AOAM5336kz8eMF9YSZnx1rhsBtlY8Rp/fOgtFcn324o3OW1P4MJrft4s
 PvFbxcAQGigvXu6msq4xD61iq4NKLYGc8yGTDs0=
X-Google-Smtp-Source: ABdhPJwsAN5ZQnfv2NSJOfIp1C9kkC4d1zK1l/YcYuUFsialKipA1F/hycv9qPZuHS3QfUGcqAgp4GiGLVZwK2cZgAM=
X-Received: by 2002:a05:600c:3588:: with SMTP id
 p8mr4906167wmq.0.1631032219438; 
 Tue, 07 Sep 2021 09:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210805125539.66958-1-joshi.k@samsung.com>
 <CGME20210805125934epcas5p4ff88e95d558ad9f65d77a888a4211b18@epcas5p4.samsung.com>
 <20210805125539.66958-6-joshi.k@samsung.com> <20210907074844.GD29874@lst.de>
In-Reply-To: <20210907074844.GD29874@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 7 Sep 2021 21:59:53 +0530
Message-ID: <CA+1E3rLpe7EoY1dbpH=rfVMFv9XXz1T47GO9xRFEujyZBthTow@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] io_uring: add support for uring_cmd with
 fixed-buffer
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com, 
 Javier Gonzalez <javier.gonz@samsung.com>, hare@suse.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_093022_290091_4537B0FC 
X-CRM114-Status: GOOD (  13.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 7, 2021 at 1:19 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Aug 05, 2021 at 06:25:38PM +0530, Kanchan Joshi wrote:
> > From: Anuj Gupta <anuj20.g@samsung.com>
> >
> > Add IORING_OP_URING_CMD_FIXED opcode that enables performing the
> > operation with previously registered buffers.
>
> We should also pass this information on into ->uring_cmd instead of
> needing two ioctl_cmd opcodes.

Indeed. We now (in internal version) switch between fixed/regular
ioctl by looking at io-uring opcode which will be different anyway.

-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
