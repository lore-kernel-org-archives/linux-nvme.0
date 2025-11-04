Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84513CCF9F8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 01:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OBTXv9sNR5YE3ZrQg2Ok9Boxfphznq9WB09Dl25csUc=; b=Ma9LMx0Gr8gkHovQ7O07v6K0FA
	o86hCuw+i5Ibsoj8ZuZ2eA3AwLF97H6B4xNwS7NBGEXOVbl2hJPbxBEHmTeIceQOKPec4xnUcK7/z
	5W/tPcAxOfrl+6ClYEy2fnWUvHNOqY5yBUD5KrMp5B4Npi9uLzURvWLUFX19atALmshXdRrcyRPre
	QJYeXvXhN9bFNR3JzVTPwsIw/SRFR6/ikmWZVmZqUEcKkdswX1TbLWLuKy3MkftDCRBTut9uR/V6U
	i1OB6ucU7LDqq8iRxeA24ptGSeOs8O6fl0uQs6mfPMnDtiTg/naT8WVV7QzSLRnE3t3weeMBSHOIZ
	sc90cyAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5pp-0000000Atak-3rDT;
	Tue, 04 Nov 2025 01:27:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5pn-0000000Atae-33lY
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 01:27:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CEEF7601DC;
	Tue,  4 Nov 2025 01:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2792C4CEE7;
	Tue,  4 Nov 2025 01:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762219660;
	bh=OBTXv9sNR5YE3ZrQg2Ok9Boxfphznq9WB09Dl25csUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=myPtxvnVpICK7vrRuydsQ0M733OeIQ4X9R3HHeA0alAcha1Tw8A9Mr06Z4GYQZKML
	 koZpo5jia5k4L6keArTMzzBtcPq2FpIED9hrAWLw+8lVIfCtrgF3i/MUiD3sT/wJcN
	 +jNJy1NVe/RrQpxhmPRRC0QObtkzYqzBxLlAnqqE=
Date: Mon, 3 Nov 2025 17:27:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Laight
 <david.laight.linux@gmail.com>, Guan-Chun Wu <409411716@gms.tku.edu.tw>,
 ebiggers@kernel.org, tytso@mit.edu, jaegeuk@kernel.org, xiubli@redhat.com,
 idryomov@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, home7438072@gmail.com, linux-nvme@lists.infradead.org,
 linux-fscrypt@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate
 users
Message-Id: <20251103172739.fd799d3df4edc014429babc5@linux-foundation.org>
In-Reply-To: <aQiM7OWWM0dXTT0J@google.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
	<20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
	<aQiC4zrtXobieAUm@black.igk.intel.com>
	<aQiM7OWWM0dXTT0J@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 3 Nov 2025 19:07:24 +0800 Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> Since I believe many people test and care about W=1 builds, I think we
> need to find another way to avoid this warning? Perhaps we could
> consider what you suggested:

I'll drop the v4 series from mm.git, thanks.

