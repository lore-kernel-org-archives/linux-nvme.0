Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C10C0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 14:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mgwyz4iRj9q6yAvphm1Dow+SLYBoFEuXL7N+OHxLH2w=; b=eeeIWm2Qrx1RVh+pulT2wLB2Wo
	ym2Uhq/sgr3iUR+cUopOVVS88zQHeadLyVsh7OQNCakUcbLcPq7LjuNPy/jLm1NjnIiVtwPRJXif0
	dmxxo3/1AQpzlRpCkOqzVZg44lciR55o4pXtIWaj3KHCP+MUkEQ0dZhckilLN48iKEgUFQEhrAzp+
	AhZVxAiFILpp+/ZUa/0sWsr1hgidGOAgZNBnZazYXBZYecCrYw4/zJPrxzLl9CUaiuXqhDDSgNv8F
	sCUkiCJrg8dTpQhpIzKwqRXF3Pl1pRC0fvRZ5k+jKF5qZuQEoiUnmQf7wKd7vRZHcQOijM+Xlge9T
	QGLkn4kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUSsx-00Anda-0g;
	Fri, 11 Aug 2023 14:13:03 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUSsu-00Anco-2j
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 14:13:01 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc4dc65aa7so2633685ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 11 Aug 2023 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691763179; x=1692367979;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgwyz4iRj9q6yAvphm1Dow+SLYBoFEuXL7N+OHxLH2w=;
        b=GQ8Q8/rdI4M1qNpW9R4Itc5OZoIOQy9/W221t3XQYfAHBztdjcoTgiCYgu5Vj3esHw
         Z3FmPryRxdVvkLIX1r7PhODgp4rv8vbgpUXAmZGUX+LZQtw0pb8HSsBy3fSC8BsstsKj
         6wyOx/wLwWdCrAqApdJi8cnyzbxLCFKTo99P0sCq0vCuS6SCy9Pn3VOsZZfLanqmX4ng
         qYuzVx2s14F/s0wHUiAXyoCMtak7ETdqmtZ36hSQHeh+G4YRNsoJctMvPPDFBB3ACTBb
         uVCc+JiNZsQH/0jv6UzY+wPOx/MlgJZ38TIbcmVpRdIZ3l7agM2LPdQN1Whdzd9nuN1Z
         hymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763179; x=1692367979;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgwyz4iRj9q6yAvphm1Dow+SLYBoFEuXL7N+OHxLH2w=;
        b=HI7B5nZBWjI3jgSYA9E72nyK2zr8moY4eV8HhoSyb3/CJyRdsFuMpFkoAJ9c+ew0UQ
         0GGMjVF/XwQKwH0qkG1DMdBSGSkv2LaggN6vn/5+HAz2eAoxe0N4zAI+qIkEURyOiBiu
         k14Qb6khqrexBiUpw5DpTlerStfSCjTPPFwYkBR5Og/pc5mDamv6Ju2/YSNur62YcsCV
         yPKoT25ckCH7vfW7QvC+/odLIsJZkR7PTPC6e8+s5XHLwC8k3EVHkotg4nI7bc8JSIxP
         ZbOaPkf1GEMQJpaHZ0DnEdC3DijWMZvwerLBPZjPodSbiXq6nZHU0MLZ6bcXHSPz3pm2
         ETQg==
X-Gm-Message-State: AOJu0YyL1rgY9/AMS4UILwja1sRFgPx5W0RQwJjQWTZzyRgbw4U9dGaN
	kNfOKoX5daG/7JHl4NMLBArGZKoIdrNNVNywRMw=
X-Google-Smtp-Source: AGHT+IHb1vvE44E885Mpy/o4Fr4NxojEjBL6DfkSbEBSrUbnDmm0Qt+tB9WxTOvN8Cr9J225WRBoDA==
X-Received: by 2002:a17:902:f543:b0:1bb:d7d4:e2b with SMTP id h3-20020a170902f54300b001bbd7d40e2bmr2467037plf.0.1691763178834;
        Fri, 11 Aug 2023 07:12:58 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d34c00b001bdb8c0b578sm1559521plk.192.2023.08.11.07.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:12:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
 Ming Lei <ming.lei@redhat.com>
Cc: Guangwu Zhang <guazhang@redhat.com>, 
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <20230809020440.174682-1-ming.lei@redhat.com>
References: <20230809020440.174682-1-ming.lei@redhat.com>
Subject: Re: [PATCH] nvme: core: don't hold rcu read lock in
 nvme_ns_chr_uring_cmd_iopoll
Message-Id: <169176317750.160467.12217175461941030658.b4-ty@kernel.dk>
Date: Fri, 11 Aug 2023 08:12:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_071300_889037_DBB10BD6 
X-CRM114-Status: UNSURE (   9.61  )
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


On Wed, 09 Aug 2023 10:04:40 +0800, Ming Lei wrote:
> Now nvme_ns_chr_uring_cmd_iopoll() has switched to request based io
> polling, and the associated NS is guaranteed to be live in case of
> io polling, so request is guaranteed to be valid because blk-mq uses
> pre-allocated request pool.
> 
> Remove the rcu read lock in nvme_ns_chr_uring_cmd_iopoll(), which
> isn't needed any more after switching to request based io polling.
> 
> [...]

Applied, thanks!

[1/1] nvme: core: don't hold rcu read lock in nvme_ns_chr_uring_cmd_iopoll
      (no commit info)

Best regards,
-- 
Jens Axboe




