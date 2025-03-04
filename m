Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B7EC021B8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Mar 2025 13:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w5Sqp6ajJUx18HBXCU4zI9bE29bBjjr9l3Mi6avbP3s=; b=oBM5T3n5zdGzF2FUYXvdLM0+tm
	tZLLOPkxTP3PcvZQHydD1M90p2/U01kUP2JzSYls11jTp2W0TdUgQyibJMk9OMJNAcnJkIOVl7RHp
	5areXP8VfPazBvbbSdY4gnSgvG3gZxN9WrcrV0AmBD7xZF4GRbvCbht500nkNGcTM1qFNAHrKa9nN
	u+LZ0zfQMfpz8JDeSj+ncZF4DAf0PaLzXb8x6mvGzZfG3mEVPLOm4aAy1lwAnmwZF4QMYfhUQalHj
	FL3wSr6hzZzWBJif6ZbeVGBgZslGYL4aI4cIAI/CPOeUJgy/mu7npgPZBAIQjilCMW6WM+J66Osdx
	TP9tRT8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpSkY-00000004rjq-14Qa;
	Tue, 04 Mar 2025 13:55:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpSkV-00000004rj7-1cId
	for linux-nvme@lists.infradead.org;
	Tue, 04 Mar 2025 13:55:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54C6B68D05; Tue,  4 Mar 2025 14:55:47 +0100 (CET)
Date: Tue, 4 Mar 2025 14:55:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, anuj1072538@gmail.com,
	nikh1092@linux.ibm.com, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	dm-devel@lists.linux.dev, M Nikhil <nikhilm@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] block: ensure correct integrity capability
 propagation in stacked devices
Message-ID: <20250304135546.GA15571@lst.de>
References: <20250226112035.2571-1-anuj20.g@samsung.com> <CGME20250226112857epcas5p1654e62b5fff4551926622f19269c6ff4@epcas5p1.samsung.com> <20250226112035.2571-2-anuj20.g@samsung.com> <20250303141236.GB16268@lst.de> <20250304084833.GA29801@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304084833.GA29801@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_055555_564321_F7A122F2 
X-CRM114-Status: UNSURE (   9.78  )
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

On Tue, Mar 04, 2025 at 02:18:33PM +0530, Anuj Gupta wrote:
> Christoph,
> Right, based on your comment modified this patch.
> Does this look ok?

Yes, this looks good.


