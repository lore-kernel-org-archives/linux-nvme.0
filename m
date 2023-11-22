Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC538C61D97
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Nov 2023 00:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8JfFhIfRkyQhWRqV2I8z47v7LQI+VTNjHUUU1GDcn08=; b=yquie5ZHVwj5gNjiFBlWyqjsV1
	0FXOuDCCpVqiOv/oeius/497/l5h5OJFpq4dszwlBrYkX6VoiSmwdQsUFAdNxGhMviQzAcZNawkjV
	etTSVJHLcv4kOFClPWoICcAIIoU8oiYvZqkW5KsY3OpdxWvIg+cbvsaNCWO3i+5UdkazMiDERfRej
	vfghlI2TWQ0dk69we9+S+ZA81hINSD01K04WwkFCEokdZGWsoNqrhf1kv7/N4+3nW3cJCnUdJoTrx
	F+vZyJvbjDG9dCWMDSbhfs2xxjAw9dmpRzpchUpUfqIyFFvcpLNn1ZqVLSKRoDDFBwdBJz8LUGUwp
	dd9xIWiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5bVy-000MFZ-0S;
	Wed, 22 Nov 2023 00:54:50 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5bVu-000MDu-1Z
	for linux-nvme@lists.infradead.org;
	Wed, 22 Nov 2023 00:54:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id EA6AECE1E8C;
	Wed, 22 Nov 2023 00:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B154C433C8;
	Wed, 22 Nov 2023 00:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700614480;
	bh=u2D2TK5J9yvcZIFrTPk8qSx9G+KhwoNjbJNTBr4Lkm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnNvymB2+kFeYw9PdwPmHqlZJWw8A2qXUFP4zLECwZkcPKbNdYe2viMbaBUgdoBLj
	 2PbFFJCDiU7Ng3BTcJ4hiYkL9NHW49VzRIIIDhN96Tm3gCIW+NDlFc2Er6uvtz5bNo
	 o0Muvl6uLG71Vy3Jb48E1Ucj4IBIypByRxDp2RkAb82rkC5GD4Jmbwg0gPCPZU+Qy4
	 GdFRVK5oKtEifttXGP4kakNdTeADEZFGHDKktttjYMJ47lMlhY0iQ2dOoNJsvlDqgG
	 0aB5JRzS3sllQJEt1O3pe26LCkFObz6+/hhsndRRNEZ+Ah3Vr7tsGRiuBiwnf9OYam
	 ijupJ5VcaTanQ==
Date: Tue, 21 Nov 2023 17:54:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, joshi.k@samsung.com,
	martin.petersen@oracle.com
Subject: Re: [PATCHv3 1/5] bvec: introduce multi-page bvec iterating
Message-ID: <ZV1RTKkKUkNybFuk@kbusch-mbp.dhcp.thefacebook.com>
References: <20231120224058.2750705-1-kbusch@meta.com>
 <20231120224058.2750705-2-kbusch@meta.com>
 <ZVxsLYj9oH+j3RQ8@fedora>
 <ZVzRmQ66yRDJWMiZ@kbusch-mbp>
 <ZV1OxMPsJYq7Tyaw@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV1OxMPsJYq7Tyaw@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_165446_759346_287A2B85 
X-CRM114-Status: GOOD (  11.59  )
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

On Wed, Nov 22, 2023 at 08:43:48AM +0800, Ming Lei wrote:
> 
> And you can open-code it in bio_integrity_unmap_user():
> 
> for (i = 0; i < bip->bip_vcnt; i++) {
> 	struct bio_vec *v = &bip->bip_vec[i];
> 
> 	...
> }

That works for me. io_uring/rsrc.c does similar too, which I referenced
when implementing this. I thought the macro might help make this
optimisation more reachable for future use, but I don't need to
introduce that with only the one user here.

