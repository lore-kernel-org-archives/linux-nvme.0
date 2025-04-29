Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F189C3ABA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mZjMxrhZX3PqZC48WDq0iIbfVoV5QzA01VRsQ1C30T8=; b=v0D6T2S15+RePbZ1J9fi9HK780
	qOZ/evW/mGzLuyAK42iVY1RNCH5piE5PTpSBXljYtjEUUHfdBLEh+AjaDr7U/Ct4TgXfU6Tv6ykEJ
	wPz2ivwBu8pHHmUyptssRzH5n+8gsBt9/DmpwxJK2Rp3snUAKwDb+IvsbqSQdrFLQEmTcxNe1AZfI
	7ayJIig4j8qrdHyvPkREZZWKHRDSckAUL7DkFezmrY/Zkxokk903hAoUJVUGZfHqNaV0sC7JWtzgM
	E+tsogaisfPjRzLJGkmVbbeNvuriWGHzRfQQm8yepOpuQ4KeVBnd7mWwf/3tDSxigzgbdbvwhaU1S
	3Vq3y2Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9mh3-0000000A4yY-3mbv;
	Tue, 29 Apr 2025 15:16:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9kjd-00000009k6F-0Hv3
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 13:10:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CA8AB68AA6; Tue, 29 Apr 2025 15:10:49 +0200 (CEST)
Date: Tue, 29 Apr 2025 15:10:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Maurizio Lombardi <mlombard@bsdbackstore.eu>
Subject: Re: [PATCH] nvmet-auth: always free derived key data
Message-ID: <20250429131049.GE13970@lst.de>
References: <20250425093434.36383-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425093434.36383-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_061053_241711_2E48E3FE 
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

added to nvme-6.15.


