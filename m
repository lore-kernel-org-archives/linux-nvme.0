Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C00ECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 16:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YWhEgQjrL+g8FZmPV7YF8mBCZoiB20tZSJIb8wIQ1+s=; b=lsEvGdx3XC/wMmcdDROgoy3Pt9
	Eit7HvCcXKlGGxJVyS0kv77wI3jr+02XqBdq9SdhwZQCUN5OqvE3E5T2hpGL83ujDYMXSX0OvWnRa
	JfGRlSuJj/H3KJOEIBD9Ct7OrvloY2FOgYLUGKsXyO7QxPTysCXT/9nhisZXuhO3Uy5ILrb06WCUf
	wcweEILhtDSty6LRpR2WrZtGuHfc5BG7+Fef0goDyj4YDtrxtuO6Nnwia5GvQjxMGi3Pu4vmkasqM
	AKsD4q8kXPunTJRrbo5MrOjcgKwUKaUjOrKRoS2kq9cUhWc9guAmTLAB5+/EBk65WGRtTJUB8fRBO
	/6bFXrhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooS85-000sWA-50; Fri, 28 Oct 2022 16:22:45 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooS82-000sUy-L2
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 16:22:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 7B188B8247D;
	Fri, 28 Oct 2022 16:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DE8C433C1;
	Fri, 28 Oct 2022 16:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666974159;
	bh=dJ7aDf+7YuREaTU4lVh+9Ney+AX8FqX45LT7lvExQN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/sev4Ai10M5JRtTo+n+KbgtYgUPFp3utKaDMo/a2dhI12fb2BIW9W/Xh4Xye5OKY
	 YmwXQ4Mf1/difUHlQA6FyLJJBN7MViIt6ANUsU3o0kCGXrvf19KTivZJfTP4E1iF8v
	 9DfjA+UsxxCEJ8mrCwvnLoPu4lUyhsMHgO2uUWd8g40nWsXhzKWGC8ivl7D8Qd9ifb
	 rv5mVsWlDTrsAwC9IhRrmznPOmiRbYIM91Th5H4CT2qyjLrli1VtB6jFZ364r5cB3y
	 5UaCJyDR+dXgVjTxvxMHFmBCdPdZMOnh+Se1AQ8OgiVPHKcA6fHF/EoKwiPj0jgYos
	 MGCoWmLZYg+Dw==
Date: Fri, 28 Oct 2022 10:22:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, joshi.k@samsung.com, javier.gonz@samsung.com,
	p.raghav@samsung.com
Subject: Re: [RFC 3/3] nvme : Add ioctl to query nvme attributes
Message-ID: <Y1wByyGo6FS/6hmd@kbusch-mbp.dhcp.thefacebook.com>
References: <20221027155724.1161670-1-j.granados@samsung.com>
 <CGME20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab@eucas1p2.samsung.com>
 <20221027155724.1161670-4-j.granados@samsung.com>
 <Y1q4Cjg1cv9w+YWR@kbusch-mbp.dhcp.thefacebook.com>
 <20221028103827.o7uhl36qavkpx22d@localhost>
 <Y1vskd0uY308uSf4@kbusch-mbp.dhcp.thefacebook.com>
 <20221028155230.cf2iktk6ut3qbzns@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028155230.cf2iktk6ut3qbzns@localhost>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_092242_853325_9F5C8777 
X-CRM114-Status: GOOD (  17.48  )
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

On Fri, Oct 28, 2022 at 05:52:30PM +0200, Joel Granados wrote:
> On Fri, Oct 28, 2022 at 08:52:01AM -0600, Keith Busch wrote:
> > On Fri, Oct 28, 2022 at 12:38:27PM +0200, Joel Granados wrote:
> > > 3. And the variables that are not in struct nvme_ctrl. Here, we have not
> > >    option but to make an IO.
> > 
> > You do have another option: we have historically added new fields to
> > nvme_ctrl to cache parameters that are repeatedly referenced in other
> > contexts, and this usage appears to qualify.
> 
> Agreed. That is yet another option. Will do that for my V1.
> Thx for the feedback

Just for the record, I don't really like this approach, but I don't have
a better suggestion right now other than opening up the admin queue or
exporting a ton of sysfs attributes (and each carry a different set of
concerns..).

My concern here is that drives implementing new specs may have new
constraints that applications need to know, but older kernels won't
accomodate. You are handling this by error'ing out the query, so it
relies on the application implementing a sane fallback (assuming such a
fallback for future attributes even exists). This just does not feel
very future-proof.

