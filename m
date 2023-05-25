Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27021C7EE2F
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+rSHBWkBgS2mm8ALT6WvzGN5/+TkGxD7ynUj1kfMsBQ=; b=1AipqY6wwmQ4IdjHhQK9BAN7pw
	E91VrR9p83tOGR9oNhHmhqghVten2hGoN+Dea03ky0A7VlfloxmhOwUXUOQdQUSISGpj8IC7ylzk3
	INKmis/iEpzIAXKoV8vvK4Toxj44RE+/IUZfDV5qSKdvNvHuPaPVq77VyB0FyNgWDw2oW1OEFI1/f
	BAisHog0gG4LEhY0DB7YjafbGmv/ZQ3whvHsPA7LnMXwUouedDwWsxgLCzMmxJkORqOHE3IdRCzIk
	2B59otfjUrF5dYj5fCZrzFJB826BWSvHHs9OjwCBOJKAysirTFyKsf8NX4jv1VsgSx6AkE8MHGyHa
	0rE9JiQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2CMU-00GtIb-1G;
	Thu, 25 May 2023 14:54:42 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2CMR-00GtH5-2H
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 14:54:41 +0000
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7757912a0d7so4615739f.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 May 2023 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685026475; x=1687618475;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rSHBWkBgS2mm8ALT6WvzGN5/+TkGxD7ynUj1kfMsBQ=;
        b=xbd0kecRRx+9NWW2PIoMEfqgPX0CRT1+PNfTWRD27rP6SGjEA08oc2g1ig6qytqArt
         hxT8emqjIMV+G/8/gMmi49z+HQ/9tAjIdEyPo7LPANxGF9HJoYnm+MLwMWFygdBh3uQ2
         lyw0gvPILXzUW6eI2WgP4+TIOmIxnj5pQYVGXlUGwOP2hxzwqn1DtoLLCDApR2lY50+w
         DkNLqerJzwQT2iG5CfgwyEf5ehHUQTVjkHw5EUGwRzB9gemxMQtul7GDRdUHW3c1KkTH
         OH5Md4o2jll6AEZql2Yoxq2VZawK2EbwkhemknYhEfew0w/vKszegAFX5NxaHMt6fou4
         T39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685026475; x=1687618475;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rSHBWkBgS2mm8ALT6WvzGN5/+TkGxD7ynUj1kfMsBQ=;
        b=MfSN7Q/65OJ5TugyJoxauy17j9U3+vsxRWlKKJuGVIXipISOe9Y4MDU915y8nW2QC0
         n+u20fJXvDADsKecJA8qj478BOosYLlIJfx3fRZiTEKFu3Y7EarY2rn7w+vJDYzMWzN2
         9zKhR5pNWdN82koBwBPtjojNTT19f+YipAMrt7mUw5DPahOcu3qm3S+yjpv/a0qq8JOh
         AhC9WEBvbdGmu7jLnOIeu66282/6yWcmp0e9dzEe2U2IZYuABpg1JNRmEqGnlxy3SlH4
         MmSpjo1wLtLOJFvrnsNADTIBEONDGzS+dHfKGgGoCRq93ywoyTdn/9mrT9Vc3oNlrurc
         pwtA==
X-Gm-Message-State: AC+VfDxB0kdlPQWnThkDlfQBw7aeSgHFKo0hB7YU5eJ+PRsnAwMlmnNK
	r8gOWuV8HskavL4wI1/AanEjCg==
X-Google-Smtp-Source: ACHHUZ7LB78/pRUlJbEGNmv97WHmzS3adTxZS+I/k6g+L59//3zumtt9ceLdjobbR+UUxoF4QMs8NA==
X-Received: by 2002:a5d:9d9f:0:b0:769:8d14:7d15 with SMTP id ay31-20020a5d9d9f000000b007698d147d15mr4546756iob.0.1685026475368;
        Thu, 25 May 2023 07:54:35 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ei24-20020a05663829b800b00411bf6b457bsm480532jab.101.2023.05.25.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:54:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, joshi.k@samsung.com
In-Reply-To: <cover.1684154817.git.asml.silence@gmail.com>
References: <cover.1684154817.git.asml.silence@gmail.com>
Subject: Re: [PATCH for-next 0/2] Enable IOU_F_TWQ_LAZY_WAKE for
 passthrough
Message-Id: <168502647392.717124.7925068931544884226.b4-ty@kernel.dk>
Date: Thu, 25 May 2023 08:54:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_075439_768300_AEFA563B 
X-CRM114-Status: GOOD (  10.06  )
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


On Mon, 15 May 2023 13:54:41 +0100, Pavel Begunkov wrote:
> Let cmds to use IOU_F_TWQ_LAZY_WAKE and enable it for nvme passthrough.
> 
> The result should be same as in test to the original IOU_F_TWQ_LAZY_WAKE [1]
> patchset, but for a quick test I took fio/t/io_uring with 4 threads each
> reading their own drive and all pinned to the same CPU to make it CPU
> bound and got +10% throughput improvement.
> 
> [...]

Applied, thanks!

[1/2] io_uring/cmd: add cmd lazy tw wake helper
      commit: 5f3139fc46993b2d653a7aa5cdfe66a91881fd06
[2/2] nvme: optimise io_uring passthrough completion
      commit: f026be0e1e881e3395c3d5418ffc8c2a2203c3f3

Best regards,
-- 
Jens Axboe




