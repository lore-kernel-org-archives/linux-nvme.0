Return-Path: <SRS0=+LKq=Z4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75788C2BBE2
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2019 17:58:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5035524670
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2019 17:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cz0CqjjU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0O630ikU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5035524670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jY0Qwx+ck4Gdx1EUJQ5rnZob5+cMrqrq0nyka1qEmWw=; b=Cz0CqjjUDpurj/
	LWrdWehIjl/u0HUxHyz8enPjbiYedhr0dybz58iA9HOmEEIXvjkwdf3uDAj3PmMX2wASpnPZ1cegK
	XOIJRI7h7lPhsLJOWOicCF6ElgCBShTP/N9RYMstV1qScb/gc0qU8qKH/s1UMm7QwAWHh8A3vNeSy
	uoxwCaQNwTowGljTiXKToEas3yJXY5tdot4eilpf0e5IFkfc9UugYnHoNTRxwl//einBq0vHhMxdb
	bYZKrZg91oL8OLpYsYWRm9SgzDDF+oeboqui+LkCShLAzqmK0n7/pcDCVfjEvmIUrbWIdpXeBMgsx
	rtwkKnnX9Qrmjy1X7Gnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1idHsR-0002ZE-V5; Fri, 06 Dec 2019 17:58:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1idHsP-0002Yk-OQ
 for linux-nvme@lists.infradead.org; Fri, 06 Dec 2019 17:58:50 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A85B124670;
 Fri,  6 Dec 2019 17:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575655129;
 bh=/3ceQaXThxhF2lA/kE8ImZh7r8c1O67MHsiDG0XYmXI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0O630ikUgde0Yt6uq3dQa+EM1xoRq0rWM5k+nNs/K7ngIAYW+9UJNV7uzryRVG+gB
 Qv+2cEQQGwrKSid659hSYHfH+O5EFNCjXRWn2KEYqT2STuRBixmIuqhNrNk2CQbaCa
 2pBr57bE1fLiJVFD4KodvCZgrimhDFGBM6Ksubcw=
Date: Sat, 7 Dec 2019 02:58:42 +0900
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] nvme specialized queue fixes
Message-ID: <20191206175842.GA2001@redsun51.ssa.fujisawa.hgst.com>
References: <20191206171316.2421-1-kbusch@kernel.org>
 <360fdd5a-f2ce-86c6-55e5-a15ff2f9e1cc@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <360fdd5a-f2ce-86c6-55e5-a15ff2f9e1cc@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191206_095849_813613_393DCB34 
X-CRM114-Status: UNSURE (   7.06  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Dec 06, 2019 at 10:46:04AM -0700, Jens Axboe wrote:
> Looks good to me:
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Thank you, queued up in nvme/for-5.5. Will be sending you the next pull
request later today. I'm just hoping to hear test results on another
patch.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
