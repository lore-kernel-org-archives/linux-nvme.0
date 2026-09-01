Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A65C61DD6
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2026 22:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xZmM4o6AtfOjzX+lBw9oMlu0125coIi3sG1O5FhkJfs=; b=4eunUyBmn6G/3/R6MSjyRkveyS
	tUyxbojFK/czDbjUgLWMmc08JhrsBSE6kX+/0bqCi/rOEXV5WwC3OQo6HPLP2yyVPpUW9cMnV+BgW
	Bvk8OJc6QquQ+y7I/uj6ugHvqTyet1TGCMZ9mAM/+49+i5AVvfEdaY+yv+PmpHErjQu92mMHCNDKH
	gxXxir2Dk82R/KwcnsiCx73ZHRZ7kQuRK8qln8ASRM2OWblY6YoKUoXqRia86ZhNdGaEWo5c0Pzv5
	+gpYZz8BUhmtD0OIGwZH8UZR/tqoyDnuAhunN+uXUHPDPajteMIcmIByDaLSU3gjbFCAGq/qZeRsb
	gyFTqS0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1X85-0000000DV31-3O2D;
	Tue, 01 Sep 2026 22:38:57 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1X83-0000000DV2d-1oOz
	for linux-nvme@lists.infradead.org;
	Tue, 01 Sep 2026 22:38:57 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-84a3e5ca66eso48179b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2026 15:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788302334; x=1788907134; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xZmM4o6AtfOjzX+lBw9oMlu0125coIi3sG1O5FhkJfs=;
        b=PU8lAFY0gdN5G0zpDHfZ1fhDVCg+uvN+TjUV2dSLbF3G/WeXw7UWxLTU0hLCeb1njK
         mqaYsN5cfCGwh2LKB4ziixPU1s3uwBeE0FPbfNcX1dqtJ4oNCl73s1FPR6zOQjRuACiM
         9dC7OhjutRo1ycv00lNOyf4j0SSigoujxDWHQp1BfmL0fPxK9M5xBHlXT/yKriQRCkJ+
         gAnNXcX3uxyiB7lt60txQPyZMZ7KeNPokgq4q5bQCH8uife2Jxd9EKXyuDArxwbRfetJ
         6TLA2HaX9nFKZ6RrFZXfslAC6wPSMXO4Tga4A+OyufebCmI3WLygxpIladqwpXG4Xgxc
         R5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788302334; x=1788907134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xZmM4o6AtfOjzX+lBw9oMlu0125coIi3sG1O5FhkJfs=;
        b=rKTLPeLBI89IRNoQe2nnS5ayeu8QNkM02UVtkBPD09cvxLqvOrp/P1xgw+LUavUGg1
         yKE8osje01LA2KAE5TMjLJd+QdRKtGmjctpqlxcjs8ONesx8QWd5gao9exHVE8Ims+Zs
         FmW3eym8T5UP6B7wMJnuZREUxcL1hbU1C2KekH9p+KN7eFXMvgZZBk07IHeNnqIV9VH9
         xRcHfqEo9BUZiqU9nkC8PXt6U2P6FqttsdFDxvqfOnO0fmaJ7mQkU3ByHrN92jQfZpYL
         +1dywQswCW4cu4iw/ecazHVR7zmRaIGGgjwGIcm5CMG17lBT7KX1wqbHfrKgdv0MIeuS
         bSOQ==
X-Gm-Message-State: AFuF++mY8gK2cXPdoExG/IbX1sgGXi962oL09PWnv+cxG33OZ8YvQoW3
	+RyYbboMkYvITO5mBwQhhWI9tIfOPDZJ8wWKxEe3sUaT+phSJEaVjJJyCgG1uQs++bv4s5aD9AF
	GF+Onafm3TnifRC1WbTjOxJpV7rxUgNlN64GjQkrCs+ULYhGGnd4fxlb6NN4vVFWnHyt65k5N2Y
	K0Ldjv5YKsbyakUg+Mu6T745xwthizMTZHka8GRAOBlXFBnZP8aWTzpA==
X-Gm-Gg: AYBFou0RHGptb1km12CuOszZRuI2Ub0KZcA97b5rF2GzHosUlJ4H0RLxd2tQU9SnMUf
	VEnAzgP+2GVY42F9wSlqj4Qynarql2YvWBrYKj82dIuaHpmhraT7+33yPo0Qjw5a5pMkLuhSqhR
	UVA7k11rl5CCSxrVYv74b/FNZD87k6HctKkNZPTi7CF5w8SaNaCQGjTLBNI4QQF5oEl+zvI8zdc
	cJtLBObMcULy4qt1qZt8FLmOkqv4XkJ66fW7cw0DpWBVLu/ukkdK98HzAdLbRPXpVd2cejv+Ufp
	bMSSkH1izoFMdHPfnR8W5grvhEstvbU0NsgqfQk8pvluAl5K40bhcclWXBnr8toTR7Uy2IHzGxm
	n8lTactZDbQLltCrRZ0bsNW2Qcvh5LnmcNDiwpMt1LYZFlS74tHInVap1pAmoxWgiyEOYtMgTAw
	oTnSyXL/+x5KCKNajpsvzTJw7rrLkmNTGCszRZeytPC14FG5YR8edl0KmrqYpKrT0Mc8lXwbm1z
	wNebAhGRP1dcJT/
X-Received: by 2002:a17:90b:4b8b:b0:38e:76f8:fcbb with SMTP id 98e67ed59e1d1-39aee1c6d08mr164366a91.4.1788302333643;
        Tue, 01 Sep 2026 15:38:53 -0700 (PDT)
Received: from dev-cachen2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-32f07baa594sm1453891eec.22.2026.09.01.15.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:38:53 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: leon@kernel.org,
	sagi@grimberg.me,
	kbusch@kernel.org,
	hch@lst.de,
	axboe@kernel.dk,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme-rdma: fix ib_device removal race that hangs PCI unbind
Date: Tue,  1 Sep 2026 16:38:09 -0600
Message-Id: <20260901223809.2346699-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831221355.1715088-1-cachen@purestorage.com>
References: <20260828232436.270184-1-cachen@purestorage.com> <20260831221355.1715088-1-cachen@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_153855_674931_288BED3F 
X-CRM114-Status: GOOD (  13.58  )
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

On 31/08/2026 16:13, Casey Chen wrote:
> The ->add path is new in this version and has not run on the setup that
> reproduced the hang, so this wants a fresh soak before it is applied.

That soak is done now, so the caveat above no longer applies.

The test bounces both mlx5 interfaces carrying the NVMe-oF RDMA
connections, one at a time, with IO running throughout and a userspace
daemon reconnecting the controllers:

  ethtool -i <iface> | grep bus-info
  echo 1 | sudo tee /sys/bus/pci/devices/<bdf>/remove
  sleep 30
  echo 1 | sudo tee /sys/bus/pci/rescan
  sleep 30

30 iterations over the two interfaces, so 60 remove/rescan cycles, with
60s of settle time between iterations - roughly 90 minutes.

No hang with v3 applied. Every write to remove returned, the interface
came back on the following rescan and the controllers reconnected. The
->add path is covered by this, since each rescan re-probes the HCA as a
new ib_device and so goes through nvme_rdma_add_one().

For contrast, on the same setup without the fix the write to remove
eventually never returns and the task is left in D state with the trace
in the commit message. It is intermittent - most removals complete
normally, and only one that lands while a connect is in flight strands a
controller.

