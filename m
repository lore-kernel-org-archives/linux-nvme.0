Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811F5E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Dec 2024 02:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:Subject:
	Mime-Version:Content-Transfer-Encoding:Content-Type:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oRNgYWoimAHsjRoodqMPvigHyqp6GjcyaQ2c/ZUjJuY=; b=3VOIhf8QTafq12pxYzk8flERlj
	HsykAw/sT+x2wZVv/GQCAaCWoA0rE+fR1kty+qNobJ1FQ675oxAz4mZv0k1dbPt8Q0pl1thw762/z
	278+U1IUB0a7mr8BufhQoto+HtF0TfLPyU2tC13JqFW1rHko8BmVPEjMsloRDpHIr2b4xcTLRHGoc
	CkKtCCImjuWaudiTp+evhkp+stF1PA5b3/OrkZ/aU17aQcOya4mceLMTebsWSzOg+TGQPth2NJaAB
	ltHIoK0clZBzcuIVUrt/EefexHjZZxptN+cqhDX8RhHlWriB6a5ajJaM1axFmMzB8Z5xBqAmP+I36
	iGRvhUow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tSS4B-00000006Ka6-0rZx;
	Tue, 31 Dec 2024 02:33:07 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tSS48-00000006KZY-1IcG
	for linux-nvme@lists.infradead.org;
	Tue, 31 Dec 2024 02:33:05 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2165cb60719so128715455ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 30 Dec 2024 18:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735612383; x=1736217183; darn=lists.infradead.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRNgYWoimAHsjRoodqMPvigHyqp6GjcyaQ2c/ZUjJuY=;
        b=CqbsrWN81L7ze7IpWWobZqPfgjBB+62F5gY6dM/5XMOtrbZOzZ1M3RZiNBwOZ6aoRk
         CirjRnEu5ZEy/kChK1xz/8V5rzVxC+8hUFOmqo10p/MTHjTwurG9CZ9kuen3MCKeioYO
         EAuk7XSOKIDmTGPu1/IEiaZVzhUeFqnx+HUGn/d2jcZPxvhUIwmC7kwfWAxG7KOkYybb
         SfjBP5M1YL/ht8KVHsiiE7PhS2P8giTz38zIXxO2hPjce98pGwlbcCHrie5R02+iRaSZ
         y9DQkRZsPXSa7vCDF66Z9j2ujJLE5ziKw5k7G5x7xw8S+NtP4uatFD21R9UbDs8ae5/W
         v5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735612383; x=1736217183;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRNgYWoimAHsjRoodqMPvigHyqp6GjcyaQ2c/ZUjJuY=;
        b=nY64kIBiujXDTrSqdX6Tzs5MoTryrMyezb20TVx6It6nxHllO3ZyaX28p0Q4iQsO5L
         5F/z9z6ZwDTyGKD6zwJu2FjqV6aDn1cU7Cd+/y/HaHOdCmRdhvxMxftDr/87O2Ukr951
         1K2z6/Vsjlfb2VWfy9ELmswWZ6zjL/4+8tNICQAWwo63bMsNCpIIAj35ZhcNdytL7Y62
         UbJmMbvvqcFoHKxUOqNYjJdVnB+69Wn3g/zQkLQL2KWVb54Q0GqdH7O/YGZ6HNlxJ+aK
         YoCsCMtPoUqA2srZMn1kRt5iGdgtfCbczKKpBaemhKpLj6B4B1KsGaaDMeJz4Wp7BZhJ
         mEWw==
X-Gm-Message-State: AOJu0YyufJi4ksCSD7DPgbOaYr0VgqyXGE+zPcuplfOqLLSmEu/kQpMr
	3Q6MR7me3PMCXxiHD+p82VHwOcyDW/khzk53xhoSujsUeGWxbHOhinQ7NW8zmwH0OA==
X-Gm-Gg: ASbGncuk8wbjs3qieYXQ5ifG7SkWFihk0WuzpToC/lx+epaZselfUN9bmVNmhG4+8KF
	cMPgHIR6Dwn/IKYXxQYHuUMZ1Xu9bBmb0uKLNoUgjS47JL1kjBXL6FqZRAKK8/Om9rVbVTd+EpQ
	Z7esJtoLckRrNoQt7aHSdtf0hmvn2ffskmuDx24o2YBqZlxixwaxLtPRaY0+idz03nEc3QX/NGT
	B5zZVTaP3sk3RG2UqJG59kZ4uqOeTlSOq3SwlIO0hrHhjZFlNEUtGEjhzChI/LCLdY=
X-Google-Smtp-Source: AGHT+IG4AVeLIsYdZl2lczwDGiGs1D8KAGneZvLsm8qrO8AbfSBYJmjLq5B8+Nw/A6f18jZFNhgtHg==
X-Received: by 2002:a17:902:c948:b0:216:2a36:5b2e with SMTP id d9443c01a7336-219e6ec0a15mr481319475ad.32.1735612383047;
        Mon, 30 Dec 2024 18:33:03 -0800 (PST)
Received: from smtpclient.apple ([103.172.41.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a1773c654sm80073515ad.29.2024.12.30.18.33.01
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2024 18:33:02 -0800 (PST)
From: Jiewei Ke <kejiewei.cn@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: [nvme_tcp] possible data corruption when host detected path error and
 resubmit IOs on another path
Message-Id: <DD72B155-35CF-47F6-A342-13445A9E432F@gmail.com>
Date: Tue, 31 Dec 2024 10:32:47 +0800
To: linux-nvme@lists.infradead.org
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241230_183304_341361_70902202 
X-CRM114-Status: GOOD (  12.98  )
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

Hi experts,

When the NVMe host driver detects a command timeout (either admin or I/O
command), it triggers error recovery and attempts to resubmit the I/Os on
another path, provided that native multipath is enabled.

Taking the nvme_tcp driver as an example, the nvme_tcp_timeout function is
called when any command times out:

nvme_tcp_timeout
  -> nvme_tcp_error_recovery
    -> nvme_tcp_error_recovery_work
      -> nvme_tcp_teardown_io_queues
        -> nvme_cancel_tagset

nvme_cancel_tagset completes the inflight requests on the failed path and
then calls nvme_failover_req to resubmit them on a different path. There is
no wait time before the I/O is resubmitted. This means that the controller
on the old path may not have fully cleaned up the pending requests,
potentially leading to data corruption on the NVMe namespace.

For example, consider the following scenario:

1. The host sends IO1 to path1, but then encounters a timeout for either IO1
or a previous I/O request (e.g., keep-alive or I/O timeout). This triggers
error recovery, and IO1 is retried on path2, which succeeds.

2. After that, the host sends IO2 with the same LBA to path2, which also
succeeds.

3. Meanwhile, IO1 on path1 has not been aborted and continues to execute.

Ultimately, IO2 gets overwritten by the residual IO1, leading to potential
data corruption.

This issue can easily be reproduced in our distributed storage system.

I noticed that the NVMe Base Specification 2.1, section "9.6 Communication
Loss Handling," provides a good description of this scenario. It introduces
the concept of Command Quiesce Time (CQT), which allows for a cleanup period
for outstanding commands on the controller. Implementing CQT could
potentially resolve this issue.

Are there any plans to add CQT support to the NVMe host driver? In the
absence of this feature, is there any recommended workaround for this issue?
For instance, could using Device Mapper be a viable substitute?

Thank you, 
Jiewei


