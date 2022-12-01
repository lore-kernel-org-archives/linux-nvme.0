Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06019C4321E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Dec 2022 21:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d3UhSYjtf0l3xQlu66ovTVD4Jm6kwWkIXMOG934Js2Y=; b=advv00vBy+BQGSQTpFHBUpCE+G
	+52RSXLiJkej74iz1Hgjsx7FX0P/oHCRAMCGujOX5UcOT6Su7HgHNC6aAft3Ku19VbV0zmtPSYCc9
	SCRr/ftQhUT9PDidhhGR+s7YfBs0lIUF/QmZilXg4z2iHT3bYuLoOSLvuyGmqTOOwWJYxOiShQTzD
	pJ/bo0d1vOxsbRn4IoNVcPr9WzzF6nv4xSnf29GV+dYUgnk3q02ozO9XN78R0TCQPNu3ZPzG1YdUF
	JiORFjxe9pe8yeoZi7em6kO1QPDJsJbDG7SQFQjcSAtQDtW/v5F0rQzxFxvPrlRJoBsjoMeiDG6ZI
	MxahLq2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0r9B-00B990-1c; Thu, 01 Dec 2022 21:31:09 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0r5c-00B8cN-V7
	for linux-nvme@lists.infradead.org; Thu, 01 Dec 2022 21:27:30 +0000
Received: by mail-il1-x12c.google.com with SMTP id z9so1316737ilu.10
        for <linux-nvme@lists.infradead.org>; Thu, 01 Dec 2022 13:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d3UhSYjtf0l3xQlu66ovTVD4Jm6kwWkIXMOG934Js2Y=;
        b=fgkAxo50XdsL2tXuORIZJe1llCKTSKBBkCCzDjkpRVWOGHsaYYlWOwZZqvvbrIpK6B
         yllblPvgrnknUFXjjG7Q+mKctzVOAu5ReRsuJoZtWDfKE6E5pDWpdB8OmY02kuKUhi3V
         64TmpTGMCGVTx3oZEYPZGxIXJyQ0hItWTM+ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3UhSYjtf0l3xQlu66ovTVD4Jm6kwWkIXMOG934Js2Y=;
        b=sgLgQWoTGMrzov6abCE57jpa+6q/Ps5woiaJ1bVrm5ryz506xdd1oLINjOKnabkK75
         jE7T/IfmJ5dWo1Iww7XJ5yU4wZb8Ssj4Vxdbh2R8RNFxytJr9j0yzQ/Okl1bBDsuk5I+
         q45MY2a8nSuxoNygsjDrXPVRYTSDEf0g6ztBhYSLvmA/mS3sDSL2YCSdSR7QXi+YeYt8
         Dk0iM8m2drpfdRGUgdwsc6VTUrymLVoknd+urZnzHQYj5HmGPx43HFsSuLgXaEphcVNr
         75ZXy123tLwF75nxforPqEPp5g26IXE6PqFuj58LNmXzTM93hti7qgraHhzKyUjmdiIg
         F0fg==
X-Gm-Message-State: ANoB5pnRaqwadUEW62bX7WoJ06mcSiSc0ghBpk/G8puLzp1OX88lXXDW
	Kx7skjj1WjRHnUMalNNzyIK+xi5j70v0YzccB8EtOQ==
X-Google-Smtp-Source: AA0mqf6mCboJ831TqzAq1xjO5ruWpmY9jr+Le41mU9yeWK3yeRQqlya995LAeXq7tk5oR9QwgC6ltD0e9+cZxdTCFj8=
X-Received: by 2002:a92:8e08:0:b0:302:c028:895b with SMTP id
 c8-20020a928e08000000b00302c028895bmr22114500ild.154.1669930047291; Thu, 01
 Dec 2022 13:27:27 -0800 (PST)
MIME-Version: 1.0
References: <dfcd682c-126d-34ab-3858-a7a7fc0afcb3@grimberg.me>
 <20221121074039.GA24507@lst.de> <CADUfDZraHB6=i77i9Mivdf5cbUHpKxHofSZFnGhsywb=k-+y_w@mail.gmail.com>
 <20221121175932.GM4001@paulmck-ThinkPad-P17-Gen-1> <CADUfDZrVT2tCnUkorJ94Mzd20n-Ch-8cZaSeT0LbowH3dwQ=yw@mail.gmail.com>
 <b42a8825-a263-22fc-9f86-5c3dada173f1@grimberg.me> <20221122121449.GA3888@lst.de>
 <6a72cb78-8f23-a612-adab-10f4fe2a2174@grimberg.me>
In-Reply-To: <6a72cb78-8f23-a612-adab-10f4fe2a2174@grimberg.me>
From: Caleb Sander <csander@purestorage.com>
Date: Thu, 1 Dec 2022 13:27:16 -0800
Message-ID: <CADUfDZpkw3iyiAqJ4X=rypJvLbO7dD2r9yegkYWyXOko-qcpNA@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, paulmck@kernel.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_132729_042727_0F9F289E 
X-CRM114-Status: GOOD (  16.13  )
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

On Tue, Nov 22, 2022 at 7:08 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> ...
> The original patch report did not include any sequence that removes all
> namespaces, and given that it came from RockyLinux 8.6 kernel, it is not
> 6.1... Hence I think that we need to understand how a namespace removal
> happened at the same time that the namespace is being scanned. Maybe
> something else is broken.

After some more debugging, I found the main cause:
ns->disk isn't set until after ns is linked into the ns_head list.
The ns is linked in nvme_init_ns_head(),
which nvme_alloc_ns() calls before creating the disk:
static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
struct nvme_ns_ids *ids)
{
// ...
if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
goto out_free_queue;

disk = alloc_disk_node(0, node);
if (!disk)
goto out_unlink_ns;
// ...
ns->disk = disk;
// ...
}

It looks like this has never been a problem upstream:
5f432cceb3e9 ("nvme: use blk_mq_alloc_disk") fixed the order before
e7d65803e2bb ("nvme-multipath: revalidate paths during rescan") was committed.
Strange that the Red Hat 8.6 kernel has pulled in only the later commit.

The list traversal here still needs to be protected by (S)RCU,
so I would still push for this patch.
Sagi had suggested using RCU here instead, but discussing with Chris,
it sounds like we reached a consensus to consistently protect this list
with SRCU. We can evaluate switching to RCU later if needed,
but since this is not in the I/O path, I don't see a big performance concern.

