Return-Path: <SRS0=ChSE=XJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB49CC4CEC7
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Sep 2019 15:19:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89739206A4
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Sep 2019 15:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QcXk0/6X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0twkSDjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89739206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4bHD3LxBnrTUaSxrx2SEucxG4HpFgbFmKmgqH4FWhOo=; b=QcXk0/6XlmU0iJ
	nq4+gMtpbqCWmjqMUUUPIzyS9r/sglvBdEqAxEDWG7yPmQZheM8FEApo0LAxsEVsdbqh0Q1PlRjV8
	8oL6K0H24x0SybD/xNaWQdPcfTxn5avXPLQKz8MCqBxv41ccI8qcE40O8Sz6Su5kTlSFXAFiHs+P9
	4zcC7Kj3Kv/ZRuZjn94H0cUyUkFyUAAEJoKICzqOnk5yOU95RVQf7lX1o3yJGoQWbs4iaG7GOl9IX
	LlFi5/WQyeK7VOk+lUku32XbK3HsGZjYSn7mOVWX+DQs1PynEDcKI42c23Ki2CXsST5rsmQBA4XUD
	2yqg3c99JKiUDGPcl5Dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i99pa-0007ti-4v; Sat, 14 Sep 2019 15:19:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i99pV-0007sN-Ox
 for linux-nvme@lists.infradead.org; Sat, 14 Sep 2019 15:19:19 +0000
Received: from keith-busch (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 80C9E206A4;
 Sat, 14 Sep 2019 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568474356;
 bh=AHVi0TSajc8B/cHr3jeu+xvJ8kz2E/CDZ43vsGFnmIQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0twkSDjcOUJuWtsou8176t3r8RzTFzjnEEW5KLeyjM8fpq4CzvG/XueyOEr1RPJlj
 qJ8Op3zTR2Ng8jTOkCHod8Rlee5o/yAEvSW5f8SOHxnN1nkcctCJfoVYaxKAeKH+0G
 c5mC5oS37FNIm4Dal8YI3/gTyITEYGbXqDKm/fXg=
Date: Sat, 14 Sep 2019 09:19:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: incorrect sysfs reported by realpath for nvme disk when
 nvme-core:multipath enabled
Message-ID: <20190914151913.GA562@keith-busch>
References: <1753358694.11967186.1568394608486.JavaMail.zimbra@redhat.com>
 <1137688987.11971676.1568396450210.JavaMail.zimbra@redhat.com>
 <20190913175637.GC17139@keith-busch>
 <a24713ad-e907-2cfd-b1da-cef552c29b14@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a24713ad-e907-2cfd-b1da-cef552c29b14@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190914_081917_831312_35A4067A 
X-CRM114-Status: UNSURE (   9.01  )
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
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 13, 2019 at 11:43:40AM -0700, Sagi Grimberg wrote:
> > This was confusing to enough people that we've since changed the naming
> > to something people expect to see, but that's staged in 5.4. Given the
> > number of people who find this confusing, this might be worth making a
> > stable patch.
> 
> I agree here.

Okay, I'll forward the commit to stable once merged to mainline. I don't
think we can count on the stable bot to pick this one up. We only need
this back to 4.19 as all the previous stables with this naming scheme
have be EOL'ed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
