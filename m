Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55723D31765
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVYdRRRX4V6bvOCYh7splqOF1YmCpORqfAvmr6GmJZA=; b=zfHYO5i1uhEdK4JXqiUg5k5iN3
	+LUcCYNw4zq88z6MJ91xGq9s+A17wYezY3JE5ZGDPX1oGIGxTBJ5dtPfXTrQJ0wFcZabrEYOWkhgz
	MHFsvN6znm9ZsUxSaUqkj2oCay9hz5+PQtZlimN7V3qHQB6bwxKVxKL35szTzwe4w6qqbKzS3HPEq
	YSpbsSTpjMiObnu+tXQpIgam+TlpKw1w9LGMzshGlaRN2r8K29dWy+znlRsc/HVc/vPdl6boSWcrL
	LFN8EumEdwyYYI+FD4ONrTiaWKehLiQvnOWyo9Rt0MJmZ8fKMPoUfBsR8b+hJjoA5ClWLlNw+gGKd
	m6/L9hZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8N1C-000000009Z1-0qm3;
	Tue, 05 Nov 2024 17:07:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8MXy-0000000043t-1tRe
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 16:36:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 11CC95C3DFF;
	Tue,  5 Nov 2024 16:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1714DC4CECF;
	Tue,  5 Nov 2024 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824609;
	bh=mVYdRRRX4V6bvOCYh7splqOF1YmCpORqfAvmr6GmJZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7Qxjpy0dQqx1dECIV19SqLURIxDT2UzT5j9qcwQV/w56BTsIbdeVcPdm29cSwnSS
	 mxdUVMdW6p0oEl2h/0OQKacustMZx6sEISFfk/MhC/e6It3Ivl/g589wzPfYR8tmYC
	 KOy/hKht/nk5j/mcAH+cNG1hM84GX25+JmOfy1TZP8GwSgNEK1FeFeFoqyFtwuelcB
	 hcuRZcTEW+MOaiJ4APeAe9LC6DjZJDT/zlD+HR6xbpoc5cbz+KHdExu/qvuFxmLn7L
	 20ibr9gZ5uy0dlDwFyfMAXpQgbYZzm+h+N0yxllljViyI9rR7x0CyXr14N/Y/gCXLJ
	 gQbxHH11SVJTw==
Date: Tue, 5 Nov 2024 09:36:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvmet: make nvmet_wq visible in sysfs
Message-ID: <ZypJn0XdI3cQe3zC@kbusch-mbp.dhcp.thefacebook.com>
References: <20241031022720.27202-1-kanie@linux.alibaba.com>
 <3cb63cfd-a4d5-4516-a2eb-7b968a036f7a@nvidia.com>
 <74fd4aa7-5d58-4493-a718-673143611989@linux.alibaba.com>
 <019d19a4-cf4e-4405-8672-b371f116da22@nvidia.com>
 <be589714-9cd1-45fd-8187-8480afb81128@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be589714-9cd1-45fd-8187-8480afb81128@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_083650_555611_EDC7B4D0 
X-CRM114-Status: UNSURE (   6.24  )
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

On Thu, Oct 31, 2024 at 03:00:17PM +0800, Guixin Liu wrote:
> Looks good now, my deepest gratitude for the tunning.

Thanks all, applied to nvme-6.13 with the updated commit message.

