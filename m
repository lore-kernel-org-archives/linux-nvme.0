Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE1BC77B7E
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 09:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LjNgHtd0l4YDpmNhhZxgUxadELg5fghbdIZrZ8u0rho=; b=rb3Vr9IyQD2yythr7MNoNKtTlD
	JeQseDKrdxZr7gCpoqKRnjYN9GN9gqnaEimyGNzD/4/ZH55Lp+KKMYpDd0QRivVhgwEMIhA5+kuA7
	tQL6l5yq1LWyO75Z83Lh29CtK8qxwkKQzr/6kbDSw9ae4y/RrAVf+oD+8v+xk4Lllch5G+oG8zex8
	EoDtG2qlavK7zVTqhhG+466erK9b8ipdcKbrXEPeccmBYTMRgdCV1Zjw1eQiRhSKC88DKhHXd9I+r
	BJzLx8wtCJn3rd07l3zgBI0qwziivCEgGNp+OK/epB1anDFZa2gHLtqSRVmNhKyyK6lBKwOZJ6b92
	H9SPrIsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q275H-00G72X-0N;
	Thu, 25 May 2023 09:16:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q275E-00G721-1Z
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 09:16:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8DE368B05; Thu, 25 May 2023 11:16:28 +0200 (CEST)
Date: Thu, 25 May 2023 11:16:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 2/3] nvme: check IO start time when deciding to
 defer KA
Message-ID: <20230525091628.GB26725@lst.de>
References: <20230524232218.1584605-1-ushankar@purestorage.com> <20230524232218.1584605-3-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524232218.1584605-3-ushankar@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_021632_671605_6F178225 
X-CRM114-Status: GOOD (  11.77  )
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

On Wed, May 24, 2023 at 05:22:17PM -0600, Uday Shankar wrote:
> +	if (ctrl->kas && req->deadline - req->timeout >= ctrl->ka_last_check_time)

Pleae avoid the overly long line.

> @@ -1173,6 +1179,7 @@ static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
>  	 */
>  	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
>  		delay /= 2;
> +
>  	return delay;

Spurіous whitespace change.

