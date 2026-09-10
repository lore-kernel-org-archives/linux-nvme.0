Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36882C79FB7
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 01:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U50mXAKZslWPGncMaFFrnOpXADVR0A7auDu2s/EoAcE=; b=Y0YapA9RleVafBmt6wYRQOuA3T
	AwbMJM42eqa0xoQxW4bglSTIICYeNF32eGM1Qk3xuBhu1hJ5KtJx/3jJQIn/72vsO5dI45FiNK6pH
	2rmNg39vAQyJFjzF+mSRXeAkgVVCMe9KJ3CkfVN/+9KQUwk5P5GUFEbIXJ4P6IS4dSv6UXTcXwR7P
	DS7WeGnj36ed9MmSxGtCO5vC0/0PlH2d0KTKkprBtI53p/+pHBBkwulbK2aAE5fye5B/lzRCu+5RY
	BMBv5NJhk0Y7/BX+ls3GzHCNjDvCp2p/NPl+evQNZ5KxvJuzkBP3B6fXSUVLUqc7ODKRNij5kvz0w
	iMRk5PvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4U0J-0000000DDfe-07gU;
	Thu, 10 Sep 2026 01:55:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4U0H-0000000DDfY-1Tk2
	for linux-nvme@bombadil.infradead.org;
	Thu, 10 Sep 2026 01:55:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=U50mXAKZslWPGncMaFFrnOpXADVR0A7auDu2s/EoAcE=; b=o6hyNJLZENs93Kv3hHqhkFTwZe
	alQSKRmXvFHDwV/T6/UFRCPn7grbud8xuAYqOSSgq0zhUXXV4MNQw7MOP/PNjMtkblOYVY4DtykOw
	55ACT0Zx6OvVAAqhuwQjYIjhMrLTKsYjdOXQyDhsTwWtUVeSEOa/TcrBv5OcFAO0jCViVBJSq+RXa
	+m6lRbyBZAohWn9kqDkB+HUWPrrQeDgDi5HSMZRMdfRZsqH8+y8TWrQnY/2c/MjYFaB6pViH2OiaV
	viLPnIhPO94K0AH2RKYrZIMWrcb2FBrjJ147ro0dhcv3MuRVg7MuMSCpckjdmMIE0TCzIQfrO/sOg
	vWmbwyiA==;
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4U0D-00000001tS7-3vIl
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 01:55:03 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso7262940a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 18:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1789005299; x=1789610099; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U50mXAKZslWPGncMaFFrnOpXADVR0A7auDu2s/EoAcE=;
        b=RFNnWoBH0AkF/kzme2rlIHpSZk1pm8FCBJafPhabDOvcoNEDWDP6ibYFl4L9r5tUlB
         WlXupatt5BShvAEimkz9eVnJ/0o8BDQzZ3XF2oWLjYnIhg7Dmjbh9fxMDsmjUBcnv/ao
         wAZ5GQdY0Elg0szgvX+VxEz+LLfUeB+kzaHlSbeZC6mwe2pbgdZqrmT7ykqLU2FdRRRd
         XSX65ixPvu7hFEf4hoNLGrf5k0qP6lkc20pHlCP3OStHkgyOkA1rkVeE76Evo3FZ+PZI
         wwiGHQkM+vJULnPF9n1tU7n8N9ufJDxdrOGOTH/dQ4zyWyWwb+wQUBogAmXZZnR/xLd4
         ek+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789005299; x=1789610099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U50mXAKZslWPGncMaFFrnOpXADVR0A7auDu2s/EoAcE=;
        b=X2Nb3sU62kmSIsn11TijapWR+xjH9w2mOv0o56T2izlWpp/SXB+0D1cM3crMfXCoM0
         6Rlq+uK7wC1xUJ5HJo823tf4S9Ccl2gI9sls6dyAfp2OEfoe/FEMTOyqQI+XEhzX3gRg
         XXF+GiVUDmT0ojIDQrhPOvbn4J/gCFy2rp4dpwsMWy8vUrYhv1EJRBVzZm86S4gftLuc
         LA6dHlcFYCSUtEqay81OA0NtNuKkRNH7NmsExbt+cKolsDcDD6NZK92E9amt9SiZpnkr
         V6I8GbXnf87A0xuYnk4XxoKlRp/UMxmmFFD2bOtRrTERhRnj4JNRFE/e+JAyCFRmLfd8
         9e5g==
X-Forwarded-Encrypted: i=1; AKwUvBw+JFlJLmOntZbX16ISC5B4WyY4zUnLBsTjf3rHTWFXvHfClhTEpNay356jJvCei41V8fG+HdHW0C7D@lists.infradead.org
X-Gm-Message-State: AFuF++m8AigPunLqHWkgEQUkCMbzoYFPSkYzHoq+Y8gP3KddRc0WXT6X
	VM3vJDJi0QaRuhWRnk51VGWmSkGHZJ9eoklpuKW+5xaD/IGpDRKwVL/r55S46LkVz2o=
X-Gm-Gg: AYBFou1SdeTfeMa96jaN9jXHj0O3tkB6SRqGpAMBJdE7JPBc8Ute5pPx/YoJwYJL/jn
	+b9B7NaQTopfOHg3Jh5wPyqcjsGLGbBO2hYUTUpV6rUb+eEqxg31ztG7ltBemZlr6297Yk2UHRO
	s1WDb551lEdxKlOODtO3Vo7ifp7FpyX6UN/drcXb12JjSq3ZHz1FyXyfJFJ9m1fZO9PBug1G+x1
	Q3iipRgnKl+HzYGwgX1LY3TxGSvv2P2MxdLpaqRbna7s4UgjBt56Lx73u0mz0tDbgzxXUWGnP61
	aFKghBPSLVTzsILy31DSWVnC0XxxcjYBwtcrL01M2dYXjXmoR6A849Txvs7VmOwMwv+txwxRc2H
	DXvM5uk1xX4hsTBiD8zJzBwn+3rjECABfdMtyqMPMR9ZrIgNd9/CHxZqhgddA6MFvEuUPrMFn9L
	9A5k5o54yItS2O00GLcGRcARWNjxEsKosS0dz+Egw1a+j4p7bIen4lSpa1IbIY1jXATy9G9nakr
	l2klZ6gNLXbLc5fD6tHhqKPnHp2eVHKmzvi091om9SVm9iz
X-Received: by 2002:a17:90b:3c42:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-39b260d2977mr56616781a91.4.1789005299313;
        Wed, 09 Sep 2026 18:54:59 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:4ca7:3a29:2409:820c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1434bb7d71fsm16129763c88.15.2026.09.09.18.54.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:54:58 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sj@kernel.org,
	saravanand@crusoe.ai
Subject: Re: [PATCH] nvme-multipath: add fail_io_now sysfs attribute to fail queued I/O
Date: Wed,  9 Sep 2026 18:54:57 -0700
Message-ID: <20260910015457.77845-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <84112f53-5c05-46ca-97d0-550565fb941c@linux.ibm.com>
References: <20260904032605.65758-1-kiyer@crusoe.ai> <84112f53-5c05-46ca-97d0-550565fb941c@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_025502_183450_8C3FDD7E 
X-CRM114-Status: GOOD (  16.64  )
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

On 9/7/26 6:15 AM, Nilay Shroff wrote:

> Does the intention here is to force I/O to fail irrespective of the
> controller state, or the intention here's to fail I/O only when no
> usable path exist? If it's latter then I believe this is not the right
> place to enforce this policy as since this check makes nvme_available_path()
> return false unconditionally when NVME_NSHEAD_FAIL_IO_NOW is set, without
> considering whether a usable path exists.

The latter. nvme_available_path() is only called once nvme_find_path()
has come up empty, so the flag only decides whether pathless I/O is
queued (default) or failed.

Agreed on the rename. For v2 I'll make fail_if_no_path a plain
per-namespace policy: admin-set, no self-clearing, toggleable at any
time including mid-outage.

> This attribute should be only exposed for fabric controller.
> It looks this is being exported for non-fabric controller
> as well. Moreover, I like attribute fail_if_no_path better
> than fail_io_now, since it describes the actual policy being
> enabled: when no usable path exists, fail I/O instead of
> queueing it.

Right, v1 exposes it everywhere. Since v2 makes this a plain
fail_if_no_path policy though, is fabric-only still what you'd want?
The queue-vs-fail choice isn't fabric-specific: a PCIe head kept
alive by delayed_removal_secs parks pathless I/O the same way, and
dm's fail_if_no_path is transport-agnostic. If you'd still prefer
fabric-only, I'll have the visibility callback check a sibling for
NVME_F_FABRICS under head->srcu.

> This patch appears to be based off older kernel branch. Please
> rebase it against the nvme-7.3 branch.

Will do; v2 will be based on nvme-7.3.

Thanks for the review. Unless there are further comments, v2 will
have the fail_if_no_path rename with the persistent semantics above,
visibility per your call on the PCIe question, the nvme-7.3 rebase,
and the fast_io_fail_tmo rationale from Sagi's branch of the thread
folded into the commit message.

Thanks,
Krishna

