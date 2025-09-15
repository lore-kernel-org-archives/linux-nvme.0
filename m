Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD22CAC597
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Sep 2025 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iihyv2Jpt4LhhJpo5ba8Ruk5g9dw67NMgnllmXLggIA=; b=zUs5YB+dWvLA/CVvOrP9x4Lat7
	DI1MplmT+s4o2+DIRC/A7MFkfXO5TBM5bp58adK4wEzGNr43BB7es2GPEoNIYssk6BImqiT5fYO67
	9ZiB30zV1Jbn/KVI19KnhnLk352hJVXv6XMTw5MW1KXXB2BeIgOkzBqPRJJ0aGehyxN+1SYiAsYcF
	Q3SSpixHDhWAvWdMZ4N4eiFbKMBwwhwKm71ohVRe1MAhobQQRU/NIPO78FSIaqPJcihh8fAct26yO
	HZiI3IwDNuXs6d7WrCWdGHYazlmG+8O2wm4ZQopt1ADqTZm6SpaA2Gn/W+kOEVIjWPD/D0TQRXxNA
	PaoF2wKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBXe-000000051Th-49AB;
	Mon, 15 Sep 2025 15:54:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBXd-000000051SP-16G1
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 15:54:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E4D6144BFD;
	Mon, 15 Sep 2025 15:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BFEC4CEF1;
	Mon, 15 Sep 2025 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951696;
	bh=iihyv2Jpt4LhhJpo5ba8Ruk5g9dw67NMgnllmXLggIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsyrB8xHJitmnS1KSVnAWVFD7Q806kw0Q9P7Xg6EEjXXAApf48C5R01eTWeqWC9ZM
	 /M8xLMJYRUP0blnlFnt1jD+LZnd/+ngbAr5LZ1aXcDbAUlxw2e3o3MN8UTkNY5kQVn
	 SCr/ExVsyf16wFz0AGtzk3ICBlUJR+SYJ1lxi16VFyvagP1+p85FfABAEakJKAkUu5
	 CwIEiaDiMqQQv75ilhWhaoKxF5v280Mcpd6gWGynSkNM9DBtF9PbirumWHeMsdpxS2
	 t7UiswTjaFqE8tKTO5YOJdPVlSjGBSTAngOEEUf2wVrzCN1gpi7uoD3hmUm8lvfk2Z
	 ijT9r1sFa4xAg==
Date: Mon, 15 Sep 2025 09:54:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	hare@kernel.org, Martin George <marting@netapp.com>
Subject: Re: [PATCH] nvme-auth: update bi_directional flag
Message-ID: <aMg2zqy7-M8-XpM-@kbusch-mbp>
References: <20250915114921.4715-1-marting@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915114921.4715-1-marting@netapp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_085457_328831_07841847 
X-CRM114-Status: UNSURE (   8.44  )
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

On Mon, Sep 15, 2025 at 05:19:21PM +0530, Martin George wrote:
> While setting chap->s2 to zero as part of secure channel
> concatenation, the host missed out to disable the bi_directional
> flag to indicate that controller authentication is not requested.
> Fix the same.

Thanks, applied to nvme-6.18.

