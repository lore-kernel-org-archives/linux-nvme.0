Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614A7C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:08:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E1C64EA4
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 09:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E1C64EA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AP4fiePh5jHMeuN7s404LxT2qU5AgW21N0lN10J+FYg=; b=mOAXEjZ8tOIST6CLaXt9nHmGk
	En7Cs4Ww/2KySabhlMGAc7Kt2RqaYYD3hd+MKF4h2egYMM/he4XgdsJ7xP17Yua69YN1919Y9PSl2
	1ZGocE3TgEcT88eb1+IhYp++hq1hWK4GaO7fT/9Ut5PRlHsR59TW9hpFHkOA/6bGX3gePAJW+t5Lw
	XWbGcyn7zVgVzMcNAitCjDI5PQ7OQrq+W79rKMusG1fnm5zbdNobriHrDDvmqk3CoctYjV4ynjeer
	MGDSEApwdm+XpUhWoi9Oh6EsPtcutUJCMPhxVFHoGSRxtT8utDH+yWaaEEeLL3QbxIpqhBw8nWOKV
	4gykQ+pYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEq9f-00007n-4q; Wed, 24 Feb 2021 09:08:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEq9b-00007Q-KK
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 09:08:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7B77D68D0A; Wed, 24 Feb 2021 10:08:14 +0100 (CET)
Date: Wed, 24 Feb 2021 10:08:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme: don't set iosqes,iocqes for discovery
 controllers
Message-ID: <20210224090814.GA4721@lst.de>
References: <20210209101235.1539917-1-sagi@grimberg.me>
 <20210209101235.1539917-2-sagi@grimberg.me> <20210210101126.GA26624@lst.de>
 <3702938a-cfd5-b725-bb75-7c9072a42fde@grimberg.me>
 <20210211070250.GA13708@lst.de>
 <f279bd6a-d4e3-52b6-740b-66f90434cf69@grimberg.me>
 <20210211183124.GA26045@lst.de>
 <a5ea738a-44c4-e953-3271-a0b97668000e@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a5ea738a-44c4-e953-3271-a0b97668000e@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_040819_802252_FC089962 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Martin.Belanger@dell.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 11, 2021 at 11:44:44AM -0800, Sagi Grimberg wrote:
> So you suggest that we keep the retry w.a. but continue to send the
> wrong value in 1.3 or lower?
>
> I personally think that this would be extremely confusing to users, if
> they do trip on this, but I agree that they are less likely to hit
> it because existing controllers obviously accept wrong values...

Yes.  While I'd like to move to standards compliance as much as possible,
introducing a long delay for every existing working setup is 
very counter productive.

>
> As for option to override. I really hate it.. What is the least exposure
> we can get for this but still allow the user to control this?

We can of course still override it using an option.

> Wish we had a good and reliable quirk mechanism for fabrics...

We do, using the serial number.  But that does not help for an issue
during connection establishment.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
