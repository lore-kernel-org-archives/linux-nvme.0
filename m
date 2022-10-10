Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57624C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 08:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=eiOnD86T81FNQZAHV8MieZzPyA
	YS3IHH8EbgBHGoxNjceqfANAqkuYfHuW3+mELImYu5i6ItsnLvV5d4gcRt0CcJXD2NRN9LPPHMcbk
	O6B9d3KYNPjYWpDjLqkvQ4aPIg/+Tz9ny6qa62xqCrmVNF9rJJBoQ2sgyWCc0eR0eBVDFZOEHpIpk
	Mz9qzFIM0LwaLULUXf1BcJ6lvVxSHzam4zCSKUOotbMTC9XqpS4c9aKm65yfA2OOioUTnZyxqeDOR
	BsBkJd4Em8VzCxITjJ0d91e2FB866xoBHJZvM60TzVfGMY3YVdIjSYPoy/UNUWJ7xLH9Vz0eT2UC3
	C5TiRCFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohoBx-0001KK-Oq; Mon, 10 Oct 2022 08:31:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohoBs-0001IJ-Sf
	for linux-nvme@lists.infradead.org; Mon, 10 Oct 2022 08:31:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A5C768AA6; Mon, 10 Oct 2022 10:31:10 +0200 (CEST)
Date: Mon, 10 Oct 2022 10:31:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Abhijit Tomar <abhijit@abhijittomar.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM760
Message-ID: <20221010083110.GC24401@lst.de>
References: <20221009173744.12173-1-abhijit@abhijittomar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009173744.12173-1-abhijit@abhijittomar.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_013113_073018_690A17BF 
X-CRM114-Status: UNSURE (   8.28  )
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

Thanks,

applied to nvme-6.1.

