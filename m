Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D54E7717D
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 00:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QQ76MNsFLRb0EE0rvSOt9g2FjwM0I0ZKaeF9BRmS5j0=; b=CfCXG/Dw0lwzXTdDDRutUUXvZl
	0/TSfCBO490hR2YqcFURgCoghVqutBxB2HTCZ2XwI/Y5su49PvFU7RpEqdHxtoUB7TVl1Qn29w7N0
	FAJHqn19GyKvwJSn3N/EWMAPqYAh23Nha28lU77t7Ce6vcz0lNdTshvPmjPW/w6x/mxJ6EnoEI+A8
	8bPc04tIa1D1wGwmQ6fINHxuv44bYxkF+OR510OerbGAuy4BMeTbsVUQMPD6UjU5fWwzagjR4WVoA
	ELLbmczCcEdPMzyY5s1BgCE/PT285oPSFRDGxXzC6ELiVTsi61hANHoeHUQHUGA0+tSzoEg3gEV7W
	zGWCRgAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKo8o-00000009iOx-3rCq;
	Tue, 10 Dec 2024 00:30:18 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKo1U-00000009h1L-3fK7
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 00:22:47 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Y6fZX0YSDz6ClY8q;
	Tue, 10 Dec 2024 00:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733790156; x=1736382157; bh=QQ76MNsFLRb0EE0rvSOt9g2F
	jwM0I0ZKaeF9BRmS5j0=; b=rPJYrBogSCqi+UC1qqPF+fPQLmD+D4x29PRYDWKk
	2z0zPY8OvP3+Aws0jdIk/FBnmhiGCJzA5bRHBuJpJYfARKeHtzX3dkGpYB4V+0ev
	z/SUYM5DlwgWvAXz0B8DRg2FupLbd0q23ScpNuuXRabwGKwir5mVYXZ0KVltluel
	furT9Q3o2xpKIdnskOkViWS5rhspJuFj4iFh1EV2JagH35rvHkzXFsbIUflw6yt2
	H72/n0GZv8HS5dPC1b/H/78BwGBr+SM1IpBHup9Ghl3Pjwyybo8Mfug9ABaAsqS5
	yD881NKI39O4cY4+75RYmqq27AmMcdGMQ5gt9pMLa01zvQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xUfLJokapvMy; Tue, 10 Dec 2024 00:22:36 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Y6fZK0GTsz6CmM6d;
	Tue, 10 Dec 2024 00:22:32 +0000 (UTC)
Message-ID: <8b1f8abc-b567-4927-a8dc-2214d79f8b42@acm.org>
Date: Mon, 9 Dec 2024 16:22:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: Matthew Wilcox <willy@infradead.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Javier Gonzalez <javier.gonz@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>
References: <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org>
 <20241112135233.2iwgwe443rnuivyb@ubuntu>
 <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com>
 <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org>
 <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com>
 <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org>
 <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
 <CGME20241205081138epcas5p2a47090e70c3cf19e562f63cd9fc495d1@epcas5p2.samsung.com>
 <20241205080342.7gccjmyqydt2hb7z@ubuntu>
 <c639f90f-bdd1-4808-aeb7-e9b667822413@acm.org>
 <Z1d9xfBwp0e8jxf4@casper.infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Z1d9xfBwp0e8jxf4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_162245_008886_B38E6594 
X-CRM114-Status: GOOD (  17.62  )
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

On 12/9/24 3:31 PM, Matthew Wilcox wrote:
> On Mon, Dec 09, 2024 at 02:13:40PM -0800, Bart Van Assche wrote:
>> Consider the following example: dm-linear is used to concatenate two
>> block devices. An NVMe device (LBA 0..999) and a SCSI device (LBA
>> 1000..1999). Suppose that a copy operation is submitted to the dm-linear
>> device to copy LBAs 1..998 to LBAs 2..1998. If the copy operation is
> 
> Sorry, I don't think that's a valid operation -- 1998 - 2 = 1996 and 998
> - 1 is 997, so these ranges are of different lengths.

Agreed that the ranges should have the same length. I have been
traveling and I'm under jet lag, hence the range length mismatch. I 
wanted to construct a copy operation from the first to the second block
device: 1..998 to 1001..1998.

>> submitted as two separate operations (REQ_OP_COPY_SRC and
>> REQ_OP_COPY_DST) then the NVMe device will receive the REQ_OP_COPY_SRC
>> operation and the SCSI device will receive the REQ_OP_COPY_DST
>> operation. The NVMe and SCSI device drivers should fail the copy operations
>> after a timeout because they only received half of the copy
>> operation.
> 
> ... no?  The SRC operation succeeds, but then the DM driver gets the DST
> operation and sees that it crosses the boundary and fails the DST op.
> Then the pair of ops can be retried using an in-memory buffer.

Since the second range can be mapped onto the second block device, the
dm-linear driver can only fail the REQ_OP_COPY_DST operation if it keeps
track of the source LBA regions of pending copy operations. Which would
be an unnecessary complexity.

A possible alternative is to specify the source and destination range
information in every REQ_OP_COPY_SRC and in every REQ_OP_COPY_DST
operation (see also Damien's email).

Thanks,

Bart.

