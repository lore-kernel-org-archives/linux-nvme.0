Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D03C3DA4A
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Aug 2024 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0SlVr6UWJIyoQfiErcr02ZaZ4YAX/JabeLEN6c+XaWg=; b=dfIWx2MuSRer+t5ylUuocF/VW2
	njWmRW1H1h+pjDhETJbMlz6vfcroGIG0xMHihg+1odnwy0v9+w5XhG3Jho2PNnEAoqnBpSaeRWLzB
	ehMAPcflhF9iAIMF7MF29E3UglJTWMmgbnVTRlDCO2h+kOXmGt5OOP4Vx27JrRId0HKgz8WeNB/8V
	vgmt2tW8wfdnz3BMCrax8UlPzFlCX/bzWegjBSULasRQ+vUESPYFKi6bFJhjv35+1qUlxVGPkbzPe
	trOQrIJQfjQYKV9QFb6/DqDkdhU+63dlxg1NHnvZJbK1PQC2P3oc0xWeo6UegEwH+90+El0D0+dXN
	v21eiZxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdDfU-0000000G1AP-48l4;
	Sun, 11 Aug 2024 18:51:52 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdDfP-0000000G19Y-2Dnx
	for linux-nvme@lists.infradead.org;
	Sun, 11 Aug 2024 18:51:49 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47BIJ4BB015482;
	Sun, 11 Aug 2024 18:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=0
	SlVr6UWJIyoQfiErcr02ZaZ4YAX/JabeLEN6c+XaWg=; b=djh98NkDdcQeqPdby
	+B1P3Gw9Ew8a/uaaPGeV93JXPsxuh70ZOLyPlbfv67jCMR4KxMLlbfoObUvjZpqv
	v/vfZcNzrpBlOEd8yoQ9jGEOZIgHn7GM9QAgjn6GIc1BMrHGyyfoWRZF/k5VBEnc
	VVand+gr1aDAK6Hb0WkhjbsuMzzVYoYgRZmNpwKvnJh9pcUaCtve0s1InFOQI0tb
	fl0ucBWGXtgDIuFkRs0rJOwfNMdqOwAgl+QZ/koGOzevpTnRwU/zK6Tsp1eJYdcd
	PUuhXIdYtojfx8Swhn4z3Xyo+tnuReiPAiov7/Q0C1+iv498DJxa9/VfAgKIiryi
	2SGMA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wxmju2gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Aug 2024 18:51:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47BFGjx4011508;
	Sun, 11 Aug 2024 18:51:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xjhtub5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Aug 2024 18:51:37 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47BIpYKq41878024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 Aug 2024 18:51:36 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B26A65805E;
	Sun, 11 Aug 2024 18:51:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6493C58056;
	Sun, 11 Aug 2024 18:51:31 +0000 (GMT)
Received: from [9.179.27.60] (unknown [9.179.27.60])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 11 Aug 2024 18:51:31 +0000 (GMT)
Message-ID: <5e6da341-3e2f-415b-bbd6-2aea420bf057@linux.ibm.com>
Date: Mon, 12 Aug 2024 00:21:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/1] Add visibility for native NVMe multipath using
 sysfs
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, hch@lst.de,
        sagi@grimberg.me, axboe@fb.com, gjoyce@linux.ibm.com
References: <20240809173030.2281021-1-nilay@linux.ibm.com>
 <ZrZ9WKimhqSJXGnn@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZrZ9WKimhqSJXGnn@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wTsradcQ_6SDRIpgaMWanD0N3GsKZmuB
X-Proofpoint-GUID: wTsradcQ_6SDRIpgaMWanD0N3GsKZmuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_17,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 mlxlogscore=937 impostorscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408110141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240811_115147_961725_094A2A27 
X-CRM114-Status: GOOD (  20.70  )
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



On 8/10/24 02:04, Keith Busch wrote:
> On Fri, Aug 09, 2024 at 10:59:56PM +0530, Nilay Shroff wrote:
>> # cat /sys/block/nvme0n1/multipath/queue_depth 
>> nvme0c0n1 423
>> nvme0c3n1 425
> 
> I am not sure this matches up to the desire for 1 value per file. What I
> thought we wanted was a directory for each path, so it'd look something
> like:
> 
>  /sys/block/nvme0n1/multipatch/nvme0c0n1/
>  /sys/block/nvme0n1/multipatch/nvme0c3n1/
> 
> And each directory has their attributes so they print exactly one value
> instead of the multi-line output. You'd know which path the output
> corresponds to from the file's directory.
> 
Yes you were right, we need 1 value per file but I thought keeping 
multipath details concisely in a single file may be then easier for 
libnvme/nvme-cli to format and parse. 

I also read in the sysfs documentation, "attribute file should preferably 
contain only one value per file. However, it is noted that it may not be 
efficient to contain only one value per file, so it is socially acceptable
to express an array of values of the same type." 

Anyways, I believe, most of us prefer 1 value per file rule for the sysfs 
attributes, so how about exporting multipath details as shown below?

Let's assume namespace head node nvmeXnY points to two different paths: 
nvmeXc1nY and nvmeXc3nY.

First we create the "multipath" directory under /sys/block/nvmeXnY 

The multipath directory would then contain two sub-directories (which are
the two paths pointed by namespace head node)  named nvmeXc1nY and nvmeXc3nY. 
In fact, these two sub-directories are actually soft link to the respective 
namespace block device under /sys/block

For instance, we have a namespace head node nvme1n1 which points to two 
different paths: nvme1c1n1 and nvme1c3n1.

# ls -l /sys/block/nvme1n1/multipath
lrwxrwxrwx. 1 root root     0 Aug 11 12:30 nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
lrwxrwxrwx. 1 root root     0 Aug 11 12:30 nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1

# ls -l /sys/block/
lrwxrwxrwx. 1 root root 0 Aug 11 12:30 nvme1c1n1 -> ../devices/pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
lrwxrwxrwx. 1 root root 0 Aug 11 12:30 nvme1c3n1 -> ../devices/pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1

As we see above, /sys/block/nvme1n1/multipath/nvme1c1n1 is soft link to 
/sys/block/nvme1c1n1 and similarly /sys/block/nvme1n1/multipath/nvme1c3n1
is soft link to /sys/block/nvme1c3n1. 

For round-robin I/O policy, we could easily infer from the above output 
that I/O workload targeted to nvme1n1 would toggle across nvme1c1n1 and nvme1c3n1.

We also create two new sysfs attribute files named "numa_nodes" and "queue_depth" 
under /sys/block/nvmeXcYnZ. 

# cat  /sys/block/nvme1n1/multipath/nvme1c1n1/numa_nodes 
0-1
# cat  /sys/block/nvme1n1/multipath/nvme1c3n1/numa_nodes 
2-3

For I/O policy numa, above output signifies that I/O workload targeted to nvme1n1 and
running on node 0 and 1 would prefer using path nvm1c1n1. Similarly, I/O workload 
targeted to nvme1n1 and running on node 2 and 3 would prefer using path nvme1c3n1.

# cat /sys/block/nvme1n1/multipath/nvme1c1n1/queue_depth
423
# cat /sys/block/nvme1n1/multipath/nvme1c3n1/queue_depth
425

For I/O policy queue-depth, above output signifies that for I/O workload targeted to nvme1n1, 
we have got two paths nvme1c1n1 and nvme1c3n1 and the queue_depth for each path is 423 and 425 
respectively.

Thanks,
--Nilay


















