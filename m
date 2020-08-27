Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45EBC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 15:48:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5B32087D
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 15:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q5uw9PMg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="amC6J9J3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5B32087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:References:Message-ID:
	From:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LGcjpZP+DY5UlrG54en80Dc6lV/PbObUsU6RwM4o42w=; b=q5uw9PMgl01Qw29xLVbhR5fc1
	A8+ZYNFmLb3V0Q97uzr1JhyEfLHukabCJh3jROPqwWWovd77ssJ+0sPl41ACifAdqLIBQRdxOYBTf
	ea49XHwRWGmiukhG6dtSjQ026F5DHvhrQQh3ZDmviXVgW2RdyH07flvcBSUkX/o4WIFHVf4UpLQVP
	MEeyBQZLaJ4lZu0XitX5MrX+dyfDOgRr/dyOuuWyiIpoLoi74ehu5XW+/UrtIVRtnaThakt62u6je
	RMbsITS1W4VJQf7s50ctmU338TdDoV53I/uz/4iJHWFeN2UQq+C1CArwpvQLJQKC5J23zK8Hzuh8u
	jhPXKBPng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBK8m-0007kb-GO; Thu, 27 Aug 2020 15:48:40 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBK8j-0007jB-Ny
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 15:48:38 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RFSosr025872;
 Thu, 27 Aug 2020 15:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Hmt/qGU6CQD2r61ceGQ8Iq47W9W7CkmYw5Oum8HZN7I=;
 b=amC6J9J3fv3kfDLg4uffPO836UwADs0ZcQcWYIarnNQyPXR5DUSGiD90/0k0qGI9DQpD
 Uq0zMgi3hbPMBFlrAFmbUn4nlW9Ysetf3IUawM2WxSMVU5/nQ0+wHaDDOcP48izwWTbQ
 Z0fo5/dJ4LY9F7mUhfnMdNeDvWHrQsI7tfWptQ3RuWCrIhJTfJ9uxDqOOy8fBSVOnkO2
 3fglgMiwO09RWLGy39dlNk0CwuFIQs4oFzAxvxC2Zr6NMetGwKI10ycKZ2wt3vmdlhfB
 Q6PagnX1ncbHekTtLtdxoWr8IffRYYCRpytmK8bt1I2k31lRUIsANPtiQ6IUBsrb4CkX mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 335gw8911g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Aug 2020 15:48:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RFUvii146462;
 Thu, 27 Aug 2020 15:48:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 333ru1me4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2020 15:48:25 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07RFmNE0010136;
 Thu, 27 Aug 2020 15:48:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 27 Aug 2020 08:48:23 -0700
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: only use power of two io boundaries
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bliwm72c.fsf@ca-mkp.ca.oracle.com>
References: <20200827152824.2784396-1-kbusch@kernel.org>
Date: Thu, 27 Aug 2020 11:48:21 -0400
In-Reply-To: <20200827152824.2784396-1-kbusch@kernel.org> (Keith Busch's
 message of "Thu, 27 Aug 2020 08:28:24 -0700")
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 lowpriorityscore=0
 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_114837_933798_1097718F 
X-CRM114-Status: GOOD (  18.15  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Keith,

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 154942fc64eb..9bbbd600621f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2097,8 +2097,12 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  		}
>  	}
>  
> -	if (iob && !blk_queue_is_zoned(ns->queue))
> -		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
> +	if (is_power_of_2(iob) && !blk_queue_is_zoned(ns->queue))
> +		blk_queue_chunk_sectors(ns->queue, iob);
> +	else if (iob && !(disk->flags & GENHD_FL_UP))
> +		dev_warn(ctrl->device, "namespace:%u has unused io boundary:%u\n",

You used "unusable" in the patch description above. Did you mean that
here too?

Maybe something like:

	"namespace%u: ignoring unsupported I/O boundary:%u\n"

to make it clear that this is due to a kernel limitation and not the
drive reporting garbage.

> +			ns->head->ns_id, iob);
> +
>  	nvme_update_disk_info(disk, ns, id);
>  #ifdef CONFIG_NVME_MULTIPATH
>  	if (ns->head->disk) {

Otherwise OK.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
