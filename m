Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17F8C56205
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nUvKDTbVZtttTCFTYuamcqVrLr0sSKD0scPXK/a+ohQ=; b=hKLjRcnbz5qFnY0YbQ3Pto5BDY
	8ti7jYYbXUN+kPU1fnXZbc0tRO6aTGRiU/gb75fCEQmvQiuq8gWoKkkS7Bki44mUQREbRYxFje1PX
	IA48YTpB4kxI5Bdy82EozMvMgMcJXnhgxscwDBk86LbA9byC1UT4swbB3LFCM+hjwAtNX9MeGtyhg
	pq0j3xFUGD6hXwA6vgIsLGptVgR7AcvXOITNWaLzf/NQdzYq1tAZhM07aBNi69gTlUzWJjezamrqS
	vukAUlZTjwSKieJVBAPsPjUGZKi4POwUNlGVLMNm1rbRUD/vetDhhtqRmd37ZWbd/dyRzFNMYz1D2
	1DnO8gJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrx9F-00000005lck-1H7J;
	Thu, 06 Aug 2026 12:24:33 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrx9B-00000005laK-1Ja4
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 12:24:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=XXRyQX0fnP4m5e
	SqIAWzgNY40FmSTS4FHVT+kO2xicw=; h=in-reply-to:references:cc:to:from:
	subject:date; d=arkamax.eu; b=cCXgps5MzlA+mXrNiNkkceQVKfvtx0N3BfiWeqYc
	GYa4NqKuNTqNIvraq9q1V9M3ybWWEiAldskgMs5aj8TZu2eIX+gYb42v81bcfdjqIRcCON
	6QJGZYlV70wDREghthjbvJXgT+FAaSm77Rjzcb6ZFT4y9jbbFj2LGNxTZf/PgiAAGqnIUQ
	CFtBaaZem36paPp98X0bt4F2hcX2X3xJybMm9d2xAKJqw4L6L45b2vO20YUVFTQUlIs4/C
	zp69weaC9s4YQAMjsekVVd9CK787VukSTntZ/SW0Dq0jB+kQLCGqxM8imBGTDL0dcgm+eZ
	IWGRK7EmueqTsD/4Z7+IsA==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 65e027f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 14:24:20 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 14:24:19 +0200
Message-Id: <DKHUX16DSA52.46FZOG8TB6T1@arkamax.eu>
Subject: Re: [PATCH] nvmet-fc: fix invalid free in LS IOD error path
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Jiang HongHui" <jiang_hh2019@163.com>, "Justin Tee"
 <justin.tee@broadcom.com>, "Naresh Gottumukkala"
 <nareshgottumukkala83@gmail.com>, "Paul Ely" <paul.ely@broadcom.com>
Cc: "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>, <linux-nvme@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260729110206.207755-1-jiang_hh2019@163.com>
In-Reply-To: <20260729110206.207755-1-jiang_hh2019@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_052430_783605_6530C7FF 
X-CRM114-Status: GOOD (  17.61  )
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

On Wed Jul 29, 2026 at 1:02 PM CEST, Jiang HongHui wrote:
> nvmet_fc_alloc_ls_iodlist() advances iod while initializing the LS IOD
> array. If an rqstbuf allocation or response buffer DMA mapping fails,
> the unwind loop decrements iod past the start of the array. The final
> kfree(iod) therefore frees an address before the allocated object.
>
> This can be reproduced with nvme-fcloop and failslab by setting
> fail-nth to 6 before creating a target port. KASAN reports:
>
>   BUG: KASAN: invalid-free in nvmet_fc_register_targetport
>   Free of addr ffff88816cf8ff48 by task nvmet_fail_nth/9552
>
> Free the original allocation base stored in tgtport->iod instead. With
> this fix applied, the same sysfs write with fail-nth=3D6 returns -ENOMEM
> without any KASAN report.
>
> Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Jiang HongHui <jiang_hh2019@163.com>
> ---
> Tested on v7.2-rc5 with CONFIG_NVME_TARGET_FCLOOP=3Dm, CONFIG_KASAN=3Dy,
> CONFIG_FAULT_INJECTION=3Dy and CONFIG_FAILSLAB=3Dy.
>
> Before the fix, faddr2line resolved the fail-nth=3D6 injection to the
> rqstbuf kzalloc() at drivers/nvme/target/fc.c:542, and KASAN reported
> an invalid free. After the fix, the same injection resolved to the same
> allocation, the sysfs write returned -ENOMEM, fail-nth read back as 0,
> and dmesg contained no KASAN, invalid-free, BAD_PAGE or Oops reports.
>
>  drivers/nvme/target/fc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index d16170755..1b557775e 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -566,7 +566,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tg=
tport)
>  		list_del(&iod->ls_rcv_list);
>  	}
> =20
> -	kfree(iod);
> +	kfree(tgtport->iod);
> =20
>  	return -EFAULT;
>  }
>
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff

Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>

