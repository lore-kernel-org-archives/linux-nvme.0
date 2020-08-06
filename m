Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E07CC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 20:16:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478392177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 20:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2ZA/KYAh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnGxvdIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478392177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BckRIAuBTvw6WrN67jvo/KppRg30iCEyfAUbcLFKF24=; b=2ZA/KYAhb27yVersH8vVs1kPx
	fJLG3QNt+mQug0nEf1qliWyBZvP26Dq9rGVrE9/ASumfRE3mmKqd4h+buJXODTxPKbvY+xeEOd99d
	DVVPoqxvHFOLcPy2mAEz7sOPuGBM0tY+Fpw4Qebs+sjhTtOU2CsO5FkF4Nf2qnPnYNuPguIl7xdEZ
	YYhBl0/1SY8wwj/a54+FdSc5wsrcHlJYttD0Tyzx/0C8qwMlOrsYTuFZjMfK3jwvi41CisWgdI9EH
	tm2G4vlnyjeHOJcGgbz0F1kPlk7+IO8odwxc0mSMEz3Z6AhCcJ4R8QmPQOHzMk9alTlD9S6p4X9Fq
	DGAQkrNyQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3mJW-0006Ak-U2; Thu, 06 Aug 2020 20:16:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3mJU-00069y-1h
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 20:16:32 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 24AFE2177B;
 Thu,  6 Aug 2020 20:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596744991;
 bh=1zEV0ritwwaPLwxjIkgxV7nfzK5O3oBvqQ33trOyYpk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WnGxvdIGivzWWsDAXzqkSS3hLOXE5paBu1DDqZaLQJanh6m8FnMqPPWagzpfbxb/6
 LiMcZGpqn/2VUeB/sa+wQ+Dg0JjPWUpf/1RPmr8obydEft8NhRIru1TKMPPZusrwY+
 8ap2JZW11GFQ1puhqEMyuRX1KPp4Abw+GrUA2GpI=
Date: Thu, 6 Aug 2020 13:16:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] nvme: multipath: round-robin fixes
Message-ID: <20200806201629.GA3797376@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200806131932.20017-1-mwilck@suse.com>
 <05490a1f-4f28-173e-53e1-c00a33d47b35@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <05490a1f-4f28-173e-53e1-c00a33d47b35@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_161632_166831_9334C457 
X-CRM114-Status: GOOD (  11.52  )
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
Cc: Hannes Reinecke <hare@suse.de>, mwilck@suse.com,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06, 2020 at 12:16:28PM -0700, Sagi Grimberg wrote:
> These look fine to me.
> 
> Can I get another set of eyes on this please?

Looks correct to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
