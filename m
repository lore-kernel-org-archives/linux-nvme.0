Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3889C25B78
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 09:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=U2a4vJ13qECcMUGWYaI+7dqwUI8KaSHN4jzmSYttcKA=; b=qHAmoJXmBUErr2
	FhxzIKv0yJxlbdXsslTw1i5kt8B08viDSWQbfBMv6sm3QIxXoK23ii2dVPGbTaLWv4eZ4I5XnBxPx
	7v8HKpKxvaRa+5vzPuAvm5WwX11tcOcaIsrGe0B1JMn74Jy+t2AVEc22CEbNSyx12np1w5UX/8wMr
	f2hBrHWkXx5xTi0oJVkOxDi87UXQ1ufyMAQIns3kyV8SU/SP+Ico1Nhy2Ro9pqHfY1UqPGPkUpfIE
	x4JFRM8x7ksGEsVjxA374Hqm/j20BSXcl1FL4+6YkX16QbbB8+TsJtLIuTaTM0ke7or+rH4acFIIa
	HjwDmb0KoTbEH721+B7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEQGg-00000001oVB-0JKT;
	Tue, 04 Jun 2024 09:15:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEQGd-00000001oU0-0Ip6
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 09:15:45 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4548gnug030674;
	Tue, 4 Jun 2024 09:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=pp1; bh=U2a4vJ13qECcMUGWYaI+7dqwUI8KaSHN4jzmSYttcKA=;
 b=kTmdUEd+kFAkv2KUPLeargbBISCPscew5sJ9mTaC1ogbxWVNLyMAz5I545imruVcI1sf
 tbvbtB+2YNK2YAwe6NBAF0WehlStbjTABCrFz14pmwoHZ9DwUL9ZPJfBKnp1BtTdBNQM
 kl12W3Lb20oTQuu5KDV1An78CzKoP+sIffBH5RlJUuL5SdMx6ZO93kYAI3gBoZJ1dw0Y
 pV+OW6QiSKM51l9pMPbpK4QesCO04l2LLNNCcSEial80JkKckzCsmvUOWzY8GI/GIRh/
 CIdaDRv/P86TO4yx1xVNtSpYS2k+PBjRcHJ67emPdZk6J5x3eZbXsTHjco/cA8mKAQLA 0Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhyn982nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 09:15:34 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4547VnH5026549;
	Tue, 4 Jun 2024 09:15:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yggp2vqhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 09:15:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4549FSYN55705978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Jun 2024 09:15:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 285FB2004D;
	Tue,  4 Jun 2024 09:15:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98F0920040;
	Tue,  4 Jun 2024 09:15:26 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.214])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Jun 2024 09:15:26 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        gjoyce@linux.ibm.com, axboe@fb.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 0/1] nvme-pci: recover from NVM subsystem reset 
Date: Tue,  4 Jun 2024 14:40:03 +0530
Message-ID: <20240604091523.1422027-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3FN1x8g3eFgf0AEc8SuWnTMN4uMnSRzv
X-Proofpoint-GUID: 3FN1x8g3eFgf0AEc8SuWnTMN4uMnSRzv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_03,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_021543_476461_850CB5DB 
X-CRM114-Status: GOOD (  26.46  )
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

Hi Keith,

My previous attempt to get attention for this patch didn't garner enough 
eyeballs and so I thought to rewrite the text and tried including some 
more background on this. For those interested, I have also copied below 
the link to the previous email where we had some discussions about this 
patch.

The NVM subsystem reset command might be needed for activating nvme 
controller firmware image after the image is committed to a slot or 
in some cases to recover from the controller fatal error. The NVM 
subsystem reset when executed, may cause the loss of communication 
with NVMe controller. And the only way to re-establish communication 
with NVMe adapter is to either re-enumerate the pci bus or hotplug 
NVMe disk or reboot the OS. Fortunately, the PPC architecture supports
extended PCI capability which could help recover the loss of PCI adapter 
communication. The EEH (Enhanced Error Handling) hardware features on 
PPC machine allow PCI bus errors to be cleared and a PCI card to be 
"rebooted", without actually having to reboot the OS or re-enumerating 
PCI bus or hotplugging NVMe disk.

In the current implementation, when user executes NVM subsystem reset 
command, kernel programs the nvme subsystem register (NSSR) and then 
initiates the nvme reset work. The nvme reset work first shuts down the 
controller and that requires access to PCIe config space. As programming 
to NSSR typically causes the loss of communication with NVMe controller, 
the nvme reset work which is immediately followed after that would fail 
to read/write to PCIe config space and that causes the nvme driver to 
believe that controller is dead and so driver cleanup all resources 
associated with that NVMe controller and marks the controller dead. 
So the PCI error recovery (EEH on PPC) doesn't get chance to try recover 
device from the adapter communication lost. 

This patch helps to detect the case if the communication with the NVMe 
adapter is lost and the PCI error recovery has been initiated by the 
platform then allow error recovery to forward progress and thus contain 
the nvme reset work (which has been initiated post NVM subsystem reset)
from marking the controller dead. If in case pci error recovery is unable 
to recover the device then it sets the pci channel state to 
"permanent failure" and help removes the device.

I have tested the following cases with this patch applied,
1. NVM subsystem reset while no IO is running 
2. NVM subsystem reset while IO is ongoing
3. Inject PCI error while reset work is scheduled and no IO is running
4. Inject PCI error while reset work is scheduled and IO is ongoing
   
   For all above cases (1-4), verified that pci error recovery could 
   successfully recover the nvme disk.

5. NVM subsystem reset and then immediately hot remove the NVMe disk: 
   In this case though pci error recovery is initiated it couldn't forward 
   progress (as disk is hot removed) and so controller is deleted and it's 
   all associated resources are freed.

6. NVM subsystem reset and PCI error recovery is unable to recover the 
   device:
   In this case controller is deleted and it's all associated resources 
   are freed.

7. NVM subsystem reset on a platform which doesn't support PCI error  
   recovery:
   In this case nvme reset work frees resources associated with the 
   controller and mark it dead.
	

Changelog:
==========
Changes from v2:
  - Formatting cleanup 
  - Updated commit changelog to better describe the issue
  - Added the cover later to add more details about nvme 
    subsystem reset and error recovery(EEH)
	
Changes from v1:
  - Allow a controller to move from CONNECTING state to 
	RESETTING state (Keith)

  - Fix race condition between reset work and pci error handler 
    code which may contain reset work and pci recovery from 
    forward progress (Keith)

Link: https://lore.kernel.org/all/20240209050342.406184-1-nilay@linux.ibm.com/

Nilay Shroff (1):
  nvme-pci : Fix EEH failure on ppc after subsystem reset

 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/pci.c  | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.45.1


