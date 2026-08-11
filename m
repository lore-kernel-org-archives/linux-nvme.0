Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0670C5AC67
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 20:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Od64kOXlsBw7l33MxioNZlnpLtczMNN+mPBlqshAfSg=; b=x5v/64gVXJxT7PlZjQja33rQFg
	zDD6WK9fq5wwszpI35T6VXy/CPxGwJsSTGHPgylUFaBQFQXRjkNFdSGYrIIIXVKoBbzWZ16fifXM8
	4tBxRt65R3PgARFQG7sNhQDIhIzlsEU3fwL1K6egMiXIYRhJIKFYvS03xbc20MsOX5637yKtyiUA6
	/A8Bo9lLzPAF62RX+ygCXwo0oAooPSeaeiBD0Lv3NIXxpGbcZT5gO3TADebIsq1FPr5LDolHvKn1V
	84zUqdf2sBpa0uHwRqcREufsAhgi5mnUO0elsu7qgQDWyFpzL6j1t0RmQdHu3Fo/qkfgdgf6ov1Q2
	3/Wz9TgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtt6t-0000000EvXT-2Xm0;
	Tue, 11 Aug 2026 20:30:07 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtt6r-0000000EvWW-1MNW
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 20:30:06 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6a157f90752so410732a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2026 13:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786480203; cv=none;
        d=google.com; s=arc-20260327;
        b=P1x3nX5chATG6sZXpz00veYFzaHhf9Aq9hPYDm0BCPxDzVhAsvYi6a9SfRu1Co7leg
         +owWn+xsiRZbH0BBjtrDUbazhd+RR72NJjprivw/9jn0bcKlCAcTaTA8dqImRTcEGPwQ
         7uLswxy3CRuRuQUzO9KJS1VEFt6KO7bTGdZldbZwbd9Z7K3F0odgnz9yfZ8zrcGJLrlM
         RWPzCrfmglCA7DU9VMO4/O4r/Wvr4J5dGKxau1PfMaduDX7TQJK4DnAZ/njC53qowbTd
         gsdoeZ58txevkIoTz23poKP0dab6pfseEjOBvYmgx8dJqdiVmhJK6cgpO8XhoxSxvBll
         Gbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Od64kOXlsBw7l33MxioNZlnpLtczMNN+mPBlqshAfSg=;
        fh=Ht7AdHjqIA3rG/Qv2kfJCSTUJLGjPtXho56FqL17hOo=;
        b=d9FoDCkioPuVBTes3UqIerYqx4RUfFMh96gVsh0ja8Z0bmva/IKSGnoEV1/3dQJ6hg
         OEWfyW9g3YeFOdwF/keLncsUSLFdPxp4DAID6qOeoBok+CviAhV7kCdrxnbIFCCS+Plm
         Q/vz+8SU0fosxXEvpVdMUsJVtXPI+d+9IYPjtjIw4K/FoK8A84SIRy8rlgwtb3VyLe0J
         bNlal8zcGNYkH+Ff4xqRD174Q/WqRYCn0W+uBV9/ssrZVPOzDMGY1tvV3iJCWpXtVlhr
         c04rbm/HVlQxMqlD2KQ929J3V+3cjICBjNj80ipUqC/OEIfMTZB11prQShNcdo1aajeS
         HKMQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786480203; x=1787085003; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Od64kOXlsBw7l33MxioNZlnpLtczMNN+mPBlqshAfSg=;
        b=Tb/HwXM8mV2WOjJdYIOiGBI23nptxl9GoRtX8PpBxJRRczOftLHis0V7dAF4oXUhb1
         T4rQDM0fPLBjoM1zp2lAjcMUzrxoNgFB64YU+fcAwuoC6VzUSSmV1FEk6Jj7ryT7NpkJ
         t7n/RLA7vbEnVXkBwzKFsIkpPjsiCC5x9nvCQctZnEnQubeYdkW98G2NwFcWtdslXON8
         CM8MsnDH6n6AhfKQKtlAg0ZJlulCeTI2cMeIXOgMsi/E38Eu66xD/3NIPShq8bwIVSER
         KBU7eLDJywhA8P2Na2DeWA57yPU5I5QPtsfCyP5xdSxArRV7OsDFrVVfPMg/7Y+9VNX8
         8P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786480203; x=1787085003;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Od64kOXlsBw7l33MxioNZlnpLtczMNN+mPBlqshAfSg=;
        b=TES7N5wqSkj8+PMg/zc/iGWnB/r84D6RjMUsr0pqNC+VZJiI/6BXsNBFJv6ptMJ0o+
         LsHto8sVu9jC1APRPiRaeJM/D8rQz4ar+AhQTCIpq9jvlRXRxfkCSDx22fpfmNyWJDMO
         F+vR28WaMB7hWpnN4UG/Zi1jEAensSBBGXYRxvqFD23vNbONReNXlkIZXc2ieozYmp+7
         LgoS3EHETZFzcEhOWcRoe3+OJ84PHeHTdS1tj07UwCq6tw4ZDuD7SejqY32sG4yOgFDs
         4Osm31K3g9FZpTNz5QZFeYu+cXMLPcR6QyGbxIzIiPWuimwP41orQRqjfmKxBdK9C8vY
         T7dw==
X-Forwarded-Encrypted: i=1; AHgh+Rqnja0ajHgfoDq7f1k+pBvNmgP7M+XyL4nav1/kb163E7fUVNUHxMt1SKtD8dd2u+uaukRmmcpbpY1r@lists.infradead.org
X-Gm-Message-State: AOJu0YwDMVs4SuECRgqGcOyX7Fv2+/UUVTijp7D3ZM3apNif0wihPezJ
	zp1CKleaQt8fshHcMUvX4Xt1fDLUfQgOdPm/+fme+7di2P+3CWXQpFAqlpdjlWJ9Q51yGITQ7dN
	FhDgimoqr2mXJFoJc/h+31/bRgfz/ST8=
X-Gm-Gg: AR+sD129Cy16AdC602SiWRGMnqK5u7qawfP7dvPAyApprhfXOXFYrXhrLf8B1TZaEFP
	uvOZNnq4f0WyrHmMpZSFWKZMSRB8a220W9T9Snyz7W2TH0BZDulnUiu+OJtulT2wfoSTNWCNL2v
	uj+YSqWaWBPLUnHvab9LOD4hETODiF81kR1126auBcqXjSL6W3nq4HBcGT/IytGiAWvjnNvO2ma
	b3l/O2bitW6mO+tftpIn5YBHLCPuVZz+qISwov7G3W83+MwWEvwATzqmpHDVTJKbFqPXpFhd70U
	6ByZdmfyjtx6QZXpxah6NyolKSS2kmaWlt9ZeL3s+o6q
X-Received: by 2002:a05:6402:c43:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6a36448b12emr3342728a12.5.1786480203030; Tue, 11 Aug 2026
 13:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260811192111.2058140-1-coshi036@gmail.com> <ant4bioGLl4B35n_@kbusch-mbp>
In-Reply-To: <ant4bioGLl4B35n_@kbusch-mbp>
From: Chris S <coshi036@gmail.com>
Date: Tue, 11 Aug 2026 16:29:51 -0400
X-Gm-Features: AUfX_mx5rnEmlFvuiMPBF-UBljjUMrJ0w3-4yrHSeb9aLUfcWEhgJ5oe1jx6xO8
Message-ID: <CACd_6n1=oS_Jdq6s=u2jNmtP9n0Yc13BkKqJHSpsjbWHy=X5cA@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme: refuse an unsolicited format change on a
 namespace that is in use
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Weidong Zhu <weizhu@fiu.edu>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_133005_384834_0DB31C99 
X-CRM114-Status: GOOD (  13.30  )
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

On Tue, Aug 11, 2026 at 01:30:54PM -0600, Keith Busch wrote:
> Refusing to acknowledge the new format doesn't mean you get to continue
> using the old format. You're going to corrupt memory and data this way.

You're right - the teardown is the problem, not the refusal.

nvme_ns_remove() never sets GD_DEAD, so del_gendisk() takes the
non-surprise path and asks the filesystem to write back.  Those bios
go through nvme_setup_rw() with the stale lba_shift.  set_capacity(0)
doesn't catch them on a partition, which keeps its own bd_nr_sectors.

So it should mark the disk dead first and drop the cache instead:

        blk_mark_disk_dead(ns->disk);
        ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;

Multipath needs more than that - the openers are on head->disk, and
only the path gets removed.

Is that the direction, or is refuse-and-remove wrong here to begin
with?

Best,
Chao

