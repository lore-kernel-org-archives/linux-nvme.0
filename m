Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA45C88E77
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2026 05:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QwZJQra0U9Ii9RAq89t8ck1DuK1mpAEqHvx5PmiAUkc=; b=29oroVlwck7BJxVQXKXssiM7+C
	io5uoTMQ/YkiNVZgFU1/IWgwGqEYhHu673LK9xXYPyVUBy+49tKeyEIPNgeL5TXcjfYcXyu5xTo32
	qlXakj2Pf6F6XfB8MyCUr7SRhtVFDZV+qYkYrGEeemYYvLTJ2puPXuwyA9H4RYALgMZHOEaVlOOA4
	UFMDt1MNXsYILezzyBGm+fYxc7pZt7nQa9OiYrPvxRUupV78XgbDiGBTGOwPCbKzhOmlhEPWYSQOA
	JFv5hrL+q5QLsRIFFdGKVp35b002vmgvFyMzGRp42bGg6hbOV8tIkArWzFqJnaRidFyplaCT5XHMx
	vr+saIvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6iaI-00000008Q99-27Mp;
	Wed, 16 Sep 2026 05:53:30 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6iaE-00000008Q8Z-2syy
	for linux-nvme@lists.infradead.org;
	Wed, 16 Sep 2026 05:53:29 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1382022a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 15 Sep 2026 22:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1789538005; x=1790142805; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwZJQra0U9Ii9RAq89t8ck1DuK1mpAEqHvx5PmiAUkc=;
        b=Tot8SuYjK1jPo8FUQfupMisfcYebE3S12VtepPXtxawaYn8FHHn8v8HFwxjny8za5G
         ufWCxOOIHEVNocaqEBr8Q8rNDnjkKFPcIInldOrUv0+FAFiIaZFVu+W+wadNvAbr5v+c
         ZDYqoYfyD4XgiyIo/TcGQLQuAe5XKLjOh/UDIIIv/Mhu6HAG5iiXZjOygfYCgaRkEHUN
         Vz0MYgnebLeGTxaynM+xMwCGc4u12q+ANNh0tI0xi22a0tXdSwQ3Ey/FebGYEnRMuHoS
         0C1NXTPvOeIuHMiZFKpuWiybaewv56/MwDB/2TJAbCVlYvDeB0Ozgr3lsjQVjeP7wBZt
         p4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538005; x=1790142805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QwZJQra0U9Ii9RAq89t8ck1DuK1mpAEqHvx5PmiAUkc=;
        b=xBDUfkQCjYUZxwoL5O2j0fuo0ZyICmOw++NTIjbm0q78EbdXOMgZHqw0gk6+qr8YYn
         8vqikcW5nvCvIOva6zkvbNUD6f6DQyafKqN4M22Rip+1ouGfSckOCqpmxJQa8KoVNOQ+
         +DGPxPlTSZU86BxwgIvf6u3loS0GPOo+jJKUtKarc1rFx0NgeQoARRZL8w2H8Si6/mVr
         JYNi6yCPGowCPezB0qqWTyVcHQzsAsmZfCpn+Iz6agxsKMVnN0L7ymUOsPIFNuQmpzwC
         h2fGB+kf0l9f2OcdVE2a1Dxfd6SbAkRRGIcCIJdI+aEAnD/uz+cDtEHU5spqYjC/+jvX
         c3gw==
X-Forwarded-Encrypted: i=1; AKwUvBykn9/FiQDuHwcocP0ZJjwvG9AjJ9NXdHLqOXl92uJLmdkMYQZzrQGMGvVKqEPWXJSOWKUvZ45BkSHk@lists.infradead.org
X-Gm-Message-State: AFuF++nY53HGsxvLjO2xv1N1diZoR7zBuJW9r7qP8AIlWkaXSzYXL0KO
	RJjhCkNEr7a0GCEAhcxS9VHde15S3C2gdeMeWfQJMwGpRNDkScgPrGQ3QgigARr4b8Y=
X-Gm-Gg: AYBFou0n4/9jxYGU+x9Qh6QYpRNfwexeEIh2nzRZ6gAo0bF/2Y7fUiLPMtKKbzUQQQt
	OXXJzAUyhpQyHPWGxPDSZlEb43VOz2W39cmr5Qquu0aB0231WvTklqTOp3rQXtcXdG37SXf9U7f
	HXrnSBx1cjwmjubW4dxaRRIH/bx6XJ4sBArZWsHLInDkVJOG4I0ZNAetEjYvEd9QRc9XnjuyJ5Z
	NTZzkT+D7411xj7BI/D70pX1wrmEDnQ0434B7b2rjVpalezg6RvN4kCXOoT8Gbpm0+fwL9+myj+
	wbja5Hixcl8Qg5Cee+jmxX55CL7OEDQnYn28GbOYp/W6EvfF9WRWs5V6WWtNrPtb3Fc5P9qAxDp
	r+6qzBXE9Bo8acRx91yV5RwQ0N44IBMZspkBXR1LD3NzEDSZGc17p3TSON/pGz65pPrW80lud1R
	7gREC6EBmldDpYPEjZNDxnckPmzxHNQscCA5r/Sj7yBlsfh3+R6FxRey8i6jAlngPqxyqSmk6or
	Rikd4dNVksx7UNC2Hl5HSn0cKOmtbWqExWQ2SV9qui0ZN6dZtKuiAT9v9fnEfDx
X-Received: by 2002:a17:90b:4cc6:b0:39e:5cc:717b with SMTP id 98e67ed59e1d1-39e05cc73abmr7152700a91.25.1789538004833;
        Tue, 15 Sep 2026 22:53:24 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4380:3400:b9a3:a85e:3719:2059])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395caccf1sm3501077c88.2.2026.09.15.22.53.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Sep 2026 22:53:24 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sj@kernel.org
Subject: Re: [PATCH v3] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Tue, 15 Sep 2026 22:53:18 -0700
Message-ID: <20260916055321.54162-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me>
References: <20260909211432.6741-1-saravanand@crusoe.ai> <13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_225326_747854_7D0E5F43 
X-CRM114-Status: GOOD (  21.14  )
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

On Sat, 12 Sep 2026 00:11:18 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
> No need for NVME_TCP_Q_IO_CPU_USER flag and restoring to the original
> connect time selection. -1 would mean WORK_CPU_UNBOUND. In fact lets
> allow this file to access "unbound" string (same as -1). I don't think
> we need to restore the connect time selection, the user who touches
> these settings is obviously interested to be in control.

Noted. The next version will accept a cpu number, -1 or the string "unbound",
with -1 and "unbound" setting io_cpu to WORK_CPU_UNBOUND.

> I think that the queue accounting is something we'd do anyways,
> regardless of how the queue is set. It just represents the io_cpu
> spread across cpu cores.

Agreed, the accounting applies regardless of whether the io_cpu came from
the driver's selection or from the control plane.

> I am wandering if it is time to introduce the core nvme queue:
> struct nvme_queue {
>          struct kobject        kobj;
>          unsigned int          qid;
>          u64                          flags;
> };
>
> And have the transport queue embed it:
> struct nvme_tcp_queue {
>          struct nvme_queue        nvmeq;
>          ....
> };
>
> I suspect it will allow for better abstractions.

This works for me, and it settles where the queues/<qid>/ kobject
lives. As Nilay pointed out the nvme_queue name is taken by the PCI
driver, so the common struct needs another name.

One clarification for the reconnect path. You suggested earlier that a
user assigned io_cpu should not change across reconnects. Without a
flag the driver cannot tell a user assigned io_cpu from its own pick
when it reconnects, since both are just a cpu number. If the
assignment should still persist, would you consider tracking it as a bit
in the flags of core nvme queue struct ?

I will wait for Keith and Christoph before spinning the next version.

Thanks,
Saravanan D.

