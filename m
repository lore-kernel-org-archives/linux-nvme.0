Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FF3C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 23:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qLmV2A/FfXX4Z1qISVXxXZ0NbRja0Rh9FDzBmYDHRqE=; b=RBaPNsuNTa0ahNcj3dXfttksSf
	mJz80x/iIZrDr6Dwg4VR32cdsXKuzl9w0MXFu8LKT2wm/3jowBJG8gjLF5RrzvGgiSG/n6Xzrwre/
	8cuxFo/4ib2ry3Qo7vTfFHkyduiHGMPNipnNmFfI+u89aHVGckrbzh9p7OJMmn5jn1rGciA5BZvWF
	BUpZDOM5wxbUlmc2hHe8awKurgpL4cPdZ20/0bIdCdbkIwglLi7gYK1S97HXfzNS3N2gwsRvzu0nR
	KfApIFuJnttAqgiGWq0KijH1BZDo8Z1u3Dyr9epLVBrSu9OFSp3AvR4MQHgqvoabLayDJbmmjoWL8
	Ow44U0rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqk0P-00AjtV-AJ; Mon, 16 May 2022 23:20:01 +0000
Received: from desiato.infradead.org ([90.155.92.199])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqjfP-00AaCU-GS
 for linux-nvme@bombadil.infradead.org; Mon, 16 May 2022 22:58:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=qLmV2A/FfXX4Z1qISVXxXZ0NbRja0Rh9FDzBmYDHRqE=; b=UvmSYUwyLwvYKruC3ctA+Er7ty
 jeV9A51I5AEKj4WfrsOqBFNwTiJj6oUVhShtzOoFLU3Ox0E9kB0W74qwgIda/BK3zEJ3INCjzOgdF
 kjRNzBUsIRBRaUBqBmURSYf6atumIHrttfgx+NaWzh9YpnfigmX4fPtiwN9v+CTLmKKBleMElnkbY
 8l/0dk8b8WzDx9y9QOcNli4WAAikJ30PrQwtz9i7UyvrxmpEEQ4VPBAwkyfSKpAHCSuh3XQeB5sTF
 s0UFyQwkHneqPVpgACPGHobtkikA39dfLw5gnFfMj0jIaHe2G4uj17C+rWoYsFJeA42uS3b0Rqe9i
 dfV+p+Ag==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqjfK-0012yK-2F
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 22:58:17 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GKrC3q027282;
 Mon, 16 May 2022 22:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=qLmV2A/FfXX4Z1qISVXxXZ0NbRja0Rh9FDzBmYDHRqE=;
 b=DjnGMps7szT0QJJvZmEjPO25tHJR+o5D0qmWbMf7C93Lv+oolSRN7YpSej1wPc8Q6kt7
 lbbTbIdZ63H2HLAK007uB0g+EvxUls3FBi/yWwyAYLfQjlItL7osd450hnc/nIaKSUyW
 Kwu903xfs0CABK+Naiy1pj55uo6DOAVXSMQ3euDAZ6b9xsa/9tJU4eiNwP3+DpBWaD0d
 A366nLxj2xq72Rp+GYol4RKGttotB6M4ghe8wRWkp8IcKH/KUvSHF9YfEqMjrHJD+JnY
 Ks3L8cyIK3VXwlONaxDvVchwh3pJcmcn3GqM6As+v2OS7P7LAjn0Y8+DNJZuOUKlaCEW UQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371vqfe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 May 2022 22:55:57 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24GMttQx013392; Mon, 16 May 2022 22:55:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v7xv2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 May 2022 22:55:56 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24GMtul3013443;
 Mon, 16 May 2022 22:55:56 GMT
Received: from dhcp-10-65-131-124.vpn.oracle.com
 (dhcp-10-65-131-124.vpn.oracle.com [10.65.131.124])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v7xuyu-1; Mon, 16 May 2022 22:55:56 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, linux-nvme@lists.infradead.org, osandov@fb.com
Subject: blktests v4 tests/nvme: add tests for error logging
Date: Mon, 16 May 2022 15:55:37 -0700
Message-Id: <20220516225539.81588-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9FuhQWjKqQtzvQ5hJWlQB6xZmC6SUEQV
X-Proofpoint-ORIG-GUID: 9FuhQWjKqQtzvQ5hJWlQB6xZmC6SUEQV
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_235815_703579_5CF62632 
X-CRM114-Status: GOOD (  13.41  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
run with or without NVME_VERBOSE_ERRORS configured.

These test verify the functionality delivered by the follow:
        commit bd83fe6f2cd2 ("nvme: add verbose error logging")

V2 - Update from suggestions from shinichiro.kawasaki@wdc.com
V3 - Add error injector helper functions to nvme/rc
V4 - Comments from shinichiro.kawasaki@wdc.com 

Alan Adamson (2):
  tests/nvme: add helper routine to use error injector
  tests/nvme: add tests for error logging

 tests/nvme/039     | 153 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |   7 +++
 tests/nvme/rc      |  44 +++++++++++++
 3 files changed, 204 insertions(+)
 create mode 100755 tests/nvme/039
 create mode 100644 tests/nvme/039.out

-- 
2.27.0


