Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE42606A326
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hkve0rty;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=rNb4i5Yz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=r0myuFApk3CTYGQTEnFeQDMpROEFi5dgwBJlvox4jFY=; b=hkve0rtyp7m1mfKw8gIZf89NUC
	Sgi5HSr96O6topI2kvh5dJFkO6dIl7kSdxg/2RTzvD2Yt9br5ZlTWs3tRLgvKnYsFnS7cCL0bO4Qj
	mjTOlk2QClB1hpO3X7XPTQMA+haiJV+oT7gioalQYRtPubln/1cHhUHxOf/dps2WK9/w2pysHKeyp
	aOFMdquQU+DKR/USZeP+DbMyXJKG0faLrmGUo1NtQjdNcKl/uIBJZ7PnOBnLcMSy81HaEQtLU3Pri
	QXBQu0+qvo26fU3gHXDYxL6lPc6kv9uw6oM1gkGbaVIrby7gc15xVCtUszfHdz1sX/7EbAdfq+Agk
	LCJZc5oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW7MH-00000008rvf-01Bz;
	Wed, 25 Nov 2026 07:24:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW7MF-00000008ruQ-1YbK
	for linux-nvme@bombadil.infradead.org;
	Wed, 25 Nov 2026 07:23:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r0myuFApk3CTYGQTEnFeQDMpROEFi5dgwBJlvox4jFY=; b=rNb4i5YzQDwJUkUxZdMhQ+Q1zx
	BiBYkOrkvdXqPCLso0suVjuXLfQOHJUF7xH6cvCATXfkp3zGlr3VOCyq92MHtoUtIIJmlonH3P7FH
	n6H4c8OaDHmDd/KuNWNVMFlmjKxoImsMer886APlLHC2T81e9NII1532eho6AsjOrhG+DaB4gn0Z6
	wzTq30IYLcJL08O8Ap9L5ESPOGDYEfY8M2LR8oZgoXF7oPXcjUqs4CXIZ6osk/e7dlbUXUYAXQZxh
	zTPSe+dpwwbW/b7QeLLgWdWtp5Kk2YRYOdstV4ECKlc1ckMS6R+OvpWH2wF3LwFby7vjBS/N6DSlC
	ay2OWQ1Q==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW7M9-00000004yWB-1XYr
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 07:23:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D012668AFE; Wed, 25 Nov 2026 08:23:48 +0100 (CET)
Date: Wed, 25 Nov 2026 08:23:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: protect ana_log_buf teardown with
 ana_lock
Message-ID: <20261125072348.GA21866@lst.de>
References: <20261125060153.206699-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125060153.206699-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_072353_618115_90270CC5 
X-CRM114-Status: GOOD (  12.48  )
X-Spam-Score: -0.0 (/)
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 02:01:53PM +0800, Guixin Liu wrote:
> Reported by Sashiko AI review as a pre-existing issue (not introduced by
> the ANATT timer fix). Confirmed by source analysis and reproduced in a
> KASAN guest with nvmet-tcp loopback and ANA enabled.

Sashiko thinks this is still not enough, and it's probably right.


