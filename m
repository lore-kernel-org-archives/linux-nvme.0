Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5023FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  2 May 2022 16:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ziMFDmcizVw/HKzX4CFbEQ+0h/nCHY1FKPAaX8g6rfw=; b=ssm6Tq1i/etkXA65KkOc5VBPar
	wEj7QrKdUlxXzEGE/MpxTKIXAxZSUsYtI4ZRp68KhmbM6rxgPNbqyGHPpO9chGoqQOARHx/HsLMzX
	TQa4tNmPtol2e+6Fab7eu8FHcVzTPHRv8JVfYH/dRdywJzPlnC8y97Fo3xaCjtSTRniFHgzU6VyJT
	YMZE9w+rD2PV2NSyRk89baHa2e77H4dOOYQJPFVXiV0B5jKI6jD0HK8fX3qdertDtIZ+mYV+GtIwY
	BtP5zGAkhZwujMcR9p7prZsEI0ZHSdqFGBswudnFwIaDy/+9NdW3Y3Rx9Nu9l5M+CIOmokfnhLrbX
	CxY4iTUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlZCK-001mjd-Ow; Mon, 02 May 2022 16:46:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlZC4-001mXj-0w
 for linux-nvme@lists.infradead.org; Mon, 02 May 2022 16:46:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 509A268AFE; Mon,  2 May 2022 18:46:37 +0200 (CEST)
Date: Mon, 2 May 2022 18:46:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: Re: make the blkcg and blkcg structures private
Message-ID: <20220502164637.GB21569@lst.de>
References: <20220420042723.1010598-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420042723.1010598-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220502_094640_270454_2806D27A 
X-CRM114-Status: UNSURE (   7.47  )
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

ping?


