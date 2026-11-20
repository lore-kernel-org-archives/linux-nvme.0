Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086F9606A339
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tW2v4h2l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tW2v4h2lX3Ccao8A2WzoydDKs3
	9t/gxxF/qmGYDy2jc8ctst5LKLmRuqS/Qy536K6XHrSS/63B8kJS+peQsZkzD2B1NBSYlfALn/3Pm
	qMUBROnYwYkBMV5e02hLKgdzrIbvusycE734AUozUOseNivp72bFqW6WhkOCoeGqpfNW+mYsMvu2+
	sLQTD5KqOwNG/e3rFEG6HM883UwGF36ZrSwtVJA2Gx1sCUmixVwT8FuF97Pfk0FjBu45ogf5kZOIw
	sjIRlKxIDhH1Pfe0vFY0duu4N24dNEa8tABUgvdYNkWr2Rj/UD3XkUICquUgJUzg+eDOiv/A6njiR
	0WcPuyEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSac-0000000Fjxf-2Hy2;
	Fri, 20 Nov 2026 17:39:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSaX-0000000Fjw5-2GcS
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 17:39:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DC1BC6732A; Fri, 20 Nov 2026 18:39:48 +0100 (CET)
Date: Fri, 20 Nov 2026 18:39:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/2] nvme-fc: fix use-after-free in
 nvme_fc_match_disconn_ls()
Message-ID: <20261120173948.GA1363@lst.de>
References: <20261116081211.1757155-1-kanie@linux.alibaba.com> <20261116081211.1757155-2-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116081211.1757155-2-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_093953_742186_AC822834 
X-CRM114-Status: GOOD (  10.53  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


