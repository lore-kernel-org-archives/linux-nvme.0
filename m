Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03596D7494C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 23:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VA06gp2Z0bt4O2No1NCXs7q16644gFfp3/mTAzsLKB8=; b=lrfvqmzANIHzLHKtiyp028lhmp
	htwtudwOcLhDsNNUwyWHyYKKNCzrMLQJODt93oWGEbSy42F7Ni7wRMnRYcJJm5GUpYPLDIvwYjFGi
	O9V0zxB/Y45gziRFo1JKq+tYbgpq3iRNsBfgABk1KD8EUC7ljG1fXunJGxIPJsESFyAbtc20SK02Q
	YaLXvzmNTPWiUxc0cTttvBQLLZGrIPYBjmM9ZCZWspG1XF7D+ZhjB9OA3p48LH3os61ACsfTT8wad
	ac5GPltx4fS7Z6tbT+Uu7lLjSWwlNJHIaCliicVISi4QHYy+SvWnYuaXFTuejv93hQbXBokxZrQw8
	WWdCmkXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5va9-0000000G9rz-2G0B;
	Tue, 29 Oct 2024 23:25:01 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5va6-0000000G9qr-2dI5
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 23:25:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 17AB9A43544;
	Tue, 29 Oct 2024 23:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF91C4CEE3;
	Tue, 29 Oct 2024 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730244297;
	bh=5ITHqbWzAxBN2O3CfNPZlYSbccUPmxNcsdv/k1wZngY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcEIzXp+tfvVvUNURdk2SUgAXMb9xMsyCuJw8u1I/7arTS9xFYlFasZEZy2LB+AaU
	 cYy34kbm5DQ0q2D8xLdWEvHBgRtA5aDrv23CMY0dwpFYVPQ2x39rZ5l9zLR0360zEh
	 hdUfh3aRzAtgu2YHzgJJdHOgn7Ga/Fkd9BhXDvKDAxtm1mGYIi8I/t4aMio4AsL2j+
	 TS/wiKYUfmCGx44aN4IfJ3l3MFjFTzWwnMphpbUpZD94mz8MKh+YJ7ELGT3Gnb2gJe
	 d/yMn58h3JsAiYfxTD7pRBe0Ig9ax163xsoAiFzXO/BGuZ3V/eqrrTzmGl5a8znzBR
	 AoEXBnKGHIU1w==
Date: Tue, 29 Oct 2024 17:24:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	asml.silence@gmail.com, anuj1072538@gmail.com, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v5 06/10] io_uring/rw: add support to send metadata along
 with read/write
Message-ID: <ZyFuxfiRqH8YB-46@kbusch-mbp.dhcp.thefacebook.com>
References: <20241029162402.21400-1-anuj20.g@samsung.com>
 <CGME20241029163225epcas5p24ec51c7a9b6b115757ed99cadcc3690c@epcas5p2.samsung.com>
 <20241029162402.21400-7-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029162402.21400-7-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_162458_756769_5E96C6AB 
X-CRM114-Status: GOOD (  14.71  )
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

On Tue, Oct 29, 2024 at 09:53:58PM +0530, Anuj Gupta wrote:
> This patch adds the capability of sending metadata along with read/write.
> A new meta_type field is introduced in SQE which indicates the type of
> metadata being passed. This meta is represented by a newly introduced
> 'struct io_uring_meta_pi' which specifies information such as flags,buffer
> length,seed and apptag. Application sets up a SQE128 ring, prepares
> io_uring_meta_pi within the second SQE.
> The patch processes the user-passed information to prepare uio_meta
> descriptor and passes it down using kiocb->private.
> 
> Meta exchange is supported only for direct IO.
> Also vectored read/write operations with meta are not supported
> currently.

It looks like it is reasonable to add support for fixed buffers too.
There would be implications for subsequent patches, mostly patch 10, but
it looks like we can do that.

Anyway, this patch mostly looks okay to me. I don't know about the whole
"meta_type" thing. My understanding from Pavel was wanting a way to
chain command specific extra options. For example, userspace metadata
and write hints, and this doesn't look like it can be extended to do
that.

