Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69133C77B73
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Apr 2023 14:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pjAcu4IcSQRiDt8dUv43LgZPu6LvertkuJ0LwpP92lY=; b=y66b4ieF6Uf9SsQDcC6W4vjeJu
	ttNuxyD7+UiTTtLZnybDg/UFiLuuAx0HdvKMDQRAcd/Ue4LChG9HzfeX4oJVjgHHwgJ8rbNoTfBv4
	rgPM/YAjGJwSSYtS54nv9L60GrGobfr2P0ixQc+smmmd+DRi/cW/ZDrTTsblsjcU3O3lQhIPL+GOk
	398td6Qf2/IeDBf0PoCFJoZ+/tbpB+3ki4GnjyP8enn0NT5ZCaAl5PNPufA0Ogbp2nkk3+0cPP/0w
	eE1BIbvU+NXPHNXjegdgwbiwM5t//kHay6jVglbpT/qHZCwHu+S83uGoR3de7i1sJpqko877S0CKW
	HZeynCfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pt8Bi-00EIGw-02;
	Sun, 30 Apr 2023 14:38:06 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pt8Bf-00EIF5-0Q
	for linux-nvme@lists.infradead.org;
	Sun, 30 Apr 2023 14:38:04 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f19afc4fd8so8609705e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Apr 2023 07:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682865480; x=1685457480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjAcu4IcSQRiDt8dUv43LgZPu6LvertkuJ0LwpP92lY=;
        b=eyJNO8ztFvFjJiqUH++d6o8mJAtT36vX3lrQGvQhE2Xci2wbWW0TaZpCVzDZmfLH5z
         2Wmzd1auAN1pnFn3V24PIcMCQgfqLk6LD10SexUl+HLUFCLvznFMwrKXCEGOZeaRqsyG
         JeXs7kd6/0ANiO6LTrzFKxY5J3Zgt6DbGpye5ElHoy465G1aU2vm6QdOaLnv1f+ZUoyf
         86K69EnkE4MUpavxdyirIhb5U3vWuYTZxaf9fKmdTgayBLFYffbK2731NL8BIoGDjud5
         PVtP3xt67ba1DeYfbf+wdhgsEQ0ldLXIOP2kndOUe+/YIXF25yNyIFy+5bWn6r0KlOet
         ZwRw==
X-Gm-Message-State: AC+VfDxcMfw7ZVwScgqm3JQ0KypH03vqtNxAvaSy55mYCm9u/Xf8R3T9
	9qz9MBzBlVe26ynuFJ8FBE0=
X-Google-Smtp-Source: ACHHUZ5MAoJuX2opkQ1iG5lqU3GmlotVF/8I1OK08Oa68jNWUln3SI3TGJBlTblGXSKtA1vu+wOMHA==
X-Received: by 2002:a05:600c:b45:b0:3f2:5922:d955 with SMTP id k5-20020a05600c0b4500b003f25922d955mr9291474wmr.8.1682865480436;
        Sun, 30 Apr 2023 07:38:00 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-013.fbsv.net. [2a03:2880:31ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id j32-20020a05600c1c2000b003f173987ec2sm33667582wms.22.2023.04.30.07.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 07:37:59 -0700 (PDT)
Date: Sun, 30 Apr 2023 07:37:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Christoph Hellwig <hch@lst.de>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, axboe@kernel.dk, leit@fb.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	sagi@grimberg.me, kbusch@kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] io_uring: Pass whole sqe to commands
Message-ID: <ZE59RGJZd8DyDQaX@gmail.com>
References: <20230419102930.2979231-1-leitao@debian.org>
 <20230419102930.2979231-2-leitao@debian.org>
 <20230420045712.GA4239@lst.de>
 <ZEEwHk32Y8IcT20n@gmail.com>
 <20230420123139.GA32030@lst.de>
 <ZEEyKolzQgfkEOwv@gmail.com>
 <20230420124615.GA733@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420124615.GA733@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230430_073803_167288_3786B9FE 
X-CRM114-Status: GOOD (  16.81  )
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

On Thu, Apr 20, 2023 at 02:46:15PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 20, 2023 at 05:38:02AM -0700, Breno Leitao wrote:
> > Since we are not coping the payload anymore, this is not necessary. Now
> > we are copying 64 bytes for the single SQE or 128 bytes for double SQE.
> > 
> > Do you prefer I create a helper that returns the SQE size, instead of
> > doing the left shift?
> 
> I think a helper would be nice.  And adding another sizeof(sqe) seems
> more self documenting then the shift, but if you really prefer the
> shift at least write a good comment explaining it.

Agree, this is a good idea. I've fixed it in the nvme code by creating a
function helper.
The same problem happen on the ublkd_drv, and I've also fixed it there
in a new patch.

	https://lkml.org/lkml/2023/4/30/94

Thanks for the review.

