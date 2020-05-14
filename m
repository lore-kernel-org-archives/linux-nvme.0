Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F76C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 03:03:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7384B205ED
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 03:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jsfmqV6/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PQR6Z0E1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7384B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q4M7ffi3UxUY5QAkJA1BGh307MHz7ucVMvNJFNH8t5I=; b=jsfmqV6/jcMBOz
	nA5bSiXk77cJV/pCe/MUf7JQG/t7/J/WdCQO5c1RYv1KYctP7NGoHTrJZ8/QRDt3g7Lq1fqfwQ3lF
	8jkfStduyFwELGbyOsRW9Jk1QU9Vmn005ceKIMrK30fctFCQUGwPzds4G7yG61ImAltmc2LPy2Yan
	JkIyCVLz4q4I4zgfoN+UtfhFaF0svtqwSSSUtpCITWgK9qwCkLvydKM0nQs1ZP1ZWUqUy10puGv7k
	cCFgfIFDsDqLAqqzq7jHoj+EUO7AqmSyWKnxxKYlM6bIK1h7u0QQEaPGZsFATEIYu24TXYA4Eq6oN
	q1lj7jBuAPlY0uu2dALg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ49U-0003E2-SX; Thu, 14 May 2020 03:03:16 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ49S-0003DZ-66
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 03:03:15 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04E338cQ079392;
 Thu, 14 May 2020 03:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=jcVffp00YlhtrjxLvELBvcBZrmP+l64oBr6w/Fb45jU=;
 b=PQR6Z0E1Md88+ngrKuJEZyBtpuxOoN+6UboIBHamCCA/FbhxmRF1tfvtASI9cyMNnshp
 m3LPljVMm0C+B64mqm4NJL+9LIVvuVrWKYzEy5QraYxpvCelLrqy2zvSMC09G7VebGFY
 GT8tPbf8TUHwOc7H5/r6uEGQfC0vF6fxex2cfGzDXAa5/j6uXdKZ2xxQZL2lsHtDjsEe
 9ovMiuULB/z5d3xYe1kytANWfdGWA9R9qISH6Opb5zqh+Oca0LNdju1wv10y6vI4qRjx
 b4UpVeOcdlt6teCGK00oi76YrCefAYZXbeUHwN6QZsV5l+rez7ELh+I08CNXvlKG0Bz1 BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 3100xwqy5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 May 2020 03:03:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04E2s1ij063354;
 Thu, 14 May 2020 03:03:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 3100ybsdk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 03:03:02 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04E330La024414;
 Thu, 14 May 2020 03:03:00 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 May 2020 20:02:59 -0700
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 09/16] nvme-rdma: add metadata/T10-PI support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-10-maxg@mellanox.com>
Date: Wed, 13 May 2020 23:02:56 -0400
In-Reply-To: <20200504155755.221125-10-maxg@mellanox.com> (Max Gurtovoy's
 message of "Mon, 4 May 2020 18:57:48 +0300")
Message-ID: <yq1r1vnw74v.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_200314_358552_41BCC818 
X-CRM114-Status: GOOD (  14.75  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, idanb@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, nitzanc@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Max,

> +static void nvme_rdma_set_sig_domain(struct blk_integrity *bi,
> +		struct nvme_command *cmd, struct ib_sig_domain *domain,
> +		u16 control)
> +{
> +	domain->sig_type = IB_SIG_TYPE_T10_DIF;
> +	domain->sig.dif.bg_type = IB_T10DIF_CRC;
> +	domain->sig.dif.pi_interval = 1 << bi->interval_exp;
> +	domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
> +	domain->sig.dif.apptag_check_mask = 0xffff;
> +	domain->sig.dif.app_escape = true;
> +	domain->sig.dif.ref_escape = true;
> +	if (control & NVME_RW_PRINFO_PRCHK_REF)
> +		domain->sig.dif.ref_remap = true;
> +}

Why are you setting ref_escape? In DIX that means that checking will
only be disabled for blocks that have a ref tag value of 0xffffffff
*and* an app tag value of 0xffff. That's specific to Type 3. Whereas
both Type 1 and Type 2 rely on being able to disable checking for blocks
with an app tag value of 0xffff regardless of the ref tag value.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
