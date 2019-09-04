Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C32AC3A5A7
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 12:49:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132EA21883
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 12:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="usOS+/Ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132EA21883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+oPtHCXKJTmTwejB7nhfUkOpm7kGnVdrz0TQFHo4xJs=; b=usOS+/RaKvCvX5
	zYUOPmtZJlo+loWpuLjjwXm8WIuqRQ9guorW3H5l7buGYmz2c8lf4skRH0rpQvqTRyCyb3KkVN6h8
	TI+d0SOtUvfeQMPEPaU3I0KhdfmGWNvBD3vzxAJBZ1EPg/n71DNDPBhrc4Tq+j/37GGLa47AFbvzg
	Q1Cc3XCdrXmiWf/OPl9mmRRh1ttrp6Rjudgz53IICcBlcVz25LXi4JzRbULozArw3uZ0xV3uaZvKV
	yHWO+Es/ACWuSEQ4TbohNwDhesL3bivtJ5P3UamLPWDVWAKlsm1z3vJ9ub0TEk1xbGgqFC0hLycwH
	uAzKgRKAvbGaXVg4iAbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5UjV-00053k-I7; Wed, 04 Sep 2019 12:49:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5UjS-0004tS-52
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 12:49:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 14C1A227A8A; Wed,  4 Sep 2019 14:49:50 +0200 (CEST)
Date: Wed, 4 Sep 2019 14:49:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 1/4] block: centrelize PI remapping logic to the block
 layer
Message-ID: <20190904124949.GA17285@lst.de>
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
 <8df57b71-9404-904d-7abd-587942814039@grimberg.me>
 <e9e36b41-f262-e825-15dc-aecadb44cf85@kernel.dk>
 <20190904054956.GA10553@lst.de>
 <fd70d115-bb29-a8a7-83ae-7e3dcaa1dc1c@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fd70d115-bb29-a8a7-83ae-7e3dcaa1dc1c@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_054954_346667_EA0CB784 
X-CRM114-Status: GOOD (  12.89  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, keith.busch@intel.com,
 Sagi Grimberg <sagi@grimberg.me>, martin.petersen@oracle.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, shlomin@mellanox.com,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 04, 2019 at 11:32:04AM +0300, Max Gurtovoy wrote:
>
> On 9/4/2019 8:49 AM, Christoph Hellwig wrote:
>> On Tue, Sep 03, 2019 at 01:21:59PM -0600, Jens Axboe wrote:
>>> On 9/3/19 1:11 PM, Sagi Grimberg wrote:
>>>>> +	if (blk_integrity_rq(req) && req_op(req) =3D=3D REQ_OP_READ &&
>>>>> +	    error =3D=3D BLK_STS_OK)
>>>>> +		t10_pi_complete(req,
>>>>> +				nr_bytes / queue_logical_block_size(req->q));
>>>>> +
>>>> div in this path? better to use  >> ilog2(block_size).
>>>>
>>>> Also, would be better to have a wrapper in place like:
>>>>
>>>> static inline unsigned short blk_integrity_interval(struct request *rq)
>>>> {
>>>> 	return queue_logical_block_size(rq->q);
>>>> }
>>> If it's a hot path thing that matters, I'd strongly suggest to add
>>> a queue block size shift instead.
>> Make that a protection_interval_shift, please.  While that currently
>> is the same as the logical block size the concepts are a little
>> different, and that makes it clear.  Except for that this patch looks
>> very nice to me, it is great to avoid having drivers to deal with the
>> PI remapping.
>
> Christoph,
>
> I was thinking about the following addition to the code (combination of a=
ll =

> the suggestions):

I'll defer to Martin, but I think we still need the integrity_interval
naming in some form.

static inline unsigned short queue_logical_block_shift(struct  request_queu=
e *q)
> +{
> +=A0=A0=A0=A0=A0=A0 unsigned short retval =3D 9;
> +
> +=A0=A0=A0=A0=A0=A0 if (q && q->limits.logical_block_shift)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retval =3D q->limits.logical_=
block_shift;
> +
> +=A0=A0=A0=A0=A0=A0 return retval;

I don't think a NULL queue makes any sense here.  And I'd rather
ensure the field is always set rather than adding a conditional here.

And btw, centrelize in the Subject should be centralize.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
