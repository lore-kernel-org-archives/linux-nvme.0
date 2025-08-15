Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6DCCA0EE4
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 20:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oxnQyQgQqPX6C+Q7OFkwM3T5WvMZStbMng60BlZqhxU=; b=x3bqLxdtBEGDL9n+9M/BdfcLIx
	efy84+IyiHq5VHih0SbURumSjZjz11fU+AvyHi7ZNlnh/1Y30aBF2zh7jl4QCjZihBZusgxM67IyE
	L+R5aolY9rGNwYT1Yi7BKoi4DH15/KSWS5uuvxJrCcKNkqr3epn6eHk6u7TyELlM1oCUPqJqJjuLP
	F7khGGhjuxAlEJAsevmZzu2laq2Wd3xQi9z5i5GcoGbi/DWx3dtEYZTgiwtUGmDTZOhyHN/nd/fz8
	ZbfWtdeMQIBNid4HHNqUUF4K/h3Ex1d9WbuFuCatS99DwCTzam8ztvm2UMX5pAYjCxvV57Zmmwfcq
	IzklcDWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un0t3-00000003Q1e-3YR4;
	Fri, 15 Aug 2025 20:18:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umxoq-000000034RW-3kEw
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 17:02:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 573CD5C595A;
	Fri, 15 Aug 2025 17:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809ACC4CEEB;
	Fri, 15 Aug 2025 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755277340;
	bh=XmIS/WI/DfVdgXw6f9J2hDX2XYrlFBTAGBPWIoj10f4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SzQO6p9fpOVIuh2yhufraOPMrNzXlYONg07s8+J9gTIW3/zS1xAUSGzoC+j4WvIhj
	 /WbguKtyh7Ip+rusYtcHDHmEp1zrNh0AjN9O3rZOx4TBysINtGCng6YxLxB6labKWF
	 /Zv2a7pLybRrU7xovT4n17Rnh8gi4Hh760N7eICMTOcv5h9ngibiG3zvnNTnQx3DXB
	 wZzQh773PYjW1AyxOP/QOzZ3DlO0cp3VWzGc7pUE4POKCSjJLp/4cuTRk0lQm8UhfK
	 Qha6yaZk+nAjRjLdZQKK25bGUZ1VYisX0GvwCcMI5EFh6uteY6TYxznG9MbsOKpOtJ
	 Z6V4qnUkWVWjw==
Date: Fri, 15 Aug 2025 10:02:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 4/8] tls: Allow callers to clear errors
Message-ID: <20250815100218.4a492986@kernel.org>
In-Reply-To: <20250815050210.1518439-5-alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
	<20250815050210.1518439-5-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250815_100220_975941_F40CF73D 
X-CRM114-Status: UNSURE (   8.57  )
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

On Fri, 15 Aug 2025 15:02:06 +1000 alistair23@gmail.com wrote:
> As part of supporting KeyUpdate we are going to pass errors up to the
> callers of TLS to indaicate a KeyUpdate. Those layers will need to handle
> the KeyUpdate and as part of that clear the error.

> +static inline void tls_clear_err(struct sock *sk)
> +{
> +	WRITE_ONCE(sk->sk_err, 0);
> +	/* Paired with smp_rmb() in tcp_poll() */
> +	smp_wmb();

Please explain how the key error ends up recorded on the socket.

