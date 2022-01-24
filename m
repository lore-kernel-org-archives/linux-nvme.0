Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FC6C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TjH3+E2QTEfIZW4myPyv1uylF3iZx7fILQ8xs/xAAh4=; b=G/YeCuw/yVswjsRKvgWT5VrwYm
	Pj567u5Nn3aejnfuyXRsdY17YcgmjWmpfj2+/XQlvwCpXQhvafv4CSIBSDX1sQHo1+pZ7psDepl9N
	RCjHomNfQsAr7otDXq/1KMJHWLUKPMYjilvxvVKh/2RB5hyXAba+2UF2DtVHeIIuFypy2Z/1Rlsuy
	V9w202bOfoXzHazLzt6e/LoFQMv0v6od2c4do4zxnw5T8lw+Eud+Ba3ZOt2stcptasWpF1j00P5pd
	2GydNnP6uAaoMT42JvQVlSGzbOCQEVKabZvKpd0N1H9XpQK98Eg4m0PBs/t5INKNTg/Cdzlr6+qUW
	UsFY+2fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBzOS-003VQr-U2; Mon, 24 Jan 2022 13:28:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBzOP-003VOv-S0
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 13:28:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A5A4968BEB; Mon, 24 Jan 2022 14:28:18 +0100 (CET)
Date: Mon, 24 Jan 2022 14:28:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 12/13] block: move rq_qos_exit() into disk_release()
Message-ID: <20220124132818.GA27997@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-13-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122111054.1126146-13-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_052822_087476_BCA2F17E 
X-CRM114-Status: GOOD (  12.91  )
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

On Sat, Jan 22, 2022 at 07:10:53PM +0800, Ming Lei wrote:
> There can't be FS IO in disk_release(), so it is safe to move rq_qos_exit()
> there.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

