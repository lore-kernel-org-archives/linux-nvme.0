Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E360BEB28CE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Feb 2026 06:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wbm43Jl33Vlw0/MBtQN8gUW4I2dD5XcqgLiSY1GBTmg=; b=yAFmYtby8Ir5XqHIVaGXeVSiik
	3H/dW/Pg/V5LSvjYUFBQ/0iESdS1MzvZPAn4G7vg2DVGT1pIZ5UpAp6v7FjCT/w8KufWON5HEGJZt
	HQzq5Z9KOlqdzUIopx4uRAlaxlluAbDna9SyehmKPjlW9G1Zyjv3kN8latSDnhog/XZHHgegAeAhp
	xO7BYETL4EeVl/J10eTsaCQJaT0hwaAwWWVgtGOOHuG0Z4iAQfZ7vnkxJL3zH3MIDx9/7TMbLqxhd
	groqp4yTD0885FogBCLcQT1Q+H91Saq/XloIjWC/NKWGZke30mdsIjL97CMyX3gNQTDLxcw7GgI3V
	c02cENCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voF4h-0000000AvmB-3rmu;
	Fri, 06 Feb 2026 06:12:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voF4e-0000000AvlC-1ZHW
	for linux-nvme@lists.infradead.org;
	Fri, 06 Feb 2026 06:12:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 37BE268D0F; Fri,  6 Feb 2026 07:12:04 +0100 (CET)
Date: Fri, 6 Feb 2026 07:12:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme: correct comment about nvme_ns_remove()
Message-ID: <20260206061204.GA25563@lst.de>
References: <20260205171115.2610321-1-john.g.garry@oracle.com> <20260205171115.2610321-2-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205171115.2610321-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_221212_555300_CB54A41E 
X-CRM114-Status: GOOD (  11.71  )
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

On Thu, Feb 05, 2026 at 05:11:14PM +0000, John Garry wrote:
> The comment in nvme_mpath_remove_disk() references nvme_remove_ns(), which
> should be nvme_ns_remove().
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


