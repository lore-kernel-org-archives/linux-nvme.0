Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21297C77B61
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p4qcoR5DneUBlbYIOewzSmGPSEu974B9T76Vp1Mv5j0=; b=0bmwGlSPKen2Kz9eRyLbQRP1c9
	CERXTkwr5otE6iHe5XK491DhvXnvHtBXeNku0lKhEkcK1rPsvK6ouurUUIv0S/meqKIcgFI9LF6fH
	o2zq5CABiEe16+UqOfv/O0VczoeQtQYuzAnXAa2mAk9osBP5gd5SlHc2LU8YhPuRYQ78oETy0Z3Av
	qJmJ65GE5VqEZzn+moSKc9eSfOO2LQOc9YGHrPtnu7YnDhIAB+SrdMnYT7rPGA8eQphQaJVm70YXh
	R74+CithteMqm747veAg+1j70btiPwmWS3f4xqOYFpNFJOMv5QxwP5QsgPwGceU1k1YD/c1DTekkf
	bb4QQOjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phXm6-000n3Y-1F;
	Wed, 29 Mar 2023 15:31:46 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phXm3-000n2P-0h
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 15:31:45 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230329153137epoutp0131324ca6d35f832c4f56b0caab4c0634~Q7ZfZ1nKD1616116161epoutp01Q
	for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 15:31:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230329153137epoutp0131324ca6d35f832c4f56b0caab4c0634~Q7ZfZ1nKD1616116161epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1680103897;
	bh=p4qcoR5DneUBlbYIOewzSmGPSEu974B9T76Vp1Mv5j0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AJHdUl3y2U15pg/2RZ8YHYlc5U3+n32TZeEX+pRihA7bK6PZubaOFzZNi5ZkAo+az
	 P60Hi6jDxd+nwpFNLmTNUbGMog76IEQBa0pfUpNl0VFMji/tCxsKX7aMQ8/3Y6UgiF
	 bIlLHTOORboFN2Omo6I1hYNPnlpxjQQlP1heQj44=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20230329153136epcas5p4fd59fa4179af42ca335419492928ffd9~Q7Ze2fHia0774607746epcas5p4n;
	Wed, 29 Mar 2023 15:31:36 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4PmrBH1Sqvz4x9Pv; Wed, 29 Mar
	2023 15:31:35 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.35.55678.7D954246; Thu, 30 Mar 2023 00:31:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230329121341epcas5p45333599c9e32850de632a1c3859b0f1c~Q4sq0wktm0120401204epcas5p47;
	Wed, 29 Mar 2023 12:13:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230329121341epsmtrp1ffb23e4e63f785ac676c4cb2239c699a~Q4sqzmkfq2849028490epsmtrp1-;
	Wed, 29 Mar 2023 12:13:41 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-08-642459d72a8a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	2B.C0.31821.57B24246; Wed, 29 Mar 2023 21:13:41 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230329121337epsmtip18397af4feb26451d5131597edd8b0f18~Q4snsNtwN0677706777epsmtip1a;
	Wed, 29 Mar 2023 12:13:37 +0000 (GMT)
Date: Wed, 29 Mar 2023 17:42:57 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, James Smart
	<james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander
	Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
	bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com, joshi.k@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 7/9] dm: Add support for copy offload.
Message-ID: <20230329121257.GC11932@green5>
MIME-Version: 1.0
In-Reply-To: <3b9adeb6-4295-6e6a-9e93-7c5a06441830@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc27b2wuOeeXlsWwTiguiAylru4Ox6ISwG1BD5iRBXEpDb3iV
	tvQh7JEMFOZ0MGony6gM2eIY8pSHyFNIFRkog6VQlFlEB0sQKg7HhBBwhQuL/31+3/P9nd/v
	/H45BMv1ey6PSFbqaI1SpuDjzuymm/47A0Zid8iDSq7iqLbvNgudMiyzUKWtAEfTN+cA+u7Z
	Igst9Q+wUMfTixx0v6sFQ+0/GTF0pbIbQ20//o2h7pd2HBnNVoAmh00Y6hjdjdo7etnI0lqM
	o0tlk1xk/vY0hponsgGqmZ5lo19HvdDAcg/nwFbKMhRFmR7241SLycalBsbq2JSlX0/VV5zF
	qYbLX1Bt97NwKv/0U4ch9yGHmr0xjFPfNFYAquHOZ9Tz+reo+gk7Fr35eOq+JFompzXetDJB
	JU9WJkr4UUelYVKROEgQIAhB7/G9lbI0WsIPPxQdEJGscIyA731SptA7pGiZVsvfE7pPo9Lr
	aO8klVYn4dNquUItVAdqZWlavTIxUEnr9gqCgoJFDmN8apLlj0GuusI381JOA5YFLF7ngBMB
	SSHstUyzzwFnwpVsA7D1+gzGBHMAdsyfwZngOYBzZXbORkrWKfu6qxXAhcIWLhNMAGjuqMZW
	XWzybXh1IMeRQRA4uRveeUmsyu6kCNrzctmrzCLLOHD2wdqlbqQEPr53DV9lF4c9z9bFZngL
	7C2aWGMnMgLm3LNyV9mD9IVdTT1rTUCy0glaS9u5q7UgGQ77zvoxjbrBJz2NXIZ5cKrgy3XO
	gFculONMbg6AphETYA72w9y+AhbTXDK8UDOOM/qbsLCvBmP012H+0gTG6C6wuWSDfWFVbem6
	fxu0vsheZwrethQDZkCLAJZP2bgGsN30yuNMr9Rj+B1Y2jbnYMLBXvCXFYJBf1jbuqcUcCrA
	NlqtTUuktSJ1sJLO+H/jCaq0erD2RXZFNoNH488CzQAjgBlAgsV3d1my8uWuLnLZJ5/SGpVU
	o1fQWjMQOXZ1nsXzSFA5/phSJxUIQ4KEYrFYGPKuWMDf6uIn6U1wJRNlOjqVptW0ZiMPI5x4
	WZiqk6ubi0iRrBz7+R+pX2ZcnCiTl3NSfcgvVx4+adAa7EV/EZbBTcthe6Wvzfzw4WJGfIlT
	6NmFg/MzqvIhhfFiRFH1loJ0pa2uxT30brDt0agP+tOwEDVZmjjWTn4duel82W+3quCAf9Wc
	os8n//CJlMbjO7uN40kxRo/QzOEHxYa2lR1+twxPvJd6mlIqhUedw8QZPBV7NJ3yDMmeXVJ/
	VJh8Pd7Vp8trKLL67vb3VSz1wuX0To8btP1IzOiLzrr9nsp/AzZ/MG2ejORHLehFBY/P6D93
	L/H0ivu90HokNnb+WPOBg1PNs7prM3kxeaaPT0iMXzmPJLwxuBI2VuGmOcxna5Nkgl0sjVb2
	H+6C8sGrBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf0yMcRzH931+9dxNejrJtyJ51Fit81tfhhlqz4Rlfo2Z83DP0o9Lu3Py
	a1xU1iWSduM0qqXWMbqLVHfZ7ahUS0jpUG1cZHalzI9Gh+sY/733fb1f7323D41L7EQgnZBy
	QFCm8MksJSaq77PBkeqIUPlccwOJbrU04uhk3hiOrveco9CH+yMA6T6O4uh7WzuO6gcvk8hu
	rcWQpSQfQxXXGzBkLh7GUMNPJ4XybV0A9XfqMVT/IgJZ6psJ1FFXSKGrZf1eyHbhFIZqHOkA
	3fwwRKCHL4JQ+1gTuXIK1/EsltP3tVFcrb7Hi2vvNRJcR5uaMxmyKa6q9ARntmsoLvfU4O9C
	Zh/JDd3rpLiztw2Aq2o9yn0yBXMmhxOL89khXiYXkhMOCso5K3aL9xU9ysFT34UcGu3PIjWg
	IkALRDRkFkLNSSemBWJawtQA6Bg47eUBAbBs7AHuyZNgheudl6f0GsBKSyblBgQTBivbM0gt
	oGmKiYCtP2n3sx+zCDrPZBLujDMGEvbWRbrzJGY5fN19Z1z1/l0/02MlPJujABo/FZAe4Aub
	Lzn+yOGw2/Uec+/jTBAsd43vi5gYmNHdNf7PycxMaK1uwvKAr/4/W/+frf9nFwHcAAKEVJUi
	XqGalzo/RUiTqniFSp0SL927X2EC49cPD68BFsNHqQ1gNLABSOOsn/f3LlYu8Zbzh48Iyv0y
	pTpZUNlAEE2wU7wfa5tlEiaePyAkCUKqoPxLMVoUqMGiFqR/K4/0IbpIcY6cjdxY++Oyb+eP
	jGgf6R6p/bBLM+IgJVF0SOv62fzmbXGLDcNRFwqqlizeWJRVwAPr1BPGFdWBrO7l6tMX7brg
	WTe6E7PTykd2GYr3NjcKA1r/a6FN5ruhW3IbRYmxpokz5oTIpC2Blgkuv7dLUebCWSuvCP03
	St8Us47hhD3RIbdL+l6t/toSs26oZGT5YExBi2mo1r9Y1yv7HIaSdp6Lleka3qJc3aaq57v9
	05MGjsvqpr/puDvN+gRPmH48cUOUeli6yGk0JsZJOm9G5zV92fp16lUn4mNy084eo1Ztr8xW
	nC9cg7KqOW1OqajQnPN0bTlLqPbx88JxpYr/BTJUoI1sAwAA
X-CMS-MailID: 20230329121341epcas5p45333599c9e32850de632a1c3859b0f1c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----3NzO0p8.1sh3-RRiYuI9FQqPO8oRjrHoddadEkfGMyLJmz0h=_118c3d_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230327084312epcas5p377810b172aa6048519591518f8c308d0
References: <20230327084103.21601-1-anuj20.g@samsung.com>
	<CGME20230327084312epcas5p377810b172aa6048519591518f8c308d0@epcas5p3.samsung.com>
	<20230327084103.21601-8-anuj20.g@samsung.com>
	<3b9adeb6-4295-6e6a-9e93-7c5a06441830@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_083143_907044_67641E22 
X-CRM114-Status: GOOD (  35.15  )
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

------3NzO0p8.1sh3-RRiYuI9FQqPO8oRjrHoddadEkfGMyLJmz0h=_118c3d_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Mar 29, 2023 at 05:59:49PM +0900, Damien Le Moal wrote:
> On 3/27/23 17:40, Anuj Gupta wrote:
> > From: Nitesh Shetty <nj.shetty@samsung.com>
> > 
> 
> Drop the period at the end of the patch title.


Acked

> 
> > Before enabling copy for dm target, check if underlying devices and
> > dm target support copy. Avoid split happening inside dm target.
> > Fail early if the request needs split, currently splitting copy
> > request is not supported.
> > 
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > ---
> >  drivers/md/dm-table.c         | 42 +++++++++++++++++++++++++++++++++++
> >  drivers/md/dm.c               |  7 ++++++
> >  include/linux/device-mapper.h |  5 +++++
> >  3 files changed, 54 insertions(+)
> > 
> > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > index 7899f5fb4c13..45e894b9e3be 100644
> > --- a/drivers/md/dm-table.c
> > +++ b/drivers/md/dm-table.c
> > @@ -1863,6 +1863,39 @@ static bool dm_table_supports_nowait(struct dm_table *t)
> >  	return true;
> >  }
> >  
> > +static int device_not_copy_capable(struct dm_target *ti, struct dm_dev *dev,
> > +				      sector_t start, sector_t len, void *data)
> > +{
> > +	struct request_queue *q = bdev_get_queue(dev->bdev);
> > +
> > +	return !blk_queue_copy(q);
> > +}
> > +
> > +static bool dm_table_supports_copy(struct dm_table *t)
> > +{
> > +	struct dm_target *ti;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < t->num_targets; i++) {
> > +		ti = dm_table_get_target(t, i);
> > +
> > +		if (!ti->copy_offload_supported)
> > +			return false;
> > +
> > +		/*
> > +		 * target provides copy support (as implied by setting
> > +		 * 'copy_offload_supported')
> > +		 * and it relies on _all_ data devices having copy support.
> > +		 */
> > +		if (!ti->type->iterate_devices ||
> > +		     ti->type->iterate_devices(ti,
> > +			     device_not_copy_capable, NULL))
> > +			return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> >  static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
> >  				      sector_t start, sector_t len, void *data)
> >  {
> > @@ -1945,6 +1978,15 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
> >  		q->limits.discard_misaligned = 0;
> >  	}
> >  
> > +	if (!dm_table_supports_copy(t)) {
> > +		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
> > +		/* Must also clear copy limits... */
> 
> Not a useful comment. The code is clear.

Acked

> 
> > +		q->limits.max_copy_sectors = 0;
> > +		q->limits.max_copy_sectors_hw = 0;
> > +	} else {
> > +		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
> > +	}
> > +
> >  	if (!dm_table_supports_secure_erase(t))
> >  		q->limits.max_secure_erase_sectors = 0;
> >  
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index 2d0f934ba6e6..08ec51000af8 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -1693,6 +1693,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
> >  	if (unlikely(ci->is_abnormal_io))
> >  		return __process_abnormal_io(ci, ti);
> >  
> > +	if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
> > +			max_io_len(ti, ci->sector) < ci->sector_count)) {
> > +		DMERR("Error, IO size(%u) > max target size(%llu)\n",
> > +			ci->sector_count, max_io_len(ti, ci->sector));
> > +		return BLK_STS_IOERR;
> > +	}
> > +
> >  	/*
> >  	 * Only support bio polling for normal IO, and the target io is
> >  	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
> > diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> > index 7975483816e4..44969a20295e 100644
> > --- a/include/linux/device-mapper.h
> > +++ b/include/linux/device-mapper.h
> > @@ -380,6 +380,11 @@ struct dm_target {
> >  	 * bio_set_dev(). NOTE: ideally a target should _not_ need this.
> >  	 */
> >  	bool needs_bio_set_dev:1;
> > +
> > +	/*
> > +	 * copy offload is supported
> > +	 */
> > +	bool copy_offload_supported:1;
> >  };
> >  
> >  void *dm_per_bio_data(struct bio *bio, size_t data_size);
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
> 
Thank you,
Nitesh Shetty

------3NzO0p8.1sh3-RRiYuI9FQqPO8oRjrHoddadEkfGMyLJmz0h=_118c3d_
Content-Type: text/plain; charset="utf-8"


------3NzO0p8.1sh3-RRiYuI9FQqPO8oRjrHoddadEkfGMyLJmz0h=_118c3d_--

