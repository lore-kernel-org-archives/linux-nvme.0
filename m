Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11984CD8C9D
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2026 15:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tH653NbSmWShhrqHO75KERtMHsrIkCDX+cA3uzofLOg=; b=FT4zpuT0mQbGwFivViVQdkvX/T
	QidjeGNvSMgUfuWI3owwERs9Q11ILXtICx29wZtbNNhEiC4DrXX0up3snFof6UIhcF9ANWUM3Kwve
	/BSCoRgGTDzENz5SFhe9LsHxpr99NV3Ovw5la7Ux2OB2tv71QajN2ENqB5qEbjY09hwc4Lkj7m6r7
	d0ScDIvKEuCLvmZdzt7jbYyy2eGu3striy8RvEhfH1f0DTaYTdJkQ67dfdO/Osd1M7IqtFYs0btUk
	F2vNwOfPXEflAWi7TAY+22oXBxImGnT+fUuTPD4rGGYLE4UrCzsFGB1OogrrZzb1671m7ZraleHAE
	pbDwXG8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbV4-00000003ujZ-2hqA;
	Mon, 08 Jun 2026 15:02:50 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVkrc-00000001UPG-1avl
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jun 2026 06:50:37 +0000
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 2E00E20B7168; Fri,  5 Jun 2026 23:50:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E00E20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780728620;
	bh=tH653NbSmWShhrqHO75KERtMHsrIkCDX+cA3uzofLOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEzT5ARsTUjn6reKkrwdJaP7fkQibLP6EKL9DaShkDrim6pD7moeJVUPAXAFqlZiQ
	 OnfLBe62DFRgqYAS5Yd48xXb3yUZCG/vEiTDp6IzwMs+lyR4jmyZXx4wy/jztlHm0R
	 gddWF2Cgp+XOPCA6cSrjf9I2QsnfupBBairNheVA=
Date: Fri, 5 Jun 2026 23:50:20 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bart Van Assche <bvanassche@acm.org>, mkalderon@marvell.com,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	zyjzyj2000@gmail.com, sagi@grimberg.me, mgurtovoy@nvidia.com,
	haris.iqbal@ionos.com, jinpu.wang@ionos.com, kbusch@kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	kch@nvidia.com, smfrench@gmail.com, linkinjeon@kernel.org,
	metze@samba.org, tom@talpey.com, chuck.lever@oracle.com,
	jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, trondmy@kernel.org, anna@kernel.org,
	achender@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kees@kernel.org, ebadger@purestorage.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	target-devel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v6] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <aiPDLFM0xYlDYQFc@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
 <5d3cac2b-4011-49c5-a142-55c85d38e90f@acm.org>
 <ah6gtquGDMvEXjcb@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah6gtquGDMvEXjcb@ashevche-desk.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_235036_465860_3C194937 
X-CRM114-Status: GOOD (  14.54  )
X-Mailman-Approved-At: Mon, 08 Jun 2026 08:02:49 -0700
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

On Tue, Jun 02, 2026 at 12:21:58PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 01, 2026 at 08:51:40AM -0700, Bart Van Assche wrote:
> > On 6/1/26 2:25 AM, Erni Sri Satya Vennela wrote:
> 
> ...
> 
> > > -	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);
> > > +	sdev->srq_size = min_t(u32, srpt_srq_size, sdev->device->attrs.max_srq_wr);
> > 
> > min_t() shouldn't be used if there is an alternative available. For the
> > SRP drivers, please make sure that both arguments of min() are unsigned
> > instead of using min_t().
> 
> Ah, I just answered in similar way against v5. I also mentioned clamp() there.

Yes. I'll be incorporating those changes in the next version.

- Vennela
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

