Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7540DD637A9
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 18:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c6j4wyvW+qjOuARZZJwh1G4pDZjq38FdBGsdmUpGeUg=; b=49p1vDHWO0Q/zWreF4zbRV1L8G
	lWrJC1WuL3G90/gSEEO1+7rIfm+m3dOBCVfjfJvmW9xVoA65+xS+ucKO7NDCK9WG1cfXwm5t6B+TG
	tuL5m3qSkHWSY5T8YalAYnjAHU4wkR7dN63RvhVznWZi7kQhESievJLeNmnlko9qaigiYw4n89BKy
	MmWMeg65S0GhX1jKEYk2cZjJnjYxQMlqK/cYQTrDRgaZvnrW19Cn2Y/XKnc0V1UpvDj6xjwOmleCg
	OTeg4MLecRD3x7C3cISpk86I3VZtFdo3xWG1pZb09tMZe/XY51WGCBQljuiQpanVPF5C4lDP4fOA3
	KPhG8ttQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIPK-00000007lKT-3DHj;
	Wed, 13 Nov 2024 18:48:02 +0000
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIOA-00000007lF7-0cjN
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 18:48:00 +0000
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-2890f273296so3342107fac.2
        for <linux-nvme@lists.infradead.org>; Wed, 13 Nov 2024 10:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731523609; x=1732128409; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6j4wyvW+qjOuARZZJwh1G4pDZjq38FdBGsdmUpGeUg=;
        b=xMOWVxj9/nAcziHEgfOStOhk50VpbDMuMCBglwa1oYHuhcleWl/0DmmyH0/FavsCLK
         8BhqRjlS3KSLHDVxEr0oy7rLAVxQcLJq97ALtb45Okrl4ZQuQcXozoY9UN7hPgbXrSFC
         z06B7VoAgqLUfnAJzHAvbWOPM2ALWsFsQ+w1VRjL+SQBvxmTiQpgGh0QEaIoHg6btxCF
         8hdn8EjEd9gODD5bV123IeI9odODLl9s1fZjyW5zqlGke9kwMKPJVb2tRgbsC/a47Wdh
         gn6uQN43AaqNZB5ojF3JKkDfVKcMhJEvY9m9/cIv83FZSsfzoWfCkH67FZg9rv+qPL4p
         bzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523609; x=1732128409;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6j4wyvW+qjOuARZZJwh1G4pDZjq38FdBGsdmUpGeUg=;
        b=MuI4dH8pqRCqQlO2vR0Th4KrwuMLoXB6Bb/ZgPfYOZw8YpknkWbDH5m035c46FpdNk
         gRvfkXrKbdE+OZiZsP3njp85ZzE/hnsM1xN0CSKvIXnlrCS2FNkEV/kQGkJKqf96oweQ
         Q52TvL+5Ha10dy4P3BfQYAEeTpfID9DdVthJ/00ZHHRdDSz86aFN3vf77p59Ez1IYlOf
         EWtc0F5KbLmboq3fmX5AxfO/RkZouVGYEuE1cjK5aiDNVtiLQv/Kw8kiunAyZiMTeiix
         8ds8IElX+D6CskiNgZ0HoZemvFibtkzRrKteB8MDrvnU5yAjJFYzio43SQzXzn20Zgh+
         P7OA==
X-Forwarded-Encrypted: i=1; AJvYcCWtsn0g8dZ/D59rwr43nRL6kHkUd96EuC+xPJmm/D9ofjBXRjUIcdwYnrTf7GwE8xCmSs8NiFs5XmVl@lists.infradead.org
X-Gm-Message-State: AOJu0YzD6TaOWjO07XiVc9KBCcmjP6ZO6aYuOr52tQZEg2YtfLC3Sv3j
	4+s3Qf1Hvtugqmmo3pYn3iyLzARphUvd7feYgdiG0jxPzLwzF7yf1Ag1NVRyZxM=
X-Google-Smtp-Source: AGHT+IGhW5wNVuxAhg949qECoPGMVp0GIeUGc7cEDZZJFiXO83xP2SEoIWQJzy2xwUop4HsywD6gWw==
X-Received: by 2002:a05:6871:811:b0:277:d7f1:db53 with SMTP id 586e51a60fabf-29560110330mr19601816fac.17.1731523608778;
        Wed, 13 Nov 2024 10:46:48 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e92afbcbsm1023381fac.40.2024.11.13.10.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:46:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
 io-uring@vger.kernel.org
In-Reply-To: <20241113152050.157179-1-hch@lst.de>
References: <20241113152050.157179-1-hch@lst.de>
Subject: Re: don't reorder requests passed to ->queue_rqs
Message-Id: <173152360771.2243093.6096591698137056565.b4-ty@kernel.dk>
Date: Wed, 13 Nov 2024 11:46:47 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_104650_383282_551ABEB4 
X-CRM114-Status: UNSURE (   9.67  )
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


On Wed, 13 Nov 2024 16:20:40 +0100, Christoph Hellwig wrote:
> currently blk-mq reorders requests when adding them to the plug because
> the request list can't do efficient tail appends.  When the plug is
> directly issued using ->queue_rqs that means reordered requests are
> passed to the driver, which can lead to very bad I/O patterns when
> not corrected, especially on rotational devices (e.g. NVMe HDD) or
> when using zone append.
> 
> [...]

Applied, thanks!

[1/6] nvme-pci: reverse request order in nvme_queue_rqs
      commit: beadf0088501d9dcf2454b05d90d5d31ea3ba55f
[2/6] virtio_blk: reverse request order in virtio_queue_rqs
      commit: a982a5637e91fd4491da4bb8eb79cde3fed2300e
[3/6] block: remove rq_list_move
      commit: dd53d238d4ca7ff1a0e10eb0205e842560f1394d
[4/6] block: add a rq_list type
      commit: dc56e2a78ba20c472c419c6f2ed8fb7d0c95ad90
[5/6] block: don't reorder requests in blk_add_rq_to_plug
      commit: 05634083a304eb3d4b5733fe8d6e2fd0c1041ca8
[6/6] block: don't reorder requests in blk_mq_add_to_batch
      commit: 65550dea43815d01f45d7ece38e458855d5e2962

Best regards,
-- 
Jens Axboe




