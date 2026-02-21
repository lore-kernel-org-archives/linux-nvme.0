Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E541C61DE3
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Feb 2026 17:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FcflqHP8wP8tLQKnEOO9Ccml2hMLrq+0/CpPwhxRE7M=; b=TvrYP4wxrS4ITdZ38eY2neIEZ+
	bWMWtJsxZIVACWlDSXvpaykw2AtnirpU4DaNBuPbi8spHoCz90bJSdrFfmEu+UpzeXN3z48Umfgxd
	bjNasSdPeQhszXKUJVQs9c9DVV9JgPFSRcWsUMdcCR/X+7cXmaMQ2ZmJrM3sA4xdNcFIrldmg7mVx
	p/5PQS/Ty0P3R9LMYQ5OnTb/2k8p7CTRYcKYoqlgI3UUfd5bkDekc6rruB3UCUhapBIS9TQ3Gl8aM
	DG0v2wcRvWL6exlRiBA9iQjlWEsQR8orfGo5P5sRyEVDUu15qzfxaDNQ7uU+hQTD1zCY2GIHGMpvO
	uOSBvNhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtqz9-0000000GDJ5-1DHL;
	Sat, 21 Feb 2026 17:41:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtqyz-0000000GDIU-1dBk
	for linux-nvme@lists.infradead.org;
	Sat, 21 Feb 2026 17:41:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B2EAD407F2;
	Sat, 21 Feb 2026 17:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B31C4CEF7;
	Sat, 21 Feb 2026 17:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771695690;
	bh=hC/bKukwvz707+9AogQXTJbFdJshNSgSwFm4eZcmcjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLZY01/u2Mj5XoC/TEIMxkn1Fyn4UOpnYAx04p7FeFCEMq1SbrqBA5WkhzTtI6kZb
	 QFBx2zeeeONDEz0vZwpr1znz0VM59flDkyZUsvQ11iRioTnfrZY5b02mfaBO49+xkT
	 gVIGx9J54pngaVg75opSFOrSuBqPazXU6im3VACIsoci3hh+mvxcqgHmuyOmrFJxlk
	 PM3x4aiUzSceUFq3RvIcK9e6yWTGZYZgn4p1RIPgV1Lvzjful53O01jX92CcsdvXef
	 C+BwuALX2iFuZVFbMf3f5j+3hnw2jdxCRNw49xhYSPafldjS/KvQ8ZczKvKSKrh8Bd
	 jINjZMvYA9SXg==
Date: Sat, 21 Feb 2026 12:41:28 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: Re: [LSF/MM/BPF TOPIC] Native SCSI multipath support
Message-ID: <aZnuSC0qYfw0hiwM@kernel.org>
References: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260221_094133_458010_F840EE57 
X-CRM114-Status: GOOD (  14.86  )
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

On Fri, Feb 13, 2026 at 02:19:11PM +0000, John Garry wrote:
> At ALPSS 25 I presented a proposal for Native SCSI multipath support. Let's
> discuss this topic at LSFMM.
> 
> The idea for this is that SCSI could natively support multipath, like how
> NVMe host driver does today. It is intended as an alternative to
> dm-multipath support.
> 
> I have been working on the implementation and I plan to post patches in the
> next cycle. I am looking at a 3-stage approach:
> a. create a driver-agnostic multipath library, very heavily based on NVMe
> host multipath support.
> The library would support features such as path management, path
> selection/iopolicy, failover recovery, PR, delayed removal, gendisk
> management etc.
> b. switch NVMe over to use this library

I can appreciate that the kernel to userspace interface of DM
multipath is clearly unwanted (hence NVMe multipath and now SCSI
multipath).

But you should really be switching DM-multipath over to using it too;
or at least detailing _why_ the core of DM multipath
(drivers/md/dm-mpath.c) cannot be updated to use this common backend
library.

This line of work makes little sense to me if it just ignores
dm-multipath.

Mike

> c. add native SCSI multipath support based on this common library
> 
> Thanks,
> John
> 
> 
> 

