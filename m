Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76283C61DFD
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 22:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PVaP7reUlLXYTaWyms8a2Quq5+138mi3Pm6IDfj0Unw=; b=B2iOOnCvR9GQ/UOAiJc8uDFOce
	bn7lgapDd+H7tAyI3gq2cysWGt3hGvYzHSCOYb769tbkILhk1ekj114aiKRSrD8mkNci5Uob8ZVwg
	26SSu3adQkw+479BdoYlrUcHxEzmz9viCSKHk0b8M/WQ6zGf41a5L4qlzFcK12ElFEcL+h6tXGYtF
	QRFzaYsNlz+B+nqBB5jvJxFAl2LzBroozOmxZTlu95Wam6YJDy4DCj2jbjvaqGcnXb/ckJkquuyvF
	bJfqqipN1I221SbGcsdPTMacAdeBWEWtM24iGxbSFrFW1C6wGc3MknpEEgxkP9+spm3sAkczqK5Rj
	XkwGw+0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1AAo-0000000AZrh-3vf1;
	Mon, 31 Aug 2026 22:08:15 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1AAm-0000000AZqy-13rY
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 22:08:13 +0000
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-7f4d4d0749dso479371a34.1
        for <linux-nvme@lists.infradead.org>; Mon, 31 Aug 2026 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788214090; x=1788818890; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVaP7reUlLXYTaWyms8a2Quq5+138mi3Pm6IDfj0Unw=;
        b=Ts15vcQiZL1MSpGG3sq1hCso3SeNUY4LzVyrYKg3xZulmqOXxn6gNbF+QTJqiAG///
         RvzzfUkSTw5VLsI8I34AufU0VfwkYuwyn4sr30e1B92hgVBStM4f7PAAM0LrwCKoqiS5
         KLfSPV86Z0QHMjB+97ikHXxK0HXQLbWCQcssOBSK/lg6AApeX93kRmSLRz5rCTt9J3S1
         l0l39KCUrySTamyZde3twiyAyC++ZYgPytMnV0FeYfF+8MRH7GZYiV1OwdLwuAHK+a7u
         ipd+J56anqQ1IAIqSHTgKtHk4NJ3vWazPg4MAsX1BipkmJ64wEUhOCvTAbAG3xarCNA8
         LitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788214090; x=1788818890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PVaP7reUlLXYTaWyms8a2Quq5+138mi3Pm6IDfj0Unw=;
        b=VHbMVKR03tY+3KJOtVDADIm46D6nloZBTNLlYxx2fcGXhREQX212gpEyUzC0PFlO3p
         rLoREk3ChFRPeJH6OQLGYEZoOazI2woXWSAuV9eLorpVCYFftO/qFBhjQid6m4ZhQjkt
         KLSL7mC5Lj6cNZVon1CLutg6V8d7Z+lH1pfBv10Xkkbpy7LOVOfyvy/VwpFlv80an785
         OEo5wRugQGIxf2saB6W8C70Egzj9kGCdRbK4CmaSNly18KUdT8TOo0hBrUhsemUertb4
         z7700nyMht9M/9ffXFYFJNDzgZEgHpfn/nEZIgzVwn4IV2JE9f2O8cI6gtduT7H4Fw2I
         cIyg==
X-Forwarded-Encrypted: i=1; AHgh+RoKZ9eEkxmj8OcDtHlcXzETo0LSxWbfRdnDCnznoanm88KY2xCz+FjO6JLFoX/R9ObiybrqhFOQ5yPK@lists.infradead.org
X-Gm-Message-State: AFuF++lfoCFW+FnHDFBp5eyYYodqAgZvjOsQLyhdWyF4FxbGJwsfjDYA
	D4BEGNGHERQPG7bRnr2gEJ/FI/r3Jhr0ah0B0hY30Wvg8v6XZvQDZ7OcYitEYxtRfCU=
X-Gm-Gg: AR+sD10lpaPkiQueG7vPkYORMllnViEOjbmW+32f0CBD6kIBp+Pn43hbFtMEHAT99gp
	Eyn62bqEAHR2kw3vHiXR1Zu3zyKfFZVkzfLF5shoJvX4hLaZbfN1YJaEV1i3OH2gnF63V8lCHg2
	mU5d8A6NsfoorUS1EpgwjDh5G71lk1vDUr6ChzBzapCNfGoSrKPk6wmZUNnM9yP9QnT25dXtphW
	LyoJTVq7mOt+hNkCjlFDe4y23iGtLS+te9nothy1+mNLVXqCAQnkMyqiGLisrexyaR9ZWVGvsQ9
	NgBIJOqafN03amY/IoJ18mUj3m1D0FPCs+2QrQBJXsq3KmLeHXZd8pRrI2xuvB4JowJlezubI+u
	ghQgvzTdYfAmFpyQ+Y2ziNB+wsHXV96cXbK+aRZZdanu1IlHA14cbDc9ifSvBFiTkuROR0kvnTe
	IiE7iH8I6VwCLJr0KnsCB1oh4/mhYaLF7SCvuTf8R8an4d8T+LyLGTZB9gyfzc+FYyoXfxHXH6H
	N5o1HZY3CPEJDvZYQ==
X-Received: by 2002:a05:6830:6617:b0:7f4:37a9:6df9 with SMTP id 46e09a7af769-7f4f1f8a280mr18603246a34.0.1788214090149;
        Mon, 31 Aug 2026 15:08:10 -0700 (PDT)
Received: from dev-cachen2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7f4fa7ec582sm9294828a34.9.2026.08.31.15.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 15:08:09 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: sagi@grimberg.me
Cc: leon@kernel.org,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	axboe@kernel.dk,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-rdma: fix ib_device removal race that hangs PCI unbind
Date: Mon, 31 Aug 2026 16:07:54 -0600
Message-Id: <20260831220754.1714514-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1ad637b8-3727-4d60-9086-b213e61ae872@grimberg.me>
References: <20260806211822.317074-1-cachen@purestorage.com> <20260828232436.270184-1-cachen@purestorage.com> <0d9ea3ed-b164-4f99-8484-87041ddffaa6@grimberg.me> <1ad637b8-3727-4d60-9086-b213e61ae872@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_150812_459985_FBA2F8CA 
X-CRM114-Status: GOOD (  26.18  )
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

On 31/08/2026 0:15, Sagi Grimberg wrote:
> Why not instead of this, simply do in nvme_rdma_setup_ctrl:
>
> +       if (nvme_rdma_device_dying(ctrl->device->dev)) {
> +               nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
> +               goto destroy_io;
> +       }
> +
>          nvme_start_ctrl(&ctrl->ctrl);
>          return 0;

I like that this reuses the existing error path, but I do not think it
closes the race. nvme_rdma_setup_ctrl() returns before
nvme_rdma_create_ctrl() takes nvme_rdma_ctrl_mutex and publishes, so the
test and the publish are not atomic with respect to the walk:

  Thread A (connect)                  Thread B (nvme_rdma_remove_one)
  ----------------------------------  ----------------------------------
  nvme_rdma_setup_ctrl()
    admin + IO queues up, LIVE
    device_dying() -> false
                                      mark device
                                      lock nvme_rdma_ctrl_mutex
                                      walk nvme_rdma_ctrl_list  (A absent)
                                      unlock
                                      flush_workqueue()
    nvme_start_ctrl()
    return 0
  nvme_rdma_create_ctrl()
    lock nvme_rdma_ctrl_mutex
    list_add_tail(&ctrl->list, ...)   <-- published after the walk
    unlock

A's controller is now on nvme_rdma_ctrl_list, nvme_rdma_remove_one() has
already finished and will not run again for this device, so nothing ever
deletes it. Its rdma_cm_ids keep the cma_device reference and
cma_remove_one() waits on it forever - the hang this patch is fixing.

> I cannot see why this additional list with a dedicated struct is needed?

Only to give that test state it may legally read. It has to run under
nvme_rdma_ctrl_mutex, and ->dying is guarded by device_list_mutex -
reading it there is what Leon objected to in v1:

  "The write to ->dying is protected by &device_list_mutex, whereas this
   path relies on &nvme_rdma_ctrl_mutex."

So the list is simply "which ib_devices are being removed", keyed on the
ib_device and guarded by nvme_rdma_ctrl_mutex. To be clear, it is not
what Leon suggested - he proposed moving the ndev off device_list, which
removes ->dying from nvme_rdma_find_get_device() but not from the
publish path, and he said as much ("at least in this path").

The list is not the only way to get that. Alternatives, in increasing
order of how much I like them:

1. A second bool on nvme_rdma_device, guarded by nvme_rdma_ctrl_mutex
   and set in the same section as the walk. Drops the list and the
   struct. Needs nvme_rdma_remove_one() to hold nvme_rdma_dev_get()
   across the callback so every racing connect tests the same ndev.

2. Read ->dying under device_list_mutex nested inside
   nvme_rdma_ctrl_mutex. One flag, no list. I would rather not:
   nvme_rdma_remove_one() already takes those two locks in the opposite
   order (sequentially, not nested), so this plants an ABBA trap for
   whoever tightens that function next.

3. Use client_data as a per-ib_device liveness token: an ->add that does
   ib_set_client_data(ib_device, &nvme_rdma_ib_client, ib_device),
   nvme_rdma_remove_one() clearing it first thing, and both
   nvme_rdma_find_get_device() and nvme_rdma_create_ctrl() testing
   ib_get_client_data() == NULL. No flag, no list, no struct, no pin,
   nothing to reset on re-probe, and ->add cannot fail because the token
   needs no allocation.

(3) also closes a window none of the others do, and which v2 leaves open
by its own admission: once nvme_rdma_remove_one() has returned, ->dying
is gone with the freed ndev, and a connect arriving before
cma_remove_one() unlinks the cma_device can still strand a controller.
remove_client_context() erases client_data after ->remove returns, so
the token stays NULL and that path is refused too.

The catch is that ib_get_client_data()'s kernel-doc says it "can only be
called while the client is registered to the device, once the ib_client
remove() callback returns this cannot be called", and (3) calls it
precisely to detect that state. It works - it is a bare xa_load() and
xa_erase() runs after ->remove - but it is outside what the API
documents. Leon, do you have an opinion on whether that is acceptable,
or whether ib_core should grow something explicit for it?

v3 follows doing (3). It is smaller than v2 (+29, no deletions) and
drops ->dying, the list and the struct, so it should address both of
your comments and Leon's. If the client_data use is not acceptable I
will respin as (1), which keeps everything inside nvme_rdma at the cost
of one bool and a kref held across the callback.

Two side effects of adding ->add that are worth naming:

 - A device with !kverbs_provider never gets ->add at all
   (add_client_context() returns early), so nvme_rdma now refuses it in
   nvme_rdma_find_get_device() rather than failing later when the QP is
   created. nvme_rdma cannot use such a device either way.

 - Clients are added FIFO, and rdma_cm registers before nvme_rdma, so
   during ib_register_device() cma_add_one() runs before
   nvme_rdma_add_one(). A connect resolving in that gap is refused with
   -ECONNREFUSED until ->add has run. It is self correcting on retry,
   but it is a real transient at probe time.

