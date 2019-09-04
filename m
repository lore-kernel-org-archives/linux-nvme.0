Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D179EC3A5A8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 16:07:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76AC20820
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 16:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fhci9dql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76AC20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pOBhdiXhQ7efhdh6dslckSOSGUnlBM8HRxB7pDLNfxU=; b=Fhci9dqlH8Wu6K
	0IrRi4xz0s3vNBTZOdArVHx5m46X+y7F+RzMdLxRe4tCvoRW5V7XfVg0tH8Jzr4MQlBAoCZAKFIJB
	XTl5kXpF1xuo9Mu7jb/5xSVV0QdZdErXlsKVvDJdCuBFum1Yn1iR6hNR5FHU+IVWlJW85dJ4cGnZN
	EJpsApBqasR7WZTHE8ocnMYaGatv6mTb/nLR6IK/TYAfYNeYp3TpRgzTfVxCHWzxqvNA3YsQxYyNG
	/L4BaIIIkYuTzAtb24UKwlRBCORJ5LgbyjXOCHZIj6lrJOELMfaP//L+SGOpc47S2iy+16vI2Y8XJ
	15ZBC1wN+9nHnmNVKDhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5XoX-0006SC-T8; Wed, 04 Sep 2019 16:07:21 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5XoU-0006RJ-Dg
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 16:07:20 +0000
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155])
 by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <logang@deltatee.com>)
 id 1i5XoS-0006yr-3P; Wed, 04 Sep 2019 10:07:17 -0600
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20190831000139.7662-1-logang@deltatee.com>
 <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
 <20190904060558.GA10849@lst.de>
 <20190904144426.GB21302@localhost.localdomain>
 <20190904154215.GA20422@lst.de>
 <20190904155445.GD21302@localhost.localdomain>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ef3bf93b-cb47-95c5-7d96-f81d9acfdb55@deltatee.com>
Date: Wed, 4 Sep 2019 10:07:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904155445.GD21302@localhost.localdomain>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: keith.busch@intel.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, martin.petersen@oracle.com, sagi@grimberg.me,
 hare@suse.com, axboe@fb.com, hch@lst.de, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_090718_805839_F4C3F6B2 
X-CRM114-Status: GOOD (  18.11  )
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
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2019-09-04 9:54 a.m., Keith Busch wrote:
> On Wed, Sep 04, 2019 at 05:42:15PM +0200, Christoph Hellwig wrote:
>> On Wed, Sep 04, 2019 at 08:44:27AM -0600, Keith Busch wrote:
>>> Let me step through an example:
>>>
>>>   Ctrl A gets instance 0.
>>>
>>>   Its subsystem gets the same instance, and takes ref count on it:
>>>   all namespaces in this subsystem will use '0'.
>>>
>>>   Ctrl B gets instance 1, and it's in the same subsystem as Ctrl A so
>>>   no new subsytem is allocated.
>>>
>>>   Ctrl A is disconnected, dropping its ref on instance 0, but the
>>>   subsystem still has its refcount, making it unavailable.
>>>
>>>   Ctrl A is reconnected, and allocates instance 2 because 0 is still in
>>>   use.
>>>
>>> Now all the namespaces in this subsystem are prefixed with nvme0, but no
>>> controller exists with the same prefix. We still have inevitable naming
>>> mismatch, right?
>>
>> I think th major confusion was that we can use the same handle for
>> and unrelated subsystem vs controller, and that would avoid it.
>>
>> I don't see how we can avoid the controller is entirely different
>> from namespace problem ever.


Yes, I agree, we can't solve the mismatch problem in the general case:
with sequences of hot plug events there will always be a case that
mismatches. I just think we can do better in the simple common default case.


> Can we just ensure there is never a matching controller then? This
> patch will accomplish that and simpler than wrapping the instance in a
> refcount'ed object:
> 
> http://lists.infradead.org/pipermail/linux-nvme/2019-May/024142.html

I don't really like that idea. It reduces the confusion caused by
mismatching numbers, but causes the controller to never match the
namespace, which is also confusing but in a different way.

I like the nvme_instance idea. It's not going to be perfect but it has
some nice properties: the subsystem will try to match the controller's
instance whenever possible, but in cases where it doesn't, the instance
number of the subsystem will never be the same as an existing controller.

I'll see if I can work up a quick patch set and see what people think.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
