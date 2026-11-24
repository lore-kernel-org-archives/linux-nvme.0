Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0D5606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=azThDw8C;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IIdZnNiC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Hk+1WeUZHedbU6UW8UjcAD8gpoCBmTCchZ7yxAalg50=; b=azThDw8Ci+rqfB
	NotvEvM+dEHfvS1S0dqoBg/9QptQ0ZE6joOCOWH+wEaGpJlKU4hiD988y7Jyzs7CWmNJYxQs1/Mgy
	B4G0b41s7h+WlyKK7IYl4ofOWD/o44OUEr+QxUsH4LSYhvf2bILrW2zIH/v9/czvg2sUcSgBRd8XO
	CSPyX6OFDejL9DcJJLrY+65beWm1QIiyv3jYHu7Kl1yrfZEAFXfm/ZMk5GVcTucuYm1REYSEK4Bjv
	zMNV3zeCcqyROSYU6QyfQp5S7cSvY1RvlLKtzSd9jK7NHk7SQyClx5/AnBVoglms8JCCQmliKMFoy
	cWpbdlNwDxxOuZcVSNzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVsPB-00000006t3v-3geK;
	Tue, 24 Nov 2026 15:26:01 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVsP2-00000006szm-0JDH
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 15:25:57 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOF4n822743212;
	Tue, 24 Nov 2026 15:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Hk+1We
	UZHedbU6UW8UjcAD8gpoCBmTCchZ7yxAalg50=; b=IIdZnNiCexp95CpvDYEUzH
	u+9rr7rK6iLJ5k7uTFhgl94i5GTNjcS/aikToMy2ssMvnDlE7OeUGKhpGFMH8Awf
	HzyLQ6v9wzfdfDftpais73dSJ8pKNY3KcicVwWY2ltDPKd0fzOlLq5rwTMosDM+i
	1Z0Z4iVGbYypxTBatXv/slcU+4iAz0h+plIWJ5CHbXPrJOfNxQCyyFGc/gbexPwH
	XpZoAgIB/wK1u+OJgJximkT9Woj1N+Zzj15RLYV2jH/uqG3AU5ktR+DeMNXfyyjv
	ruNBMduYjKFENm4/0DIaL9S0pdsGFSRcTN75nVpB0D5Ysh31xeRnBiAL7bkUAvyQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv7xsd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:25:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFJKHe2467765;
	Tue, 24 Nov 2026 15:25:37 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3quftud7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:25:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOFPaWd55836942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 15:25:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBE8B5805E;
	Tue, 24 Nov 2026 15:25:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A98758051;
	Tue, 24 Nov 2026 15:25:34 +0000 (GMT)
Received: from [9.61.113.35] (unknown [9.61.113.35])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 15:25:34 +0000 (GMT)
Message-ID: <4c21b2f8-6b0b-4728-af20-6d91bb13a6b0@linux.ibm.com>
Date: Tue, 24 Nov 2026 20:55:33 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] nvme-hwmon: notify hwmon alarms on the SMART /
 Health Status AEN
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261124120032.1824788-1-kanie@linux.alibaba.com>
 <20261124120032.1824788-4-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261124120032.1824788-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b05ac73 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=g5ZX1A3Pyp0KHW-r8XIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1OSBTYWx0ZWRfXzuxHjyVqb1cv
 /F/Ho0205kZ/Xf5EZKS4IuoJT7nsgUcY68HPht9P4lmJr4v7qRaMqV5KGZPdcHa3HQDE0LMZycF
 ++zA0ydj+1T0mnJib7n84mLBYupggas=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1OSBTYWx0ZWRfX78iGoToB1BGh
 gKOkD+TrNGE8dd6cWwP2WOEXYfRBnxtGQOe7iemKDWd/WDWvNX+vrhWiDV5zzur1MrJebf9tYpR
 z7Re/pB8oDZ8Bu3PpDRSj1wuiv+cWkv0dCRzXLUk1za+WdasN14g68X713C3+evycfnMzigAfF4
 msFN7FzYRzDSktXmGRMKSOJ0rhLlzPq47tWSQKsnr1UH6srCMGo66HsCEitm4MhY0d44oqMD3O6
 7ouLWZuZoKK8p0hcyFO4bSRgHRS9fjBuQc/vbHxtLV/xT9qsDxZcbz2tfSNxsVbuFdkw7iCxoQM
 mUeutLGwbpJRxtxhAZpw5BUF/QhbB3o3k4LGboIRmKwvfz5QxxWHvXGwHk02456gAf49Vmk/MIj
 eX1ALL33V+fZJwt+btWYyLlsRTJHc9yOylAgSbuFoqCQcpAtWWT33KEgQrs5HpkGUy359HCaqBJ
 LKHGGegvl/JrHICTAJQ==
X-Proofpoint-ORIG-GUID: iitE6Zci-jsAceZOkET7ujndk2I_wZWS
X-Proofpoint-GUID: Uy0kgNU6Xv5jNDtXCch5eKKhtYBwwVq8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_072556_109662_9BCD6D8B 
X-CRM114-Status: GOOD (  21.43  )
X-Spam-Score: -2.6 (--)
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
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 5:30 PM, Guixin Liu wrote:
> The NVMe hwmon support exposes the temperature alarm as a plain sysfs
> attribute, so monitoring tools have to poll temp1_alarm to learn about
> a critical temperature condition. The device does send a SMART / Health
> Status asynchronous event when a critical warning is raised, but the
> host never enables it in the Asynchronous Event Configuration, and the
> completion path silently drops the event.
> 
> The temperature warning is configured through the SMART / Health
> Critical Warnings field of the Asynchronous Event Configuration, which
> mirrors the critical_warning byte of the SMART log and has no OAES
> capability bit, so the subscription does not go through ctrl->oaes.
> A rejection with Invalid Field in Command falls back to the
> notice-only mask, so the notice events are not lost with it.
> 
> On the event, a work item embedded in nvme_ctrl re-reads the SMART log
> to clear the latched event and notifies temp1_alarm through
> hwmon_notify_event(), which also feeds the registered thermal zone.
> The notification fires when the event information indicates the
> temperature threshold, or when the re-read log has the temperature
> critical warning set, so that a transient excursion that recovered
> before the log is read is still reported.
> The work is only queued while the controller is live and is drained
> before its data is freed.  The nvme-pci transport completes
> asynchronous events from interrupt context, so the completion path
> only queues the work.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

