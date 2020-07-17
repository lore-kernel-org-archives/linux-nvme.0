Return-Path: <SRS0=QPGu=A4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81BDC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 02:32:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F402070E
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 02:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q3MTpBG3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLmGMSW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F402070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ppw1Z2QLHH2qVvxqBDy8Sk7M0i7c9k0WX7SAYF+uNHg=; b=q3MTpBG3EAb32rM76cYR1shnx
	HotshioZVmt8zWbh0TB/9eYWKCp7m3C9cNmCSpZMTPydJK+0MiYFQVQzBbUFqsRt0FUErqb2Gp9xe
	vZXts3K80ICz1llnYGf+Ub+JsaLbDlZe9MT+mN4MBB74HwisE6KTYX/ZyIZQnwIKoHMHQFF2462MZ
	nWKyBpSqZquVxWcsmfZD+4Wb9X0apBt2CAKMVze1X193m+1+1ZEFdfwoZWGL6qA3K7ITBqW/0jDKY
	+IdIbr6N6x26z2tGcRe2sX0EoqY7kArUq90XKSQ7v366VCrBLHsXgachNE4FOhVW0Zon5LW8vXUeK
	ZnWzNwhVg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwGB6-00050M-KV; Fri, 17 Jul 2020 02:32:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwGB4-0004zz-Es
 for linux-nvme@lists.infradead.org; Fri, 17 Jul 2020 02:32:47 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2EA402070E;
 Fri, 17 Jul 2020 02:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594953164;
 bh=43mwSR3LlDG9cyORsj7ieWJ7gs7MgtUbOOUowgnbzW8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RLmGMSW8vBYQK6tpjl32dtGeJbuiNq0XAuFMsjTKp9K+dPeQY1vsboH6rKJq//K6l
 GLLnQ5oJYg7JPGXiGUsLqLDbaDP8o92Kf1RpwpBftpnLcl+UhXqfmm0ZpLZtLAg+K+
 mGnEaonkY9XOu4tEPWP7asTTBM4dIGw2mN/Cl0pM=
Date: Thu, 16 Jul 2020 19:32:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V4 3/3] nvme-pci: get rid of the division in the fast path
Message-ID: <20200717023242.GA322692@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200717005139.18923-1-chaitanya.kulkarni@wdc.com>
 <20200717005139.18923-4-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717005139.18923-4-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_223246_662742_6F7B3737 
X-CRM114-Status: GOOD (  14.70  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 16, 2020 at 05:51:39PM -0700, Chaitanya Kulkarni wrote:
> Since we have a macro for calculating the size of the ctrl page we can
> remove the division in the fast path for nvme-pci in nvme_unmap_data().
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3c852a8f18ed..616db1ae137c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -513,7 +513,8 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
>  static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -	const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
> +	const int last_prp = (NVME_CTRL_PAGE_SIZE >> ilog2(sizeof(__le64))) - 1;

This is an integer constant expression, so the result is already
evaluated at compile time.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
