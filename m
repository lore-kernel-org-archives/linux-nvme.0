Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0FBC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 14:10:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE5160EE0
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 14:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEE5160EE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DNYC1imD7X6bXQkonOXFr19mjyYaQIVokYLFPDPjcpA=; b=fMrJdVe5/oMrRB
	dmOtzZPBXdzeJzXbgmWxM5M615woLNhPuqmKSjLOgtrJYyQMnd6pPE7quEzNkX+xH5ys8fbsOPyyK
	lqLI+PzaOGpPTebp4iuzhGTBP9ATsvBwuiHe7MFGMEhznTaox3NIwukh5MFHr+KDWtMzYti+p1R2G
	gk+5RDB+i40EpIq9uF0KgL9KM/arRgsn9mbbeQ0JBQM7APi672opP0BorJOSEkO1TKhM2SXMzfPEa
	Niur5dYj4z+vnfPAqOZtyYsu0U5f5B17JYhIjyeoitiLhlrSiVDdJn5rEb9Js0o2Vc5AQ8UPd5mo7
	iRSwcy43GLe2BDxPSeWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPmfI-0021ED-N8; Mon, 13 Sep 2021 14:10:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPmfF-0021DF-QI
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 14:10:31 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9C5F60EE0;
 Mon, 13 Sep 2021 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631542229;
 bh=OTsRl5Q3kDZL5wkUcNUuh63p31uqgYtaOZofdSX9D7c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HBF99wVwkxxWBQj0mgmdT/dckA9MTQpK1jgE5Va0qR6hAWBT6pw58iWVb445GKwwg
 l4u8xUN+FqZt0Vegxcaxs282MVgS4kuflHOPWzbdmCwoQRgYndzicl789c8bAQVLIR
 hnquiaYKwQ7QOguHPi6SKfA1Y1BDSRKWdBNCXAFERQsFc4C8WBh0p5GUguaxsgGWYH
 Zq3wthaT+LnThl6oNqhOrOdPZrRhSKeQEfdobFaI/BHDELntLGF45OoRR/q+lbNu3p
 uyHCmlJF1PZIE57DspukkMy3VQ0SWI5OrgZgv6ykRAL66H1yk7z30xEFuZD44SkizJ
 n8IbbJk/szLFw==
Date: Mon, 13 Sep 2021 07:10:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Samuel Jones <sjones@kalrayinc.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: Command timeouts with NVMe TCP kernel driver
Message-ID: <20210913141026.GA3283786@dhcp-10-100-145-180.wdc.com>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210907204615.GA591280@dhcp-10-100-145-180.wdc.com>
 <473ad941-a01d-8107-a6a8-6d051f6955a5@grimberg.me>
 <20210908215017.GA2116734@dhcp-10-100-145-180.wdc.com>
 <9266ad25-ec2c-377d-092d-941f26371c7b@grimberg.me>
 <dc84f3ee-5f22-2f79-5483-9ae0235e42fe@grimberg.me>
 <1537083616.6148364.1631174974578.JavaMail.zimbra@kalray.eu>
 <7e313963-b377-74ef-2fb2-650e15cde2e6@grimberg.me>
 <1387247003.6552417.1631519054752.JavaMail.zimbra@kalray.eu>
 <cec5db7f-a785-e219-b502-5aa4ed1be880@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cec5db7f-a785-e219-b502-5aa4ed1be880@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_071029_906212_0EAAD4A9 
X-CRM114-Status: GOOD (  14.86  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 13, 2021 at 12:15:25PM +0300, Sagi Grimberg wrote:
> 
> > > > > Keith, can you send a proper patch with a Fixes: tag and a descriptive
> > > > > title so this can go to stable.
> > > > > 
> > > > > And let's wait for Sam to do some more extensive testing. Ideally we can
> > > > > also hear from the WD folks that this doesn't cause any regressions.
> > > > 
> > > > OK, I'll do some more testing over the weekend and let you know next week.
> > > 
> > > Thanks.
> > 
> > Hey,
> > 
> > No further issues on my side with this patch.
> 
> Thanks Sam,
> 
> Keith, any updates from the WD team?

This was queued up for their next test cycle late last week, I will send
an update as soon as I hear back from them. I believe it's a multi-day
test, so it may be later this week depending on when they started.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
