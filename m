Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECD6D0E6F1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 14:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aw2Y8oEh6bqWW/XcaZH0GXs/SY0LKo1OAbKDADmPqRk=; b=xMNtd8JHuBL7W+O3k0rcZplgC4
	X6E7IWFFFm1q7w2Td0PA1HT9Pwu34vQ11mZvZf9E0a9lai8PDQo+EsBeHaYU54y9VP3gLj2niP04j
	XpOCASHerG8HaJYYo/swyxlTmu1Z1XqQTCeG0V2bFd/IUhlvtKbit2bZUYuETKopmNJPcaN043xEm
	W8oX7/OQBab47trCtL9OrZrT7iPqbLgtotzIshiuEuwyQy59ZzlMStT/Yj5GdqntKmWwQxrA/xydM
	7+QzF0CIOSvAw7iE3rN7ODhpCRdyojCvYShYn8WaZm4vk67DzzUw4eD3pZr7h8PdSU5KN4diWpiQG
	hHzcdthA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNuLP-0000000DSXs-0d50;
	Tue, 25 Nov 2025 14:48:39 +0000
Received: from mx.treblig.org ([2a00:1098:5b::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNuLM-0000000DSXS-2sHj
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 14:48:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=aw2Y8oEh6bqWW/XcaZH0GXs/SY0LKo1OAbKDADmPqRk=; b=VrW9Tby6fAKdyw36
	XXoTlnwIuhMRA3VyJik4syM3ynqaTP/N5Ynsnmshbcqd7asNr9Qq87mfhP1cLrqldVUdCxhhC01xX
	1V6bWN3Od/pZx9BZubJoVBfJFOMSW0xEnvx52VZMNHONSL4n+BOK6v9sR/tcJXR/6bVPejA6xkpBU
	7b7bft8tTJaGESY34YtAUjc3TISjztmh7AhwCj6JZ7o/1OhY8BWVbH+CuTBtCyGvFnzsiW00tor9m
	8NbBqgac6AGWrmk6I7cS6qS3jQiUetGHqLKsAR+yf6ZRduZyXQ7PZg9WMmZV1WNW9w9nhqNYZD5QB
	USVnlmJGaF1p3WNFQg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1vNuLI-00000006PlQ-3QJY;
	Tue, 25 Nov 2025 14:48:32 +0000
Date: Tue, 25 Nov 2025 14:48:32 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
	linux-raid@vger.kernel.org,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
Message-ID: <aSXBwBoBZp9t890U@gallifrey>
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 14:45:30 up 29 days, 14:21,  2 users,  load average: 0.03, 0.02,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_064836_810101_88925EEB 
X-CRM114-Status: GOOD (  10.00  )
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

* Justin Piszcz (jpiszcz@lucidpixels.com) wrote:
> Hello,
> 
> Issue/Summary:
> 1. Usually once a month, a random WD Red SN700 4TB NVME drive will
> drop out of a NAS array, after power cycling the device, it rebuilds
> successfully.
> 
> Questions:

> 3. Are there any debug options that can be enabled that could help to
> pinpoint the root cause?

Have you tried using the 'nvme' command to see if the drives have
anything in their smart or error logs?

(I don't know any more than suggesting looking at those logs to see
if the drive is showing errors or what it says during the timeouts,
so I'll leave it to others to dig deeper).

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

