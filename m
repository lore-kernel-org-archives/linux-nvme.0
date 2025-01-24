Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273A8C0218C
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EUyfHwb9lv3xB513S78TNVQ3Fp0DkOb+zWH8cEEAir4=; b=BCHYNwx9X/ryu62gv4dE07jaLD
	o8LO5LIr1jXsMjtTsFOC3BOo/HlPcK4ldSSWAlpZKAHyWZaiLx0z77MNdWEAi7h0M8BFNaFH1vybs
	+5RAF8OdvSS3IA2fimgAWvxMEsv6c1WwALG7+7E/rfIWD88amBTfnXpm0KEDQzR+exH9/tpCHkb8X
	fI83eVUR1wh3XJ53yFbPUmLoPA5++u+cONH/DzRe6oMoQjk9yJPsKVPe2YIsUCxA59LNScX1OuHJz
	/UCcdWfYLkxpeHzaAwSe0pWH/+Xp0L/bANI85dssnOf+1SJE1saf9CYhv82iiZ+DjIwyej5KYE8QI
	0YrIZRKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbMb1-0000000F7HY-3NBe;
	Fri, 24 Jan 2025 16:31:51 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbMaw-0000000F7HC-0qQD
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 16:31:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3EBFCA41A6E;
	Fri, 24 Jan 2025 16:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91C2C4CED2;
	Fri, 24 Jan 2025 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737736305;
	bh=EUyfHwb9lv3xB513S78TNVQ3Fp0DkOb+zWH8cEEAir4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlwUv/aNh00YxVmL4SCDAk5syOKEO/rLwityHKcDzBkd/8US91uM4/s3TaAxeCDKi
	 71PkIADg5j9GZ8m8HCA/tFMdQiH+k4B5rGKccoaN2gagZ7cO959LrzvPr4UU4fOAYO
	 iSykBaXCw3KykLYVL52FPECKrEA5/ppaFUEvnKqPqB57m26Pz9kLakXCqDNGi02MAF
	 ggyYGtfJQPqUErngvF+la1itsmPlcrQ3xuTZ9EgGMowq8t9BKaDZxiFIXtxLGuW+NP
	 6WF7q50DcAf+apRjg9ERGTzYIdxC9fylHLmYT8QXk45fUh7bidoLsVgxfHodNdQqX9
	 Zzikx0XezmM9A==
Date: Fri, 24 Jan 2025 09:31:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?Q?Sa=FAl?= Valdelvira <saul@saulv.es>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Avoid the deepest sleep state on Wester
 Digital SSD
Message-ID: <Z5PAbgT0d4RIvtSv@kbusch-mbp>
References: <20250117164653.1751-1-saul@saulv.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250117164653.1751-1-saul@saulv.es>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_083146_302493_3DC69E72 
X-CRM114-Status: GOOD (  11.12  )
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

On Fri, Jan 17, 2025 at 05:46:53PM +0100, Saúl Valdelvira wrote:
> This [1] page from Dell's web mentions a firmware update for this SSD
> with number 20240012 that seems to address the issue.
> The problem is that, as far as i know, Western Digital doesn't offer
> official firmware updates for Linux. At least, I haven't been able to
> update it.

We would definitely prefer the firmware solution. Quirking devices in
the driver would force everyone to subscribe to the less aggressive
power savings even if they're not affected.

How do they offer their firmware update? I think it's common for vendors
to provide some kind of bootable USB image that does the update if they
don't provide a standalone firmware binary or other tooling.

