Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CD5C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 08:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Auh5Dv9WfIsMc5rxu+aZzFtIPwT4cBiJ1zwFftnySgQ=; b=oUbSoMSAx7uYo5NNrgVRt81JiP
	P8uxwFam5pvv0S/q9LLEUC5WFn3SyxkFj9yedFemz9anaj9s1S4ug8IYQFQRtXznqgEEiA5vS6Sne
	Gof1eRp735p3OatMMc6QSONEr1/EKS8LHK8SukYOGsaLuGO7eBE7Xc4McTv5acP3LQVB6+mRVtQ6U
	wWApImXBaCDMjvlsTqsb/86v/WZ4A+LhSsmSlenmRg5xX/hKCuLJBOc5QruEKDcxQe7SgOccbF5uH
	gO+32JHgyYyzPCSsYY+x6IIM5Ui84ovHGiZ42jLv85p+/wM163KGVWysVglL0+3ZQ5n48BJOQ5p7I
	TysRQTZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u797I-00000006LEs-0UmV;
	Tue, 22 Apr 2025 08:36:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u78At-0000000693l-4Ayl
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 07:36:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A76D868C4E; Tue, 22 Apr 2025 09:36:07 +0200 (CEST)
Date: Tue, 22 Apr 2025 09:36:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, kbusch@kernel.org, hare@suse.de,
	sagi@grimberg.me, jmeneghi@redhat.com, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of
 the multipath head node
Message-ID: <20250422073607.GA31849@lst.de>
References: <20250321063901.747605-1-nilay@linux.ibm.com> <20250321063901.747605-2-nilay@linux.ibm.com> <20250407144413.GA12216@lst.de> <5db5ab7b-fdf2-4b40-86fc-3ab4ccff9a41@linux.ibm.com> <20250409104326.GA5359@lst.de> <385cbcd5-fcb1-4f98-bdf7-80b16d4f5f8e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385cbcd5-fcb1-4f98-bdf7-80b16d4f5f8e@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_003612_172402_95C81BFC 
X-CRM114-Status: GOOD (  11.59  )
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

On Fri, Apr 18, 2025 at 04:15:55PM +0530, Nilay Shroff wrote:
>         }
> +
> +       if (head->delayed_shutdown_sec)
> +               return true;
> +

Please add a comment explaining this check, but otherwise that sounds
fine.  Your text below is a good start for that.


