Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF2BC48BF8
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 19:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:Subject:Cc:To:From:Date:MIME-Version:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+2njaI7YfBJdIG3TbNZpw59bNGttFUJUPUr7o7GinPw=; b=KIV1uShgWC+q2QQljymHSzM/Su
	p0PfXv0T+8HEkdPcO4iJaTKBro93ELzu/S5b74mdUOISwOHRJL5OUPZSRBBEIfG6gMQRyNpSmCy2I
	XIbL+AgbazuXVzk5GaqwfbbJZ7XcCP3VT9LJt4FBO75ersHW8Adl5LwptbRM8Wr+ot9QYaHU9h8I4
	KIkvUcND/+Eu6JqmiQAok6yZccxrcag2Elqa9CYhYd1FQ95IaoHRbSgu8gPHescqDkL8RE+ozPh8B
	rN6KnITPno13XvRSbIQQ2nqlrZGpJ72kivOixmk7bwQwS/6wNeSdARn5eOzHCQDs1VOVM/xP7OTNY
	7f515T3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc8vn-0000000BpSI-31rj;
	Mon, 19 Feb 2024 19:03:59 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc8vl-0000000BpPo-1HA9
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 19:03:58 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIuWKd025532;
	Mon, 19 Feb 2024 19:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : message-id : content-type :
 content-transfer-encoding; s=pp1;
 bh=+2njaI7YfBJdIG3TbNZpw59bNGttFUJUPUr7o7GinPw=;
 b=VUhR8sY3uu8p0WohobB91erxaaqkGxD/CgHPUTKWgdLeZMgK5Lr3nOAXy5yZElEOwxWR
 oOsWzCepr17ye6+TZFFvBAitteQ3IrcudzB0waFu3rNyIYAz1f4antbToIhlCygtJW54
 XmPejCQlq8HZlW0OxonfVTQJZqxTnRGlebW41ZDWSuSnVCuXQ9paP1HtNN0EmEmrfo48
 bAcvGpFszr6g/5MInYfLejJXEVswOC8g+DLRAa3c52tDfHowlw879UeO5izglneGbMM8
 bO/QvutNsXnDqQtrYZ+GZpi1Sh2Ll6RKXD0iPYtvXJz2L4Aa2kThQWpkqgOxXoCyODhh /Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wca0w4e8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 19:03:52 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIdicB014347;
	Mon, 19 Feb 2024 19:03:51 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u2ans5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 19:03:51 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JJ3nWS4064142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:03:51 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69CD658065;
	Mon, 19 Feb 2024 19:03:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BF8358051;
	Mon, 19 Feb 2024 19:03:49 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 19:03:49 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 19 Feb 2024 13:03:48 -0600
From: Wen Xiong <wenxiong@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: Wenxiong <wenxiong@us.ibm.com>, Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>
Subject: nvme native multipath question with two physical paths
Message-ID: <f5c8d980ffd12601d258c510b879f4d9@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OUPWqWheMJFCoye2if4HoP1h5_2dQU2T
X-Proofpoint-GUID: OUPWqWheMJFCoye2if4HoP1h5_2dQU2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_17,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 spamscore=0 mlxlogscore=408 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190143
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_110357_355793_5D165573 
X-CRM114-Status: GOOD (  12.75  )
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

Hi All,

In our nvme native multipath support drawer, each nvme has two physical 
paths/two controllers.
We created a shared namespace on it.

# nvme list-ns /dev/nvme2
[   0]:0x1
# nvme list-ns /dev/nvme6
[   0]:0x1

# ls -l /dev/nvme2*
crw-------. 1 root root 240, 2 Feb 18 18:05 /dev/nvme2
brw-rw----. 1 root disk 259, 4 Feb 18 18:14 /dev/nvme2n1
# ls -l /dev/nvme6*
crw-------. 1 root root 240, 6 Feb 18 18:05 /dev/nvme6

nvme-subsys2 - NQN=nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:
\
+- nvme2 pcie 052f:80:00.0 live
+- nvme6 pcie 058f:80:00.0 live

#nvme list
/dev/nvme2n1          /dev/ng2n1


Run stress io test over nvme2n1, we hot unplug nvme2(052f:80:00), 
/dev/nvme2 controller is gone.
/dev/nvme2n1 still existed and io still running over nvme2n1 without 
error. Looks io test still
running over another path(nvme6)bbut we didn’t see /dev/nvme6n1 in /dev 
dir.

# ls -l /dev/nvme2*
brw-rw----. 1 root disk 259, 4 Feb 18 18:22 /dev/nvme2n1
# ls -l /dev/nvme6*
crw-------. 1 root root 240, 6 Feb 18 18:05 /dev/nvme6

With nvme native mpath enable,
- What multipath disk name we should use for ANA nvme multipath?
- Why IO still running over nvme2n1 without error even nvme2 controller 
already unplug?
- Shared namespace is still existed since shared namespace  has another 
controller on it?
- How can let nvme6n1 showing up after nvme2 controller gone.

Thanks for your help!
Wendy


