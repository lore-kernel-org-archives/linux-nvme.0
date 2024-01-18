Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8FEC4707B
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 07:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jsLAggBG7jNSyoUNSxBkNWTcJJFL/+CUBaC6/kd4BcY=; b=1d9Y+iwAvVsXNPMTTVrt0o0lzE
	w8IPFjcTvPDpvkroG38thZPpExn4UXzxSmuYEWhTq4dXQfczaLBxKkT9zis9jNeYBGFVOhJzOJngF
	MFu0TsXw6MKlPdtofK19Az//eK5p+xw4xS1RSgyb2EcFlXO+IropACwZSpuf0TCSj4nM4bqB5HvQV
	M+ipXBzM3WNd190SknuOQXA04K0ucfOvA+CuTrl8hyu8irlDRNYqcsw6aQNWvbHHQ/gl9jJHn/xd6
	jXKySisuant38dqaoWwlXSUcopp6r7GnKKrwA3cal7gVziUW4sANOokJUOfVzOMUXbAmTOFStB/gM
	3Yr7DZcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQMlK-001uIZ-1T;
	Thu, 18 Jan 2024 07:24:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQMlG-001uHT-18
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 07:24:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C883168C7B; Thu, 18 Jan 2024 08:24:19 +0100 (CET)
Date: Thu, 18 Jan 2024 08:24:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, linux-block@vger.kernel.org
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Message-ID: <20240118072419.GA21315@lst.de>
References: <20240116232728.3392996-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116232728.3392996-1-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_232426_537136_9FB24539 
X-CRM114-Status: GOOD (  10.39  )
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

On Tue, Jan 16, 2024 at 03:27:27PM -0800, Alan Adamson wrote:
> It has been requested that the NVMe fault injector be able to inject faults when accessing
> specific Logical Block Addresses (LBA).

Curious, but who has requested this?  Because injecting errors really
isn't the drivers job.


