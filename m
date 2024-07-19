Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C639AC3DA59
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 05:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/P7V19CJKvrDy8szdOhLAkx5jucB52c1pEl1GLyZuFY=; b=JanKSne88pjeRMy6hBOEW1aca+
	BLqaufcJHjLDidTltiWK67M666M+bGJiutVUbQzWNEEoxdWpTVI1iC7W2xil+PRTD5cc1Wggi8Vxn
	rVhExEpI8Kofm4DkSwKi79akjwfMrE7MU2y/t9akYA8LNAvqPvNfUDeMCn/09/AzM8GBs74kbqSi8
	d4KI8Qrgs8rhSfg0EurDW+wcGMfSa7XLCt4uI/AjYfS2HaO6gp4WRVn/cD7EjkWy3LXFtzYmMwys7
	O9LkTX/S1zxj+Go74mPCvm7qVoarSVy9EfHfIlBogaYXG+E1AWgShOVFKQz9hGnzdoRRzCyrhlaDW
	hyxEKOlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgGT-00000001ed9-0a4u;
	Fri, 19 Jul 2024 05:34:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgGM-00000001ean-0Ex8
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 05:34:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9886A68CFE; Fri, 19 Jul 2024 07:34:33 +0200 (CEST)
Date: Fri, 19 Jul 2024 07:34:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/8] nvme-keyring: restrict match length for version
 '1' identifiers
Message-ID: <20240719053433.GA21535@lst.de>
References: <20240718144858.19074-1-hare@kernel.org> <20240718144858.19074-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718144858.19074-2-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_223438_260975_198C4611 
X-CRM114-Status: GOOD (  17.16  )
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

On Thu, Jul 18, 2024 at 04:48:51PM +0200, Hannes Reinecke wrote:
> TP8018 changed the TLS PSK identifiers to append a PSK hash value,
> so to lookup identifiers we should just consider the length of
> the match value, not the length of the identifiers to compare
> against.
> And we should modify the PSK lookup algorithm to prefer v1 identifiers
> as they can be uniquely identified.

Can you reword this a bit to remove the weird "we should" and state it
in terms of requirements / recommendations from the standard.  Bonus
points for adding actual references to the specifications.

> @@ -109,19 +107,38 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
>   *
>   * 'Retained' PSKs (ie 'generated == false')
>   * should be preferred to 'generated' PSKs,
> + * PSKs with hash (psk_ver 1) should be
> + * preferred to PSKs without (psk_ver 0),
>   * and SHA-384 should be preferred to SHA-256.

Please reflow this to use up 80 characters and make the paragraph easily
readable.


