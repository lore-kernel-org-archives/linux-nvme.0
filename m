Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DC1CD8C92
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2026 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ZPQTHXE5gAinvcFrdLDvmny5q7hBMs7sPulpqBsTN0=; b=hPh9vEOzcZtP1i9wxOMzrR1Epe
	t7D6lBEJbNR7AJwitPT9EUSuANewHM4qhkyHpshKwmjC+ftRLoh/crCrv/eakr9V6ZEslP3vwLO2s
	QJ98A7mNP/hA2BvzAm2TFdt8ZFyjzcpHKa8X0Jq3dmKM7Ie4CNV1Ai3BWWxzqDuBhptCX8vJVPYAd
	RHmTJOXzBSfzWf0Z+GlPttcd9w/u+qw23z046vmArRt14UfYHLnIcBrSH4ax2hM4oQTt+y5cBPLkC
	9F7gng2kWLznNIQXohaWfrYrm9FXS2rfnt0JyIheIjDRMmKwUYh1RKhh2I3KiPwNX0aGrAdLGY5Zc
	lJLVghTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbV4-00000003ujf-3KwN;
	Mon, 08 Jun 2026 15:02:50 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVl0P-00000001Uet-29gp
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jun 2026 06:59:42 +0000
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 11F2F20B7168; Fri,  5 Jun 2026 23:59:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11F2F20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780729165;
	bh=8ZPQTHXE5gAinvcFrdLDvmny5q7hBMs7sPulpqBsTN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0C9gHEVD0NItrWIcxHcAKdiGWLtqWnpxv4406k0NGC46Jm9ka8DXY5OSQIa3u+LY
	 fSbOgIe4H81D1lGrGMDTEBc1nw39+OpJaICLqiBvDFnKF7ROTKlLqhh2PS4DliPwnK
	 YVbn8fVYf2a21SWTcuKyixQI0DbmOjZ27lEZo5eI=
Date: Fri, 5 Jun 2026 23:59:25 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bart Van Assche <bvanassche@acm.org>, mkalderon@marvell.com,
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
Message-ID: <aiPFTW1NCl+p5NUc@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
 <5d3cac2b-4011-49c5-a142-55c85d38e90f@acm.org>
 <ah6gtquGDMvEXjcb@ashevche-desk.local>
 <20260602122104.20afa8b4@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602122104.20afa8b4@pumpkin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_235941_600135_C90FD7A8 
X-CRM114-Status: GOOD (  20.86  )
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

On Tue, Jun 02, 2026 at 12:21:04PM +0100, David Laight wrote:
> On Tue, 2 Jun 2026 12:21:58 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Mon, Jun 01, 2026 at 08:51:40AM -0700, Bart Van Assche wrote:
> > > On 6/1/26 2:25 AM, Erni Sri Satya Vennela wrote:  
> > 
> > ...
> > 
> > > > -	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);
> > > > +	sdev->srq_size = min_t(u32, srpt_srq_size, sdev->device->attrs.max_srq_wr);  
> > > 
> > > min_t() shouldn't be used if there is an alternative available. For the
> > > SRP drivers, please make sure that both arguments of min() are unsigned
> > > instead of using min_t().  
> > 
> > Ah, I just answered in similar way against v5. I also mentioned clamp() there.
> > 
> 
> IMHO it is also best to do min(value, 255) not min(255, value).
> Like an 'if' put the value you are comparing against second.
> 
> The min_t(u8, x, y) you've removed are usually broken.
> 
> Maybe I should change clamp() to allow clamp(int_var, 0, unsigned_var).
> That will need the order of the compares swapping (to do the low bound
> first).
> I think they used to be that way around, got changed by a commit that
> said it didn't change it!
> Correct code shouldn't care.
> 
Thankyou for your suggestions, David.
I'll use min() in the way you suggested in the next version.

- Vennela

