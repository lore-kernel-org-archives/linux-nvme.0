Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAD6CD11DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 21:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FmXK1EB0uACV+GAD7WU+M1L+YJGjsqGi3oLvgjjCfNI=; b=gbD65SEjseg8GCn+npwgSA5okn
	WLs6oFDtaEFvQQgGynMMfQQPZmoEzcCasswlWt5TTVH6N8ny3+wWk+11F7mhEAzwgCL/YnzIn773D
	XoptSgugZaWf3EsCm/Qvk+RLrPEh21HR2RTgjeTK9I1LUjDF5boGitnjIXVrnPgepvvpJyjD2sIaE
	u95eUmfY7KO8lq0ENPFeVB67G1P+SbcM/eXqJjlYGnh0gGAR9K4mb6g4bllmaYiSU6ei7QPHNWG5s
	ZHRTR0C0mcNrbXqKsdyiE9/m21B5g7wtn8UPF0HXbJJYmXAmCq69MLzahdv9xbYi8SaGAhx56yq/M
	Q0YG+PUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpxIt-0000000Fm5k-0NlH;
	Thu, 28 Mar 2024 21:28:55 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpxIp-0000000Fm4n-2jHU
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 21:28:53 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5Gr24tZPzlgTGW;
	Thu, 28 Mar 2024 21:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711661327; x=1714253328; bh=FmXK1EB0uACV+GAD7WU+M1L+
	YJGjsqGi3oLvgjjCfNI=; b=xZDP9qYZFbYHUEUhfJRQ3Podey/KTRt7J/o8s9AK
	CXY1ZwKCZi057UaO+Y0hMNB1ZEGlvDdMtRfHiOAoHQBj4FCQQI0VCnfrR4vNUTkp
	TIl93ze6//3P8C3KqxjGv28jWQ5rW+92q7cJZqxBH23ssyIVdlVgPACo0cEgQh2l
	3eyweGUsTqOW+4ZYi0dxxPK8+ELhWnFL3V0E8mcL5O+nhz4oS4wTNoLTV6mWmB4/
	RD2SooLgtOEjG/pAZSMraF/UG+NPIMMztzbVHtFAAXCvqHPbgYAVkm9hmzH4rYu4
	99f8/C7AADEIPDDs3/XwDoH0yDmWoDtUQ3e+yIocXIcoMw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id iH-ndkCFmm3u; Thu, 28 Mar 2024 21:28:47 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5Gqy1grgzlgTHp;
	Thu, 28 Mar 2024 21:28:45 +0000 (UTC)
Message-ID: <b09d7101-4124-4d77-b33a-977e2b555607@acm.org>
Date: Thu, 28 Mar 2024 14:28:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/30] block: Remove req_bio_endio()
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-4-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_142851_888080_31AD33D2 
X-CRM114-Status: GOOD (  11.10  )
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

On 3/27/24 5:43 PM, Damien Le Moal wrote:
> Moving req_bio_endio() code into its only caller, blk_update_request(),
> allows reducing accesses to and tests of bio and request fields. Also,
> given that partial completions of zone append operations is not
> possible and that zone append operations cannot be merged, the update
> of the BIO sector using the request sector for these operations can be
> moved directly before the call to bio_endio().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

> -	if (unlikely(error && !blk_rq_is_passthrough(req) &&
> -		     !(req->rq_flags & RQF_QUIET)) &&
> -		     !test_bit(GD_DEAD, &req->q->disk->state)) {
> +	if (unlikely(error && !blk_rq_is_passthrough(req) && !quiet) &&
> +	    !test_bit(GD_DEAD, &req->q->disk->state)) {

A question that is independent of this patch series: is it a bug or is
it a feature that the GD_DEAD bit test is not marked as "unlikely"?

Thanks,

Bart.

