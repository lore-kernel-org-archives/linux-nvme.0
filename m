Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F44C48BC3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 22:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:Subject:Cc:To:From:Date:MIME-Version:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=M1rHOdneW9D+Tz5IrbTVq64K4dn+honZfX+WmbPAO44=; b=XcSdRDuzHTQYk+63ru0UhNmoM4
	qk7D2PeB9/S3cm6/pTh4QcozLCax3JObVKwdSrD8rDE980vMaWTOGnctNlkBPBkW/2lrbxzKELg9+
	1EFODYlx3UnHZuMLul0r3l6+nNBSCIMedGy8D4N0or2DXgOVeACysAny5nphImi4O2baQATTcg+at
	nPCsMkWvd+dyOUhHVMdqfs7JMD/wvJUtkpUCN6fY4T4SBfCsTMCe3HU740Ky4GMZlWSNiLQQwGAQK
	aTWLU9SpZI7IWoSgd53bfS6RMQTYu4Yp4xJtQTAYDwcL63z32fNpxXnu6hmvwE+FYQGuqelbH9rIm
	wkHpZYWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcCRt-0000000CUTI-29Ts;
	Mon, 19 Feb 2024 22:49:21 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcCRq-0000000CUQ2-18Lu
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 22:49:19 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JLCdlB003161;
	Mon, 19 Feb 2024 22:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : message-id : content-type :
 content-transfer-encoding; s=pp1;
 bh=M1rHOdneW9D+Tz5IrbTVq64K4dn+honZfX+WmbPAO44=;
 b=Wc8Znwai8lTlPN4RmTZwx8u7/X/XuXQvDvmcmx9SOIqbolrG07QiycAtxEiel3YYiON9
 4IBd4odaLMQCTRaazt6a0mlWdb2jD01VoN74Am/Ozs42rDS19xtBLsmX0HM/XeqeqUKv
 TCSpQGeQz1MZVH3QvnJwRdRjDIAaTyAz9S0pTp02qStS30ePDpZ8OpPzRsS3QtNGzDsE
 IsojsEHZiraU+BVKuXaJxUFxR98hHUF2nodv5xs7z0TacdxZb/FGUySDrSUUb8mqCdi8
 cH05C6blfQLMCHSxRY/Kbn4f9t58DlKQXdtOidKphKUS7QBVGUtyaGIkXQFnNfpYm84A Kg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcepuskcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 22:49:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JMawn8017265;
	Mon, 19 Feb 2024 22:49:09 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mm49pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 22:49:09 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JMn6PM2949738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 22:49:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2F315805C;
	Mon, 19 Feb 2024 22:49:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68A985805A;
	Mon, 19 Feb 2024 22:49:06 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 22:49:06 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 19 Feb 2024 16:49:06 -0600
From: Wen Xiong <wenxiong@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
        Wenxiong <wenxiong@us.ibm.com>
Subject: re attach-ns causing IO errors
Message-ID: <75700e85137a40305238c74cf03bb677@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qRWGx7GvwzcS-7gXB3yA6IjKqd2kRHkr
X-Proofpoint-GUID: qRWGx7GvwzcS-7gXB3yA6IjKqd2kRHkr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_20,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=881 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190171
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_144918_436029_0C37AA5E 
X-CRM114-Status: GOOD (  14.31  )
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

We discussed this at the beginning of November last year.
Test team with extra ns-rescan, get new namespace back last year.
But they still ask if there is way not doing extra ns-rescan.

Consider this scenario with nguid changes:

# nvme list-subsys
nvme-subsys0 - 
NQN=nqn.1994-11.com.samsung:nvme:PM1743:2.5-inch:S7DDNG0X100093
\
+- nvme0 pcie 052a:58:00.0 live
+- nvme1 pcie 058a:58:00.0 live

After system boots up:
Nvme-subsys0  -> ns_head(NSID1/NGUID1)
/dev/nvme0n1 -> ns_head(NSID1/NGUID1) ->ns(NSID1/NGUID1)
/dev/nvme1     -> ns_head(NSID1/NGUID1) ->ns(NSID1/NGUID1)

After delete-ns /dev/nvme0 -n 1 -c 0x82:
Nvme-subsy0 -> no more ns_head(EMPTY)
/dev/nvme0  -> no ns(EMPTY)
/dev/nvme1 -> no ns(EMPTY)

create-ns /dev/nvme0 -s 0x5000000 -c 0x5000000 -f 0 -d 0  -m 1:

After attach-ns /dev/nvme0 -n 1 -c 0x82: I saw calling 
nvme_scan_ns_list() twice.

1st scan: nvme_queue_scan() -> nvme_scan_ns_list(), we got:
Nvme-subsy0 -> ns_head(NSID1/NGUID1)   -------> Note: this is old NGUID1
/dev/nvme0 -> ns_head(NSID1/NGUID1) ->ns(NSID1/NGUID1)  ----> Note: this 
is old NGUID1

2nd scan: scan_work()  -> nvme_scan_ns_list, we got:
Nvme-subsys0 ->ns_head(NSID1/NGUID1) ----> created this ns_head in 1st 
scan.
/dev/nvme0n1  -> ns_head(NSID1/NGUID1) -> ns(NSID1/NGUID2)
Then saw: nvme nvme0: identifiers changed for nsid 1  ---> because of 
NGUID changed to NGUID2
                    block nvme0n1: no available path - failing I/O
                    block nvme0n1: no available path - failing I/O

My question is:
- Looks only scan once during system boot up.
- Why scan twice when did delete-ns/create-ns/attach operation? 1st 
scan: Nvme_queue_scan is called from user space or udev?
- 1st scan, NGUID1 is old one, 2nd scan, NGUID2 is new one?

Thanks for your help!
Wendy

