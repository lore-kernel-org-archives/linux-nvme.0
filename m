Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396DECC6B16
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fRac/ENAf8sbWAIo8siY+nB/tJsXS7y2nHVsGkQK6zk=; b=QKMhrSw3qnC7mTQHRZ/0ooKjQW
	MCFfWcaSahqWMNaD6PUzrfnumBlqymNi0LWZUdhkrnZ0c9c1LL06HSmNLhF/oClAZkX2p2FoSaxx5
	HjqGi/XhuDhrYW4ysiSHINQAo+9YFHUThJoTMz1eWGM8Yi9g/JNiqGWw2bEez8bg8S+ItCUo/DCZb
	/WsVbVP0Ji1bCuGQOUph+kDsLsnK+n3xg7Rzbrae+pdClLoZNqSvMNQtYFT45chPqBgbD0noYVigc
	YhcXX0gLRIc4mha4GEA1YjlSKsapQa40i14+6zddUP4/URHSvxPfPB8yLPxzaVUPjaRHmqJjWD35G
	olmIP8tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGea3-0000000DNLl-1AiK;
	Tue, 13 Oct 2026 15:38:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGea2-0000000DNLG-0xox
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:38:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D291740AB1;
	Tue, 13 Oct 2026 15:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B31E1F000FF;
	Tue, 13 Oct 2026 15:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905897;
	bh=fRac/ENAf8sbWAIo8siY+nB/tJsXS7y2nHVsGkQK6zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ioCEEFu0T8VAMITdUgiseYpyrNZcylEasjSvB/52gdAjb7MpKfrigZtNehfc+4O84
	 2Ss8bW/XCj2GFuOxCy6cOYxU46pWWLTwCcd7b1HZrrdZCYZ+nGo8aOxHnIt5ihnjpF
	 Z7NPQyj1Zc9vJhkveWnIGur253+R7yMWwG+Hya6gTdSJyZb1pAkFtEocNRxNd0ym1P
	 spj4AajzxqpabqMXQctdPSjUdoPYMgy1d/xosgLDq1wI8fL5yRGp3BiEd+oLoQMHxE
	 Oecrk9BVgP0BFNMaK7fAjJDdC/Hjrn52mn+jFmuGaTp6Mjv4XTJ29jNfkVuQpcvRXr
	 eumrKq3nLrozA==
Date: Tue, 13 Oct 2026 09:38:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: serialize access to DH-HMAC-CHAP state to
 fix UAF
Message-ID: <as5QaLgssz5ZK7IB@kbusch-mbp>
References: <20261003210154.2453077-2-Jeremy.Jean@oss.cyber.gouv.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261003210154.2453077-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

On Sat, Oct 03, 2026 at 09:01:55PM +0000, Jérémy Jean wrote:
> A REPLY AUTH_SEND command can derive a dhchap_skey key while a
> concurrent AUTH_RECEIVE command observing this REPLY state executes
> the failure path and frees that key. The REPLY command then continues
> and writes into freed memory, causing a use-after-free. KASAN reports
> it as:
> 
>   BUG: KASAN: slab-use-after-free in __sha256_final
>   Write of size 4 at addr ffff88800359c540
>   ...
>   nvmet_auth_sq_free (drivers/nvme/target/auth.c:237)
>   nvmet_execute_auth_receive (drivers/nvme/target/fabrics-cmd-auth.c:621)
> 
> Add a mutex to each submission queue to serialize authentication
> commands and timeout handling. Unlock the mutex before completing
> requests and ignore outdated timeout callbacks. Limit timeout delays
> to prevent immediate expiry on 32-bit kernels.

Thanks, applied to nvme-7.4.

