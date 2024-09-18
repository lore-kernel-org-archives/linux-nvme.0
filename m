Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7092BCCD1A0
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 12:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sLzKTKWg3g0du0egesNyuK5+3sKuXjEkiax0B9e4gJs=; b=A6QI0uCQ2A3OX9r+t9vAlxIcvc
	Jm7U5dCNMdz5/FYtkIDXUcPDjfIbERivujEuNhciAOu7pv4KYmMJrMJdaauNrSmXb5cCl9Qir7j+6
	qk6Wjco6hW5hqJ3HGP/Akl9DW8+uviU085HdEhVyIyTPah5zk7h7NqXIBKAb5X00yNnM15xjXUXql
	RXT42e8g8jSf204L+b31J4AePFaiouHgTy+B72v/6mjgI4ZzrzaFdEm4NilU1Qt5/r78vZbtln7rd
	lWhqt6WMCX6EzCUmh9O40ezqGtHN/0J1ZKAWilSTiuL96j/8E7MA1CdQEQ5rRs8J91shCAx+qUhrG
	OIt6zZVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqtNr-00000008Bso-2kjJ;
	Wed, 18 Sep 2024 12:02:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqtNo-00000008Bs0-0RS4
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 12:02:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B102227AAD; Wed, 18 Sep 2024 14:01:59 +0200 (CEST)
Date: Wed, 18 Sep 2024 14:01:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Message-ID: <20240918120159.GA20658@lst.de>
References: <CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com> <20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de> <e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com> <20240913080659.GA30525@lst.de> <4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com> <20240917062007.GA4170@lst.de> <b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com> <20240918064258.GA32627@lst.de> <197b2c1a-66d2-5f5a-c258-7e2f35eff8e4@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197b2c1a-66d2-5f5a-c258-7e2f35eff8e4@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_050208_458117_9D6655A0 
X-CRM114-Status: GOOD (  12.42  )
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

On Wed, Sep 18, 2024 at 01:42:51PM +0530, Kanchan Joshi wrote:
> Would you prefer a new queue attribute (say nr_streams) that tells that?

No.  For one because using the same file descriptors as the one used
to set the hind actually makes it usable - finding the block device
does not.  And second as told about half a dozend time for this scheme
to actually work on a regular file the file system actually needs the
arbiter, as it can work on top of multiple block devices, consumes
streams, might export streams even if the underlying devices don't and
so on.

