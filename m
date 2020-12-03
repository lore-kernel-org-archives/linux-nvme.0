Return-Path: <SRS0=Kbn9=FH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8DFC64E7A
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Dec 2020 04:07:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F93820658
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Dec 2020 04:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F93820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:References:Message-ID:
	From:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ejtKl+cEqRZoQ7+0WfqMahSj+gdEXbZhZa/n8Ec2zMg=; b=VfntSIj1h6cXUdE66um0V7cwe
	JYxinLWTGzxauejci4Kv6gM0XPx/xanqbjKMn9memeqeczotS4LdBZw6TGjeUGuMhqi3TAy2n6T3J
	n+yulNtFiZbfKKTEtXpcbwhe2S0zbTwPRSHT39QBqqQ26YuK0jHvVBaRNlQ8l2A2hEff3PWX5BLz0
	4B2mIsHpPq9w2FyOX5wor9sb/kAUnmXAXd3KuAftkLFoqFk7Bqsh85wb6OYaiR7noo8OdRSJhXd1u
	HiE0TlQ32TXVsc5AlF4DMNTlSrA2EURbO/YxigtLSn47ACyyB1GTFQHmbCEakAHGybzK5Cga1rl65
	Q6c8NR90A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkftW-00020F-QG; Thu, 03 Dec 2020 04:07:02 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkftT-0001zv-Jy
 for linux-nvme@lists.infradead.org; Thu, 03 Dec 2020 04:07:00 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3457vJ020751;
 Thu, 3 Dec 2020 04:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Oww/8iFoOsE1zM3fFYoD3Oq4k1GA5uwflIdMRTl3mec=;
 b=fyla7Dqb2gXhO/cJjdl0yvSvOSu/pagItggvc1t2wSrUk/mP4xAnnh/0IhPPdR0aHoKe
 Ibni9NreZWk+zLuvcfCa9UZ9Td3PC0ZwRbDIBKx8hDDmtU9MxPotY8+daPljUXKy/0TM
 UaOQPNmirWNqgXI/lKF57lDeYMpkYIdC9w88WBiGgcCTHLSP4D3eZsEqh8M5orT9vFU+
 3J+CzrRyLqjh/Qe6oMbo3xP/R5oKlGlWp/1tjaNn3Ip0RGIGJw0oiZMFx543Fsil29AS
 pWLwKI7X8Uhs9ddrmZs4/E2NU7HFDKup2QFJ/eT8YkX9R/GtWlIEP+mjI/J6T8uSiuIw rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 353egkuqqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Dec 2020 04:06:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B340D7O085693;
 Thu, 3 Dec 2020 04:04:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 3540f19ag8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Dec 2020 04:04:44 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B344aX8004987;
 Thu, 3 Dec 2020 04:04:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 02 Dec 2020 20:04:36 -0800
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] block: add a hard-readonly flag to struct gendisk
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17dpza6nz.fsf@ca-mkp.ca.oracle.com>
References: <20201129181926.897775-1-hch@lst.de>
 <20201129181926.897775-2-hch@lst.de>
Date: Wed, 02 Dec 2020 23:04:33 -0500
In-Reply-To: <20201129181926.897775-2-hch@lst.de> (Christoph Hellwig's message
 of "Sun, 29 Nov 2020 19:19:23 +0100")
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 suspectscore=1 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_230659_821666_A91F816C 
X-CRM114-Status: GOOD (  20.23  )
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
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Hi Christoph!

>  - If BLKROSET is used to set a whole-disk device read-only, any
>    partitions will end up in a read-only state until the user
>    explicitly clears the flag.

This no longer appears to be the case with your tweak.

It's very common for database folks to twiddle the read-only state of
block devices and partitions. I know that our users will find it very
counter-intuitive that setting /dev/sda read-only won't prevent writes
to /dev/sda1.

>  int bdev_read_only(struct block_device *bdev)
>  {
>  	if (!bdev)
>  		return 0;
> -	return bdev->bd_read_only;
> +	return bdev->bd_read_only ||
> +		test_bit(GD_READ_ONLY, &bdev->bd_disk->state);
>  }

I suggest doing bd->bd_read_only || get_disk_ro(...) here. That does
take part0 into account.

>  static inline int get_disk_ro(struct gendisk *disk)
>  {
> -	return disk->part0->bd_read_only;
> +	return disk->part0->bd_read_only ||
> +		test_bit(GD_READ_ONLY, &disk->state);
>  }
>  
>  extern void disk_block_events(struct gendisk *disk);

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
