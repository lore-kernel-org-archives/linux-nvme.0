Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D9D606A33A
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=n4UxP4Ty;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gj9WUalL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=za7z8z9lZ9fii1K97uc1umG0higoyE8X4ITJtDUfk30=; b=n4UxP4Ty0UZHPl
	ZVlalc9WbtgT+J6gQVpmNasXRhXwBn2QVVQSzI6XxSxHbvPZyAveWcaqfcUpBZNlqB2vj7CWNGf+J
	QxVOdniUFG6ITdQq1qX5S1xek4ibS7k90KzVRsM5uH9c1aB6NogSkwKMM+DrT/HJVBBUPqWj4EHMB
	dX8mbZX9PU1vZqaMceya6pqom4QS3BDFqijI/d0qhTtLpL8akDirSfgcKtbUUMZ5XlPyLz+sfikD7
	sbUJsIsLYOzJTCF105lKi39CtdA8AnQizaLE/5/V9i7CGEWjev6xuH85NWDOGAI2Ki+msJ/hp0HNQ
	uW7rP7tWlGMT6eS/uIyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTgeG-000000096gH-1ntM;
	Wed, 18 Nov 2026 14:28:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTgeE-000000096ea-1BLL
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 14:28:31 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQT7b1373696;
	Wed, 18 Nov 2026 14:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=za7z8z
	9lZ9fii1K97uc1umG0higoyE8X4ITJtDUfk30=; b=gj9WUalL+vdGRx7CdyBMCh
	JJMnSVPntF/23CTdKWrGmm/360kmJ1O0rpJ05zbQZnRNFFt+RXa7iTMz/JEB6dBy
	ojvNUu2GQ8Pksw1xWC0op/vaRDYKzbk7JvpDZarKTLqVPLqQcinGncDvJkyReI3k
	1hRruJbckpJy6QaQqdm1mSu1o/W4qy/2NadiDmfMjzTXQR1vMwHSoxRwilPC+cPD
	uULYDtg76fg8JaDomzbqa9VPMik+g7zbbE8/JdajKTRlNUQgDQHP1sfNE14X1CzS
	aal8hGW2pFG71REdv9adzsh68IGntj8mxN7W6EPC5ZSk1S2EWV4QmN8DftCVxQQA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105naukg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:28:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDZDg1975543;
	Wed, 18 Nov 2026 14:28:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067ng4ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:28:20 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIESJ1C26477086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 14:28:19 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADB9258056;
	Wed, 18 Nov 2026 14:28:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D70558052;
	Wed, 18 Nov 2026 14:28:17 +0000 (GMT)
Received: from [9.61.157.4] (unknown [9.61.157.4])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 14:28:16 +0000 (GMT)
Message-ID: <5dfddff9-2158-4660-8393-d0670fba5254@linux.ibm.com>
Date: Wed, 18 Nov 2026 19:58:15 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme-hwmon: notify hwmon alarms on the SMART /
 Health Status AEN
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261110110737.3965373-1-kanie@linux.alibaba.com>
 <20261110110737.3965373-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261110110737.3965373-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX57xMvitohYtR
 aVo1X94RY7lIx2rqCm79SRv0kVrXMdSdC4Gf4E5zm50dsg6Lwan0HgL8svnqO9CHcdOQP8Q5/Ll
 jR1rLRNtEohZO8yXgtqF5va+qkWT/V85cryaHHzRrXu/yb2AHxD5o8oGJZVprkGQCMfwYcbltgg
 m/hUNwOqFAbCEMvOwIFNWpn75zvRRUzxoMwiIial9hmNqfyvE/iUAZnDDJySoS1lSwvDpokQ91G
 OkRXptMLsRXrXUxVBvrMzJkx81MhE2LRAa1c56iEJqEk87t3xxOUssqBIdSUZr2Qw1I9Zwe0hsS
 QBVJNgyqbUbX1aUU9YuozABoN/Sr+BXholLwfqRuP/XyFMa/Kjfx70fV5fb3G5brfK1HmuHvucq
 M6fJk3ATeOfsjB8NspblUlj0Jdm2qFYzIdQnXjUOeyJ8M/mONeklTNNtXqHG8OxX+1rIy2n3S0H
 iI3vRCpQRUNGOtjFgSQ==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afdb605 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=SRrdq9N9AAAA:8
 a=sLrTT7w_miJAVR8UDjsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MQ-hISvJ2U3vj8qC12AKwNiRV8hkQ7Uv
X-Proofpoint-ORIG-GUID: W5efxOEIAf7-cH_OkCZDDmO1hAuGnM6j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX2fENf4zig91j
 FwEFuwhCvSHXWOHacKsqm36r0axLxjHcbS067iaFaJufCe831YCkLIXOzYffm5We6LodBtt8Ly4
 FDQyqTQJ+gDlHHPTufZ4FVGdgw/6puc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_062830_347790_A83FBDE1 
X-CRM114-Status: GOOD (  19.01  )
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

Hi Guixin,

On 11/10/26 4:37 PM, Guixin Liu wrote:
> The NVMe hwmon support exposes the temperature alarm as a plain sysfs
> attribute, so monitoring tools have to poll temp1_alarm to learn about
> a critical temperature condition. The device does send a SMART / Health
> Status asynchronous event when a critical warning is raised, but the
> host never enables it in the Asynchronous Event Configuration, and the
> completion path silently drops the event.
> 
> The temperature warning is bit 1 of the SMART / Health Critical
> Warnings field of the Asynchronous Event Configuration (feature 0x0b,
> command dword 11 bits 7:0), which mirrors the critical_warning byte of
> the SMART log. Unlike the notice events, it has no OAES capability bit,
> so the subscription does not go through ctrl->oaes.
> 
> The event stays latched until the SMART log is read with RAE cleared,
> so the deferred work re-reads it before the completion path re-arms
> the Asynchronous Event Request, and then calls hwmon_notify_event()
> on temp1_alarm. hwmon_notify_event() also feeds the thermal zone
> registered with HWMON_C_REGISTER_TZ and emits the standard hwmon
> uevent, which a plain sysfs_notify() would skip.
> 
> The nvme-pci transport completes asynchronous events from interrupt
> context, so the completion path only queues the work.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

I was looking at this patch and found the temperature alarm notification
particularly useful. I think this functionality could also be integrated
into nvme-top.

With this change, nvme-top could rely on hwmon uevents to detect NVMe
temperature alarm changes instead of polling temp1_alarm.

I also noticed that Sashiko raised a few review comments on this patch,
which appear valid to me. Are you planning to address those comments and
send an updated version?

Thanks,
--Nilay


