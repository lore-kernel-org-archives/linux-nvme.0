Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06410606A337
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RTK4PiUc;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=lLAtocV3;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VSKOcRbF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=T8fuHfLLI/KBIIKp0NHewt25AgG0Iceb2ruvsdc0koE=; b=RTK4PiUc/xmbAG
	QHmFFbLWdvKInfLVAfBcScZsmTnMStg2h6BkIvVjiJW+rUfmJa/j3U3rblgHO4TitAYv9bOXn2ChH
	IFLQ8G4+7T8CLawb0UzNdt6t6eu1d5tbjzmYoGUjlN52t+v7EJms1Bpz0A7ZFV1K7HzbMi+NItTwR
	wwBR2v0ncf+D/rX7rpbtbsX90CSQKLw13yfSYFV7Y14aYeOBMmEyee+TUbcv1A1BHD6+25yoLLNiS
	SAlmlGRIsvFlCJHMWE77EziXwug3Lo2dztOGXQtIrxPUWDr6gEnXtd58Fk3IbzDklWcFl20wxeArL
	23JG0+jqRlbRBXSFskTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLgrW-00000004k8o-2Wuz;
	Tue, 27 Oct 2026 13:05:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLgrU-00000004k8O-15Zt
	for linux-nvme@bombadil.infradead.org;
	Tue, 27 Oct 2026 13:05:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=T8fuHfLLI/KBIIKp0NHewt25AgG0Iceb2ruvsdc0koE=; b=lLAtocV3iWiwKvYgpsJNVnn7aa
	TUroeu5Hk7o18PuLCwOx05WrIIo/it2KxKwKDk1JHXjz4J9zQSRlNRGjAHP7pMntpduW+Bn/Rsen1
	97JPQPGMJ7miq9Sau8f1q/2nEEqANUQ7tYs0Jn/sMzig5LwiqE9PzHoeZxB4MBPHqX9zEgEkiRo7s
	FwrtwaKhLDryFI7Etg6ITiCsQ486JRupPl+jXGON+91KyRNJPUFtfU2+nDEIMJNSqJuV6UQSIvfUn
	/SzkYIsN6ck1pIzWYGl4sx3/kPxb2GHnUZU/hueFda6G0GD8Dg+mpUQoVO1aPJjfpnTj1CMNK8kMR
	NxPgzk/w==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLgrR-0000000EzIy-0hsZ
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 13:05:07 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5iBHH1525005;
	Tue, 27 Oct 2026 13:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T8fuHf
	LLI/KBIIKp0NHewt25AgG0Iceb2ruvsdc0koE=; b=VSKOcRbFc+T1H/Y58aG9bT
	tb1J79A8dHwCT5MZ+77DJlIn93T4piCuaXWMvUxx7ACvBIXbFY6sINyGfxoleUiL
	1y1ihdM2ZqxVeU1FbucIwP6feaxA1KJMn9Y45Pnx/NWDssYQXgQhJHbOLSugh4up
	Briny4GADoBa4lLx3Cm57IOOy0AXoo74Emo65DXbEEoJHGVltQ6EIGTy+JGusS2e
	Kil08LWWRkfJ2cbaX2j6Us7IIdZcQhommwM6JUq6Q4xGjWsamvS/7FX28LkZmRO1
	s2rwIwoBbHHqI2l5To/5Yx+LSsPb/IME1UBl/dSFMEF4a5hJ9aqEcWFLle+X6LXg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavf069-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 13:04:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RD4BGA044432;
	Tue, 27 Oct 2026 13:04:52 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh1r043-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 13:04:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RD4q2a21234216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 13:04:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57B605805A;
	Tue, 27 Oct 2026 13:04:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5DBA58064;
	Tue, 27 Oct 2026 13:04:49 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 13:04:49 +0000 (GMT)
Message-ID: <782141a0-1ac6-46de-995a-24d5f9f2b8f7@linux.ibm.com>
Date: Tue, 27 Oct 2026 18:34:48 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-tcp: Validate the queue state under the queue
 lock in the address attribute
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261027123950.3122316-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261027123950.3122316-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae0a175 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=jba9WidwSOGUWApDYBoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rc1h6R20btw-gi007CiM6qo2XYHDzCNq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1MCBTYWx0ZWRfX93CwM6ybUDv7
 8wesn1226VdVa5fTCV/e/z1poE8QjWUnGhlhR/lnf6zsbCibrfcsG6rBC7q1H1Q0me3Z2NVNYae
 sX/CY1ZUIq9FeIWTDAEFhD+X6S8bSG4=
X-Proofpoint-ORIG-GUID: 8azURX80DqOlNQhCAZkTwhg4kK4dwtMY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1MCBTYWx0ZWRfXxqYog4bqqs7v
 K3FDaBE/mjJHoj5zTatkllB7xjI26Y/dOnlVg8NOJEdOLGBif4admNzCnHQPLjBIKar6gDc9dkk
 j3cla14ahM6Phi6G/XFOG+g2Jc5QM1K+zba0ql1jzZrx2dB5ldr7UtrEU4BsJlCRfSezJ93FTN7
 V5SB54J9i5HCKqVFKx3PyLAFwlLon6kl5zt/fP0titsMrOo4L71bi/VDbGiVeNsSWeKp/3Y0ISF
 m29XV/UMXRHTlmFc5EMCr7IeK8bqCRy8zA2KsQIqxTQCQv38QI1GpT1krGSqmnkbWZ9t8NxA00a
 eBvr0N2+95c/aUod7LPI4dUpYK7J3rst6Q6F676080vigbhkcBva2KQcpJ8nl7N/oljNugdGZuu
 dDUCGID/1VIUY3O+g+e+9eJT9y0DO8fB3xZb3M+8XM0gTOVAsbHUlIZGzeIQ2Cnfv9tIOXlyxS8
 l7OAqQtLsFmry4Ze5/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_130505_595114_1E1A2BAE 
X-CRM114-Status: GOOD (  18.92  )
X-Spam-Score: -0.7 (/)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 6:09 PM, Guixin Liu wrote:
> Reading the "address" sysfs attribute calls kernel_getsockname() on the
> admin queue socket, which can race with the queue teardown during
> connection error recovery: a reader can observe NVME_TCP_Q_LIVE set,
> then block on the queue lock while nvme_tcp_free_queue() releases the
> socket and clears queue->sock without holding the lock.  Once the
> reader acquires the lock it dereferences the NULL socket pointer.
> 
> Commit 76d54bf20cdc ("nvme-tcp: don't access released socket during
> error recovery") had the queue liveness check inside the lock.
> Commit 782373ba2766 ("nvme: tcp: avoid race between queue_lock lock
> and destroy") moved it back out because the lock itself is destroyed
> in nvme_tcp_free_queue(), so a reader arriving late trips
> mutex_destroy().
> 
> Check the queue liveness inside the queue lock, and clear queue->sock
> under the same lock.  The teardown clears NVME_TCP_Q_LIVE under the
> lock well before the socket is released, so a reader either sees the
> bit cleared or a socket that cannot be released while it holds the
> lock.  To also close the lock lifetime race, the queue locks are now
> owned by the controller: they are initialized with the queue array and
> only destroyed when the controller is freed, which cannot happen while
> a sysfs attribute read is still in progress.  The queue count is
> computed by the NVME_TCP_OPT_NR_QUEUES() macro from the original
> connect options for both initialization and destruction, as reconnects
> may shrink ctrl->queue_count.
> 
> Fixes: 782373ba2766 ("nvme: tcp: avoid race between queue_lock lock and destroy")
> Cc:stable@vger.kernel.org
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

