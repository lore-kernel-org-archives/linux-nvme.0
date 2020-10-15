Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9DFC433E7
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 16:01:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1657521D41
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 16:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J4J7F46l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="EjR/Qbje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1657521D41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SllvacYgvOYCI6L+AasgqfpT51f+NX7O0rzSguoamtE=; b=J4J7F46lfM8yjeBfsNXqT9O2L
	ttA6cuDCvDw5U+SRiFdE7GpBxQkttmlMYD35MJd2a2rgVHjozrLD1okmkY3Rpjd+raCV/6pjnbP3c
	lhSEpp+Il1NB6suo1ho0n9svvgZDP0G/nBo6XaGqSktqlH1sGNwy/n2dZf2iBBtKx4I33vax22R2z
	ZLfZAQFzJ+03YowFYVWD0ZYPZBZbFBEu6CWS2yN1Qh7EkgKRKqUpZ51ck8YBGQuFIEDerubrAMr4K
	ne3DsctfnGwPwtEOxv5upbsG9cBr75NR3bitiIJzAl7jKKqr7kN/LMaS6XS3hrm2FF6FcrJGFw2KY
	NY9DJFjUw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kT5hF-0006m7-6C; Thu, 15 Oct 2020 16:01:41 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kT5hC-0006lD-5F
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 16:01:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tzjjZSFfZLG+9OriD6iS4ghe3x6VDY7f45sTi6zJMJw=; b=EjR/QbjeDt4ZolL+P87haI23Iy
 TuISuIx8PMLNQ2EV5xPdrO3vCOSgZVUIpav+boJAjnEYZaDTeKChH/SsAgaqThpOWI4JVa2xcNpkW
 oLbWPNLkC9FXC1aGq96OfKq3EfzFkMbOSjw3F1e+fG2HQ32+TYnq/1g4czViLlR5U1sJcE+kwlYA2
 5N6O0a8CxGK0NTr6NXzNwWkE6TyRm/ABpTjc77u5cyM5YNl6AlrN+gHiFFrtgbeP8c/HvZXRnGyzi
 urGRUvdDVfJjD2Uhk1qKfD8iPqQT0egzvaURvFGzBQ5KPcdTg3MQyNmP4SpFRGrLsMg4rl5JmsoZv
 QGNGsgmQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kT5h6-0007Ar-HN; Thu, 15 Oct 2020 10:01:33 -0600
To: Christoph Hellwig <hch@lst.de>
References: <20201009231816.1524-1-logang@deltatee.com>
 <20201015075640.GJ14082@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bc51aadc-eee3-cf52-0623-b3f82e1958f4@deltatee.com>
Date: Thu, 15 Oct 2020 10:01:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201015075640.GJ14082@lst.de>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: chaitanya.kulkarni@wdc.com, sagi@grimberg.me,
 dgilbert@interlog.com, linux-nvme@lists.infradead.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201015_120138_255646_452CA169 
X-CRM114-Status: GOOD (  14.45  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Douglas Gilbert <dgilbert@interlog.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-10-15 1:56 a.m., Christoph Hellwig wrote:
> On Fri, Oct 09, 2020 at 05:18:16PM -0600, Logan Gunthorpe wrote:
>>  static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>>  {
>> -	int sg_cnt = req->sg_cnt;
>>  	struct scatterlist *sg;
>>  	int op_flags = 0;
>>  	struct bio *bio;
>>  	int i, ret;
>>  
>> +	if (req->sg_cnt > BIO_MAX_PAGES)
>> +		return -EINVAL;
> 
> Don't you need to handle larger requests as well?  Or at least
> limit MDTS?

No and Yes: there is already code in nvmet_passthru_override_id_ctrl()
to limit MDTS based on max_segments and max_hw_sectors. So any request
that doesn't pass this check should be from a misbehaving client and an
error should be appropriate.

Logan


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
