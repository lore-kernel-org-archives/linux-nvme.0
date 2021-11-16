Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D98C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 02:18:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C59B61B53
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 02:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C59B61B53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xvda9FYT5jDU+zGU+1tzGaGXcVF+Tg2WK50MASMbLcA=; b=OSak1Vi6Wo5BTJORvxtrGAPJbZ
	MkF/EpGXGDbY4sijLyG9cvUmDk4+Ug5Pt2fp8nbobAR1WzVw3W41fRJfztow8qppI5+ugt5goQjsP
	C690E3U26SUezHuJS0zV3ihUK7+s5lRnWtsxOBhYqzhXz3YpE+t3R5Gpmz4efmAdCLradYac07oZ+
	+bHi8xU2WJ+Mcv1tB6uQGI7WJx1d7J2QL5JAUtkhHbn6xnr02u46gpt+WpWAA1cxi3tNuxq7Ona8j
	amf+kWJkUj9tcOjJwZCSckkuK6x5IiTGvBgLdIDvWjkLOIgmUmUVCsqzUnq1lFOuuEinBzzW5K8uH
	sZu1Vf1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmo3S-0003Hu-2r; Tue, 16 Nov 2021 02:18:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmo3P-0003HP-2j
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 02:18:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E8DC61B48;
 Tue, 16 Nov 2021 02:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637029114;
 bh=nwtQ2BuA4jjkKv9oDvDBUHBpXvg6ursXnj34x2uxWmA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hkyf+dRE4U89/z72GQSbQnlEv8IqZlhaW0aVAcq16betXGGmWxBLAVFOUxljt7Uo+
 tDjIOrkJ5M+ohTseL6kWsoo5IOtKDUkXKZxEWCcifk8lMSLDM5tQP8PKQ3EdTTzwOw
 gdetMyR1UWnklV/qc3Nz4QK7N6gofcmtdLNhGpWAtYc/WGGEJ4ZH9bv4Ne+t0FGluz
 6HtFk7w9SGnJp9kUQz5ctoVIYFW1swCaZMNcRHvW4hD2yrtBg9d5fclj2RviTonnsS
 SmxHyrIkIcsy8OdFsielsxlZqNvpElxbzATpYjmThsTE7So7ocU08N8yr3wLTRw286
 22AexI2VkjQxA==
Date: Mon, 15 Nov 2021 19:18:32 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: honour O_NONBLOCK during resetting
Message-ID: <YZMU+DUJpsD7uMHY@C02CK6ZVMD6M>
References: <20211111105953.63072-1-hare@suse.de>
 <9c8da771-c5f9-923c-4c03-5d5ac8392ef8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8da771-c5f9-923c-4c03-5d5ac8392ef8@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_181835_164932_3FD9B697 
X-CRM114-Status: GOOD (  14.73  )
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

On Tue, Nov 16, 2021 at 01:40:04AM +0000, Chaitanya Kulkarni wrote:
> On 11/11/2021 2:59 AM, Hannes Reinecke wrote:
> > When opening a controller device node we should honour the O_NONBLOCK
> > flag to allow the device to be openend even if it's in state 'resetting'
> > or 'connecting'. This allows user-space applications to use a call to 'open'
> > to figure out if the controller is present, even if it's currently
> > undergoing a reset.
> > 
> > Signed-off-by: Hannes Reinecke <hare@suse.de>
> 
> Will resetting and connecting ever result is deleting the controller due
> to error cases present in that path ?
> 
> If yes then application will have handle for something that might
> go away in the future, should allow such a semantic ?

Resets can happen at any time, so they already have to handle it even if the
controller was live when they opened it. Perhaps the open should succeed for
any non-terminal state.

