Return-Path: <SRS0=XP6N=CS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0094C433E2
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 21:27:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EBE20BED
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 21:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0ikp+wny";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWLIoASh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EBE20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wxQA4jj4bIzVFOurKKqSVqam1aQblMN9TPLqvCZpZA4=; b=0ikp+wnyyyGwTJDs+nV8jPjNR
	9Y6UXKBjt8zrYHD438w6xgzg8RbTEFDwe48cv46V147vUeCTHyGPmc/lHc/hxnOkca+H5xzSLOMyc
	MFT5391jlBoZwSsGvDPga/Aq316M7HcfccuaDLT/Bg2M4m9Zirw5bQRClSD/UQA/4+sPlEyyXjel0
	OkAxVRCGoPKDXswKFegSsmtapFO1KewTmNejKnWs6mldFz3BMPgaHWBLmAfmrTrPKv6kLyHHJaNss
	ggcjD2UEU0uylnN4b33a2w0NaIgaQ0S9D1OJExzqslyLofy2EyNrYpyC71aa1No9UdsuSfGN3RmV9
	V/plpBPQA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kG7ch-0006D8-SE; Wed, 09 Sep 2020 21:27:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kG7ce-0006CY-VK
 for linux-nvme@lists.infradead.org; Wed, 09 Sep 2020 21:27:21 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A38A420BED;
 Wed,  9 Sep 2020 21:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599686839;
 bh=V84QayIaOCCJqrZHrSlO7i2gQhXrvov7Us9JdEU/+KM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CWLIoAShc0ZklAn+eNhyqVBtPa2IJmnHE2a+3THgyUcF+FZSIcF4wM3T8bkVY/N0R
 kazY79+b1y7FPLwT0agIifKOTAGeyC+HaL+T2PPNivmDqoUVPhVRmVQ4nFkNDaqV71
 hcHs2893us6SanHzaecV5T583Y1/pHGkZpAqD2kE=
Date: Wed, 9 Sep 2020 14:27:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH nvme-cli] nvme-status: Don't reduce all negative statuses
 to ECOMM
Message-ID: <20200909212717.GB3384631@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200909212129.309888-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200909212129.309888-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200909_172721_090677_9AB2D91F 
X-CRM114-Status: GOOD (  18.38  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 09, 2020 at 02:21:29PM -0700, Sagi Grimberg wrote:
> There should be no reason why we should reduce all the semantic status
> codes we are getting from the device/driver to a single meaningless
> status code.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  nvme-status.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/nvme-status.c b/nvme-status.c
> index a78c1fd02797..29982541466d 100644
> --- a/nvme-status.c
> +++ b/nvme-status.c
> @@ -142,7 +142,7 @@ __u8 nvme_status_to_errno(int status, bool fabrics)
>  		return 0;
>  
>  	if (status < 0)
> -		return ECOMM;
> +		return status;

Shouldn't this be 'return errno' instead?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
