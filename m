Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3A2C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=aLrIJfLah0zo+fUZjiv319dVSe
	bcbO6sLfJuPyvNk8V1f8dzpr81SV7uGKgnKqMwh62VCTgksfKw1nOIIYI6M2H0o9IJYjvN/M81K+C
	v8Ov83abCfPEnqWD9sEQyjQFUs0zqHVNr3hVBRfEbiY/doC627aLECxKFhq0SbAg5j/iwLEuAJl6f
	Wfkp9buByS7P+p1eHKpbVE+4eKNzUD0ez7dRK6qZaS67bg4KZnkSo51BeQbOiPOj8U15X73GMYlWu
	KqbvZd7Jf8W6xXc4v6ZwgO6cwD29YGtWTAKUhei1jJu+xI3iBKaJlYF2/b0nXiwTAM8JKc73xvqhV
	VgE1xEng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfIAq-00000004bsO-1aLo;
	Thu, 02 Jul 2026 14:13:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfIAo-00000004brQ-1WZl
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 14:13:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBBAB68CFE; Thu,  2 Jul 2026 16:13:47 +0200 (CEST)
Date: Thu, 2 Jul 2026 16:13:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: hexlabsecurity@proton.me
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-auth: zero the AUTH_RECEIVE response buffer
Message-ID: <20260702141347.GB23046@lst.de>
References: <20260702-b4-disp-127414cf-v1-1-e5395cc0f9ae@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-b4-disp-127414cf-v1-1-e5395cc0f9ae@proton.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_071350_543185_472DA254 
X-CRM114-Status: UNSURE (   9.79  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


