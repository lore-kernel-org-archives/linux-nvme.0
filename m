Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4521C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 17:14:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D072067C
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 17:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mp3ew1kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D072067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6QGke3WuSwIEGF5d4NcZk1u9ijwoSN4lQXDfo5AvJCI=; b=mp3ew1knlJGw8HzlfIP74dPAC
	buEVx4YR8+c0Mg4o5Zfb+sZ+PqfqaqRiT4d/zXRzAMoMUK7CKRa+B34wq54fetgb5Erj45v0msSIl
	jt8F4DcYHsI2eyBOxkGTWvbvVF9IKnZRx5cV4nPARvdaswD+4EjIu6AQouI+gfTeB9TQdhA9rPp89
	dUJgd8IvEiDdw6ck7Q6ccd/b78dy6W5jmQChOSotjrcFJhCXHikhOwz2Co0z607F1JiLOoyWOQShk
	ru+Iny6SGjX1XCvRng7swLyYguV8mLLvYDwE77zChABkgF/qlNfzgPky76LedJ/5/mSAUIJVxuIKn
	kvPucZm9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k85C6-0006Fm-23; Tue, 18 Aug 2020 17:14:42 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k85C3-0006EV-RE
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 17:14:40 +0000
Received: by mail-wr1-f68.google.com with SMTP id a15so18962358wrh.10
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 10:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vb3zGwE1WCHx+27JTR7GFIFm9G79r4Q2mIZjMGFpqGY=;
 b=pthvGHCiDmVan+294w8vrGvE9gz4KsIfAIubeGF2s5anHQ/8KYplNjMPyS6baLTnUg
 qrCGD6gei5pQ1kxKYDSB/Z3pCgXpL2a2iS8s4GKbiIjyxqMODc7B/kCwX27sAM6apk8Q
 5u4u0EbtTIQcO6uc7G+p6BlMy0cEs8f+DkOJb5LJGL7qHgVRRN8fgR7i7MIncVOHQ35r
 jQFaMsGHNGTeycqCpaDRRiJXc7ekxGI//fiRvbd+zdOeFz+AVVEglkmnbRiLXzKJppI9
 5IxpRvw9GYd+lV0QFdGkhSDfHg/TYwgEzQTq74A5p1XxLTKRonF0uZ0R0MwZvwa+CBI0
 mfXg==
X-Gm-Message-State: AOAM533jAfipHylpwbvvnfTHpdZrRBEPzIhftE2kTM8UBVGArPEsWk7H
 6T4/wH2TivgZoET0GfSdS+E=
X-Google-Smtp-Source: ABdhPJyJHY/NJ3mG0RnRPvsuD1T6FVfsRe2a3gqSII96sXaJzw7NrhRfx5QMBsW4GuseFGLoY7t11w==
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr241953wrn.345.1597770876875; 
 Tue, 18 Aug 2020 10:14:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dce:63f2:5e83:391e?
 ([2601:647:4802:9070:3dce:63f2:5e83:391e])
 by smtp.gmail.com with ESMTPSA id z127sm703344wme.44.2020.08.18.10.14.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 10:14:36 -0700 (PDT)
Subject: Re: regression with "nvme-rdma: use new shared CQ mechanism" from
 v5.9-rc1
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org
References: <1476432272.38046616.1597766884817.JavaMail.zimbra@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <797037be-c908-6c95-e459-4e997de51679@grimberg.me>
Date: Tue, 18 Aug 2020 10:14:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1476432272.38046616.1597766884817.JavaMail.zimbra@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_131439_917933_75170EF5 
X-CRM114-Status: GOOD (  15.36  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: yaminf@mellanox.com, kbusch@kernel.org, hch@lst.de,
 linux-rdma@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

+linux-rdma

On 8/18/20 9:08 AM, Yi Zhang wrote:
> Hello
> 
> With Sagi's new blktests nvme rdma[1], I found one regresson that lead nvme/004 hang.
> By bisecting, I found it was introduced from [2], could anyone help check this issue, thanks.
> 
> [1] https://marc.info/?l=linux-block&m=159738590701657&w=2
> # nvme_trtype=rdma ./check nvme/004                      -------> hang and never finished
> nvme/004 (test nvme and nvmet UUID NS descriptors)
>      runtime  1.647s  ...
> 
> # ps aux | grep rdma_rxe
> root        1657  0.0  0.0   8292  1632 pts/0    D+   11:54   0:00 modprobe -r rdma_rxe
>          
> # cat /proc/1657/stack
> [<0>] disable_device+0xa2/0x130 [ib_core]
> [<0>] __ib_unregister_device+0x37/0xa0 [ib_core]
> [<0>] ib_unregister_driver+0x9d/0xd0 [ib_core]
> [<0>] rxe_module_exit+0x16/0x7d [rdma_rxe]
> [<0>] __do_sys_delete_module.constprop.0+0x170/0x2c0
> [<0>] do_syscall_64+0x33/0x40
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> # dmesg
> [  273.577444] run blktests nvme/004 at 2020-08-18 11:54:22
> [  273.615610] rdma_rxe: loaded
> [  273.623675] infiniband rxe0: set active
> [  273.627962] infiniband rxe0: added eno1
> [  273.639520] infiniband rxe1: set down
> [  273.643611] infiniband rxe1: added eno2
> [  273.655617] infiniband rxe0: set down
> [  273.659713] infiniband rxe0: added eno3
> [  273.673854] infiniband rxe0: set down
> [  273.677946] infiniband rxe0: added eno4
> [  273.695954] infiniband rxe0: set active
> [  273.700236] infiniband rxe0: added enp130s0f0
> [  273.717858] infiniband rxe0: set down
> [  273.721954] infiniband rxe0: added enp130s0f1
> [  273.739460] lo speed is unknown, defaulting to 1000
> [  273.744941] lo speed is unknown, defaulting to 1000
> [  273.750413] lo speed is unknown, defaulting to 1000
> [  273.757853] infiniband rxe0: set active
> [  273.762139] infiniband rxe0: added lo
> [  273.766229] lo speed is unknown, defaulting to 1000
> [  273.771681] lo speed is unknown, defaulting to 1000
> [  273.777135] lo speed is unknown, defaulting to 1000
> [  273.992958] loop: module loaded
> [  274.024550] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  274.039541] nvmet_rdma: enabling port 0 (10.16.221.68:4420)
> [  274.066081] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e5372c18c860491bb18adb3b5b025a20.
> [  274.081395] nvme nvme0: creating 32 I/O queues.
> [  274.120241] nvme nvme0: mapped 32/0/0 default/read/poll queues.
> [  274.132037] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 10.16.221.68:4420
> [  275.171715] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> [  275.311794] rdma_rxe: not configured on eno1
> [  275.321210] rdma_rxe: not configured on eno2
> [  275.333410] rdma_rxe: not configured on eno3
> [  275.347527] rdma_rxe: not configured on eno4
> [  275.362830] rdma_rxe: not configured on enp130s0f0
> [  275.383157] rdma_rxe: not configured on enp130s0f1
> [  275.406067] rdma_rxe: not configured on lo
> [  513.938222] infiniband rocep130s0f0: set active
> [  558.930867] infiniband rocep130s0f0: set active
> [  558.948955] infiniband rocep130s0f0: set active
> [  603.930414] infiniband rocep130s0f0: set active
> 
> 
> [2]
> ca0f1a8055be nvmet-rdma: use new shared CQ mechanism
> 287f329e3131 nvme-rdma: use new shared CQ mechanism
> 
> Best Regards,
>    Yi Zhang
> 
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
