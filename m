Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16176C5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jWfq0kQUzU36ek1O4g7xTgNjp1pjDO9soQYYEygEMxs=; b=AmDfUPQFPgHlTUBsrVpYLVUTzL
	2KPQr1J2R8owwOX/foc+MQcOfr5+LFta8oAJbIq9LKowvR0WUFHOFo1tQcHhnV4ntQX9iRyjKlrPy
	lnrqLQ2FLc/XWJoYyPyZtR60IBqCRKad/jQqkkSOAlj4bHliZAKs1wsslL8jSV230bOm5nsaJGVut
	PoVtvdbMeEbFfUtpLCyKuMh/kGFj8uxfx9fahr5GQTx5JwXEgSObpX5pN3gRT5FP1zO+b3KebNYyg
	ibhKC2RuvFS4Qe7paVzaSkBT3eT6ySefPa5Vpuz7D/2YDqSL213JKAWmmua46GqXS7uTqWqQX08qu
	83Aqp7KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww1QD-00000006ckL-0Jyc;
	Mon, 17 Aug 2026 17:46:53 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww1QA-00000006cjg-2VV3
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 17:46:51 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-c1712a04ddaso615750566b.2
        for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2026 10:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786988809; cv=none;
        d=google.com; s=arc-20260327;
        b=WZ5dt+O3v7j+YOrcdkHHkegC1vF29gOCzFsvvP+2KnbJ0OxUZ31UeEc1A4dm3eX/EU
         HYfZHFWKGLeqCSnzqSnLwZ9Y5qNBB0kGIm2qWJgjEyvnFv/r7DrjTTVYd4Xt3x8mqeiZ
         JSlFuwGzIsWFWIBVoxN8Mgc1d5EeD2LfQgEZ9Th6YJ1r6VrCsZbHdaTkd32N6WSXAeaG
         rKfQPwQliESJcoAqZSoHDKejpxNcMux2Bcikt4zFDbCqNjF7SpI0fPq4sx4ytyefXx+W
         E/kvvYm8yPehX3gn3gZUTw9jqy1g/x8qrvczusI0PvMDE3Xj3w0Nh/J36xpYGLXjR6ca
         xYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jWfq0kQUzU36ek1O4g7xTgNjp1pjDO9soQYYEygEMxs=;
        fh=8io4XCak0vW5qbtPFV+hiz0hIlcBXCiaMyTHZ10j50E=;
        b=ZevbsiYg7pKDYnW75sZL3ig7uyuQG4uOGNMYkQLmPwPjyHQrvN+zHGg6ohqtB33r4g
         ftc0I/b9kQQqedQprE/5vYpOnvULgZ0RMkHUruv8zm1ZyXJ+R3yfycduU6CAma0ewk0s
         vifIhi/NTPeWopMM0Md5lShzndzRRB0Cua69rbdXxhAbzGhHET3PPyjvzK/xLEjUTQDB
         WyvG2o6q7BRw97qmA+AyU0LiyCLbVySORKxKeriBRxAPfjZTXWFtE0BaZ0qQP5rq5weL
         5V0yoK6c0o/vB2qSu0p/D/Q9rdFBIUbKpeyWbw77W6/8e8z9DhU18YgBQPXlBAkzxxBV
         7S7w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786988809; x=1787593609; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jWfq0kQUzU36ek1O4g7xTgNjp1pjDO9soQYYEygEMxs=;
        b=p+s4BM5PA+PtEGqcc2Dp0yrtgzciTb0+0bAAgKaz+nZ6Td5fSNReFtNQngDIpE6UGh
         bO+OvnoM9O96d1jTUT84vzf1s1E60T7p9UDxkJWrABUH+oWxFhZoJZNASEMmKpS8Gag8
         YkjqMifk5bjb25GF0fNh6gbpNlDbmimDTRlHr9VLyWuHxjt1sQm39VNp01iyJaW+yQ58
         IhJwwC+3cw0aFjuLB8Bb1SoMd22e0hkNTwZa9ZsCOnQE83XzVZAcdaa2BDnWsSXWydkH
         86MdnuVIN56LWDQK5SUJd20DuVNvopLRJT/rSPzZQcYd+hT1wTgpyXU59DlU1yTar2t8
         ynyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786988809; x=1787593609;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jWfq0kQUzU36ek1O4g7xTgNjp1pjDO9soQYYEygEMxs=;
        b=cmEDHDgvDSFwFWUt/nxdDntPcEwFC4YCecxVcNiwP0GNDC3qBNih85qhVhB/mqN/W4
         BNAt/g7HI1MPtpMZKQKvcA7B7x2XydM7QfEkxWvH+u/bhDnusGKOo35JQUGSsVj6VL+p
         ogFB7acE623xlg8V7IDEreHyMhODeOazesub3uvbPdLDhFExXQbx3b3NX1Qk/R4/HQdl
         1s6AuFYVkHOQJib9BkhkHQu/iaOxYsLjwwuqoG4Jeip5w/NaBQiI5aEcvLv8Qyl04UJA
         GDSwNY8RZSHatAAO9hfNjE2y20NH5enSxnY3cYqxzi/7w7g0ZyeL+V92ceVt6g28dpQF
         gcdw==
X-Forwarded-Encrypted: i=1; AHgh+Rrt0Y/sJrcDl41ZPOMw28hjHqOvBmA5UDIExjMs5fUQIPvTGf4h+XcvzFvAtJ7fHkziBGZR44ruU6Yi@lists.infradead.org
X-Gm-Message-State: AOJu0YxLzvC9msY5fjmt/1WGhlWkzEEU3AUw16AYPq5OUuuuymnSm0Hk
	KboBJGDBOVOOvyGEetVAh8OCeqFsw7f40yNjh0iG6cQa4mW70Wjb/UliNikBS5wAqe00ZOjVakq
	QYg/9bL8xSUQ/jA2IQ1zCFDmTz61cIik=
X-Gm-Gg: AR+sD11r7Wenql7aLAvpSVIxJmUFZFh5VVx5MGVhuqg4mdsjPtsrPl6yerrk2mWzoJf
	y8D9xuh97sUzCpMqQ7HIBHHm8bYNkj2XudA95+4mJSODdQBfWgh9lpHdIO3SGaycUWUSM0JFGQR
	tgHjDlFxr8eUrCCQ0mqEokf6Jw9mhobGcJAH5fusR2crxRQYmgfjSGCCP9ezBHdr/3KntbOe9q3
	4OrjONinJEpKkOwmhMt5M9RB6ivUL8nBUaDc0RRXjBwrxy9xvmR5Driv3qIvgd1fxTalIxmdkRH
	94OkaDdKI6YvpUvFgNWvITuZ0syJdU1URN/U6h/kICAC
X-Received: by 2002:a17:907:c80e:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c2129b5702cmr1272623066b.9.1786988808440; Mon, 17 Aug 2026
 10:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260816191729.2865523-1-coshi036@gmail.com> <20260817065553.GB16255@lst.de>
In-Reply-To: <20260817065553.GB16255@lst.de>
From: Chris S <coshi036@gmail.com>
Date: Mon, 17 Aug 2026 13:46:36 -0400
X-Gm-Features: AcwNN1X5x44M7lIgndIl0Ch0i--1X4X4Boan2SI4Qh3MU6IukQVLH7-NbdtLCb8
Message-ID: <CACd_6n0FoZo88kqzN0X-n6aOXKTeqDL5XwdgEaxGVkfGti2gkg@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: skip the zoned limits update if the zone info
 query failed
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_104650_653418_81047AC6 
X-CRM114-Status: GOOD (  16.15  )
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

Hi Christoph,

Thanks for the review.

> Did you do error injections to get here?

Yes, on the device side rather than in the kernel.  The splat comes
from a fuzzing setup where an emulated NVMe controller rewrites
completion status codes.  In the wire log of the run that crashed, the
Identify with CNS 05h and CSI ZNS -- the one nvme_query_zone_info()
issues -- appears twice: it completed successfully at boot, and on a
later rescan the same command was completed with SCT 0 / SC 24h
instead.  That positive status is what falls through the "ret < 0"
check.

> The most common case for this is probably during revalidation of some
> kind, and then we'll just keep the old values.  Which in general
> should be fine, but might be worth mentioning in this comment?

Yes, that is what happens.  queue_limits_start_update() hands back a
copy of the current limits, and nvme_set_chunk_sectors() returns early
for an already zoned queue, so skipping the update leaves the
previously validated zone geometry in place.  I will spell that out in
the comment.

> Also we should probably log a message that we either just register
> the handle or keep the old values?

Will do in v3.  blk_queue_is_zoned() on the not yet committed queue
tells the two cases apart, so the message can say which one it is.  I
was going to use dev_warn() to match the neighbouring zone code -- tell
me if you would rather have dev_warn_once(), since this runs on every
revalidation and a device that keeps failing the command would repeat
it.

Thanks,
Chao

