Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C139BC4361B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 05:29:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587CB23A60
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 05:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587CB23A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:References:Message-ID:
	From:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QqHzgOLw9N7EO6FiICygTzeZ6WDM2bc/5vq22dj2m9g=; b=0UaYXcAehHv0eJHwT2aqnKzEA
	5sJiCSSnwhgGEiz0HljWzjkRbVrsc+HGj8izgc3UyAxYBYgXkBz6JIySY0DBcN2zRtUnHmCcK1iyL
	rynw4HMRjPvDQFhIKGKhVVZhudHxlyMfiQCGr2hcoErsrspJbm4p+TT1QUWTXOc0fkbI9ra8s1KND
	qwx96WK1Drjqq1Kt5k50FchN8uXFXMqHzIAAPTl3tnrmTSFUZA0lWpDKVgWICC3jAJO5gOl36TAMF
	cOI64nhnQlSb5LVXYddx2bChELiCmjxZMxcSyJcwbHbMVx1cVHj5KBQTOdTw+VBxAkIJ0x5Z0e/j+
	eiwLSDoGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmVYl-0006A1-Vh; Tue, 08 Dec 2020 05:29:12 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmVYk-00069d-5U
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 05:29:10 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B85PsUK160259;
 Tue, 8 Dec 2020 05:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=8RZFhY374YxRU7wZzkbyymuA3HBrUUjHnKaMHjvD0Pg=;
 b=Y+cziqEsSOOWByyffK5q+fwU9tYZaFoN7JPjqblyzgBntMN9fqD46Xc1l5sjAfuBvdPt
 Jv6BurV0LqaKRey7KPGe80iXoSTaVWnVkSVWZdHQ73QymkVxwyy26B8qc0Hfix3WsJs7
 hL0v5nfswhjpu+ELmuLQ5O9XaS0KzydTWQ5sVHpYjiiPb1ThGPjXGt74XLA55xv81sfJ
 gZ2+PRiEKfGxf6S4ARZuuIjEvwmCpicU+kGCvPxxHiL3ibfc1miMrmdFUbJtBUgalRT+
 5JHWyi7Xuv8mjxC+uaJUnFIrxfbxkFYvVYcKibG8M5A7gmfV0kXXkzWKTpFYkgTmX4FU hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 357yqbryty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 08 Dec 2020 05:29:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B85Qb1V058091;
 Tue, 8 Dec 2020 05:29:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 358m3x8fen-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Dec 2020 05:29:01 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B85T0Je020284;
 Tue, 8 Dec 2020 05:29:00 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 07 Dec 2020 21:29:00 -0800
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/6] block: add a hard-readonly flag to struct gendisk
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sg8gx3xd.fsf@ca-mkp.ca.oracle.com>
References: <20201207131918.2252553-1-hch@lst.de>
 <20201207131918.2252553-4-hch@lst.de>
Date: Tue, 08 Dec 2020 00:28:57 -0500
In-Reply-To: <20201207131918.2252553-4-hch@lst.de> (Christoph Hellwig's
 message of "Mon, 7 Dec 2020 14:19:15 +0100")
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=1 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080032
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_002910_321496_D717E279 
X-CRM114-Status: GOOD (  17.94  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Christoph,

> diff --git a/block/blk-core.c b/block/blk-core.c
> index ad041e903b0a8f..ecd68415c6acad 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -693,7 +693,7 @@ static inline bool should_fail_request(struct block_device *part,
>  
>  static inline bool bio_check_ro(struct bio *bio)
>  {
> -	if (op_is_write(bio_op(bio)) && bio->bi_bdev->bd_read_only) {
> +	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev))

Build failure, opening brace is missing ^^^^^

>  		char b[BDEVNAME_SIZE];
>  
>  		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
