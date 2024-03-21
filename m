Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4750AC54E68
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 13:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L56tzJF0W9+8t19Zme7lBpl16syJrfCyVIA47SM64fs=; b=ohUTDPgvUiQ50TwEzjUGSzt1Hi
	MxkzX6BtchdqiVP8p9Guz+V0Xt5KPUYxCdWHEW3zB4YPd2xyYZ2XjJd1bZxCofX9QjAsnSSOGZkW3
	IoFSVecEorXWu2KSgNNW2aWO3Lia08b+WAHtgutKb4IGYdX2cC7OpZ9uMtFxsEoyzJTcN+F32mBvT
	OpjUnYYlRw9tcTMW+BZyBzOkj66lCNrLOIx3peV4IiJo6yZAM98qCbR7/ku9NI1u16LAiVnGi/HE1
	g/bG5k5oKVQz6MMoYNBmqxbsuSbcVeXgQvWk/u0nBO8FXokXa0WBnZqK5Uus5MO7xbmH0EsNO/bGG
	C4QV+3SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnIPt-000000036vD-3leu;
	Thu, 21 Mar 2024 13:25:09 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnIPq-000000036u8-2NkS
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 13:25:07 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LD0hD6021071;
	Thu, 21 Mar 2024 13:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=L56tzJF0W9+8t19Zme7lBpl16syJrfCyVIA47SM64fs=;
 b=A8nLiIF3y9/6TfBK7G7e91Hi8AWGNF4o7PJdgC02bVyRVNU/6mQMwq1YQmvZXbylULM/
 ocHcYQHxuO7kxIbK9AWo/QnzYmYfcmPb7h3z3s9QX8xWdJydzXZeqNDb2FrquKd9Roch
 9hUeedKqZgHhFd67ZWzCit8nx0Fk5/yUHuiVNG5elTBGktRaqqBQ+NcDbGC7vM7kpvLu
 WmCigaCjxS/pSct21jKMh7tWqffrtPR3sfXcmJsOOs1daxUmhL5bJ0j9c/jbED4OutQJ
 wKbR5MwX686QQI5GJ7gf6CmyANTarZKSPsjmx7Psq8PTXJeakiyr0jPHZxfEN1btf2Ky Ag== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0hwv0kt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 13:24:57 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42LC14bO015789;
	Thu, 21 Mar 2024 13:24:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp50den4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 13:24:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LDOrGD32637386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 13:24:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32B3820040;
	Thu, 21 Mar 2024 13:24:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F317B2004B;
	Thu, 21 Mar 2024 13:24:51 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.202])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 13:24:51 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, dwagner@suse.de, nilay@linux.ibm.com, gjoyce@ibm.com
Subject: [PATCH libnvme] libnvme : record the nvme pci adapter physical slot
Date: Thu, 21 Mar 2024 18:46:17 +0530
Message-ID: <20240321132424.3362887-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pPtKFEV71vqiTfC_vR7K9Ocjb5ozIr5D
X-Proofpoint-ORIG-GUID: pPtKFEV71vqiTfC_vR7K9Ocjb5ozIr5D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_062506_757545_DBC45CD3 
X-CRM114-Status: GOOD (  21.90  )
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

There is a subtle bug in the nvme controller physical
slot lookup code due to which the readdir() prematurely
aborts the lookup and hence libnvme fails to record the
pci slot address of the nvme controller. This patch helps
to fix this issue.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Hi all,

The "nvme list -v" command displays very usefule information
which includes NVMe subsystem, controllers and namespaces. 
The output also displays the phsical slot name of the controller. 
However, I found that the slot information printed in the output
is always empty. Further debugging, I found that there is a subtle 
bug in the nvme controller slot lookup code causing the observed 
symptom. This patch helps fix it.

Wihout the patch (slot is empty):

# nvme list -v -o json
{
  "Devices":[
    {
      "HostNQN":"nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2",
      "Subsystems":[
        {
          "Subsystem":"nvme-subsys0",
          "SubsystemNQN":"nqn.1994-11.com.samsung:nvme:PM1735:2.5-inch:S6EUNA0R500358",
          "Controllers":[
            {
              "Controller":"nvme0",
              "Serial number":"S6EUNA0R500358",
              "Model number":"1.6TB NVMe Gen4 U.2 SSD",
              "Firmware":"REV.SN49",
              "Transport":"pcie",
              "Address":"0018:01:00.0",
              "Slot":"",
              "Namespaces":[
              ],
              "Paths":[
                {
                  "Path":"nvme0c0n1",
                  "ANAState":"optimized"
                }
              ]
            }
          ],
          "Namespaces":[
            {
              "Namespace":"nvme0n1",
              "Generic":"ng0n1",
              "NSID":1,
              "UsedBytes":1600321314816,
              "MaximumLBA":390703446,
              "PhysicalSize":1600321314816,
              "SectorSize":4096
            }
          ]
        }
      ]
    }
  ]
}

With the patch applied (slot contains the correct value):
#nvme list -v -o json
{
  "Devices":[
    {
      "HostNQN":"nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2",
      "Subsystems":[
        {
          "Subsystem":"nvme-subsys0",
          "SubsystemNQN":"nqn.1994-11.com.samsung:nvme:PM1735:2.5-inch:S6EUNA0R500358",
          "Controllers":[
            {
              "Controller":"nvme0",
              "SerialNumber":"S6EUNA0R500358",
              "ModelNumber":"1.6TB NVMe Gen4 U.2 SSD",
              "Firmware":"REV.SN49",
              "Transport":"pcie",
              "Address":"0018:01:00.0",
              "Slot":"U78D4.ND0.WZS0021-P1-C8",
              "Namespaces":[
              ],
              "Paths":[
                {
                  "Path":"nvme0c0n1",
                  "ANAState":"optimized"
                }
              ]
            }
          ],
          "Namespaces":[
            {
              "NameSpace":"nvme0n1",
              "Generic":"ng0n1",
              "NSID":1,
              "UsedBytes":1600321314816,
              "MaximumLBA":3125627568,
              "PhysicalSize":12802570518528,
              "SectorSize":4096
            }
          ]
        }
      ]
    }
  ]
}

Thanks,
--Nilay
---
 src/nvme/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index de6ce879..584e3f6a 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -1729,7 +1729,7 @@ static char *nvme_ctrl_lookup_phy_slot(nvme_root_t r, const char *address)
 	}
 
 	target_addr = strndup(address, 10);
-	while (!(entry = readdir(slots_dir))) {
+	while ((entry = readdir(slots_dir))) {
 		if (entry->d_type == DT_DIR &&
 		    strncmp(entry->d_name, ".", 1) != 0 &&
 		    strncmp(entry->d_name, "..", 2) != 0) {
-- 
2.43.0


