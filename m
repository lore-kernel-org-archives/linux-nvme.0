Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2B4C48BF6
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I26RqWdS27Kau7kmPZDT4r94pxp5QbU1dol2UaWqmXI=; b=MdlLCYbpUwP6hkzAO+2aCBZphh
	IUV1sRoSdAJAy7YFB3OOdDyxFrE234y9dh0bH2edL7xMFa0g8uiXy+3kjJgFgrIgaFhZp0Q3QYPWs
	rpnU02zdrDv+yTgPAbZsP7XbCRlicAc5NRHjyiKP/3bE8lnYW28txj4reO07/CTIOOU3k81Aa777L
	WokR+zjufZ4EGJJre6m3rCg811bFajSimlb2UY13UfyFSi6oN30aTpqRp3JhbPcSP5fhq7IE6HlB6
	gGcJLv7BVi0j3JvxC2djReIaFPqC0CqyQXzrOVrhx+P9gx76vgmWG6Uoan/Nkc1uzr3s/BgmplltB
	FodDW0PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhBEf-00000009qS7-3wRw;
	Mon, 04 Mar 2024 16:32:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhBEd-00000009qRE-2WLZ
	for linux-nvme@lists.infradead.org;
	Mon, 04 Mar 2024 16:32:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1110861086;
	Mon,  4 Mar 2024 16:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33062C433C7;
	Mon,  4 Mar 2024 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569934;
	bh=I26RqWdS27Kau7kmPZDT4r94pxp5QbU1dol2UaWqmXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZJkKXrwfJhO/yLUO4AtC1EJ8LhxqUHll1l6T28iBtK//pKNC5k7Gu0H65g6tfedF
	 DJ6lvj/xi2/Yg4ZIrMJlsONYN3RhtfLFgPSrrJhEehT4P38nLA5Jw4TGYzE8NdB575
	 w5qhaKbtK3Wa1RqZLU6A9H+iGLJZz29twLMPoFLeqoD3g28v5grBHbLkBKwxY0o6Z3
	 fOUi+usvMVVXEeg8nJ2jKqVqfDdMxT3o/1XkI14K+G7ihD3Y0tB6jsGED+P7BwCWLl
	 ze5rlECHnHb5RNKQ/UrD8pg8LQ6wkUcqLZUIFlJoPtjfZ/ZUa9qJyHW97HAXkXWpGk
	 dj+7d+aa9D8jw==
Date: Mon, 4 Mar 2024 09:32:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	James Smart <jsmart2021@gmail.com>, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v2 0/2] nvme-fabrics: short-circuit connect retries
Message-ID: <ZeX3jMpzFjjjjIKV@kbusch-mbp.mynextlight.net>
References: <20240304161006.19328-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304161006.19328-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_083215_705143_A20D843B 
X-CRM114-Status: GOOD (  11.88  )
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

On Mon, Mar 04, 2024 at 05:10:04PM +0100, Daniel Wagner wrote:
> I've picked up Hannes' DNR patches. In short the make the transports behave the
> same way when the DNR bit set on a re-connect attempt. We had a discussion this
> topic in the past and if I got this right we all agreed is that the host should
> honor the DNR bit on a connect attempt [1]

These look good to me. I think, though, if you're submitting a patch on
behalf of another, you should append your 'Signed-off-by' tag after the
author's.

