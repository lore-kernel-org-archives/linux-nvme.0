Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF84E9D827
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2026 23:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=; b=l47HrECKbc/+A7pneOlgUBGvX/
	l4MisgNLVHFYJIVc9leZuLq85Leyl8woIPUXjuxRnavO+HpyTvnwC1aiJDERgtL0nSg/AsCbaWtFh
	BYtEt9GS3QEY2ysrq2rst2UN4d//dGD41wxm+vnUT2nnBKydGAjzPTUQCF3mRAHRO9N6KCGtSuJ4i
	whMtiHPfVk/C8hSZ0+XEDWwe4MnEJFOzgmUik1YQvQZjwjrVz2FKTah15oJUi5nuiltwQXxfoXZCR
	idoHpfeZJuCTSLidQZeEIPeqgGMm4Qv6qAlYVNR/T61rGEbOLGyUvWCWqkrUZbqX1lTYLZiapsts2
	Ee1NCHhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9X8c-00000004Z2W-2aV1;
	Sun, 05 Apr 2026 23:44:18 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9X8U-00000004Z2C-23pM
	for linux-nvme@lists.infradead.org;
	Sun, 05 Apr 2026 23:44:11 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-66f1b5e17efso181439a12.2
        for <linux-nvme@lists.infradead.org>; Sun, 05 Apr 2026 16:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775432648; cv=none;
        d=google.com; s=arc-20240605;
        b=N87aVC0+25oQcQi7S3rMgIfmosbWzyZ1pym48F4JpWq1Tao3wcm2PQryNzsxeHzzxT
         fMmTPgvxq81Ujor3UNOWQ+chZQry/tREpWcbMKhBeZWXg/0Yjps4ejLGCM1HLgel1iam
         lmSdnIF3I6MPDZtbIQX6yyvVhZzJLyIk6fOKkYT991jgbfgyniNeDAvoQ6My8cJZop1B
         KRf7Y85QK6TBFAtLPnGMue4ysVLhcbig8FnNS9P2eafKLB+rW+EobguGH8puVLs+wHBM
         ByEFAdmyKY15y4q0jj/puw2L5uwN/DGvPOwL7w4Kn4vUdDGWbyjXAi2QF63WY+bHXVQp
         /G/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=9tGR73IT9WbVXep3TyU6YK4QRHW/9A+YMcEZRp4oHsY=;
        b=hvJSXQ7NHfJ65oQzplLkVoRwupwoJsoNv/kjFzXik7v3Zw8BjZgbMSWrL0DIpAXvoy
         blpoLIQ35t04Vyt8LyVq5ou2FPa5GfRi1oI8Dv9GBHcHksiioUPw9Gorig+ywAxq2O81
         ehtZDtD26i3Blxj8vwieDnsciZFyTbdXj4UggZk3BgxJU3zrx2z7vElSggBqx7QVh4FW
         n4Wq5bzu2ncsrf8hTa5FtPoAgq105iFBMJj/oP78b8fgCyHLpNCUn3dnwNdV/3N4lmpZ
         HdfFqIOUBxZE1NVzoV0NrdQ/f5b4SAderKzRuskqOYJ/pRK8wHhJeUz5b+JjC6db4boP
         LhoA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775432648; x=1776037448; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=MFoV9y4dFXPIMxa25sMZWfs2q8g7hktnpL26cd2/JhAXvbe1oV/YkAdj8YERbdkhpi
         1YSl4ar/GWgX2QD/MxcAVI+c1ZN+rBbb9optEt4kJRhNMhXro8rJx5hL1MNEk750Q1Yo
         EvhfyOnmQj+mK9PQNV26ha04CJL2/+G/tDsRHTp4MGCJts/oRMsQafYT9M1bd8o+5Zuc
         7b/1DRNSPYPL3u7EjaYX9wpdPuU7GQjmts1VFhgXVW4bf1Q5EXN6F3BjYfI5UxO75rkj
         DWeaU24wQnepQ+stNBrV5k+o12gWI6VoFgXKwiZAWZXYY1sG32NbZESwrvmHhbtiX9Ew
         TmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775432648; x=1776037448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=cZMekEi1CkR422vji+3bxQ1raf2wsOFxGaEYwHFknfjTJcKudkdzBvY8Vn0lTQL2e4
         QWao8UsAX0eySfXNI4W685rY4ZywHvofV+NSwpa0uxoOPUwu96Cm3nu8Hke1pmzIVrbf
         s/xBMzuNzwJL1eMS9/AVmHz2gWpSR3hLKFZEDaJ42Hbrk1dJixJsgqZjCulhkzQENnQ7
         jFB+9j05LJFemQ2xI6hCRAnLZrP06oigqrO14/bHmcTfErG52WWbFViMwcN7BJ01tTY3
         M09RKnsDiLKykvTsbl5JgRS41SOaJ1Gf4kOumLL5uZZBUYxi/r0zCAIlY/00ZyBMfQPb
         fK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmj3kWx6uPpFqwMqbWo/MQllW7Oseq/B8ITYQSJz43nKaK7Fc6RGpY0LrtYrK3BZP5xsJ1BzmQdtMF@lists.infradead.org
X-Gm-Message-State: AOJu0YzIHJc53MAZtTUhEx/oMM2Bwg4qRyoMlHUA5Z5gOUJw5XKqIX/K
	eLWFL1V+KgWygFsLcidvZl5E0qn89j11XychOsxJYaXNN48bKJ5ouQY/DJpBQbXBYjW1sZj6QwK
	KDSYoSSFfYZKQLsSHgCb5vvc39MQ6Ng==
X-Gm-Gg: AeBDiesJ5rWTf2H5K5gTdLdexl/Pogf1xwdZtE5lAWA1Wr/IM7PN+L3OpRCTAgKWvd8
	HrsVMw/ZLvl09YHK+uuGeQCI4yWpdVqSkyFEOg2JnHDEI0l9boy9wF6tytigGLZHUwqZ4XmDyws
	WmdKFj/8l+KW8FJVY2NIlPtGjjukhSMjbpLFltGgvvpzfns+EDrzxzAp1W+YChAsOpghADw7tZy
	VTiAEAfdlwfz/+MufFwk+DESln2JRsI2OvQyaCwKqNvaazt8LNB6wfKtRJ3hmjgDjTDhU43f0CJ
	toGBvQLPDKqigAGFcgs3yBnDDNrC9tQk6xmRe/BoUIxhg/wsktAqRt9j6F5bujvZe7zLjA==
X-Received: by 2002:a05:6402:430e:b0:66e:f4c0:c365 with SMTP id
 4fb4d7f45d1cf-66ef4c0c656mr717744a12.10.1775432648191; Sun, 05 Apr 2026
 16:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com> <20260403194109.2255933-6-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-6-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 6 Apr 2026 05:13:30 +0530
X-Gm-Features: AQROBzAe_pR1JdvPMRMED5Vbpy-Io1YSGKtG2B-bIRotwUzCJw2tWzJbmfKAgHw
Message-ID: <CACzX3As8NN6n3uCvOPhejzZCs4fTnXkohKvZw787+OyP=tpnNw@mail.gmail.com>
Subject: Re: [PATCH 5/6] t10-pi: use bio_integrity_intervals() helper
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260405_164410_532666_8E0F11CA 
X-CRM114-Status: UNSURE (   6.46  )
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

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

