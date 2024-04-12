Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED86C4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Apr 2024 00:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5vKBuksZ5kdmC2xyPQ9szOKT7dNSk6Dd2A5gwawhC98=; b=qA6gZreynzhUkL6unm74Ao5neg
	NcS7k+pdUWFt2J1mh9RW7ypAa5o15BX2B1Gm4mhnw78N2Awrf95JLLwmzC/G2ALySaa3jkb1m/M/c
	VxaaE8Cb6UNif+TXSj1+C0BzdbJGscxKza5lMmY127pzuMdkaHllZttdq1qMvDS1jX/ybOvidxKgS
	aMP5DJUMGAKB8T7BHIS10ccB44fqyi+H3+D4042QNS/JYJpdqiwM2QrJrrWBeBsOLqldIbGwU0lTZ
	7L+QgR9SIEtU16QPzO5cbdIY7MFAhn2/qeVH3gqSN0GuVAL0vBwauIOo91+oUeOJ13+UWSBThYxTo
	XggV5T2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv4tW-0000000EeTl-44mZ;
	Fri, 12 Apr 2024 00:35:54 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv4tT-0000000EeSg-1mPh
	for linux-nvme@lists.infradead.org;
	Fri, 12 Apr 2024 00:35:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A7F2ECE1A42;
	Fri, 12 Apr 2024 00:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DCDC072AA;
	Fri, 12 Apr 2024 00:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712882148;
	bh=xkiOakWsstPYUd3L2iZS0Z2/9nFmIGmyDdRpxbqWF5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pyXKWUx3GAgXAnYE+f/YFC1sXWSZauRG9HFX7RRrez1CX0D5K2HTaSDOqHC7DwyAC
	 jAU0DvGEmlx7F3mv8sbIOQdliQOkcSud0EBr88omo9t2ZrfXz3i5loEofX2oOnVUwa
	 WFGq1Gk7oU5plqdQ7UwbhhYO3/eSakc8uo1+jgkj8G48eKx7iUxyxMiUC3W1MHkhac
	 uvcLF+Pyq1MjiWkNhplrw43thVH9ZYKtwXddmin76US/QIzAQ/MCnuwECeuEGxpfYS
	 do6vSqeYDixQVfWspacYMTovaCKRJAl17yFSPn/bQ3PkvAZmgQc/pWDpIbRHvIOxGX
	 2Azf7Gguj9hDw==
Date: Thu, 11 Apr 2024 18:35:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, chaitanyak@nvidia.com,
	axboe@kernel.dk
Subject: Re: [PATCH v2] nvme: fix warn output about shared namespaces without
 CONFIG_NVME_MULTIPATH
Message-ID: <ZhiB4iLS11qFEqdj@kbusch-mbp.dhcp.thefacebook.com>
References: <20240410005714.4112157-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410005714.4112157-1-yi.zhang@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_173551_821608_4A5E18B1 
X-CRM114-Status: UNSURE (   7.77  )
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

On Wed, Apr 10, 2024 at 08:57:14AM +0800, Yi Zhang wrote:
> Move the stray '.' that is currently at the end of the line after
> newline '\n' to before newline character which is the right position.
> 
> Fixes: ce8d78616a6b ("nvme: warn about shared namespaces without CONFIG_NVME_MULTIPATH")
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Thanks, patch applied to nvme-6.9.

