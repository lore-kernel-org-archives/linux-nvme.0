Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8452FC282D0
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 18:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/U7UzWbQh+keSEkUDMOM86mvhS2v5VXUMevqMtVsfbk=; b=0+/5zXoZ8ziWJf8nfZj8SvgXbx
	kHkwBJWcOVd7GihmNL0wQhN3536xzUQPAyV1b4yqd/bLq8okrJfeXcnaXhQTpAlDdGotggM6Bgopd
	D2tMVBWsX2LWNVfoI1YzjlOYG3/MNYHUmty2XXyuAHjFoY4dV9OOrmjdcFHed0gMcj3D7p2azcfmP
	JkW5G6JbXB9NfZTQjDPSzcjgtZKtR2+cauiplGHAFJLpA2L7auPyIx7TTH7lrFa7yqxk3N19cyh1/
	6jOiFwpKMV/AxvkO89orJW/kmRdQ9svYCITidgWNBAnVh694YRMy5e3KHtJkw+aar9zfihkO/t7pT
	XHt1lzew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1to4en-0000000C38Y-38by;
	Fri, 28 Feb 2025 18:00:17 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1to4em-0000000C37b-1i1j
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 18:00:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 21EC661148;
	Fri, 28 Feb 2025 18:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD8CC4CEE2;
	Fri, 28 Feb 2025 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740765615;
	bh=70im7C4fH9IXW7uFm7V0dzMqCVvmg+D95gWFtPw/2VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QU6hIfZV8Oy8PEVUayXnjQ+Q74LvlqTJcw0N5l5iqqPDasy62AlquQ1xpmgB8RSWn
	 OFhb7DZgIUhEXTvx4rcTU+fLqKnNQprp5WDrBHJeeDNYGFHWG2AvtFRsQTtAnyV6Bf
	 iGuBUHguGcKl54UlamrPbrTnQEwrf0zxMsGCRVAPIsm0dmHq+JKGuEseFGL2r21D/f
	 r8kWPx9n539TxXAByHV1WBYkAnYJdPoz6BKTUgdFDYWt4+RYzaUN38PTuFrPDDZVVC
	 gMjjH/I0REVKLnI8GqA4YaCatVEcw1G2gYBnrCcSv4zciLbEnvIhd8+OkVipzXDziI
	 iI31tYrJB3ZFw==
Date: Fri, 28 Feb 2025 11:00:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Meir Elisha <meir.elisha@volumez.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvmet-tcp: Fix a possible sporadic response drops in
 weakly ordered arch
Message-ID: <Z8H5rfGoMEagAHb_@kbusch-mbp>
References: <20250226072812.46089-1-meir.elisha@volumez.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226072812.46089-1-meir.elisha@volumez.com>
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

On Wed, Feb 26, 2025 at 09:28:12AM +0200, Meir Elisha wrote:
> The order in which queue->cmd and rcv_state are updated is crucial.
> If these assignments are reordered by the compiler, the worker might not
> get queued in nvmet_tcp_queue_response(), hanging the IO. to enforce the
> the correct reordering, set rcv_state using smp_store_release().
> 
> Fixes: bdaf13279192 ("nvmet-tcp: fix a segmentation fault during io parsing error")

Thanks, applied to nvme-6.14.

