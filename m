Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A05EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jul 2022 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m+HurB37esaYPyXcV322ffClt3dKNXFg4mguC6R77tw=; b=2IBZ+iBOijn/7Z4omm48/CQ2fM
	eoQeTGVaGO4MGlu3K3PpmkyrMtQ3ftLvuKhZpNLsIz32p+K4QmCzW+qjYx3iwZJcf48Q17pkHpqZ2
	rz37YMIX5TwuzpDfAugX8dAi3rQTbbtIxFBT7QCrmNdUrHnQqfIPx3Q+ehq2nVnbv7WYyRRq92jQj
	V+oN/baBGB7xNx58bj2hWoImJCw//3C78IXPv/PTN2puz9dlQ/oFljFkL6rrTFxvS59MnW4ehT2/t
	LLI5raD+tcWjizmtVLSfj4TZmfoy8CBx4rWAxoC5adsipFcC5ShY9y5OIPRzekdEvUh7JKlAE8Bwj
	cn1tmyJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBFGI-00B5tF-Oe; Tue, 12 Jul 2022 12:45:10 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBFGG-00B5qj-02
	for linux-nvme@lists.infradead.org; Tue, 12 Jul 2022 12:45:09 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CBxmws023669;
	Tue, 12 Jul 2022 12:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=m+HurB37esaYPyXcV322ffClt3dKNXFg4mguC6R77tw=;
 b=YhmFI3DzeFKdFmyAvGDqrUkzuFjkWN5pjLAyXlaKOAUuK7NjYJp1yhu/zVBcSiXzOx9y
 UM4Yhf0kaAfCmyL21RT3QLmaiXqQLtKCA06Bnfzxj9l+PqSV+/38m2MQ3DNYvHzD/geY
 hK9Psz4LwZogqfBOZstqaZJ3oQw7eF4O6vWj3vfBPgNlwHs5J34UZyjjWmQM4/uVh+Sf
 NGcmnlkipCO+Zm6QSbg3aajzA/Tdpv7YFqZfSgDYF8wr/S46jCuADEVwW7Zs9gwzIrk1
 GVlJQYW0I4HdeXKyu13u2UOFC+mRjbEbk5i37g+0yt6ho2IlWXzt+VBzEq4OuBD9tToT +w== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h98jvhd0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Jul 2022 12:44:58 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
	by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CCMgo8021877;
	Tue, 12 Jul 2022 12:44:56 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma06fra.de.ibm.com with ESMTP id 3h8ncngcrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Jul 2022 12:44:55 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CCirUY24052116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Jul 2022 12:44:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69097A4051;
	Tue, 12 Jul 2022 12:44:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31F42A4040;
	Tue, 12 Jul 2022 12:44:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 12 Jul 2022 12:44:53 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Stefan Roese <sr@denx.de>, Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] nvme-pci: fix hang during error recovery when the PCI device is isolated
Date: Tue, 12 Jul 2022 14:44:52 +0200
Message-Id: <20220712124453.2227362-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RqNpgWD8A2th9MugL-spxZNOTYVDqSwP
X-Proofpoint-ORIG-GUID: RqNpgWD8A2th9MugL-spxZNOTYVDqSwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_08,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120048
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_054508_200986_B6D20135 
X-CRM114-Status: GOOD (  24.34  )
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

Hi Christoph, Hi Keith,

I found a regression when recovering NVMes after a simulated PCI error on
s390, though I believe at least some POWER systems should be affected as
well. I tracked this down to commit b98235d3a471 ("nvme-pci: harden drive
presence detect in nvme_dev_disable()") which causes nvme_start_freeze() to
not be called before nvme_reset_work() does nvme_wait_freeze() thus hanging
forever. The detailed analysis is included in the commit message and not
too complex but I'm not entirely sure my proposed solution is the correct
one.

The patch I'm sending here works for me and should at least only affect
platforms using the explicit driver->err_handler->slot_reset callback. To
my understanding it seems that the nvme_dev_disable() in
nvme_error_detected() still does the necessary quiescing towards upper
layers and I assume that nvme_start_freeze() won't do anything useful if
the controller is inaccessible but I'm not an expert in this. In particular
I'm not sure it makes sense to start freezing the queues right after
a reset.

Also note I will be travelling for about 3 weeks starting July 14th and
won't have access to s390 machines or my work mail address so apologies if
I won't answer. Feel free to do your own fix. Also Matt (on CC) might be
able to test fixes for this.

Best regards,
Niklas


Niklas Schnelle (1):
  nvme-pci: fix hang during error recovery when the PCI device is
    isolated

 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.34.1


