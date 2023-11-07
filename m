Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8624C4167D
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QrV7KPPQNlo9xPAidPGn+XCm2lqUfK/rXjEzmRapG6Q=; b=QFc2QNiQQwjV/BEVyd7O09Fu6u
	S5JkPOOpD0GBbw57nd3zU2lhgugwGT4SrkRWTLBnxXfnyduzbpG5fDKddvEZ8QwwZvbjKbjKE+iNN
	oQSlfu56R6v3vqvCpKbbTI/X/9p5hQajeO8yZAohMRuFhnhpNBThsE4vdEy5is6f1BaoovQ1HD4eD
	M7d1CWlEj7G8o4f98Ya6HWuFUSLZYZPY4LERDHxxQ/4eyhMEqsp/kwZtcHwtayaNPYnX2KIRzBQ7k
	joxuRx+9bHdV9rVhIdcNCkArNfRe8Nj5e3i9RRVVEhqyOwofIDcogm9k2z4DPZMhlA9MJVijTo7pw
	udc5NbeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0M6K-001bvD-17;
	Tue, 07 Nov 2023 13:26:40 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0M6H-001bt1-1I;
	Tue, 07 Nov 2023 13:26:38 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7DK46X032641;
	Tue, 7 Nov 2023 13:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=QrV7KPPQNlo9xPAidPGn+XCm2lqUfK/rXjEzmRapG6Q=;
 b=ZCVhjhpU1F9/FHtBaqdRRE9vSRw6t6C6Gsf3rG4056Omow42kkBOgRfvk0WJ/prXX6CJ
 jeqYldCajs2FKVHWktlZo7s5GR0Dn+lU1PD4IqwfjGVq5OEwc8ZSMXGBd1Vn5Mv9SbZl
 BR0VwokvKnXG9vLQHIwbazNiznxR8UnUvKEKGuIdtz0lrFlsf32sBnzAwIlTqpLMrHUo
 kIEo6/Qa0wupIdyMOTOvFqFEL0q7QLsHdVfxZbGzcHxCORm8QFPik8uNs0e2tBtXIRXr
 WaoIG0fueCZUbKDJXP56ccaozGa5MfdDNeo/MbOzs6N6NcCmy69SwrkkjiFp4jTcWPbe Jw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7p1cg6t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 13:26:30 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7CjMBJ007961;
	Tue, 7 Nov 2023 13:26:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u60nygxeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 13:26:29 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A7DQRwF29491864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Nov 2023 13:26:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42A6258052;
	Tue,  7 Nov 2023 13:26:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E027558050;
	Tue,  7 Nov 2023 13:26:26 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Nov 2023 13:26:26 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 07 Nov 2023 07:26:26 -0600
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org, Wenxiong <wenxiong@us.ibm.com>
Subject: Re: Saw I/O errors while delete/create/attach a namespace on nvme
 device.
In-Reply-To: <ZUn70pL+YV0adqd0@infradead.org>
References: <ee222a8c6574d754d7e6355591e1a06a@linux.ibm.com>
 <ZUn70pL+YV0adqd0@infradead.org>
Message-ID: <cf26ef634f3414927b98da2ebf1e66d0@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VsbDzEjyUwJO8XWRaiiJK84sQRcwTp5s
X-Proofpoint-ORIG-GUID: VsbDzEjyUwJO8XWRaiiJK84sQRcwTp5s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_04,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 malwarescore=0 adultscore=0 mlxlogscore=708 priorityscore=1501 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_052637_560628_E2878E45 
X-CRM114-Status: GOOD (  14.25  )
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


> What exactly are you doing?  To the Linux host code this looks like the
> NGUID changed for an existing namespace.  Are you deleting and
> recreating nsid1 rapidly and the controller is assigning a different
> nguid?

Hi Christoph,

Good morning!

Yes. controller assigned a difference nguid to a namespace.

Steps:
Executed nvme detach-ns /dev/nvme0 --namespace-id=1 --controllers=0x81
Executed nvme delete-ns /dev/nvme0 --namespace-id=1
Executed nvme create-ns /dev/nvme0 --nsze=1562805846 --ncap=1562805846 
--flbas=0 -dps=0 -nmic=1
Executed nvme attach-ns /dev/nvme --namespace-id=1 --controllers=0x81

Saw NGUID changed and IO errors when executing attach-ns command.

Thanks a lot!
Wendy

