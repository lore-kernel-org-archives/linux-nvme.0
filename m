Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A907C4332F
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Dec 2022 06:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BvE2awRwFzFbxJ18OKrhIqmcucLQ6AvTFfNUPm7G5WM=; b=gMhjT645gm/8LxjAE9KNCRdRk0
	7kjaSnku3x1ab8+G/h5V3/PsaxmvOYl8TMOkT8pQiF4u9186dMA/37CLoO1lQZnB76llXoBuwrj0Q
	qHo6IBRTQyKBa6ZUNy6DqmnJlSFJLTdRdvMBswnlhqx9eXaZmC8e67VNJonqGTqwNRLjpvEY01CRA
	Rd+OHfT/5HArjLzOLLIucJKzna9YVkCenVgtwCxUXJlgIKHWXSbubaj36rTXJMeDfA3gqz1jSURoK
	MZADLFtsN3xES07CjaM8aVhME9S/yHHu1+MKZf88v9EIez0FTg97i1KI/neYmFK5DUbqK9V8pJMGi
	JTyaD4Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8xwN-00FW3O-Oa; Sat, 24 Dec 2022 06:23:27 +0000
Received: from mail-qt1-f181.google.com ([209.85.160.181])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8x21-00Ezh9-Fu
	for linux-nvme@lists.infradead.org; Sat, 24 Dec 2022 05:26:49 +0000
Received: by mail-qt1-f181.google.com with SMTP id h21so5127353qta.12
        for <linux-nvme@lists.infradead.org>; Fri, 23 Dec 2022 21:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BvE2awRwFzFbxJ18OKrhIqmcucLQ6AvTFfNUPm7G5WM=;
        b=k6yGb/e8VmV5KYVZsTahb9RS1DKkPk395PBpTV6Q0c0DCTyRc82+Q8HoH8NgoHMKlu
         k0OJAqWW+dtvDsPiUy+FHoe2+HNwiRoRulbbb/udOX5BbqyGakPkGPqYwtw//+x8CJNH
         LgqkLvXGhZp7vBGd/aGwXhmFxSo/qDjCyUXHaVuYpgTeIrv1fjIQiX83kC67SV+3rW/n
         Prew+NQNkcr42MsV06oBUb6os+U5uPv4Ocej1jDMD9c3BVENdFVTXiv3gsleYn8W+Tlm
         fkaLLbvNvYxPcDoryiGUIf4ka6vhmNl57zxitj1ZSgqZX6C55cy+MeUN99MLsdp/X6Ew
         iPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvE2awRwFzFbxJ18OKrhIqmcucLQ6AvTFfNUPm7G5WM=;
        b=Jrzkqx/KxzLoeQkfjCCmvRH0PB6rIQ1ABxkxsh3NSFgi1PSu++ZWXz0Dbabp0d7MZv
         a2PsRKxYBe6sYb53vrsvvmCT7//lvy2X2Q24ilD79TJ7Bxpfc+V1ovhh3dK9tpQbRcwb
         NWOH74oNK65MzluxXiv9MgCO8Nplssniuw7jwE03W/2FRphaPnzNSgD+yQODpbFuTAI+
         arsETIU6GJdrBPaD1LzRsojA99zkNLrmojqKszbIw61uSBcXE5q7+gytl93PR+RfCCe6
         mafX9EugvkHKzJIZKnuazOGXfhf9k435/YCUECbS+jzRG3Nf+Mkx7B9PPRVjyqkTQbwo
         NTWw==
X-Gm-Message-State: AFqh2koCzX5ZMkVpps7dXO173LcJoypOFUBls8rl9wX42ufEY5qjOMuw
	f6tFxTwqqJd6A6PQWwIVCeUuqA==
X-Google-Smtp-Source: AMrXdXvarlLSAFP/bDWauq4ZnQA3IIy1ziyTyivTcJn+nGyKDos6haGrFxuYk8OoGGeRKpx00w3VuA==
X-Received: by 2002:ac8:649:0:b0:3a6:93d7:873f with SMTP id e9-20020ac80649000000b003a693d7873fmr14076523qth.49.1671859507050;
        Fri, 23 Dec 2022 21:25:07 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v2-20020a05620a440200b006fed2788751sm3654004qkp.76.2022.12.23.21.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 21:25:06 -0800 (PST)
Date: Fri, 23 Dec 2022 21:24:56 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Thorsten Leemhuis <regressions@leemhuis.info>, linux-block@vger.kernel.org, 
    linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: 6.2 nvme-pci: something wrong
Message-ID: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221223_212514_128373_E8C5DB89 
X-CRM114-Status: GOOD (  12.47  )
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

Hi Christoph,

There's something wrong with the nvme-pci heading for 6.2-rc1:
no problem booting here on this Lenovo ThinkPad X1 Carbon 5th,
but under load...

nvme nvme0: I/O 0 (I/O Cmd) QID 2 timeout, aborting
nvme nvme0: I/O 1 (I/O Cmd) QID 2 timeout, aborting
nvme nvme0: I/O 2 (I/O Cmd) QID 2 timeout, aborting
nvme nvme0: I/O 3 (I/O Cmd) QID 2 timeout, aborting
nvme nvme0: Abort status: 0x0
nvme nvme0: Abort status: 0x0
nvme nvme0: Abort status: 0x0
nvme nvme0: Abort status: 0x0
nvme nvme0: I/O 0 QID 2 timeout, reset controller

...and more, until I just have to poweroff and reboot.

Bisection points to your
0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
And that does revert cleanly, giving a kernel which shows no problem.

I've spent a while comparing old nvme_pci_alloc_tag_set() and new
nvme_alloc_io_tag_set(), I do not know my way around there at all
and may be talking nonsense, but it did look as if there might now
be a difference in the queue_depth, sqsize, q_depth conversions.

I'm running load successfully with the patch below, but I strongly
suspect that the right patch will be somewhere else: over to you!

Hugh

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4926,7 +4926,7 @@ int nvme_alloc_io_tag_set(struct nvme_ct
 
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
-	set->queue_depth = ctrl->sqsize + 1;
+	set->queue_depth = ctrl->sqsize;
 	/*
 	 * Some Apple controllers requires tags to be unique across admin and
 	 * the (only) I/O queue, so reserve the first 32 tags of the I/O queue.

