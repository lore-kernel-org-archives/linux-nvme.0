Return-Path: <SRS0=Onny=7V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E661AC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 16:31:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79B32053B
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 16:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uDeRGPie";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EBplNvga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79B32053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=GizDDI3SNsOcUuRtoUtfikkj5U7D3qbSyjpJnDnCNfA=; b=uDe
	RGPiecdQmyFkuLWy61UQQWGaYGN5Z4+X4DtApP7o1yXrQR4oCFCFh1QevGQgB4yy6Y+RoXVnTcr2N
	goRp4fmWirTD2FofXTMwtgJn9SXwErnP9uxMrJGhNaBnJnjpfEgNn1bZv3EMcsHgVob1zt5KqXF0f
	IhyGajEIrsAva4uLdHdXm8kTTcnf4LQCyNhenky2TaFWcPaaewg0gHSDs1myZX7zm9iGDbKPfJ4Lp
	foa6xKxxnl2qrr3PcnvUCNu52RL0WDldbcIWjgd0y++IpUp5bpxQDD5XzZ0J6INIfEdQ7bqdpqLMp
	klRhlzu7t0rmw5HytNp71DTW4WdXxLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jiKg5-0004zu-I5; Mon, 08 Jun 2020 16:31:13 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiKg3-0004zZ-Gp
 for linux-nvme@lists.infradead.org; Mon, 08 Jun 2020 16:31:12 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058G9MiM066579;
 Mon, 8 Jun 2020 16:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=tYYiyASbtZojC1CqxMm1OnNF5Ok/Fu5wHgNs6PBEbjI=;
 b=EBplNvgag2qURqZrox4y/jD+u/uvttDNaSmSql1f6SDchYho4FZFfDyP+lQGmQ0+hB2P
 XAHa7f+/6kHA3wolXPjC3UyU/T3EBvg2sh/+D7N/o2/2kuO/z/Pyl+2/35s3PKwn5AJa
 /KyCDz90Rp38qu/yJH8E0MHU9AQBZ2YBHIn5H0ccOJMwWS/VF1nz3mCjWChikVEZM+Wy
 cj2VIKHvImqIQ6MEz/hIVRt+UGQVf0X7ziCcIXMhzWTZS97wSxMz8jNGY3vxPQxopt6D
 wsSeaPzDJjbftNJtL4wh9+jO19R/lrT3V6LRAYa0g8WKJvEp+E/F6Q3q/FRutQMM/Y83 SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 31g2jqyugn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 08 Jun 2020 16:31:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058GDrHh012273;
 Mon, 8 Jun 2020 16:29:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 31gn2vev4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jun 2020 16:29:02 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 058GSxWn012649;
 Mon, 8 Jun 2020 16:29:00 GMT
Received: from localhost.localdomain (/10.211.9.80)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 08 Jun 2020 09:28:58 -0700
From: Dongli Zhang <dongli.zhang@oracle.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme: simple cleanup
Date: Mon,  8 Jun 2020 09:20:00 -0700
Message-Id: <20200608162002.17017-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=593 spamscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 mlxlogscore=621 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200608_093111_641457_0F21D7A8 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, chaitanya.kulkarni@wdc.com, linux-kernel@vger.kernel.org,
 axboe@fb.com, kbusch@kernel.org, hch@lst.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Just cleanup without functional change.

Thank you very much!

Dongli Zhang



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
