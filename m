Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AC5C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 19:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6n6iq3CZVUsX+sCMEoHVc2oaM47QdeTqGDAvLrbLFts=; b=Qv/T+F0SKWci5tuk1WnuZUU/Ri
	ID80KvULikauNy2deZlut7QpAaxY2kJ1i/ZSzfHciqfHvjYYjr95P/vRMsTzA24eRb9443pfRsgVM
	IaQMajAMVsvaGQzgl+ftYZdQuBKpAKpf5rd6242kXWkjKi00IhFCLfQd6Gb0+NuNdk2EAD7BpNHNN
	G5v9QDxIpTedGjioi0LlZuILK+WZqQt852LruzboyjPDxo9/ZAvmqsyfn6tXoaRL26dXBOwtSN1x6
	FN0t26pcRoJxYv9U/LezJlkaiRXLv8Rm1JiF4lYoHL1KvenFpnB7DpVqAClJ/17WfyOzEgBdcEcS8
	GByNlm5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQDij-00Bl29-2x; Fri, 04 Mar 2022 19:36:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQDig-00Bl12-9t
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 19:36:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F229068AFE; Fri,  4 Mar 2022 20:36:00 +0100 (CET)
Date: Fri, 4 Mar 2022 20:36:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
 song@kernel.org, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: remove support or stream based temperature hint
Message-ID: <20220304193600.GA15474@lst.de>
References: <20220304175556.407719-1-hch@lst.de>
 <20220304193439.GA3256926@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304193439.GA3256926@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220304_113606_516176_6DB3DD54 
X-CRM114-Status: GOOD (  16.82  )
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

On Fri, Mar 04, 2022 at 11:34:39AM -0800, Keith Busch wrote:
> On Fri, Mar 04, 2022 at 06:55:55PM +0100, Christoph Hellwig wrote:
> > -	ctrl->nssa = le16_to_cpu(s.nssa);
> > -	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
> > -		dev_info(ctrl->device, "too few streams (%u) available\n",
> > -					ctrl->nssa);
> > -		goto out_disable_stream;
> > -	}
> 
> Just fyi, looks like the patch was built against an older version of the
> driver, so it doesn't apply cleanly to nvme-5.18 at the above part.
> 
> Also please consider folding the following in this patch since it removes all
> nr_streams use:

This was against Jens' for-5.18/block tree.  I'm a bit lost what tree
to best send it against as there will always be some conflicts.

