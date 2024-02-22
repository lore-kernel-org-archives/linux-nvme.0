Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B17C48BF8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 12:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hWOITJu4r5lsySLBbsUAYu+To6wn7rng5eBjiQD5I8g=; b=kjL68pgY80pKlztX8WCaskp4vx
	fCYuQBT4MK1FyC0xqd1xzxMZt3XWc5SErtHmqIJ94WO7g1OInDPvhZz8FBXQ7qrY62yuxYkWTK/hw
	FfSPThxE0oCQ8MMDn5OSciq3wxAuP8QkdtdJ+BQDigIab/yNKfS0bAfi+iHEc9Ejq54INFg+HJpO2
	5fFA+5KYB/3lWuFhxEM40RSxb1e7MRSwqr1IhXCWZdQ3dl/piyjjYDfeYTRzyC9w3Gw3nNlW7dj0B
	w8615dCqXn+hgtvWsr8DqjiQoPMZQGAvOmCkKfzjtlXwl49RN1TZ2xdj7mgqVM4iLIRnBn0hOLkYM
	VGyrmAYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd87T-00000004o2p-2r9f;
	Thu, 22 Feb 2024 12:24:07 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd87O-00000004o1L-0uWu
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 12:24:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5138B617E7;
	Thu, 22 Feb 2024 12:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C60C433F1;
	Thu, 22 Feb 2024 12:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604641;
	bh=UQcJF0MxGv8FI6zkieEqniVVC2e2rV9dcda8hmiOZeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isDtrnurIw+5Awb+A0d791uKs9I8QT3zdq69bW1sofnwb5nAt8Kac80quAWL5f3RV
	 P0+Jf36cR2xhYg4PTXu7SSFojqatfSknDlf+AF3Q29HmyfPVs1in/4OXO8zPTOKbfI
	 QNBkantiKyCCvPLHlSF965Sk67dW7xv143FncXNIkPjzypclgtw24uIPs5j1XsjRbh
	 Fm+NW7BsRao4R1z2VB7SftScm3I3iOmFrO9L08phdYEM8bPmwPwpIuZK6uX2EqVQXr
	 nPyLhD8MF5u7g1FNwOvciDMhL6+0+crtpTgBQHvPfe5nZcPZunwlu6Z6E0z83gsZiy
	 Uo0qWYln/uhuQ==
Date: Thu, 22 Feb 2024 07:24:00 -0500
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	james.smart@broadcom.com, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.10 13/16] nvmet-fc: do not tack refs on
 tgtports from assoc
Message-ID: <Zdc84CT6LXmbz2DQ@sashalap>
References: <20240207212700.4287-1-sashal@kernel.org>
 <20240207212700.4287-13-sashal@kernel.org>
 <ZdJVw8PbwTDngATQ@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZdJVw8PbwTDngATQ@duo.ucw.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_042402_367230_5AA8EB17 
X-CRM114-Status: GOOD (  11.60  )
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

On Sun, Feb 18, 2024 at 08:08:51PM +0100, Pavel Machek wrote:
>Hi!
>
>> From: Daniel Wagner <dwagner@suse.de>
>>
>> [ Upstream commit 1c110588dd95d21782397ff3cbaa55820b4e1fad ]
>>
>> The association life time is tied to the life time of the target port.
>> That means we should not take extra a refcount when creating a
>> association.
>
>I don't see this one queued for 6.1 or 6.6. What went wrong here?

Yup, this should have been dropped from all trees. Thanks!


-- 
Thanks,
Sasha

