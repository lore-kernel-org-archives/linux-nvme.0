Return-Path: <SRS0=Nwsb=7A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B9CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 17:23:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622E9204EC
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 17:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iDsJA+aA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WSWQ+c2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622E9204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D/VL7kcf2oviD2fNEdprSSTqYvOHA8ZAJZ/r18YxdnU=; b=iDsJA+aAA2AGQ3
	peWSRL8Nkf2/7yltpv7+aDsUyWaA1HfD+48DMY0zCFjyN1hnotKER+lcKQhQtzi5e3rTPpf4UYh9W
	vqKjENd6W3PKloggaPTUUzAGh5Y0KCzpCKTU4tXv2RoJ3VBgH/wW+qu1a/bVmC1QeMmC49r5QlSlb
	WcGihxlREwgE7+u5z4aClqlqh6Hs/O2wrS8mritUueGeHTyjF0ehfkRYmuqt6rElT3LahzjL2NPkG
	Dc3mmlowYqZXusBk+SaarD2YT/EHezWK5pnXFcCbXU5WuW7hG8VQygrEEwrJ7KmmltWHoG+odTsZu
	jJoabCFjf+oUI9LlC3JQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jajTf-0007Om-WB; Mon, 18 May 2020 17:23:00 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jajTc-0007MZ-CP
 for linux-nvme@lists.infradead.org; Mon, 18 May 2020 17:22:57 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04IHHLLo125644;
 Mon, 18 May 2020 17:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=5WzSSvatwTINbbKzqn1Ef3qM1CFXwwqeJyCn9y4U8t0=;
 b=WSWQ+c2nk/EV4WPJ85FjWoH+DZD7/f3wHkvY+qKCC2rtA47b9oP9bC4ygyMLlfflpz6B
 Mvlx/XIdRdygI+uQeTaXdZqBJMMMtfT1BVcvOeWLIxhYe+yWrQkkuGnvL1Les2PaYgnj
 oeIi9dkYDEX4iQ3WliZy4MR+LyW9I5gujC9boh9ZTS0nzs6flNcOk2pIpYFDwBN7iZzz
 dJS0W+ajSWP8tB4zfW3asPVyrhXPfsGUA1I9jVqRor9DliksnPCdOTNZXrYRnrfGKPaP
 ZJ/aOq3WxXBq9EOvmWy+jLVQ/3CpIB8GBHljukdLz0wnfr8ISzyqH0lTMm+DiIg9XVl0 og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 3128tn81ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 May 2020 17:22:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04IHIK75063241;
 Mon, 18 May 2020 17:22:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 312t3w31cf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 May 2020 17:22:50 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04IHMnwS026575;
 Mon, 18 May 2020 17:22:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 18 May 2020 10:22:49 -0700
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 09/16] nvme-rdma: add metadata/T10-PI support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <4e4873ad-868a-ccd6-e4dd-456d2ad7f010@mellanox.com> (Max
 Gurtovoy's message of "Fri, 15 May 2020 17:50:48 +0300")
Organization: Oracle Corporation
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-10-maxg@mellanox.com>
 <yq1r1vnw74v.fsf@oracle.com>
 <c7f3151e-a401-56f7-735f-476b01337b17@mellanox.com>
 <yq1o8qqta2l.fsf@oracle.com>
 <4e4873ad-868a-ccd6-e4dd-456d2ad7f010@mellanox.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
Date: Mon, 18 May 2020 13:22:47 -0400
Message-ID: <yq1h7wdqhso.fsf@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 bulkscore=0 spamscore=0
 clxscore=1015 cotscore=-2147483648 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180145
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200518_102256_590810_E1C93FD0 
X-CRM114-Status: GOOD (  12.44  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Max,

> Will the bellow cover this issue:
>
> static void nvme_rdma_set_sig_domain(struct blk_integrity *bi,
>                 struct nvme_command *cmd, struct ib_sig_domain *domain,
>                 u16 control, u8 pi_type)
> {
>         domain->sig_type = IB_SIG_TYPE_T10_DIF;
>         domain->sig.dif.bg_type = IB_T10DIF_CRC;
>         domain->sig.dif.pi_interval = 1 << bi->interval_exp;
>         domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
>         if (control & NVME_RW_PRINFO_PRCHK_REF)
>                 domain->sig.dif.ref_remap = true;
>
>         domain->sig.dif.app_tag = le16_to_cpu(cmd->rw.apptag);
>         domain->sig.dif.apptag_check_mask = le16_to_cpu(cmd->rw.appmask);
>         domain->sig.dif.app_escape = true;
>         if (pi_type == NVME_NS_DPS_PI_TYPE3)
>                 domain->sig.dif.ref_escape = true;
> }

Yes, this looks OK.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
