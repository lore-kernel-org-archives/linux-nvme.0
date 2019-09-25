Return-Path: <SRS0=H4mI=XU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FBCC432C2
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2019 21:36:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 339B320872
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2019 21:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="otKSiMj1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BImGnchE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339B320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hqMyjv8VYTCfK/8WRQmnK4qglmUedZA/3mG8DKpmtVw=; b=otKSiMj1brZ12c
	vKHvcXYQ3SjOKFLQ2bN6Vz0+PyLLTRgvz5A5jOw7O/kF83XIJAB4VarjcOMwNpK1rCTcLSLk8LGcG
	66NsRun9iWOvpcQ6RsscHAhqN48kabxgM/9lqgGK0QqvaGsu+JO8eCoTo5rlNSioigUYxSDhs8XiD
	jXfkjop6bu7WVzvEx759vyhkZ4/HNCL2Gi0Db31jnmJ5R2yZotppgwBwLX7j5yB4Waisdhz217A51
	XZJfMCYedfxWQrSUb1CqQ9GNOZWxUDnjc4dalSY2E3eyZ4cqEEO9IMW3o+oRAVwCqajliTvsdqvcS
	K0RaAi0EzhKTl7c7CR0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDExZ-0001h0-Dm; Wed, 25 Sep 2019 21:36:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDExW-0001eI-La
 for linux-nvme@lists.infradead.org; Wed, 25 Sep 2019 21:36:28 +0000
Received: from C02WT3WMHTD6 (rap-us.hgst.com [199.255.44.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E3B5A20872;
 Wed, 25 Sep 2019 21:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569447386;
 bh=QC0u3XMA0nF5eJQzGFD0cLsBChxWfnkO0vLwNCeBCDQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BImGnchEgZB7fhM4qgrSbw0on2D1KQTMZ1FqTChCMjp5hTJwrRurS/dEh9j/lwwR9
 djRR8ma6RvsV/v+j43cuVZ4wBhc+Ul8z4WtLmA1oZPLR58+A7O+YCHCdEfGL1n9xog
 K/bhQgKH5q1QfmWE2fpVn1pdiXs20sng+csNGFdU=
Date: Wed, 25 Sep 2019 14:36:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvme: Add ctrl attributes for queue_count and sqsize
Message-ID: <20190925213624.GA11469@C02WT3WMHTD6>
References: <20190924212208.3637-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190924212208.3637-1-jsmart2021@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190925_143626_754110_8C79A449 
X-CRM114-Status: GOOD (  13.72  )
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

On Tue, Sep 24, 2019 at 02:22:08PM -0700, James Smart wrote:
> Current controller interrogation requires a lot of guesswork
> on how many io queues were created and what the io sq size is.
> The numbers are dependent upon core/fabric defaults, connect
> arguments, and target responses.
> 
> Add sysfs attributes for queue_count and sqsize.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>  drivers/nvme/host/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e0e2dcbfd05e..b1c24af284ca 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3040,6 +3040,8 @@ static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
>  
>  nvme_show_int_function(cntlid);
>  nvme_show_int_function(numa_node);
> +nvme_show_int_function(queue_count);
> +nvme_show_int_function(sqsize);

The sqsize is only valid for fabrics, so I think you need to update the
'is_visible' to suppress this attribute for pcie.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
