Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9448C79F91
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2026 04:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lSK+ygaN89Qf8NuWacdgk2BCoJ6BxY5UTHSSSwk++Nc=; b=PJ72vLKNv78Ls5e4sQUGk4x0a6
	e1iyEQOmhw5KM5wqvz3Sy0v60d3EVwpqYG65or8hh5eTExbSpOS/rf+spErtSv3b2uxnQFQCPvpo4
	YzkLEjioApI+q9n91YCAmF8nPAldW4aTOdprYxmyR+E76ntuuZOhmFPfG7uiUyMd1vdRmed1F3cvc
	abZtnVM7FaR0ad+CubU2pQ4FIcaWhMLEcWI7K0ZtWQknDoBRqxmRAjrlRoe8JlLp01QwWWLrAtNU6
	ZM3aVTVKH609pF5tKfTS0Mq49z6VbGL4BzPKQ8plZ0eCDvNT0OpQKkUPUPHANWw93Z8F6q/n+nYxJ
	v/J9iXlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x34Ow-00000004fvv-2DdA;
	Sun, 06 Sep 2026 04:22:42 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x34Ot-00000004fvL-345Z
	for linux-nvme@lists.infradead.org;
	Sun, 06 Sep 2026 04:22:40 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so2029343a12.0
        for <linux-nvme@lists.infradead.org>; Sat, 05 Sep 2026 21:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788668558; x=1789273358; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lSK+ygaN89Qf8NuWacdgk2BCoJ6BxY5UTHSSSwk++Nc=;
        b=QNW6uMUY/9tTljoNEl2dEuLiqPzgSpvGZ6ca4wIKE082ZUcow+Ni64LuiKAh6vm3yI
         783OMM/EVU9QHJrBWHa+4JhSHCQ6qOiNZ+mw/+W0CkC4h8EF57gq9uQ1gAOat68/TPWH
         oYSSU1SoMaOyAiQRqBmPH3c/cLCEn3BROlSC3iGpQ/nmK62n0KfLNudMTMRKf1tK9CkO
         jpCUEUOI73/j/in96R8uBK2KsruUgshwZtNKo9VmsajcoscD/rVLaZmSv+Qa/MLLKvvS
         FhKays9jzyoHojHN/X7XLA6y3+cwKkLJYsx/4tUEmMUbXWpRK92sjV8NrtYgAdV29Z2G
         W1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788668558; x=1789273358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lSK+ygaN89Qf8NuWacdgk2BCoJ6BxY5UTHSSSwk++Nc=;
        b=IFmWidhku2+cJ0mYPvZ+ft1wPInWMNjLRCWq8UTzGX9XZf/izouS0YBlfVmTVmmyhk
         CRb/6rQRuqWqUajRprHuqedlHovrHua/35GXwejYahktLk+Gxqin+rsdRJQ9JYICO8Ct
         0Ps2g1ZFnMo1Px6W5DuB/0bZ8ccFJM2Qg4vxvCykVQWH0/yAamGRlXsL1M9jHiTV8gCO
         zIUQowMBVoiFpMA7co001SiDMNh+wFTbXGTsyO6v5+/jXu5KSUDAJmLoUpwgDuvJxs7l
         iGCDVE0KR9TtFLwDkeIjCNA8Kh7ChDoO7YMpt7hwqkX530Xk+nqNPApj0kPkZrY4Cg1e
         Vs7A==
X-Forwarded-Encrypted: i=1; AKwUvBx45C7Kxp1WM3pqYbWzzRDtQZdyAw/qVloanG9Hj0ej0rowlIfNyMigRHaPTeHhBZulul2Gk/N8HSbM@lists.infradead.org
X-Gm-Message-State: AFuF++n/Db1r0Vytb4hjE2vXcnYFvzPR/c9g1M64rqS0EcDBqYOr7RaU
	Hgu5m7D52hiPm65nVkiN+Z0qaJn4ySNEZ93kFrGn63Uz68X0zMb2OjkDPgW8TFH9j4s=
X-Gm-Gg: AYBFou0NJNFR0k6rfgWqyFWzv60ZpASRyJg1L7d1d7tdn3yKHSo8dyNFpARMPpD0MPJ
	OpapsxDvl368m5IdFL1AeoXgDiWYscztcwYKukpgu0C+x53jboRHq+kuMW2UWgs5KuHcEtHYJR/
	s0BNTfxYeTVmj6p8AwbJ2Y1+VuIn+5GIqFqjgIFx2MTUGezm6GCzrMlAoKnlsTIVxfV/2ma4LNQ
	Wh7bxDXegFGESDvIXShkqeo6AsBXChwMFpmVMxwLm0xx8HZjxvOqqD1mtmYO7Cv2DXI/XEhtGWq
	Z0bjklwwgYX8LAgNa2uPEkVvj5fOWqp+Vaz3GMoynooFXFfi0WnA3dYTFW6Zb7FdgAQAYHLsYqY
	aNtpklBgcbv0lO2Pgx6Efibyw8C7mCdQsadbsLrKf96PRrVjBrkZEBY2XBlu9/qak9Gu42R9AMl
	rfoJPn9UJz6DlGH7fTVeS3evRLcX6I7CEADpJUI777Mo+IBhXetyhXU532y8p5RdvPCkF6cZ29e
	ivWT3LIRn9/fhiOgeubNZKxLewlU1EyVnhSNQ==
X-Received: by 2002:a05:6a20:244a:b0:3cd:9f0b:f788 with SMTP id adf61e73a8af0-3da39d12327mr22845565637.12.1788668557997;
        Sat, 05 Sep 2026 21:22:37 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:c4e1:d17f:f4c5:c097])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm17316962eec.9.2026.09.05.21.22.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 21:22:37 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: sagi@grimberg.me
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sj@kernel.org,
	saravanand@crusoe.ai,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: Re: [PATCH] nvme-multipath: add fail_io_now sysfs attribute to fail queued I/O
Date: Sat,  5 Sep 2026 21:22:35 -0700
Message-ID: <20260906042235.71778-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <6b8ff0b7-c606-471d-b3be-12df3dac350b@grimberg.me>
References: <20260904032605.65758-1-kiyer@crusoe.ai> <6b8ff0b7-c606-471d-b3be-12df3dac350b@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_212239_788807_1D16AFAF 
X-CRM114-Status: GOOD (  15.85  )
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

On 06/09/2026 1:36, Sagi Grimberg wrote:
> I don't understand what is not sufficient with fast_io_fail_tmo? It would
> determine the time that IO will fail when all paths are down.

Thanks for taking a look, Sagi. fast_io_fail_tmo is indeed the closest
existing knob. Like this patch, it fails the parked I/O without
touching controller state. Three things make it unsuitable for this
case though:

1. It cannot be engaged after the fact. nvme_start_failfast_work() has
a single call site, the RESETTING -> CONNECTING transition in
nvme_change_ctrl_state(), and it returns without scheduling if
fast_io_fail_tmo is -1 at that instant. A controller in the reconnect
loop stays in CONNECTING, and the sysfs store only updates opts, so
once an outage has begun with failfast disabled there is no way to
make the timer fire for that outage. That is exactly the situation in
which the need for this arises.

2. It decides based on time, and this decision is not about time. For
deployments like ours the right policy for an outage of any length is
to keep queueing; that is why we connect with ctrl_loss_tmo=-1 to
begin with. The exception is not "the outage got long" but "this
particular submitter was just killed and will never consume its
completions", which host software learns at a moment no timer can
anticipate. Any timeout short enough to release such I/O promptly
would also fail I/O for every healthy workload whenever an ordinary
outage outlasts it.

3. It is scoped to the controller. FAILFAST_EXPIRED marks the whole
controller, so with all paths down it releases I/O for every namespace
in the subsystem. The process being reaped owns exactly one namespace;
the others belong to VMs that are still running and should keep
queueing until the fabric heals.

So fail_io_now is the failfast expiry made available on demand and per
namespace: the same nvme_available_path() mechanism, and it likewise
clears itself on reconnect, but it is triggered by the admin, for one
volume, at the moment it is actually needed.

Happy to work any of this into the changelog if that would help.

Thanks,
Krishna

