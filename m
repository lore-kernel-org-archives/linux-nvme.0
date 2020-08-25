Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42841C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 07:16:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0631B20706
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 07:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZMFsnvcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0631B20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T+ZHfIjlq2Gt7Y1R8RjxQjFiiW5SmagC98LiFTBQAFU=; b=ZMFsnvclXe/1l+oEB53bGmkdP
	mJJ6n7cvuPddS+p/7E6GfSsfoMOFRmDodEi2vIfmz4ZJ24iHPNPaxo7EnIVdxHqYATyCiBWgOxz/B
	evvMb77OLpw3riMYR71+quCdO+u3w35xtHBBoRPfTjZe3hqXuvDktr2SMJhjYB0p/LkUto+Scutgp
	TSHYReC6cElcFoChYFEuFFGG3xfH5mQK/kPWIABf4ksdF+fwJdPrmVq6kIqmRcMenKp4Voc/egU6b
	V08h4HBc54o2gEFx5lON20Mken771bzFEGbV3b0iZRyALgbIHyNLxILCUEHpldliv94P07m/WQQCe
	jYN5NJG2g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kATBT-0002ec-C2; Tue, 25 Aug 2020 07:15:55 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kATBP-0002dW-NE
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 07:15:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3CA0868BEB; Tue, 25 Aug 2020 09:15:49 +0200 (CEST)
Date: Tue, 25 Aug 2020 09:15:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] nvme-core: fix deadlock when reconnect failed due
 to nvme_set_queue_count timeout
Message-ID: <20200825071548.GG29268@lst.de>
References: <20200820035406.1720-1-lengchao@huawei.com>
 <20200821075034.GB30216@lst.de>
 <dbf66315-9e36-2105-535e-a90352ec5306@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dbf66315-9e36-2105-535e-a90352ec5306@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_031551_909231_5E454090 
X-CRM114-Status: GOOD (  15.89  )
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
Cc: axboe@fb.com, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, kbusch@kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 21, 2020 at 01:20:44PM -0700, Sagi Grimberg wrote:
>>> Many functions which call __nvme_submit_sync_cmd treat error code in two
>>> modes: If error code less than 0, treat as command failed. If erroe code
>>> more than 0, treat as target not support or other and continue.
>>> NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR both are cancled io
>>> by host, is not the real error code return from target. So we need set
>>> the flag:NVME_REQ_CANCELLED. Thus __nvme_submit_sync_cmd translate
>>> the error to INTR, nvme_set_queue_count will return error, reconnect
>>> process will terminate instead of continue.
>>
>> But we could still race with a real completion.  I suspect the right
>> answer is to translate NVME_SC_HOST_ABORTED_CMD and
>> NVME_SC_HOST_PATH_ERROR to a negative error code in
>> __nvme_submit_sync_cmd.
>
> So the scheme you suggest is:
> - treat any negative status or !DNR as "we never made it to
> the target"
> - Any positive status with DNR is a "controller generated status"
>
> This will need a careful audit of all the call-sites we place such
> assumptions...

No.  negative error means never made it to the controller, and we need
to map the magic NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR
errors to negative error codes if we want to keep using them (and IIRC
we started because it solved an issue, by my memory is foggy).  All the
real NVMe status codes come from the controller, so the commmand must
have made it there.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
