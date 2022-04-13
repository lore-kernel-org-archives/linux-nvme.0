Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3BBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 17:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g9hgt2DKcIwZaHcOkpIPEINB2X8Tb/KFaQOpOROejmM=; b=tWd99GeBSPEfS+4NTLhBPCdnd8
	7C3CH9M1I+iEKxMQyavEq348pYMv9pkBRZRAA7PwLtf8UTj5+L0B1gNr0ROZxrztLD9Xo/g7d6h71
	Lxb4Fsi3ZciSZmHUkXKpJ3kh3+AP3BwvbREhm1UPklBoJhbkzWzX03ZcP7HOYMz4aNPfljXAAZW2c
	Yrc7UTwGaaUZc5csQf6dkzlpw3RLLj5ubU3Mu2e00HTMCx1re2PdTmViyjF4vy+j/w4c5C9U8HCD1
	xGLgXTy3VJ/kDMOs38OItxa3vtbRdfV2gLAC//tgvX92sVr2D95OaXhjxTyMELHMEom8N3KZzr6tm
	ETpfmFYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1negWh-001uXd-A6; Wed, 13 Apr 2022 17:11:31 +0000
Received: from out1.migadu.com ([2001:41d0:2:863f::])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1negWd-001uVN-0M
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 17:11:29 +0000
Message-ID: <f7a9cdc8-d00e-60ac-c293-e0bffb328486@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1649869883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9hgt2DKcIwZaHcOkpIPEINB2X8Tb/KFaQOpOROejmM=;
 b=g/9TbwbIN93uxApyXF8BBEkQ1/lTKyyy4/IzfIxd429u+TEuLs16VwniJNRczAnfLyE/F+
 8/UOAh8y+L7RtsZ+OswYi/1qRRCzOShwzx8zYVX3ROnvjEEp+PFzoGdmL6qXgZYW0kRNGg
 G+axaF90C6UfYue6h1ABkudSLwScFqE=
Date: Wed, 13 Apr 2022 11:11:22 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-4-kch@nvidia.com>
 <cf4534ec-c8d1-c020-2079-5636177ca1b5@linux.dev>
 <20220413165238.GA31786@lst.de>
 <fed97517-201f-f7a8-04ee-4a12698b4e41@linux.dev>
 <YlcDz4x+PNLgsSCQ@kbusch-mbp.dhcp.thefacebook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <YlcDz4x+PNLgsSCQ@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_101127_641927_90D52812 
X-CRM114-Status: GOOD (  14.27  )
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



On 4/13/2022 11:09 AM, Keith Busch wrote:
> On Wed, Apr 13, 2022 at 10:57:19AM -0600, Jonathan Derrick wrote:
>>
>>
>> On 4/13/2022 10:52 AM, Christoph Hellwig wrote:
>>> On Wed, Apr 13, 2022 at 10:49:33AM -0600, Jonathan Derrick wrote:
>>>>>     +	req->rq_flags |= RQF_QUIET;
>>>> Any reason to not make it a part of flags in the argument list and let the
>>>> block layer build the req with it?
>>>>
>>>> eg:
>>>> flags |= REQ_QUIET;
>>>
>>> Because there is not REQ_QUIET, just RQF_QUIET and BIO_QUIET, and their
>>> relation isn't quite as straightforward as it seems.
>>
>> Well let's suppose I had written RQF_QUIET instead of the non-existent
>> REQ_QUIET
> 
> The "flags" value passed to blk_mq_alloc_request() is not the same as the
> values for rq_flags, though.
> 
> I guess you could add a new allocation flag, maybe called something like
> BLK_MQ_REQ_QUIET to tell the block layer to set RQF_QUIET. That is similiar to
> how BLK_MQ_REQ_PM is used for RQF_PM, but I'm not sure we want to add another
> 'if' check in the fast path.

Fair enough

