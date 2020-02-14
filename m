Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F164FC2BA83
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 14:26:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48622187F
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 14:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="il6rgdfP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tfz30crt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48622187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wnwcm8M508YlmfFcyXj+2lqBzNm8XiammvwE/+WnYLA=; b=il6rgdfPbqjmWO
	kSOdHSt5y4k1F2+0cRrKJWyhwRWWrddlQ5pbttmow7VmxLcpJiurPNLdU5eGVInRVxEZyTrBDJpPN
	j+cXOUCT6eGBUHnXUn7wJyG874KChSrGCBc37vcQphVnsUqRVbyhbZAF6z63gAosxX/WQClaEw+5F
	9fkczMv2VxMT9JpRZoBAm2ZRjtphwHlZqUP6yd4Cw5Tyu+InaPoU7NAsylDv797irVXcIe2ZZ9ei+
	oax0GLUx5THOK9PyxIEijvrZ+YLZjLU6Lcf7Nmyn1F/cUWP3tOXxI8RUppxTAybZTMASMPTlto35e
	kOBrzcNBUU6q9+5nzr6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2bvU-0000Vv-Jp; Fri, 14 Feb 2020 14:26:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2bvS-0000VR-Uc
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 14:26:40 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D084B206B6;
 Fri, 14 Feb 2020 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581690398;
 bh=tzYAU2owoKqUd1Mbm9le2aYFYypvgk67z2U604NQ06s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tfz30crtlGdcnXCLZVCVEzkD5Ifm/uSI88GiQQXQpniyOum7fgWYaV+YV6lk5qNvK
 84uSN//Ri2FA5u4ZUYi5dc8bsuCAJAuX1AlL4i3I/tOHa/ovRJ3z31OZN24FmNQJKN
 24cIPFc7yku9OZTLV/DGnaAdxhQAEEVCN+4ybDUs=
Date: Fri, 14 Feb 2020 23:26:35 +0900
From: Keith Busch <kbusch@kernel.org>
To: Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme: fix the parameter order for nvme_get_log in
 nvme_get_fw_slot_info
Message-ID: <20200214142635.GB9819@redsun51.ssa.fujisawa.hgst.com>
References: <20200214104802.29209-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200214104802.29209-1-yi.zhang@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_062639_005964_405B49E4 
X-CRM114-Status: UNSURE (   9.12  )
X-CRM114-Notice: Please train this message.
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
Cc: dmilburn@redhat.com, sujith_pandel@dell.com, hch@lst.de,
 linux-nvme@lists.infradead.org, emilne@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 14, 2020 at 06:48:02PM +0800, Yi Zhang wrote:
> nvme fw-activate operation will get bellow warning log,
> fix it by update the parameter order
> 
> [  113.231513] nvme nvme0: Get FW SLOT INFO log error
> 
> Fixes: 0e98719b0e4b ("nvme: simplify the API for getting log pages")
> Reported-by: Sujith Pandel <sujith_pandel@dell.com>
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Oops, thanks for the fix. Applied to nvme-5.6-rc.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
