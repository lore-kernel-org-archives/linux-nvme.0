Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AE7C7EE30
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=crWwaD/7GgCUUFcWT/Llkm7dN9wwCuiLb/qh9BwJGxc=; b=IKMFu0+uhvj0GUOtpAYWt0pONM
	xi0yv3nryXoPdKg5l9mmBLSKF/Tve8N9u89VbJCzbvx06wHWX7if5GOS9B07h/jIwR/P+4ksbyVPA
	ul0ZmsqmR80pS3sae9K5fl3y+haDwOUEVF2/8Xt9+QaonFCVOkaLNjIgLa6QI7oc+N6kdxNW/qC97
	ztQ2S4r85oTokpVvXtbCVql45hYl6W3itNRkvuGJJxVKsDOQh1ZunkuqocIuRDl8BodDb9aqdRnfL
	jDd0mBbmA5x9KImYLCUagaJOr1YSGX+DjToGcvHCPP529DJaEQc5JZlX9mDAsxojTTlMwLUtmUMDU
	boIUO7Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWgDR-00000006PCn-22sh;
	Tue, 01 Jul 2025 19:00:25 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWdru-000000062uu-2jkb
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 16:30:04 +0000
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-8731c4ba046so319684139f.3
        for <linux-nvme@lists.infradead.org>; Tue, 01 Jul 2025 09:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751387401; x=1751992201; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crWwaD/7GgCUUFcWT/Llkm7dN9wwCuiLb/qh9BwJGxc=;
        b=hA9Dw4LCscRqPOzAg682ovvvqzV2z0j/I5vxL5l7E5i+FKXx4Bda7Xkz4WopSKCk64
         GNECx8HNYgMGaeNdPOBpR4awL538NlMMmkojvC3HYC1HHfX5i7MmsBBbKIMDup1nS7Fz
         Xjmqk8+G12+dsu/CaBQLp6h41PKCm+cXFePUGaLbwBhAckZvo/bkvfCcIgohw8EPiO3X
         7jxLKWwzjwQJ2qVzzrhSIPdkTYnjCT4NVBUxgM9ys0jj4j4xyMdJNfFVeEtIwUJ0Y/8D
         Rjj+jkzKnUbaQyrID4G6InloPcTjJ+vkyigxsCZxPXJhNWlT/yNQUW0Fz6061b5NKPIO
         j03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751387401; x=1751992201;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crWwaD/7GgCUUFcWT/Llkm7dN9wwCuiLb/qh9BwJGxc=;
        b=lRsLSflD4+OhIw0N0GQwIZ/TvW4BHz8higsIIJjTPDB8UAEzjVbvCHxvCByScWa7Q2
         bffqLOD03eKSAaGnWkjBIYVbhu7RzUCJeKbOVvNjeCm1oA6iAXRx8zcUgq4mzJHhENWv
         rmbqba6LlT8KAoooZDmlBgiTpuAY0gXTgJuYj4BvRHUTL9peSRvbKwTM8sv+RPHYHc7f
         sIN0OUzAzTXRNJTpb+MBadPFJWm4Ue4GX990uZXFUnIMQuqtFypVr6/OMZYz/ReIMMN3
         jJWuCK5oRcvzjOLLlLEVeh1n4KMLrfBEg+HKE1E2n3+iVxoLYzctcRZwaouAiuNmiBaG
         BHBw==
X-Forwarded-Encrypted: i=1; AJvYcCWDflceDXcMKxhgw7YavmMixCFsg2d/p4JsyNxveRZQn0Nx1kJWm6617lrjy4T+hEWkYR8GHUvTtNei@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1XLohbriqbYlV3yPaXNEh7qipaKUS68b1l61DFXSLtQmPpsBn
	vZRamiIzJi1YVADCeuHOpfFLxKPyGCP6g1p6YzAlFPgHIWzGUdh2B8Ea3L0IHF3eUDQ=
X-Gm-Gg: ASbGnct5HSLjTCzQYwT2AJQ6bdReMQ2l1txirb9IDZ/Y7Q3cWx/ZnqEBAuJTAeN/CSs
	KtYQbgdk+BMYjJjP55Q6U9MPIrQcqlFIrjmGb1drcNUvidW43ovn7CI17o+ia+4UI87a3k9MvSm
	XzkFPWaWE3AomXQiupYBCBXVw1EFh6ufCEGC81/jQqrK2/Kq4mgFlvuWzvOC/ldESC062i0oZOH
	hHOFeEophkWj9onQFRswzMpaD4xdDy05L0jm0O2xHXJUPTpeIqvFlAFCp9QXCp4oe2FU1OpKT8V
	gpAcc+e1bHVjDXMlz/gKGpHSSwTWN6pS7075wYbQ3XAV4wAOWOygbH7OC5Up0mA=
X-Google-Smtp-Source: AGHT+IGmszV/ckQKjI/KgjT/UrAo+IhSsGcXQNmla80uKgIibrMYCCf4LgGCWJe7gTvyQW/Kg7z8dQ==
X-Received: by 2002:a05:6602:2b8c:b0:864:4aa2:d796 with SMTP id ca18e2360f4ac-876882fbadcmr2169640839f.8.1751387401311;
        Tue, 01 Jul 2025 09:30:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87687b0d3fbsm236096439f.39.2025.07.01.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:30:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
 storagedev@microchip.com, virtualization@lists.linux.dev, 
 GR-QLogic-Storage-Upstream@marvell.com
In-Reply-To: <20250617-isolcpus-queue-counters-v1-0-13923686b54b@kernel.org>
References: <20250617-isolcpus-queue-counters-v1-0-13923686b54b@kernel.org>
Subject: Re: [PATCH 0/5] blk: introduce block layer helpers to calculate
 num of queues
Message-Id: <175138739958.350817.18365520328662376034.b4-ty@kernel.dk>
Date: Tue, 01 Jul 2025 10:29:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_093002_800269_2C1B0817 
X-CRM114-Status: GOOD (  13.61  )
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


On Tue, 17 Jun 2025 15:43:22 +0200, Daniel Wagner wrote:
> I am still working on the change request for the "blk: honor isolcpus
> configuration" series [1]. Teaching group_cpus_evenly to use the
> housekeeping mask depending on the context is not a trivial change.
> 
> The first part of the series has already been reviewed and doesn't
> contain any controversial changes, so let's get them processed
> independely.
> 
> [...]

Applied, thanks!

[1/5] lib/group_cpus: Let group_cpu_evenly() return the number of initialized masks
      commit: b6139a6abf673029008f80d42abd3848d80a9108
[2/5] blk-mq: add number of queue calc helper
      commit: 3f27c1de5df265f9d8edf0cc5d75dc92e328484a
[3/5] nvme-pci: use block layer helpers to calculate num of queues
      commit: 4082c98c1fefd276b34ba411ac59c50b336dfbb1
[4/5] scsi: use block layer helpers to calculate num of queues
      commit: 94970cfb5f10ea381df8c402d36c5023765599da
[5/5] virtio: blk/scsi: use block layer helpers to calculate num of queues
      commit: 0a50ed0574ffe853f15c3430794b5439b2e6150a

Best regards,
-- 
Jens Axboe




