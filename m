Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B4EC10F16
	for <linux-nvme@archiver.kernel.org>; Mon,  6 May 2024 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cI/nxKt9Gp7zWhd50LimhwBOTIQvFqLcn3T/wRXUQgU=; b=gOupMWYUCdZvT754nSYPbZxju0
	/TrKBDeunt1iM4zqbzzyAwTSJMEuCr8KlxkekikuBwkkbcMlQQA6murj/fjbM4N27RXApcpaWihBF
	PphhBSn7OXmZ85r2c1S9YV4vpkblQUt0kGFgXAxXr79Qtt4rikKkU8vgAXBdJaiB3LZr6sP6HQo+w
	2mYt4NZbazoXq/8dS0syeP3cHsF1avKXTKKfNZ7W5Rusg7VcVI2P5k6O/Ew7vXi9SKkJiBVpfFMPM
	GxxOzsBOdYnPFGuiaBjydY6DV+zXE4w6ZhSB3bBCD/sQ/EhPW33xk/BrO0tqubM6uGKm87/BcYtro
	nzaAxDPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3z84-00000007c8f-2qu7;
	Mon, 06 May 2024 14:15:44 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3z82-00000007c6p-0BNT
	for linux-nvme@lists.infradead.org;
	Mon, 06 May 2024 14:15:43 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446DWhr3015732;
	Mon, 6 May 2024 14:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : content-type :
 content-transfer-encoding; s=pp1;
 bh=cI/nxKt9Gp7zWhd50LimhwBOTIQvFqLcn3T/wRXUQgU=;
 b=VZfamSicWx6SZiARM1rUzJICU9xNZ36p/ZR2rhlUfvy3hBzyQSBp5h2lzlSR+jp9hbze
 RTP2kPxkQVUBzxSSpmyep8fHIcxzz2Cs99er0VF9+fZuufPMtw6UmfluduB1xb3TkIH+
 xGvz7DC6F8fO7wxhxEB55TA3LK4zLT3zy7YLwbIR9isBYZncoO7ulLnn8LsoGzM/OPsl
 0NIHsFDbWGB6p/8O0gH4YOB5Oh/gSy+YvFopbdm5eMpUniLYWE7aaWpnjchKXcIQwWd3
 Sv57VmXbCJB+TQyux8yEIrqd+Z6dBAqssEBJpvTeV4miZXDKnjfww6XrVZHnHvyC9S8i 6A== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xy065043n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 14:15:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 446BfL4D031316;
	Mon, 6 May 2024 14:15:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xwybtrj79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 14:15:28 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 446EFO1k53150188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 14:15:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1A145805F;
	Mon,  6 May 2024 14:15:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E2F258045;
	Mon,  6 May 2024 14:15:22 +0000 (GMT)
Received: from [9.109.198.221] (unknown [9.109.198.221])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 May 2024 14:15:22 +0000 (GMT)
Message-ID: <f1a7c1e2-3203-4b7a-a922-82fa812455bd@linux.ibm.com>
Date: Mon, 6 May 2024 19:45:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
Subject: nvme-cli : attaching a namespace to an undiscovered nvme controller
 on multi-controller nvme disk
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Gregory Joyce <gjoyce@ibm.com>,
        Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>,
        "axboe@fb.com" <axboe@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2P_woP3czFUU7mUiv251n2_6loGDpFRC
X-Proofpoint-ORIG-GUID: 2P_woP3czFUU7mUiv251n2_6loGDpFRC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_071542_338505_90054EB0 
X-CRM114-Status: GOOD (  25.12  )
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

Hi,

I have got an NVMe disk with multi-controller support. This disk has two controllers
however kernel could only discover one of the controllers. On this disk if we create
a namespace and attach it to a controller (which is not discovered by the kernel) then
that namespace can't used for IO. In fact, there's no path to reach such a namespace
from kernel.

Please find the details below: 

# lspci 
0018:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173X

# nvme list -v 
Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys0     nqn.1994-11.com.samsung:nvme:PM1735:2.5-inch:S6EUNA0R500358                                      nvme0

Device   SN                   MN                                       FR       TxPort Asdress        Slot   Subsystem    Namespaces      
-------- -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
nvme0    S6EUNA0R500358       1.6TB NVMe Gen4 U.2 SSD                  REV.SN49 pcie   0018:01:00.0          nvme-subsys0 

Device       Generic      NSID       Usage                      Format           Controllers     
------------ ------------ ---------- -------------------------- ---------------- ----------------

# nvme id-ctrl /dev/nvme0 -H 
NVME Identify Controller:
vid       : 0x144d
ssvid     : 0x1014
sn        : S6EUNA0R500358      
mn        : 1.6TB NVMe Gen4 U.2 SSD                 
fr        : REV.SN49
rab       : 8
ieee      : 002538
cmic      : 0x3
  [3:3] : 0	ANA not supported
  [2:2] : 0	PCI
  [1:1] : 0x1	Multi Controller  <== this is multi-controller disk
  [0:0] : 0x1	Multi Port
<snip>
<snip>

# nvme list-ctrl /dev/nvme0 
num of ctrls present: 2
[   0]:0x41
[   1]:0x42

# cat /sys/class/nvme/nvme0/cntlid 
65

So it's apparent from the above output that kernel has discovered one controller (nvme0)
with cntlid 65(0x41). The other controller with cntlid 0x42 remain undiscovered.
Please note even though kernel couldn't discover both disk controllers, it's possible to 
create and attach namespace to a controller which is not discovered by the kernel.

# nvme create-ns /dev/nvme0 --nsze=0x1749A956 --ncap=0x1749A956 --block-size=4096
create-ns: Success, created nsid:1

Now, attach namespace to a controller which is not discovered/known by the kernel.
# nvme attach-ns /dev/nvme0 -c 0x42 -n 1
attach-ns: Success, nsid:1

# nvme list 
Node                  Generic               SN                   Model                                    Namespace  Usage                      Format           FW Rev  
--------------------- --------------------- -------------------- ---------------------------------------- ---------- -------------------------- ---------------- --------

The nvme list doesn't show any namespace and the reason being the namespace is attached
to a controller which is not discovered by the kernel. The kernel doesn't have any path to 
access this namespace. So in essence now this namespace can't be used for any IO.

Looking at the above output (namespace list is empty) if we try creating a new namespace
then we see the below error.

# nvme create-ns /dev/nvme0 --nsze=0x1749A956 --ncap=0x1749A956 --block-size=4096
NVMe status: Namespace Insufficient Capacity: Creating the namespace requires more free space than is currently available(0x2115)

# nvme id-ctrl /dev/nvme0 -H 
NVME Identify Controller:
vid       : 0x144d
ssvid     : 0x1014
sn        : S6EUNA0R500358      
mn        : 1.6TB NVMe Gen4 U.2 SSD
<snip>
<snip>
tnvmcap   : 1600321314816
[127:0] : 1600321314816
	Total NVM Capacity (TNVMCAP)

unvmcap   : 0
[127:0] : 0
	Unallocated NVM Capacity (UNVMCAP)
<snip>
<snip>

We find from the above output that all available capacity of disk has been used but
nvme list output is empty.

Please note that "kernel is unable to discover both NVMe controllers" is not a kernel bug.
Also I think, this is not a bug with NVMe disk or its firmware. This multi controller NVMe 
disk has a "DualPortEn#" pin and by default, the disk is configured to operate a single x4 port. 
Asserting the "DualPortEn#" pin enables the Dual x2 port mode. When disk operates in Dual x2 mode,
kernel could discover both controllers. However when "DualportEn#" pin is not asserted
disk would only enable one of the controllers and hence kernel could discover one controller.

There could be multiple ways to address this issue. However my proposal would be to address 
it in nvme-cli. As nvme-cli builds the nvme topology it shall be easy for nvme-cli to detect 
this anomaly when a namespace is being attached to undiscovered nvme controller and shows some
WARNING message. The WARNING could be shown for ~10 seconds so that it gives enough time to a 
user to cancel this operation. If the operation is not cancelled then nvme-cli would proceed 
as usual.

Please help review and as usual, comments/feedback/suggestions are most welcome!

Thanks,
--Nilay

