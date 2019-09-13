Return-Path: <SRS0=imtT=XI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BADC49ED7
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 22:31:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D82820692
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 22:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dXukCFUp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HXUJIqd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D82820692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ab3boBK1sIvAMnmBxGr1Q869IzgClTh58+t6IXWs1yc=; b=dXukCFUpcPqDny
	II63QXba2C5IOgWIQgSctrWHq2M91CEn8nFEYwcXep5/tcD2aAniousnEcHb0Ro5cFtpABo1baqte
	SfRWhjhUIiU5eLFUld9H63/0RFkqlrqD2qMF2aYIuT015vuLZrHJKBgMyWsECZgknkP88TtrALukF
	7TKyyxUpXkSx+v9XXDfUW2SOzMiAQWUYHtKAvvWy4hHrVcZeo8zMqWrE2aDhnK/SDztKCGcOPNaFc
	puN1En8PqcugAwfziB49RyQ/lM/pZRqOsljMgfUpCeR4WEmof6ALw/5+a9/3yDAZEGu0trbXH7lt1
	QlyAq4k7hDz6tuPrHayg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8u6Q-0002LW-Bw; Fri, 13 Sep 2019 22:31:42 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8u6N-0002LC-C9
 for linux-nvme@lists.infradead.org; Fri, 13 Sep 2019 22:31:40 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DMTb46002552;
 Fri, 13 Sep 2019 22:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=AytNg7Y7pX8v7DSd9Lm6chkJVbM/QLIa9/YYRNsXJpY=;
 b=HXUJIqd/1NrjT8MwU8LQ9nuvE/iikC+T8GG/0eoU1QhIia/SdtoMiSGv0TBTmF4Yqo37
 BvenJ1K37tiLXbY8OYto/rYPRQgaX/gMmQHwy5ki7AzQ7L0oacS8CkNtcC+ZXj9eYLYH
 IS+YWk11+T/4RLParSq/IBl+iIC2Ebjq9X9b+6ZJo2uypqkiiPvmkqXcHU2ADurjqAs9
 8k3lJDj++5bwvP+p1mNzUSakzXtVgAcl+f4FgBl5AgVl8Dfd1XEczC1El7iMVNZqbseG
 dwsnK9HS0yJmHMpDuoFxAZpSZJL7Cl42n/94Zq0gj9hj8UVl1vgZv9+b4yBCJi6AeKVm uQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2uytd379ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2019 22:31:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DMSYct010694;
 Fri, 13 Sep 2019 22:31:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2uytdxc071-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2019 22:31:30 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8DMVT0m022663;
 Fri, 13 Sep 2019 22:31:29 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Sep 2019 15:31:28 -0700
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5 2/2] block: centralize PI remapping logic to the block
 layer
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1568215397-15496-1-git-send-email-maxg@mellanox.com>
 <1568215397-15496-2-git-send-email-maxg@mellanox.com>
 <380932df-2119-ad86-8bb2-3eccb005c949@kernel.dk>
Date: Fri, 13 Sep 2019 18:31:21 -0400
In-Reply-To: <380932df-2119-ad86-8bb2-3eccb005c949@kernel.dk> (Jens Axboe's
 message of "Wed, 11 Sep 2019 16:01:11 -0600")
Message-ID: <yq18sqrde12.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=815
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909130220
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=902 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909130220
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190913_153139_546802_B5A3F904 
X-CRM114-Status: GOOD (  13.71  )
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
Cc: keith.busch@intel.com, sagi@grimberg.me, martin.petersen@oracle.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, shlomin@mellanox.com,
 Max Gurtovoy <maxg@mellanox.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Jens,

> While I like the idea of centralizing stuff like this, I'm also not
> happy with adding checks like this to the fast path.

Yeah, but at least it's just checking a request queue flag.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
