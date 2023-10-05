Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF49E7C4FF
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Oct 2023 09:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HhMXB1n8XWKHsDiDcZ07uTiFWB
	bt1DXfBgPLDaC+JuVv35HP9Xnw/6i1qqSdaLBZE+bZV65rW8hHeR2Ygng7ec/PfwIu8bpmYzlhMeD
	wzunOYOyS2H71dtVlS2DINCGkmCWQtYuimod0pSXWBCEyYGetG7NsBs/Cd+PqJCuH4s4CIjHzNIHv
	VFDI7LF5TNGx0PneeTkdhvc0yI3wONrr53CD4Ico2xW7iVyZqqOhOGjkTMlUJHcL/gSr6+JzLoRSh
	pB9xQtfUEwy1373bEwWc2vEX9JL0Pg8xV3v2HwHmqDu1difFQus9qXXt9N8+T1fXladJB2yWpM3w6
	UTDldHVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoKGg-001j8I-1i;
	Thu, 05 Oct 2023 09:03:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoKGc-001j7U-1l
	for linux-nvme@lists.infradead.org;
	Thu, 05 Oct 2023 09:03:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A09F868D09; Thu,  5 Oct 2023 11:03:26 +0200 (CEST)
Date: Thu, 5 Oct 2023 11:03:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	zahavi.alon@gmail.com
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization
 setup
Message-ID: <20231005090324.GA15643@lst.de>
References: <20231002105428.226515-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002105428.226515-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_020334_726699_947B6015 
X-CRM114-Status: GOOD (  10.77  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

