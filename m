Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D22EFA1FED
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 20:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SjrwhuTh1kXk2rqAACRgiGnhBl8VOW5XlWX5B8IOozw=; b=IvruUAwKhbGrihRX706CvfY08x
	AyxI7k1iuiDOYbirSg5iP4Cg6e01XDRJtagdte8geg5qOKUsmCSqDIcBtvQ5+8CogFyvQBHzPYPfI
	wY1H1o2pEBL1JtOkT6Fi+oQ/4ouht6iYTncnjH6DkK6lfLvJU96D3ZnjK+AbGNMZ26v52yo0QC+Sq
	Sq9lsVHxmeEAuhhqPX2xQ+40Q7qnerAV3dEEd65vW05jiq2+LgTUgf+MgIgjct2UafpSunS5ON8Qj
	bz3EtMUPibczptHCK4Tc0LSTB3ImTI3TQ+R/dxiWzqP1/TANq74mv/gLzrf0zVAkUchh7CwfiJ0Qc
	syObZqJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFdoE-0000000Aho0-3bop;
	Wed, 22 Apr 2026 20:04:30 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFdoD-0000000Ahnp-1chC
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 20:04:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5C1E661863;
	Wed, 22 Apr 2026 20:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71E4C19425;
	Wed, 22 Apr 2026 20:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776888268;
	bh=HQDN14+srPqkkOYrDGk7nqd06U6qAsFN7b7a9efJ4Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qxbcm5/ouS8CzxQXJzUdQRw39hRZTkAL9N9zL2rUlOVDnZCG7wJyfjDqsCmfe+GyU
	 SnhWCgOIMlLZEmisDx0C0JfGMlGFCfE1pi/KMyxBHIJSfkBs72ktVormzVd+h5VXQ7
	 pz2Vv9ybl98TQPqGEkt42OiBbieA2usBCTH7qJ85b7CWPMEZiyFGBKwjkaG1DqxN0v
	 aihJU6qQ0jDL5zvfY7pofey8d47xpLs5bzO0qLNjDBt+tmHqRGBdg/08qGKBVNL80W
	 eqo4QtTXDsKS2EsaoG3FB9gepA2Pfkz342dsuINd5PTHqLMuJZWQ7WOxlDuFt5WyLd
	 CCPEdDyzufg3A==
Date: Wed, 22 Apr 2026 14:04:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 REPOST] nvme-auth: Hash DH shared secret to create
 session key
Message-ID: <aekpyfAzqqIN6oKU@kbusch-mbp>
References: <20260422190636.2651992-1-cleech@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422190636.2651992-1-cleech@redhat.com>
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

On Wed, Apr 22, 2026 at 12:06:36PM -0700, Chris Leech wrote:
> The NVMe Base Specification 8.3.5.5.9 states that the session key Ks
> shall be computed from the ephemeral DH key by applying the hash
> function selected by the HashID parameter.
> 
> The current implementation stores the raw DH shared secret as the
> session key without hashing it. This causes redundant hash operations:
> 
> 1. Augmented challenge computation (section 8.3.5.5.4) requires
>    Ca = HMAC(H(g^xy mod p), C). The code compensates by hashing the
>    unhashed session key in nvme_auth_augmented_challenge() to produce
>    the correct result.
> 
> 2. PSK generation (section 8.3.5.5.9) requires PSK = HMAC(Ks, C1 || C2)
>    where Ks should already be H(g^xy mod p). As the DH shared secret
>    is always larger than the HMAC block size, HMAC internally hashes
>    it before use, accidentally producing the correct result.

Thanks, applied to nvme-7.1.

