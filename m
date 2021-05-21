Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2EBC04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:43:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528A5613AF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528A5613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vy0Z2JygtyAXDJEW5lqb30DvW1gpJSOwtkBFrmMBD/M=; b=Jd/EczU7M2eTgkpi+nnBbnUBh9
	mrKXyhg4dI+TicOvfTyZns8wkRoGLqSDjyhD2cWz9S1FCvgIMbM2xcMcZCrN/QetT0JV2uzGnhp7E
	o4lsgwjmC+AwSzAp7h4SoPkwKeP+CHQHIFZSfCcLvF63L8EjczhP/fxD9pwiE9bsb4H6mp82c5fYk
	KssAQ2ATkIVbva24DiglolTeoudt+i/IhIC/jccL4mLAdcqcvzzcQ9u16LsNO3yjR8gXEeK8YbTku
	TyAAW+QFsWCg0kJPqJ/XEwK2gukqLbzDqVm7XzKBdsup/TDX0T7lXLo/t3nH/UrCT6zftg2WvDjYS
	4pXTDR5g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkDrT-001H5T-0C; Fri, 21 May 2021 22:43:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkDqZ-001Gsu-Bg
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 22:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=rFRlsn0tRqZ2HO4Jjc8Iy7bArGsh8irOCXRU592kZ9Y=; b=PDo32tde0SQXlv2ksd8No8qhoV
 Z9hNwzic7/ZmQaKv6K4mwMTGB7BDW1sLqBHvrxRFijrHmV+NDNGRB3jmr6L+EoP1lB+3L8C7rUqyx
 5LWk8KaBkSGyQgHWwGKNH4ODJeSEd5II+MrZkwPoLRJtMoGpyQGn9Y5yK1HhLDsQOWzgCk1etBJyP
 P74jiakAaxeGSSubp8pKnEaPSPZaSJcawlqew5luqQejD3feRb4/xRx6no9jhNO4GdqOII7471AAK
 ZYFQgjFnPI/MRWXKfPXwlD33pbQZB2YSDDBGOFvhZZzGUAcNAi43uB63f7asRHfnDDEzkXOo+g/BG
 xEBXwrcw==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkDqW-00HTfb-SM
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 22:42:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621636941; x=1653172941;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tWgHPiqgV6RADV4763uVHW/5nDkKsW7DertScZbWJio=;
 b=IMaqyqJ+sH8+Zy7kQO/1cUgwKnoC7xFUWEp/IwMURetitYF/ZAX4xbg0
 TYQ45jui7tT2U7R4OwDFEP3TrZcmdq7ZsRoTpbBomzduaDa+yejpOh2X6
 8kZPv43XQTFuoSrAbiFTJ6PTxh82wW8Dh5nio9cBlzflWAsrQS0sYQu46
 KhR2Gz9eOUidHPl9tUNx13jKWT6z0vjgGyfOIju/cEIAG+gakcNyDy3Z1
 lcBVxe9JXbWnSuZ9j0S4pLZRvXw1OCA8Ixolf3ZpvhIt2+UmwTmXZjHNu
 0vZ6LbqwOOR98fm90OuR+xH6f8EhbMw329wczkJYYvfYkoeFO6hlVCQjh A==;
IronPort-SDR: IF2E08S4EyQVUqUUDBFWOVWU206DpyV9ZPBDl2niaRJj6cpkT9tDifvYnA/blq3oCjacEEtmgV
 Wcmkb2/KotnZ9QIgncPm7M47ZHSwA1PkoOmof1Dt1s+lSZ6WbRmVGHyHmR/M+dCjNqhUkt9sS9
 YfgUdtKJ56v+V3JOnKYgIOPz0ZNDgX6A7dX7hwsFnVaHPYRseRKdzYqPL3O+VZeDaYZ9FjDFsx
 ssUacUD/NF9UqXg0qVih046WV62diEsv1hSPQQffRlykmAJroKLwLAm36ApC41gfXsKgVkomJo
 BUw=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; d="scan'208";a="169598963"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 May 2021 06:42:21 +0800
IronPort-SDR: V79NgzFkby7OY949b/xFEzk47aphRqLYAP6ZSVixyEbo3Er+9Og4lb+D1QD2k7UG4xKWWm/huw
 IWp7Yh15hepb/gjgkvtQy9s+vcdLdIJcH0ifxW+3rT261YAT5VDT7FYtiZJXTLac0RbQ0q0XFG
 XgYh3VOjTvgnCh3vI8Ccxl+FtOo1MGx5sSCJOGVw8Jl87pDDHoOdbsqqp1dPTaSdP+j9yhaBfg
 tmNoYjLjc4zHu/b15GdfnjM1b946lYTtn/knxwIXeAge1oi2CAU+WQkMiUK0/v+jly/heCIeyy
 KgEQAmrSbbVI9n7OC3DvbtP/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2021 15:20:42 -0700
IronPort-SDR: IjZWrRSXAr0xd94V78G7g5J9poU5ArwlO/Y9l8LyaK0n1TvFIxdBHr0Yv+E8hiZjsTCDOhtViO
 rhIpkuuP/rJHCy0W/qq0Gsu7ETophNsy8YV2S5JH9uXYDG1T5ASjujuTER9DemKKlv/9WtqNU5
 s0X2x3j1NGwZbPbK569Nl80MZey0+dUheDYHda46wi6S3uhQ/YQt+jXEJsDbUOcerbUXz38Uy3
 3q127FU47qtinfoBQ+VW6dcJIb5ozEZzZMZDCnC+NX7hGgpT+10XIW9DNko3ziwPYwkhZaRT2K
 ubY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 21 May 2021 15:42:21 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/4] nvme-fabrics: remove extra comment
Date: Fri, 21 May 2021 15:41:59 -0700
Message-Id: <20210521224200.7380-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210521224200.7380-1-chaitanya.kulkarni@wdc.com>
References: <20210521224200.7380-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_154220_997701_F6108231 
X-CRM114-Status: GOOD (  13.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Remove the comment at the end of the switch that is not needed as
function is small enough.

No functionality change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 86004036bce7..6bf775c7fbb9 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -332,7 +332,7 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 			"Connect command failed, error wo/DNR bit: %d\n",
 			err_sctype);
 		break;
-	} /* switch (err_sctype) */
+	}
 }
 
 /**
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
