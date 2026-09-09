Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8FFC79FAD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 05:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=onQYOLBo5II2o1VUv0LAcpIhMvNzu5amd5JnFVInk0I=; b=R3q0SLQ1hnNJ0ssSFl/uu32wfO
	3xbj8vi2gHGGoIB6IQ/IS6dwAJCgEiIAsgs3nFcReoDd6OR21a9l7/rKdp7k9IiJ+f6t2+JYr33Vr
	FSIs3MOFwMRKdNvMxMFtqaUULg5F5vrArVOLgfQdgtMDHJ7T3xviXLmumH+JSfnJLAYpsKwEFYCBv
	AFheIt3pMJRJ6xqSRJWBOxfgY8f5eyrOs6QhdG3CtirbojYxhaRpyjA4n4Um+9c/7eD7gPvdkO3HF
	QDpldxVb5aFiaBkuEiNYY4cjZOZSdZJ5ubCfDgdtzQoyfWKqaXLp96Ovs+O/M7OTzhJ9IepUhkoNJ
	QPQeOShA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4AkX-0000000Amto-1aby;
	Wed, 09 Sep 2026 05:21:33 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4AkQ-0000000AmtF-0HRi
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 05:21:27 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-86265451beeso2805831b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 08 Sep 2026 22:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788931284; x=1789536084; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=onQYOLBo5II2o1VUv0LAcpIhMvNzu5amd5JnFVInk0I=;
        b=HLUDpui+7LoHnjyCfDYyg+ulWmEn9y1R05jxq9+Xbc6hhgbz7KJhU3uw8CKdTJD03i
         dwFwbjrJxiEkmJF4OeOGscMquuvu7biwv/uR/tiMIoo6zwASorbm/X/LjuAksAR5UsuO
         A9GVLUuLL8vPRzRsWO6Za8QOZMvRvhCreAocAsthcSfZCVDXBAheSkUYsRfJil78t6TZ
         /LK3KP/0JMrkTaJyHCzvo5pIlUPnPzLVZLI2ANxXZGGLC5nIOtYp7YDIXIdZ7GNwG76S
         mq7neVIi8W6GDNHpwHNuAtcQTr0Q5e9PBaOdz7P2rPeTiZ9eYGiWYwQH1CjzTw8IE5NV
         JXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788931284; x=1789536084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=onQYOLBo5II2o1VUv0LAcpIhMvNzu5amd5JnFVInk0I=;
        b=plO6dQKvV/hZrxIZJpJtOljepMUDuMl2XFG69Pj5bWEttQASVyT4hvAbvqN5evAl5l
         drkQYvqZb1YVb1PqypxQgaTJW5oD9gg7hx1MgDopFD2GuxC8xyMkVIvGil3wigS/aR6F
         /CWItuWWFaPDJ3yuz2JFlOp1AcXDxzKQaCraP9gTjpkDI5JFvHYJh3Vs7+kBCZfVxgog
         EHBWWgV/5zJQxbu9DpVERZFGAw5cia9Fo4xmbhmeqNB7rH6qQVQLItZyi1A4m85pHXCv
         l9Gjxf0ijRF/2d4Zj/qocv5CWzAIYzozipZwB43XitZO2s+1Sa1Qfgy5SEP5DZCMcJLk
         ZB4w==
X-Forwarded-Encrypted: i=1; AKwUvByy1baEyYdzozpcEkdZQ6e5NHHAgA+gimaVbA7RDxbIAltaIagUGwi2c/o+NEXVJuFHWv5A8ahA8O08@lists.infradead.org
X-Gm-Message-State: AFuF++mepRbDc86p7CANVIbJUYQLYSuSRLX9ef/pYkCABRA6IzvQZr2z
	rMfNL9e6ovHCPDvCEchnkGTQDe7dxNp65b3tW3Pk87STh8fqvkgWwH7CHd74VIHt7TAjk8bnEL4
	ECXcs
X-Gm-Gg: AYBFou0k9NuttbKlVDdAk+dCcXoVajR6i7EOEupIKkTx8Xb56d0lsWXL2pQDpRqVzYp
	CDbWaHbTeDi/KuR2wGWG2DtFkZZZpOX3SEmUtRKCB20s4vtGw/IkgDa1a5IeejO25VUftkbnmZb
	MyRuM7QdDW7bgSLhE3QtYyhJIEsq3yf7uYBW6FNeLN98hhq+7cLb5iDxj4u4pLs4MV1DgywxHur
	+ROsAjKkzMrUXZYBLaT4xVoNH53+R27NNoR5P2vQlSYbdqxsaoOzx3qa5/QoSDNqoU3U9SCvpwv
	kyyqKRgDZpVcuLKtX+VqNXFRee9USqiqP8y+Y+SaWTKXnHcsXL7OtegFV4XhwtBVVF7X/BWX4JM
	Uywn0P+SzpYxcZuEpawhqdKDWzMLH0ha+q1BFs3hn+p0//qeGsJMruFlfVGMP2ZdPR/n1+CYHvJ
	ltZPOiB9qj7TwegsPZIoeXQDJCJ8BHQlFj+N4yaPpMyqmKFxnwR9N7w6qHeNKSdFfsad/a0p4rX
	m3qVwPoa00iBRDPavI/wkgds/kQa2YpcfBAediLf1e7agdMZL1ohw==
X-Received: by 2002:a05:6a20:4310:b0:3d3:adbf:777c with SMTP id adf61e73a8af0-3da3a0b7121mr48882980637.24.1788931283810;
        Tue, 08 Sep 2026 22:21:23 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4380:3400:58db:5832:d21d:1b0d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3397d6d1becsm2946134eec.22.2026.09.08.22.21.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 22:21:23 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Keith Busch <kbusch@kernel.org>
Cc: Saravanan D <saravanand@crusoe.ai>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC] nvme-tcp: allow multiple queues per hctx
Date: Tue,  8 Sep 2026 22:21:09 -0700
Message-ID: <20260909052111.59944-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aqBBgzV1Q9pP7Z44@kbusch-mbp>
References: <20260903152623.614951-1-kbusch@meta.com> <e940ccd7-3e7c-4118-a66c-1c17c33d2417@grimberg.me> <aqAZ6S6lBILltRwq@kbusch-mbp> <aqBBgzV1Q9pP7Z44@kbusch-mbp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_222126_124608_562339AE 
X-CRM114-Status: GOOD (  14.73  )
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

On Tue, 8 Sep 2026 11:10:27 -0600 Keith Busch <kbusch@kernel.org> wrote:
> Initial results show there's some promise to this suggestion, however, I
> think in addition to the wq_unbound, it looks like I also need to adjust
> the "io_cpu" to change to the submitter's CPU. I incorporated that in
> this RFC, but there's also a proposal specifically for that here:
>
>   https://lore.kernel.org/linux-nvme/20260820083634.71689-1-saravanand@crusoe.ai/
>
> I need to catch up on the discussion there, but from what I can tell,
> the cpu hint provided to the queue work appears to be important.

A short summary to save you reading the whole thread. v1 and v2 adopted
the submitting CPU as io_cpu for every command except the fabrics
Connect, opt in per controller. The motivation is a multi tenant host
with more CPUs than controller queues, where the connect time pick can
land a queue's socket work on CPUs owned by a different tenant. 

On a 384 cpu host whose controllers expose 128 io queues, blk-mq folds
three cpus into every map group, 9% of nvme_tcp_io_work executions ran
outside the submitting VM's cpuset by default, and adoption brought
99.99% back, so the cpu hint matters in our case as well.

Sagi suggested replacing the heuristic in the driver with a per queue
writable sysfs attribute so a control plane can set io_cpu exactly, and
my v3 submission will implement that. The user assignment is kept across
reconnects and writing -1 reverts to the connect time selection.
I will post it shortly.

Thanks,
Saravanan D.

