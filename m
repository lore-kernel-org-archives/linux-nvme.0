Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A48D116F3
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 02:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMLjj6fpWLalWNCWlGG0O4eJGIJVRcEEIw31e5D0zQE=; b=H6Yvjsy2SBLcO4dxKNi8t3Emal
	wTEVJgF9ivWyijyAvrBE1TqxACUZvcC6ihw0zT4zT2WSMAGKKVeqifGaQgB0bGbXHxhCUi6JHqFuU
	D4PVYkYK7S8iCMbO2YYtJqjB8wA8mFcioKaGLkbo6tL9zZE7ddx6SVy/yXOxuA/R3Z92Dbj29NZIQ
	7SdFb56yZMfbiFtTcDMHtFgVUY4eTOpVMhOvZSfRdM70eJbUA8qGfXZp3Nf/lqhmhO4qbSZUq4G62
	gspdTT5ELApohRLFiRJHIdaTVzOLX8RC2NCVvDNtJyZ/+VcyMbNk7rS/y8AlRv7XXkHrXRCetsFqY
	+5dqj8/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQGQC-00000004jGa-1Hud;
	Tue, 02 Dec 2025 02:47:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQGQ9-00000004jG4-4ALO
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 02:47:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 612E843F51;
	Tue,  2 Dec 2025 02:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B37C4CEF1;
	Tue,  2 Dec 2025 02:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764643637;
	bh=ptZo5CdJibDzbm5KHwiJX7L6GU2pFUSsnTi65NDpqO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpdfxE4jYXfc/QxVnk9Tzr7OsffArfujjfARrZed7c3mGkfJjXODI4tO1fbL1L4eF
	 PlicYsc6d8qKghMWqOPUgbTUDpWqn9ja9h5FMPZeuO7P7l+GpHn1UV1HT7TmV4g6JV
	 eG04pOD3cRzSaO7B8EayYTd3yNl3nI/LjIMnSqGj3SllI7B/Vfxbl5RZuy/AN2zB1k
	 wS73bAsj4NUkPSJ60rn2qAesY25o+/4O4xXsWUvUNHEYrUpdfLfNnUf4YLN2mwK49y
	 ZE05C0n+d/Cb1L8EMX+8OcQzZ8nM1OxfY8DqftetRadpyyIDFLDz3I7Eva6McDJAcA
	 KVHcl3E2TJ1MA==
Date: Mon, 1 Dec 2025 19:47:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
	linux-raid@vger.kernel.org,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
Message-ID: <aS5TM30PizKtz_hW@kbusch-mbp>
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <aSXDnfU_K0YxE07f@kbusch-mbp>
 <CAO9zADzUZYzM=xkvHPXepQP_+6V0f4__yroPNV6feyPB27Ju=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9zADzUZYzM=xkvHPXepQP_+6V0f4__yroPNV6feyPB27Ju=Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_184718_058251_70C9EEE9 
X-CRM114-Status: UNSURE (   9.95  )
X-CRM114-Notice: Please train this message.
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

On Mon, Dec 01, 2025 at 09:13:01AM -0500, Justin Piszcz wrote:
> Nice, I was not aware of this, thanks!  As this issue appears to
> affect different consumer-level NVME drives, any efforts to address
> the quirks in various NVME drives to restart the device while keeping
> the volume intact would be awesome if it is possible to- get that
> point in the future.

Various consumer NVMe's use 3rd party controllers, so maybe that's the
common denominator. There aren't very many to choose from.

Anyway, the suggestion won't fix random IO stalls when the situation
happens, but if it is successful, it should keep the volume in an
optimal state, albeit with exceptionally high latency during the
recovery window.

