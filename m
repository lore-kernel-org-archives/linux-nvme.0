Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E13E87823
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 13:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ORAUrY7CCq6jnbgHciSir0WahqPaeKKQcXCTgEj0Tug=; b=emkSAM5H9jHhUu9zdDfn9H3Nho
	SkefykbRmWwQINoJQBPBxL30lYunlxv9Z1Y/J4NG6RPtNPSAIuQPGzOST9Jccw+0RKfBsYRRWZWEu
	n3YFuCRWIFGdlw3lrL6I3/vB4ON6U7gCwqTVg6zaMj5KZWlvBhqPGlFT0DitzCupe+qnVmdifYbC4
	Zmy4/IwA9ed1I3cBye2dNeHf9fMXJJ+1+YRvTJ1jdIpM0WmdcXbWS4IpLJQJWm/XWvYlfNzxwNSrY
	iV8nn8GWK8uF4YqllnJrVz1FB2lYqeKeeEej2tpPZX1OsSEgIJqjEKY78JnfGZQez3nKqJ/YkEKrg
	qCRUtVcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnG4O-00000006dZS-1CbR;
	Tue, 03 Feb 2026 13:03:52 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnG4M-00000006dZ7-0XTe
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 13:03:51 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6139ZIQq022223;
	Tue, 3 Feb 2026 13:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ORAUrY
	7CCq6jnbgHciSir0WahqPaeKKQcXCTgEj0Tug=; b=U/VRUbIuwKy/ZxZw6taqmD
	cadbMXW48kNMxhoxH5SoKcoLWJh9nr4FG/k2PKLFE62iBUiM+IS+oL2m7DSf3W/1
	iweCv81XIVJfGeitV/N7AN2Qh/rX2HZQ+vUs28i1yjKaWrAekdC44cWPf93h9K/b
	u2S976gZb4bLu1zFGVthfXfEvI2T5cDC13AGz8ObUNZCMKR3yqz6VSkTuT1PnxTK
	b17/LHjLJJ+GKZxQvsIEE1v/aL3qj1pmEdDT2k/+RP7FbrKEpW2+4Td+a13JXIRS
	ERR3qzREybD4NU3f3+EBAI6lQQvkzbCKD6Ln7lUpwWP6M7HR6v+l3hYDD/6E5e+w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt5d1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 13:03:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 613AsGls025696;
	Tue, 3 Feb 2026 13:03:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1w2ms6g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 13:03:35 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 613D3X6W24904210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Feb 2026 13:03:34 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF8C258061;
	Tue,  3 Feb 2026 13:03:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26BC358059;
	Tue,  3 Feb 2026 13:03:29 +0000 (GMT)
Received: from [9.111.10.240] (unknown [9.111.10.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Feb 2026 13:03:28 +0000 (GMT)
Message-ID: <a5a9cee9-361d-443d-ab62-662ecdaf0238@linux.ibm.com>
Date: Tue, 3 Feb 2026 18:33:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nvme: export additional diagnostic counters via sysfs
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
        wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260130182028.885089-1-nilay@linux.ibm.com>
 <CAFj5m9KuHZKoqRMeyM6UpoZsVrhg32stx5piEY4BBA-+xkiJPA@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAFj5m9KuHZKoqRMeyM6UpoZsVrhg32stx5piEY4BBA-+xkiJPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5OCBTYWx0ZWRfX9ONkztqxuKTC
 PCLkk4yg8IC4YMtw4eF0SDJAQEv7XVaHJavycXM7YQRd5Kb+FhbzIQbjVVvPeX+vKRREUD5JD3O
 rKb2xeMqQft7GgZYSOPLdX130t63FVU5xebmbPJsITHShsIgWyDxw2k2AbtmoZX/MeBqGHv+LLF
 48eqgfaUUXU/MTuBy0WBtzjwDmuw0wVydXMHtsIioEbvwXD4ZOj9Yo30Rnl2mSVxWQoi+lUoYKH
 nUpD8c0g3udnE26Y67F9qTuM8XNCrLed4kCEEXg5Bwq7Tt3zx4Z5QjtEhk7xC8TiMwI7dxRkURR
 69n1YyN5DGou9nIOBQgQDohRCqpSAAAnBh37PDR0dXst5zaTJ0p8hv2X3Tk1dj+qaEii7+Mc5ya
 6AW7alpPy2EI5tKRE7Pwc21RvcalgoSBSyycutqR6kPrcj+2V2k2zO+WCvbUJyi6MLTNMrCbbRA
 DWF9J9K/JAnrodLeSrw==
X-Proofpoint-GUID: DHXtQnKr4TSf41wWEdAQIYlaTj-H2Lcy
X-Proofpoint-ORIG-GUID: DHXtQnKr4TSf41wWEdAQIYlaTj-H2Lcy
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=6981f228 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Cw-_W6gQ4LCMQt-w7yQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602030098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_050350_192179_623D9D3D 
X-CRM114-Status: GOOD (  17.13  )
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



On 2/3/26 5:56 PM, Ming Lei wrote:
> On Sat, Jan 31, 2026 at 2:22 AM Nilay Shroff <nilay@linux.ibm.com> wrote:
>>
>> Hi,
>>
>> The NVMe driver encounters various events and conditions during normal
>> operation that are either not tracked today or not exposed to userspace
>> via sysfs. Lack of visibility into these events can make it difficult to
> 
> Not sure if it is true, you may get tons of results by googling `linux
> bpf observe`.
> 
Yeah true, and the intent was not to mention/generalize that _no_ NVMe events
being tracked today. The goal of this patchset is to export specific event and
statistic counters that are either not tracked at all or not exposed to userspace
in a consistent way, and that could be useful for analyzing NVMe device and
multipath behavior.
So this patchset proposes to track these counters (command retry, failover, errors,
I/O requeue, controller reset/reconnect etc.) and export via sysfs. These counters
are intended to be consumed by tools such as nvme-cli/nvme-top. For nvme-cli, in
particular, sysfs is currently the only practical and supported interface for
consuming such statistics. 
Once these counters exist in the kernel, they can of course also be observed via
BPF if desired. However, the primary motivation here is to make these events
explicitly tracked and reliably available, rather than requiring ad-hoc instrumentation
to infer them.

Thanks,
--Nilay

