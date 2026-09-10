Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99808C79F9F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+sfjOHgzJyP82fsYeXuHc6zDgfl2ZB0n08E7UBdDAA8=; b=wsQERQyOhEkVKshkAvVzvsfJf5
	TT09jsD0PY8tNyHamHdcC/OEHlTuQU9G6g5swEtXBg4YujgV6rE8FPppfO2lThLzP+QcxqbfX12aA
	4m17WPYwbJ4/r74d1KThuu2mPuAbriRwOjVOneKnfTpB7Vdk8Ox3wTivenhhRWa3DKJPBxzK7OOCA
	3u7zwAJklOb1zKm+t4eCzPCeUQnSpaxm746rQlJRPBsF003P+jOT0629dpwDcjlHjyGsptV9d7gxv
	+cBipz+KN2uj2CrmDQxnm16A9HRw90CIhcyi07uGS4q3PMHJH5DLDbH8IkRI/WqTtHEpa+vmwmBAX
	qD/NTlMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4iLS-0000000F2og-0l1n;
	Thu, 10 Sep 2026 17:13:54 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4iLP-0000000F2o1-334H
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 17:13:53 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2d944747d41so82531125ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 10 Sep 2026 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1789060430; x=1789665230; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+sfjOHgzJyP82fsYeXuHc6zDgfl2ZB0n08E7UBdDAA8=;
        b=Ttmv47VyHcb/w1p8HlmG+yRcvxo1TfyQEuYLUebIxtE/gVY9CwVMHK1Pwvv+hxnGFE
         pRwz3wyLETIwk+CUFJWgusaRC/tdukZ47Ydg0++JIlNudpdhJK/TbcjVjDi5gTJCkny7
         P0xOczUsVwjoaLCGaBn27HzwxAYA+77naBy7/yKP9eXjJuq5ph5wQABNXg7zqGnaZEra
         5cPUw6scz419Y3jEOhYKlWnbBo0E7xNGlP/Q15k2gsCw0VIf5MEMo27z1/P5kGuVinoi
         Zcf82A4fYIBPFoTaq/lC1BjxRcB57cJkJpdFgO7UK7k0mNe3DXMjBTfO2FbhjxDw3t9E
         pWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060430; x=1789665230;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+sfjOHgzJyP82fsYeXuHc6zDgfl2ZB0n08E7UBdDAA8=;
        b=DA4W3A49tLZxBLYglskksbreh8j1qC/MqI8/kvlRODV2HQ6K4SxsPrtRfxNe9mEHk+
         1Y9f9MLp453K71sNwL5Vid7FNuPWEhQ6Vs5MFiqH5ck2G7TIpOzISEVqknsFvW/DyvyN
         I947pQXOG6X9dUcr2+AgPlNCBzaqJ7z20QMBAsbBtnXtve/nsvNyP9YtGocAI+MTSyAo
         17BCgC5y41oFMS2/Z4PK+2j4chWQbkbuitWL6B9TBIoG8bjfglYEpnqNDPLXhVaW3U1j
         ysnU/FE6fWZ8wccBW9kZ8wdQG8frv9xI8sf/1pOigj1Zj84tk6bUaok7FlCWaQ2lsZsG
         pyxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPkEAS9ci8WG711cq0QFt4imZFe5ml1ZDMxdBdibV0s9QhQwhqfyIBXTj9FFsictckukgWB81cG7Ux@lists.infradead.org
X-Gm-Message-State: AFuF++kTsXljaB+16czp7kTAnbhnW6ZJR113hYgvdk02z0keMiXJxm9u
	jwB3FWQ8mmWNXY63lxc2a9hV+4jxeoz0ie3SwLx/UGtovDSfIYmNc5ySgy7UO/CqgYtoRC/V/IR
	NbBFrIG0=
X-Gm-Gg: AYBFou3MRTiJIMwyOBnLDMHNiA7CTJw7Lu0aV+F5XE+YmhqUbuc/xWMQBrVvkTjMcP+
	cEY+jSfZEf+tF9FGxrCmjNZAuQChqqUAquhW38XXmpojzUzL0Er3rYv6h13TBni/pXfazc7DyCk
	C0Yroo5wmf3371PPwcDe9n9a0Z2Fa5WHaBfdEdr3u+a9hVfCyIT7p0OWkPJCILA/5GNRqOSFXtS
	g6CvI7QHFZTtgeYCL+OdsHe9/sP8MsNAdiTCT2s7bhv2I9MG53iB+m21cRfFS4/TXPeJ97Su5S7
	Y4ZuOWdPe04174accyLkRGeJP0g1lVczbI5LOmZg/oLQP4urHvKswDs2aXtExUQsnBBEGqUew3a
	a/YbQTdFyIcxhFqwZ8bJepV7du2vmaHaIhycCl8YomxzipWcqeHheQ3j3L0JHlP14wJM8klz06P
	Q1rHYJQni34V706z+TiE3ojS8XEs8n2K3lx6xXKaDtgcVgAKrEG/Vs5EWU8jdRNcj8+jt5gKhBT
	xRNRQ4DKw8fRWcRigvXLNBK3OFkhROzbg==
X-Received: by 2002:a17:90b:5343:b0:398:e46e:ade3 with SMTP id 98e67ed59e1d1-39b2628fc1amr67409060a91.23.1789060430253;
        Thu, 10 Sep 2026 10:13:50 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([4.7.95.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b9f68e4sm59209809eec.24.2026.09.10.10.13.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 10:13:49 -0700 (PDT)
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
Date: Thu, 10 Sep 2026 10:13:47 -0700
Message-ID: <20260910171347.19445-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <361d1726-ae09-4d21-a507-a792989e9f44@linux.ibm.com>
References: <20260904032605.65758-1-kiyer@crusoe.ai> <84112f53-5c05-46ca-97d0-550565fb941c@linux.ibm.com> <20260910015457.77845-1-kiyer@crusoe.ai> <361d1726-ae09-4d21-a507-a792989e9f44@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_101351_785169_34639BB8 
X-CRM114-Status: GOOD (  11.97  )
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

On 9/10/26 2:00 AM, Nilay Shroff wrote:

> [...] So I think the policy would be better enforced at the point
> where we have actually determined that there is no usable path,
> rather than making nvme_available_path() return false
> unconditionally when fail_if_no_path is set.

Agreed. In v2 the check moves into the loop. With the policy set, a
path no longer counts as available if its controller is:

- CONNECTING: with ctrl_loss_tmo=-1 that is the entire outage. Same
  effect as FAILFAST_EXPIRED, policy-driven instead of timer-driven.

- LIVE with ANA inaccessible or persistent-loss: the target says no
  usable path, and today only controller deletion releases that I/O.

Everything else (RESETTING, ANA transitions) queues as before.

One interaction to call out: when all controllers are gone,
fail_if_no_path wins over the delayed_removal_secs queueing window --
an explicit fail policy beats a removal grace period. I'll document
that in the changelog.

> So I'm okay with keeping fail_if_no_path generic and transport-
> agnostic. The policy is essentially about what to do when there is
> no usable path i.e. fail the I/O or queue it— and that behavior
> isn't inherently specific to fabrics.

Ack, will keep it transport-agnostic in v2.

Thanks,
Krishna

