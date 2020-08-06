Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB49DC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 15:42:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC512177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 15:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gzaanz3b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nduwJOm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC512177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zEIDecENIfcaPlhd47pgHXkPDrUdRFqFZ00347IdeR0=; b=gzaanz3brPrCqtfB1BP7N/HpB
	yjN1g4O+RVGfr1/PX/KjkKWvx0lSgqbW9a2nr2Mwd17d3v0kyE4bvbDjwqbO+we2+FDAh8kNNf6M1
	KLxHDIl8ri4NqduL6bbMjuGSKyKbe5F/eEfh1a7iKeUoMF4dR2tCSGr7IiZq3QqknbuMrWyRySYZz
	aoEkA8lIpX/J4QhQZrgsRsey4uZiBDdlhZuS7BV0MHp+S553YBSBoSzDNti5mEFAXoYn8mIyxfixm
	cHKosRwhGrVaA8nn4oC6vbsD/apmKApwyPAiwEnvuYp3bui7YEv/FAFyYuLVsmtAU+HXhkbO076zE
	Ijm/s0bAA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3i2f-0002Zs-G7; Thu, 06 Aug 2020 15:42:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3i2c-0002ZO-LO
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 15:42:51 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 638B52177B;
 Thu,  6 Aug 2020 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596728569;
 bh=z6GrakdJAVOGNdoebmBOUkyDPQDwxRiB8qCKTYDkbe4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nduwJOm7GYR90K6fLM84ZBBKalzagdlYBEZzDwDsqog3Sn/BSWRTOfbSYibvcNUbl
 YAHOQwzJ4vN6mc9cRA8ZOBOZwsr2n4pMgtrHeIRXixHRhZdfzis39UTHhZYRbttlUh
 0nGVbdAILKVnOh+6u3GxTVWT+Y3pn3BjuQlpfyig=
Date: Thu, 6 Aug 2020 08:42:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Message-ID: <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_114250_819624_9ADACE0D 
X-CRM114-Status: GOOD (  10.69  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06, 2020 at 12:31:50AM -0700, Chaitanya Kulkarni wrote:
> This patch adds a check in nvmet_execute_passthru_cmd() to prevent the
> following Oops :-

Suggested changelog:

  A passthrough request may be NULL if an invalid namespace is used, or
  if the allocation failed. Check for a valid request before releasing
  it to fix a NULL pointer dereference.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
