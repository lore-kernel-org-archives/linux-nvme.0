Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC85C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 02:22:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B650620863
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 02:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ottl8/Fm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g5DJfx2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B650620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wm9kye9KEaJ4/dGIaPnKxp8eeh/AwIu8VzRLNAzjhoo=; b=ottl8/Fm0Tgo8d
	wJL4f0nJbhsOBTOn9cO0yyqe7QPYNPtFJtKctMDa+CEFFJz/dNksTb4QWfzP+u5qfrvWVYrUYDeRS
	sHQDafVVBJc6nOYo3njGqbr0nZ1wx2ObERxePfajJyP1GGhEFZ7IkP9AVqdbKx3uKWwbZbtT+AR64
	uCYFOic8p6ww8WJxKLfMv2hXUfZVy9HA0h4beNT2AL8J7IR6tk0ncLsO5p6tv9fj/d5Ebsztlmbgh
	HUFXXORvueeefOEb0RTpfnCmvCKJorXWHk6/eCx+oTt/lukWaMOhgVuUKsLuyLB/vrbvfAlaiVu+c
	mv6cY6ny0VDEGHgHWeog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i79Js-0004ap-7L; Mon, 09 Sep 2019 02:22:20 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i79Jn-0004aK-S1
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 02:22:17 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x892ECU6057448;
 Mon, 9 Sep 2019 02:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=xLab5lamKsGFf666j4F7UQaBA6m/n6xltiyHHlsEAo8=;
 b=g5DJfx2ukxm0P213vHrVVCiGHmNtCf1ExGzZOYJFLnm9ihpgVdH7Rtx9y4NJzPzQK3XT
 3frsyblD2XIS6GkCNOszsh+I+eY3juw8jA5Djznx2XNdvxMVQgv7zfp/mC2ajTT2M7px
 vbQOIQ/gBb04agqEuL0ItIkcILUmCCna/6u6MpGChon2reRl0e8eoe4AxJhx37BhlI5M
 6NS5HcPGzID8dq3IJF8yBny0f8gTEISmAX1iqc6xMi9ABS0cXr/i9YvPucscPEOjE9rd
 cmj1HhfJeTgGZ+4yEb+sOhDP6BQPue6BIiDSSZlihO5A8dQIrTX1spnJEeSLXcEX2RFY bA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2uw1jxs77h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Sep 2019 02:22:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x892J6YR087456;
 Mon, 9 Sep 2019 02:22:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2uv4d15p3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Sep 2019 02:22:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x892LsqO013967;
 Mon, 9 Sep 2019 02:21:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 08 Sep 2019 19:21:54 -0700
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v4 1/3] block: centralize PI remapping logic to the block
 layer
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
Date: Sun, 08 Sep 2019 22:21:51 -0400
In-Reply-To: <1567956405-5585-1-git-send-email-maxg@mellanox.com> (Max
 Gurtovoy's message of "Sun, 8 Sep 2019 18:26:43 +0300")
Message-ID: <yq1mufei4zk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909090023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909090023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190908_192216_000650_1A233638 
X-CRM114-Status: GOOD (  17.88  )
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
Cc: axboe@kernel.dk, keith.busch@intel.com, sagi@grimberg.me,
 martin.petersen@oracle.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 shlomin@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Hi Max!

> @@ -309,7 +308,7 @@ static void sd_set_flush_flag(struct scsi_disk *sdkp)
>  {
>  	struct scsi_disk *sdkp = to_scsi_disk(dev);
>  
> -	return sprintf(buf, "%u\n", sdkp->protection_type);
> +	return sprintf(buf, "%u\n", sdkp->disk->protection_type);

I'm fine with moving the prepare/complete logic to the block layer. But
the block layer should always be using information from the integrity
profile. sdkp->protection_type is a SCSI disk property which is used to
pick the right integrity profile when a device is discovered and
registered.

 - sdkp->protection_type is the type the disk is formatted with. This
   may or may not be the same as the metadata format used by DIX and the
   block layer.

 - The DIX protection type (which is what matters for protection
   information preparation) is encapsulated in the integrity profile
   registered for the block device. The profile describes an abstract
   protection format and can (at least in theory) carry non-T10 PI
   protection information.

Linux currently uses the Type 1 block layer integrity profile for
devices formatted with T10 PI Types 0, 1, and 2. And the Type 3 block
layer integrity profile for devices formatted with T10 PI Type 3. This
profile is what we should be keying off of in t10-pi.c, not the
protection_type (the fact that protection_type is even there is because
the code was lifted out from sd.c).

I would prefer to introduce .prepare_fn and .complete_fn for the Type 1
profile to match the existing .generate_fn and verify_fn. And then adapt
t10_pi_prepare() / t10_pi_complete() to plug into these new
callbacks. The need for protection_type and Type 3 matching goes away in
that case since the callbacks would only be set for the Type 1 profile.

>  static inline unsigned short
> +blk_integrity_interval_shift(struct request_queue *q)
> +{
> +	return q->limits.logical_block_shift;
> +}
> +

Why not use bio_integrity_intervals() or bi->interval_exp?

Note that for T10 PI Type 2, the protection interval is not necessarily
the logical block size.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
