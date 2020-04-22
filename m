Return-Path: <SRS0=9Zwh=6G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AA4C55185
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 16:55:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7982021707
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 16:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b4gIMtW3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgwzCYp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7982021707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dmgzlXRxMycCshKYIQzhroqk5Yk0F+vNCIysKI+Kq0Q=; b=b4gIMtW3XeX1ZP
	5/9tvFzQdbGEm2MeK+wOBuv5AgDcX7JMhASEkYPjaeJTmEPKH/e0LAH8h+N4l4EEPbwGxwy9w6sGL
	sHeHV+LnCqwHaZKvnQxBNA93BHaMm48uGed1DjbAvC2gW5j3dd6BuLM1wI/y1UU1WOIJYEju5mATY
	kLJ4mFiIAdgpbjoi0FRIwvbDNYyJ0KYb1GBi+Q6fxN91nwl9fr0iOO61gurvfnhLTOrkUduCh+mRl
	IKl0am6HolqwS+b64M8kiCRSIOoE1stiGB0f/JHEZujw/tAcYY9kJ50VpbxNChhCwU7IryLuzwkLd
	vPDrO8kFJ8llTsZi/nTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRIej-0001SP-Kq; Wed, 22 Apr 2020 16:55:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRIeg-0001Qw-Jn
 for linux-nvme@lists.infradead.org; Wed, 22 Apr 2020 16:55:23 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A550A2098B;
 Wed, 22 Apr 2020 16:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587574522;
 bh=fXTuIP0mHmZ1QbdOw/Y/UUq/RQsZdpQU1lg9CORkiBM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jgwzCYp1fuJm7ItVd/IQ14AnEGWkh5BgWHg5BHKIEuwfxwcl8BPaPhzdKeWCN2x3j
 SDZIyDHHyT8JRCKlvB1gEeBlpdd+UU1kt61OXICZMpqyhcxL8QTrdwdZcIqEHcI9eu
 U2cJpiqFAEq35/BdvuL/zDEu8X1OoStB1J5Ek5Qw=
Date: Thu, 23 Apr 2020 01:55:19 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: clean up error handling in nvme_init_ns_head
Message-ID: <20200422165519.GC14788@redsun51.ssa.fujisawa.hgst.com>
References: <20200422080016.306205-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200422080016.306205-1-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200422_095522_669736_D278DD96 
X-CRM114-Status: UNSURE (   9.86  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 22, 2020 at 10:00:16AM +0200, Christoph Hellwig wrote:
> Use a common label for putting the nshead if needed and only convert
> nvme status codes for the one case where it actually is needed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
