Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4E6EE01EB
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 21:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F9JRazt1XcPxIBi4ezj1dV5LBjiEeHbt/v/TTg13crs=; b=GOOC6fPo+orIcYYRI5NBYJBoWg
	JVHlLxEvd8SfpAavvwUg/CnZY0ZYbOXRi3PsNx32cBrkpAGR6mF1TmI9OqnLXcmkR2a/m3hWjbeMN
	o+WCmeK13ZZldwx0F6s2nlK8xvZqL/xkleihNN+l3EJnsGXsaFR73KJm8KLpmTN4OHdghlFcO58BD
	4z8NX46m8xn+GwSvx53i0vW9tXCKrDpKLrjldr1526z6mgQrx5GiJSjh/zYxc9IMFxc+OYux31qdF
	q4+HxS3OnMjGcgoHlPsltoP9pu+Fip/XV1UQ/9ul1SCs8EMA1FhpYyhT5UA9gGRfAO8mJSnqz2wiP
	DQq+tLIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so8gA-00000007EMS-0vEM;
	Tue, 10 Sep 2024 21:45:42 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so8g6-00000007EM0-3nw2
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 21:45:40 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9BA554188E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726004735; bh=F9JRazt1XcPxIBi4ezj1dV5LBjiEeHbt/v/TTg13crs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SLjTh1qf1DQ1TSqjPe4hXo7/rORNZ8+0s+ilj2cAifj3n6GtQh/+i+mZuu3cDWSXn
	 gi91mMWq3A2eQQsB4FmtW2hciDc5FhuQPmuLEpyaEfV8o8Knh4JlSXNV2iMEQNLaAv
	 nnOF0N5aBcpyMPGXlKA9EYW9LI5QSTHaJD+C2pounFtsSRaYlpKrvgSBSEEBb1s+Xb
	 5dy3CyqTAg1zWu1245UzH+ZeUA/JOh0PfWUIyBNAgy/0wagHW68YYRxObDLe5rQV3X
	 yMf/4NPXkxQpXcG5kEONXzi5KsmztLWeQx9VhfukytwjJbgZNho7zNv9D6lT8V6Myj
	 WvZm506Pwr1sA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9BA554188E;
	Tue, 10 Sep 2024 21:45:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Shivam Chaudhary <cvam0000@gmail.com>, kbusch@kernel.org, axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cvam
 <cvam0000@gmail.com>
Subject: Re: [PATCH v2] Remove duplicate "and" in 'Linux NVMe docs.
In-Reply-To: <20240910052737.30579-1-cvam0000@gmail.com>
References: <8734m8h9ce.fsf@trenco.lwn.net>
 <20240910052737.30579-1-cvam0000@gmail.com>
Date: Tue, 10 Sep 2024 15:45:34 -0600
Message-ID: <87o74v5gjl.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_144538_967221_7F008668 
X-CRM114-Status: UNSURE (   8.71  )
X-CRM114-Notice: Please train this message.
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

Shivam Chaudhary <cvam0000@gmail.com> writes:

> From: cvam <cvam0000@gmail.com>
>
> Remove duplicate occurrence of 'and' in
> 'Linux NVMe Feature and Quirk Policy' title heading.
>
> tested: Not breaking anything.
>
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>  Documentation/nvme/feature-and-quirk-policy.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I have applied this, thanks.

For future reference, a remark like "tested: not breaking anything" is
not helpful.  If you have done testing, reviewers will want to know
*how* you have tested it.  For a patch like this, of course, that
doesn't matter.

jon

