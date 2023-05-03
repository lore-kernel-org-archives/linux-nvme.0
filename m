Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB692C7EE26
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 19:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=54FcX7m56ayBWjcvud1Kf/5sZaGwEHaWh+uspYclntQ=; b=XJl4bkKykHDlCCbPQILDSThZlY
	XRlfaVkHTDbq29KYcU0ulv4vnV4mWXDlu7sp8Dmkt6/jmak+ttUX8hFwKGu/6s8pqM5SlIb0ipRxJ
	6OssZlqh/GGUd5DBFyqB4JYz7WQ7fIEFkkD1IVf587cmSwQnn6KaYAc3fx7bo95CaF+igeZrBTzTF
	WJIuQc+owHzxsbzqf+cAz/YOepfJGzRsdMeqcLZ5u02YF/jcCQEiFX2WxUk2FfuwdbMnRNqu5B7Pc
	BKo/fGAaziolVFk28NIdfxyXQyYfjMO59kLVSrD5RLo2ypo2L15U4VmJ+Qxy4jr16vNNpdls+xZgp
	w95mGHMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puHtE-005YV2-2f;
	Wed, 03 May 2023 19:11:48 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puHtB-005YTr-3B
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 19:11:47 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-304935cc79bso5556309f8f.2
        for <linux-nvme@lists.infradead.org>; Wed, 03 May 2023 12:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683141103; x=1685733103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54FcX7m56ayBWjcvud1Kf/5sZaGwEHaWh+uspYclntQ=;
        b=A/whQam5XvPPsJwwhKvu2J4MH74m0Q57yWSkmYr+XWQR/SzSgkkE5iggC4qD/jEhyZ
         fNrr9tZ10NM/x49rSosqAZgYQiikrxN5KP5gjuBc91oNydnrp94/fxMxSqin75Wof+dl
         p1NkogN1EREebosF/4EMiwMGyJ5Qcu8gP7SVcCXVBXDk2azvStXxPnFdjNGaYmgLbLD3
         9MCxdduutK+1/WRUV/pVTcRp1qDnXGjtQYtCZ/6u417RdXA41IGRxQoN1dc82h/aT7/D
         BoAyhZngA5tNxsImAFYhJQ92wYv4Cl6kQjYMVxP5VJKN61FWalMiboA2TOC/rQM+TpSu
         iWlw==
X-Gm-Message-State: AC+VfDxjJQSET/UxdvYFGRlC+Bj8ZEu0tkiGmxQO5FaCoZK2aj4FCC4M
	DcFEPOQCQ5UpA+CKSV9zsak=
X-Google-Smtp-Source: ACHHUZ6HDa6PpE0QZkVce9/fw7pukp37W1XiFxrwL1kOk7bquMTIwotFwziRSBw5lTeJ/dgM0pLGRQ==
X-Received: by 2002:a5d:6b09:0:b0:306:2eab:fb8c with SMTP id v9-20020a5d6b09000000b003062eabfb8cmr771025wrw.42.1683141102639;
        Wed, 03 May 2023 12:11:42 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-029.fbsv.net. [2a03:2880:31ff:1d::face:b00c])
        by smtp.gmail.com with ESMTPSA id k5-20020adff5c5000000b002f103ca90cdsm34480997wrp.101.2023.05.03.12.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 12:11:42 -0700 (PDT)
Date: Wed, 3 May 2023 12:11:40 -0700
From: Breno Leitao <leitao@debian.org>
To: Christoph Hellwig <hch@lst.de>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, axboe@kernel.dk, ming.lei@redhat.com,
	leit@fb.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, joshi.k@samsung.com,
	kbusch@kernel.org
Subject: Re: [PATCH v3 4/4] block: ublk_drv: Add a helper instead of casting
Message-ID: <ZFKx7Kn2Q3qiKfze@gmail.com>
References: <20230430143532.605367-1-leitao@debian.org>
 <20230430143532.605367-5-leitao@debian.org>
 <20230501043122.GC19673@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501043122.GC19673@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_121146_019988_FA1B080E 
X-CRM114-Status: GOOD (  18.41  )
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

On Mon, May 01, 2023 at 06:31:22AM +0200, Christoph Hellwig wrote:
> On Sun, Apr 30, 2023 at 07:35:32AM -0700, Breno Leitao wrote:
> > ublk driver is using casts to get private data from uring cmd struct.
> > Let's use a proper helper, as an interface that requires casts in all
> > callers is one asking for bugs.
> > 
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> 
> No, I've not suggested this.
> 
> > +static inline struct ublksrv_ctrl_cmd *ublk_uring_ctrl_cmd(
> > +		struct io_uring_cmd *cmd)
> > +{
> > +	return (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
> > +}
> 
> I've two times explained we need a core io_uring helper to remove this
> casting in the drivers, and I've explained how to do that and provided
> the actual code for it.

Sorry for it, somehow I misunderstood what you meant. I re-read the
thread and got what you said.

I am preparing a V4 with the new approach, and I will send it tomorrow.

