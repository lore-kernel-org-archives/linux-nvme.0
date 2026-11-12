Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ADE606A32E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CmpTnGS+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XLX7xUN0STtbaswLUVy039LSW+Xs+KrNDznhT2Gm/LE=; b=CmpTnGS+Lb65stagZJ8PjSos++
	H5BYutmBg2gCkxZvo/TZNK/AykTR6Dr7vwtkQHfN+WKptKCtzR5O9kFHj+vDDQjCpkOX/6N3sbsrY
	WkXuTIAGANlA9q9b3+ZSHmX4xLTrP+Yp5YuUUYPJVbWyifKlzHQFyS4ENnJpOfioVwRhKUVFmPXib
	n98yGoFzouanNhsXZx2n8adB+Iruj1QZ1QS6MPPD7mZe+vBlL5a6B1+qyDn072zTKfVOb+yLz6kH1
	UNts6lW0EewhnU3/uoAfnVID2HcUEMwsirV7F9q0oxxVWPdl1CF0HHGux2ZlW0iYomUOeOYl+HRaA
	jUGqJIMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRc2r-0000000B3T2-3kmF;
	Thu, 12 Nov 2026 21:09:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRc2q-0000000B3SS-02Na
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 21:09:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A941B6732A; Thu, 12 Nov 2026 22:09:16 +0100 (CET)
Date: Thu, 12 Nov 2026 22:09:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvmet: handle short reads and writes in the
 file backend
Message-ID: <20261112210916.GB11078@lst.de>
References: <20261112220058755zQhw_h6UkcVSjRnu478lb@zte.com.cn> <20261112220105340AIwfaxoF7-iONJ2bZlEqI@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112220105340AIwfaxoF7-iONJ2bZlEqI@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_130920_208414_AF2E313C 
X-CRM114-Status: UNSURE (   8.74  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Still looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


