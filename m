Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EBCD5CCAF
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m49hkzCq3vBfHbyFUz5keNGzCSwjxw/OxmhytlgUODY=; b=KU3wu/R6sy35QEemDzh0EAnQwE
	/TGrbSwcrwlHzAN/wK49C7+O5OqhrmUjkcfMg73n31J5bWEIA0ODB2F5Ip5te/Gvx0pSAWIxENsXn
	zohMv+gT4vE8KH9vvtVpFjIQzLu/uFsLnLqvN7pFfpXF7m8471wD8iXwjt3Ta5a+32r8QITXaReq4
	Rcwsw0HgDcQWyz37ffAj2Kh/T+TednfnGn5/wCdFynWhTEbYx8c2kX1d5Zwh9odaZTwvA0WE2sVHX
	sV+kSxe9jlWyatOo9+fbJEBkaz2wy4Y+wlRokD6Hl8iLm+FUx9GWIfQc5Ov4BtIKsFDHHxPpmKAuw
	GxKlQWpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t69CJ-00000000Z4f-2urW;
	Wed, 30 Oct 2024 13:57:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t698A-00000000YNo-3UhS
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 13:55:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5CA57227AAE; Wed, 30 Oct 2024 14:52:58 +0100 (CET)
Date: Wed, 30 Oct 2024 14:52:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme-core: remove repeated wq flags
Message-ID: <20241030135258.GA28325@lst.de>
References: <20241030064737.95291-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030064737.95291-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_065303_035480_D8C624C2 
X-CRM114-Status: UNSURE (   8.17  )
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

Looks fine, let's hope the flags actually stay the same in the long run :)


