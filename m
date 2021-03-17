Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAFEC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 20:51:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC12E64E74
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 20:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC12E64E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FhWnB+WBywcpjWhNC1raz2tgH4mOIDbSqUxvgsvcw7A=; b=PHW+bjg6EKtwvS/0HibhQGecin
	/91NhJHCTXX8Ebf0Q2CAtxbR2/4t/8TVdlIApMQjmkTjcnFji47FpqErPbLGT8gjeWk43gw2YzyMN
	POYtjG2u6r/aWA1QarIOuYOznGtoU2ual1xACy5r09dlD6l18yM2VTEBONf0OLqE1R6+PxLt9NCSp
	V/R3qCa2T6LLfiKwA6HMDq8nQ7p0aATNF9sIhaKrfhdgYBsrVxGCs3UgVujp1eGnr0rtETNlT8Zl2
	Of8hTZIwmai4gcDKP/kPV26LH1iSWpa+S+TB7qPRNKpJiVWeEFcip4ffTF6BzAXtaJqP3/qemuX6I
	8IanCB+w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMd85-003svY-Gi; Wed, 17 Mar 2021 20:50:57 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMd44-003sdq-DN
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 20:47:25 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HKfWer051963;
 Wed, 17 Mar 2021 20:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=0hGGj+51lCaVzOO04HCqUaxBVL6ejCH7M5xLNc2arXY=;
 b=ykSoNDqRx2rmTFkuKJr72rPwbGzWIIY7yGN5PHi1fGUh0T2y7v0vJoOA4zEowxLhhBCX
 ZEnRyT1BbWDVx1TJbUXANpTz0EI3WVp6P08LbI0rF7gqLshRPkNuBJXKSgVBoc2Iaj4n
 woJ+sI71jxCKDBzo4Wzw7PmcLOB8/cDynoSlPIWwN1wK9vUA5p1gsI0Liowoyf4OklKL
 /zUDbXjoBHHtrAqN3WlfUCYNbb6sqrVALHvhicpM9NP36uC0fSIQAtaOSe3SDdOYG5ay
 g97tmBwwAgKhGEB7FNN03Hy0/vvNwPyv115AbfFkfSV85mOs6bQR9QBljCsPCrfTUtlf rA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 37a4ektebk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Mar 2021 20:46:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HKekul077058;
 Wed, 17 Mar 2021 20:46:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 3796yvahky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Mar 2021 20:46:30 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12HKkNFe001225;
 Wed, 17 Mar 2021 20:46:23 GMT
Received: from localhost.us.oracle.com (/10.147.27.236)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 17 Mar 2021 13:46:23 -0700
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH 0/1] nvme: Export CSTS register via sysfs
Date: Wed, 17 Mar 2021 16:46:14 -0400
Message-Id: <20210317204615.13971-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.18.4
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170145
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170145
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_204723_866847_EDFD1898 
X-CRM114-Status: GOOD (  11.70  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch exports the NVMe Controller CSTS register via sysfs.  This
feature can be used by userland executables that accessed CSTS and
possibly other registers by mapping them into user space.  Since this ability
may not always available, exporting certain registers via sysfs provides
a safe/read-only way to access registers from outside the kernel.

Testing:

# Controller in the RDY state
# cat /sys/devices/pci0000:00/0000:00:04.0/nvme/nvme0/csts
1

# Controller in the FAILED state
# cat /sys/devices/pci0000:00/0000:00:04.0/nvme/nvme0/csts
2

# A virtualized csts register can be accessed for fabric devices 
# cat /sys/devices/virtual/nvme-fabrics/ctl/nvme1/csts
1

Alan Adamson (1):
  Export CSTS register via sysfs

 drivers/nvme/host/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.18.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
