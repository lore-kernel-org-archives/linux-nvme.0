Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101B1C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 19:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OlE4r2KKM7U3GhmxcSHP5QnmLizzRjccDnQhM+hyAAw=; b=YEmeOjWB6wuyuV9djSr83kjInj
	tc9L1ElrOB4X3kLVdMTjiVvqYSYI21+AHbsPXyMpmh5A6O3++hZ5Fn5z/5/nWcRhhBm4KDVADfx0c
	ZpcoNljBlPv4fmKO59YoEkw2MHjXhdDaGfDOnz84OCrYRSZ2VprKc9Z8+GaIV9DPsmVS9dNQ4/Vho
	+gJDbNEEzTk7hXH3UXZSxfJe/M/sZPTWPys9Op9pWHfQSEHCTWn1dDJXpFJFkKhUfDk87BUttEH6t
	0zmEtvQTZlfrqk2mrxJIutZ9oS1PE1XtBUuPwJ7TEg6aub+Ub6XsDi2rO2sFHKLEQnHXqIFbp9T9D
	E+3bZ8vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrlom-0098AV-Lb; Thu, 19 May 2022 19:28:16 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrloj-00988t-Hx
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 19:28:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 32B87B827DC;
 Thu, 19 May 2022 19:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CE8C34100;
 Thu, 19 May 2022 19:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652988490;
 bh=9XzFmTph/YjgqiYmcuv2QYbHL/Ihp/kN9e0z00Pb/CE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GhsmYGrUiRkz0ni3UlnhnjmtnsHg2403+bUGdwWK/pi1kZCHlLMs6JbCivW0hSnu0
 JsHkI2cZ/SoEmR63idCr52kDUm6X1jiquq5RWJ+0L1qwgoVQhuM2YIobyj7XQBw411
 Wg2CiMJPtmMMsFljR2zdr9z7KKjntkmcqDcvLM+5f987u13QzRMzijlCqwV4kzd9nM
 jQqhs5ud4pMT695rKtWoRkv0VjCX2QyBvpZiCLzljfWT4teCuusLwdlsEZObUUL4qr
 DveTcW9jA03XuXr3hziMQnfon328fdUtb/jycJvKWbnVXSvY1fA3CAcT37CTlhQYqn
 Tv3KmdJMM/jrA==
Date: Thu, 19 May 2022 13:28:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, james.smart@broadcom.com,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH V3] nvme: set non-mdts limits in nvme_scan_work
Message-ID: <YoaaRlK8MF7UQrA0@kbusch-mbp.dhcp.thefacebook.com>
References: <20220518155138.120470-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518155138.120470-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_122813_781737_B8DAB1C0 
X-CRM114-Status: GOOD (  12.30  )
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

On Wed, May 18, 2022 at 08:51:38AM -0700, Chaitanya Kulkarni wrote:
> +	/**
> +	 * Identify controller limits can change at controller reset due to
> +	 * new firmware download, even though it is not common we cannot ignore
> +	 * such scenario. Controller's non-mdts limits are reported in the unit
> +	 * of logical blocks that is dependent on the format of attached
> +	 * namespace. Hence re-read the limits at the time of ns allocation.
> +	 */

I think we usually see the "/**" comment style for kernel doc.

But otherwise, patch looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

