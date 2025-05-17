Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D875BC2D0CD
	for <linux-nvme@archiver.kernel.org>; Sat, 17 May 2025 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ujTe5y2drFqLe10iZeJkkl2HCeVshI1pIOY1Qn2BYaQ=; b=XvkugPlD7nVx/DDWgB3ifhH5CK
	ga2uOIwstZ/stlouTolC6V/fwFm2AjiDoOpY+JeLlQDfNZyH91xsnHgsSdGFiFLNcV7yjiyEzPAaG
	RXgeHpzwsg+6G7/85ahCofDnWzq4FaSoWcgPjwxiuY70D4YIkOE2xKr4AM/5TIC7yRib4NwKIN+hm
	TebYyxWlby9WSqJebwQxjV/7weyDIySpcXTdX95IAFkfNWYOhgez9jEzjENsvJP96wATnVDVS3QSQ
	NsB0C/wfbBge1z0ZiU08RRhNjh/qKyimz7YIMj5HTFaFPaeotFMwgiQZ/BIxl4jedFzeVkz3fpu+V
	O+QhF/lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGLMR-000000062Yh-29CJ;
	Sat, 17 May 2025 17:30:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGLMM-000000062YT-3VEm
	for linux-nvme@lists.infradead.org;
	Sat, 17 May 2025 17:30:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 91AFC614BB;
	Sat, 17 May 2025 17:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9E2C4CEE3;
	Sat, 17 May 2025 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747503005;
	bh=f81/M7NtWX54f5IpNC9UWQq+EKFTy1NMk2/6m6eqiIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyF5WWZ6HYP3IKMJshPYdOKe7d3oVgEL/l2dTMOrp8n9njs5m4RNI16oQ3PYwDfRv
	 dyEYn5wUnXDzts2G/ROnpJr4I0pUs4rEd20j4Ka3rr2aYDz2WitXJph5Om29lHRnoO
	 CQFIn1KHGD2k5TaLaW4KNucyNR9sjLcsI99PTXYFQAyMpwH9qeJt7HFDuhTR6F9PkQ
	 hFZ7CdfTlO//IYAkI25qnKsFZqy51KWpAmx+3Psexow7i28x+DHjLkibzhqTh2QlPL
	 YvnYyQV2871Jj+lOyjcxnrURlVDMiOHZ3pUSCCn/jc8kkMFSXEtMLRAS5PF62yFZc9
	 TP0FSYBweK/MA==
Date: Sat, 17 May 2025 10:29:54 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
Message-ID: <20250517172954.GA1239@sol>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
 <8b4db290-00c0-4627-a03e-d39a22c56fcf@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4db290-00c0-4627-a03e-d39a22c56fcf@grimberg.me>
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

On Sat, May 17, 2025 at 12:58:35PM +0300, Sagi Grimberg wrote:
> >   #include "nvme.h"
> >   #include "fabrics.h"
> > @@ -166,12 +166,12 @@ struct nvme_tcp_queue {
> >   	bool			rd_enabled;
> >   	bool			hdr_digest;
> >   	bool			data_digest;
> >   	bool			tls_enabled;
> > -	struct ahash_request	*rcv_hash;
> > -	struct ahash_request	*snd_hash;
> > +	u32			rcv_crc;
> > +	u32			snd_crc;
> >   	__le32			exp_ddgst;
> >   	__le32			recv_ddgst;
> 
> Let's call it rcv_dgst (recv digest) and snd_dgst (send digest).
> Other than that, looks good to me.
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

rcv_dgst would be awfully close to recv_ddgst which holds the on-wire digest
that is received.  I think I slightly prefer *_crc, since that helps
differentiate the in-progress values from the finalized values.

- Eric

