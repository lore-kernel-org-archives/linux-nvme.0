Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A50AE77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 07:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U9a/7+vbYDk7zSofqkhw1PA46IlmZwx3tU6qx7kmPnU=; b=qNEOSEKYGwm/FnRxiCdQZUKlzG
	Wq05+UEOCluNiFsTSxAN4NrUWbwtWzHYZgW3HdY1IBKheSbdfAufiP+LEcHdwog8rvrTIAqY+4a+9
	XZgYnkLpgyVP09Z25+UFHubG0yA65fEhKy4TaFW9qP2TDk3mpSIEvYCNM4VmAxPVqyItp9G4Jd3Aj
	plQGhLgrjLbIuyXtNnCvld6tyt3ByvGP71mvw6gtMjRDUasVYDYZ72oKsf5hgz63byqs05Bsn8JbL
	afwpAVQK4EjozSJmY0fLDhlZdb6Ce/gt+p8p5Ewh/l+P84qJ+p08ElaVo4Zuo3Idt37t0lKsXjepZ
	Buk31U6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKYfK-00000006ncn-1exq;
	Mon, 09 Dec 2024 07:58:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKYfH-00000006naa-1PLH
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 07:58:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D7BC68AA6; Mon,  9 Dec 2024 08:58:37 +0100 (CET)
Date: Mon, 9 Dec 2024 08:58:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yongsoo Joo <ysjoo@kookmin.ac.kr>
Cc: Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix return type of nvme_poll()
Message-ID: <20241209075836.GA24705@lst.de>
References: <20241207045546.119933-1-ysjoo@kookmin.ac.kr> <Z1UOyFnUavHNJu5H@kbusch-mbp.dhcp.thefacebook.com> <Z1U7npo/DINh2MR9@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1U7npo/DINh2MR9@ubuntu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_235847_512158_4C715D4A 
X-CRM114-Status: GOOD (  13.13  )
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

On Sun, Dec 08, 2024 at 06:24:30AM +0000, Yongsoo Joo wrote:
> I agree that all the "current" interested callers seem to expect 
> boolean-like return values from nvme_poll(). However, the return 
> type of both nvme_poll() and nvme_poll_cq() is int, and 
> nvme_poll_cq() actually returns the number of processed CQEs.

Maybe add a patch to switch the poll method to return bool instead?


