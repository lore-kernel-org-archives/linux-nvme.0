Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148ADC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 16:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bDbpNy4bQcOCdUZGxOGPiwVNT6+/6IuR3y95GN1aWJs=; b=tuDaD7DV7WjaNtIRuvnqVpdPG8
	4lO8SQZneH2ThoOUaTWjJR9FQ522jis4wuEBn3s95Q5m4BJR3A5Z23Rq7M1XwrdFLp2Wa+tedm9Yr
	7fGIRoTvnzPXK+dIoV5QvdcZtKR9T1vodUuIOs8X7rIGAllqJMhSuj6n79ERTeE43XNrt7wzXUJ02
	hx9Ke5VwjTd4MTZP/yQBpNJ59qjctYOH4By4BGj7PypoPB3ZJtzyFmg4XYpphJK8DAT8pMRE5oYCv
	9InM6L87cRSxh7DBzb3WcZvofZjQ3n7gfe26yU4oy7gz/0uN19MJHnOyjxTUMEpy2+05McIP27alq
	tR70d1xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1negJ2-001qH8-Qe; Wed, 13 Apr 2022 16:57:24 +0000
Received: from out0.migadu.com ([2001:41d0:2:267::])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1negIy-001qGP-TD
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 16:57:22 +0000
Message-ID: <fed97517-201f-f7a8-04ee-4a12698b4e41@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1649869039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDbpNy4bQcOCdUZGxOGPiwVNT6+/6IuR3y95GN1aWJs=;
 b=tVCbdaZWDBJXRZ49eldiS2WGZeNIavDQZBjf4BjoCo/xds0ebiUY+oSrlBDVIlyUH4bNRR
 WyXI3gzWU5IJRph8jDPfpicAUG8ZHf0b0xv0sypkA3QcxVZMki9O8stGsNz1dSYRc91U6b
 ir0SM8uwGC2X8MSG3li0GzyTO7EhDi4=
Date: Wed, 13 Apr 2022 10:57:19 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, kbusch@kernel.org
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-4-kch@nvidia.com>
 <cf4534ec-c8d1-c020-2079-5636177ca1b5@linux.dev>
 <20220413165238.GA31786@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220413165238.GA31786@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_095721_123647_0B8E5E0E 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
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



On 4/13/2022 10:52 AM, Christoph Hellwig wrote:
> On Wed, Apr 13, 2022 at 10:49:33AM -0600, Jonathan Derrick wrote:
>>>    +	req->rq_flags |= RQF_QUIET;
>> Any reason to not make it a part of flags in the argument list and let the
>> block layer build the req with it?
>>
>> eg:
>> flags |= REQ_QUIET;
> 
> Because there is not REQ_QUIET, just RQF_QUIET and BIO_QUIET, and their
> relation isn't quite as straightforward as it seems.

Well let's suppose I had written RQF_QUIET instead of the non-existent 
REQ_QUIET

