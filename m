Return-Path: <SRS0=rA+l=65=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC757C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2020 10:19:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7541020709
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2020 10:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sCai7Iq+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AOrQHDKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7541020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=lORmENiI+fzrTGOQHH1i9fz6jAeb2KQ7eaUNH9loy1U=; b=sCai7Iq+ccvqdV
	bAGoAEsczMWoWo2dfCZnclbiTel14EpAYTuH5DkhY0lYVX8A5CVOfwT21SCPDVsN5XLjyCTbyNrvJ
	Eiz1Jylcy/hfNnJJDzBUKm6PZdP07aWCbJEHB1yI9aGzWBDMCZ5bP/ruMqvJf5zPSOFytVaHROhS+
	qzPHArwL+N55FZZHI+ufCvh3mSw6AcuHsyZH8EAyqxZB+iplDlxj367sIaFCEHhnCd2cdqyvn3usv
	kMVEh9jn1ej5SOPuH/dARs3DDHchXvW0v+4usfiMC5cddD2ncWgfPJseKxS7BOKAnBeVU+LU1eTcC
	RwKmEdVqh37TdrX1C3bQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZXR8-0004br-WC; Fri, 15 May 2020 10:19:27 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZXR7-0004bW-4K
 for linux-nvme@lists.infradead.org; Fri, 15 May 2020 10:19:26 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FA6aWf066361;
 Fri, 15 May 2020 10:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=Sraec879HLM5mjkyogjFeEukkZwmyXPLKB47XiprxHQ=;
 b=AOrQHDKhZmh7LCauki/I/L1zz5BtGRBDBykkJnK5poPnUy/7xKKy3L7uNzf0I57JLG61
 pNt7KfFXAiKI7OllVQyWXCra2aY7vN8op9V4JPlTEyuy3viffgcmCAtIalCD0oC1fj76
 tTFJijWEj5OYto0qQAf5r9ccW8dhk8/MI/QdF6Sipdx8nlzvJs5CWhEgFpWHCXdEaTnb
 fY/YsfGDlz2TZN8WAMVvz+hHr4i0hhhizF5AKOYKYr0X2EBx4lyML2Yoe6Div6Vj8GLr
 dGJGN/Ud2YZ6sJjdUGovMWPbRkGz9TRpkqgvz6rRsWEWPHMJhA9TVa+LmkkJiujJOx+y GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 3100yga5jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 May 2020 10:19:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FAEBC8192223;
 Fri, 15 May 2020 10:19:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 3100yjqfnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 May 2020 10:19:16 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04FAJDdv007968;
 Fri, 15 May 2020 10:19:13 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 15 May 2020 03:19:12 -0700
Date: Fri, 15 May 2020 13:19:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
Subject: [PATCH resend] scsi: lpfc: Fix a use after free in
 lpfc_nvme_unsol_ls_handler()
Message-ID: <20200515101903.GJ3041@kadam>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yq1y2purqt1.fsf@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=2 adultscore=0 mlxscore=0 mlxlogscore=903
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=2 spamscore=0 impostorscore=0
 mlxlogscore=931 malwarescore=0 clxscore=1011 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005150088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200515_031925_256962_8C9F2470 
X-CRM114-Status: GOOD (  15.69  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Dick Kennedy <dick.kennedy@broadcom.com>,
 linux-scsi@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, kernel-janitors@vger.kernel.org,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The "axchg" pointer is dereferenced when we call the
lpfc_nvme_unsol_ls_issue_abort() function.  It can't be either freed or
NULL.

Fixes: 3a8070c567aa ("lpfc: Refactor NVME LS receive handling")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: James Smart <james.smart@broadcom.com>
---
Resending to the NVMe list.  Added James' R-b.

Is there a way we could update MAINTAINERS so that ./get_maintainer.pl
send these to the correct list?

 drivers/scsi/lpfc/lpfc_sli.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 38889cb6e1996..fcf51b4192d66 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2895,14 +2895,14 @@ lpfc_nvme_unsol_ls_handler(struct lpfc_hba *phba, struct lpfc_iocbq *piocb)
 			(phba->nvmet_support) ? "T" : "I", ret);
 
 out_fail:
-	kfree(axchg);
-
 	/* recycle receive buffer */
 	lpfc_in_buf_free(phba, &nvmebuf->dbuf);
 
 	/* If start of new exchange, abort it */
-	if (fctl & FC_FC_FIRST_SEQ && !(fctl & FC_FC_EX_CTX))
+	if (axchg && (fctl & FC_FC_FIRST_SEQ) && !(fctl & FC_FC_EX_CTX))
 		lpfc_nvme_unsol_ls_issue_abort(phba, axchg, sid, oxid);
+
+	kfree(axchg);
 }
 
 /**
-- 
2.26.2

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
