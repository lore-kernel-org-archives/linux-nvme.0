Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE23606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HIt+ulza;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hag4bK9M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VuA2I7NMVJdutfn6BKFqlvdE9aLLBu0the6fIUoQqhA=; b=HIt+ulzaDkOHSM
	jhF45jYtT5QKxtEkvNsVEYYaNvJE2JjLS4cN6AMeF8WQOZS2gzRKYhuQoBloTMhyZYub1i/Oa93Z5
	i/7fiD7K0RhHV69Ub4Ya5eRDBnYovl6k+zoCi++NMuGWt6U3UdS1OVV+Xmw+IIFM3cmglq/CAhEUp
	j/ExYy87OSKiNRf5aW2NLH3z0euRv1cW3NdoZlWik868Qfvd7vYYEXA7gnI6AcYxuu5hbC1fPNQYO
	o57wH6+zh9JSOJflXR2Kq0iqBzQI9v2tdrgrEZIdDSNMQ8zJn70xFveouIcAZQEQE2B0LsdSBNzH/
	1vTOJFcZ2Dp8n1pvJ5cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVlaC-00000005qws-0zpR;
	Tue, 24 Nov 2026 08:08:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVlaA-00000005qwB-0rpJ
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 08:08:55 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO34VCI3825815;
	Tue, 24 Nov 2026 08:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VuA2I7
	NMVJdutfn6BKFqlvdE9aLLBu0the6fIUoQqhA=; b=hag4bK9Mp39+3ypT63Xs6m
	L9haEg4PlFjK6mAbTjINzDT/YmJumNgIo5ofed4sZ/VylA6BMHT7RefDenz1Vwtl
	xPq4TZcWGwPs1hm/7c5Rb2B5tLQwVa44fYg2hMQquU9WH9424LG1OFuMgnhU/ag0
	xIpgY8eI2C7sFPOtYU8tfDgkf7mm011JL8+DZqYnT3kQSmkFme73ALUVeW7ALcN7
	ZrAVuLqaDIi47Q1ukF8uF8xrEYiOWDfh/8CnJbQtuQQrQbcfq1ZVkze5v1nKmYjX
	7/ZVZDGKxfqcJ9ZtmcLqf4bpm9svtnJGiEAw2g2E57ISXgD3nuTQ+NEBfwDVSKzA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g36qq0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 08:08:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2nHYg021873;
	Tue, 24 Nov 2026 08:08:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmk1trg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 08:08:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AO88eBS14221954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 08:08:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6502C5805C;
	Tue, 24 Nov 2026 08:08:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 187435805E;
	Tue, 24 Nov 2026 08:08:38 +0000 (GMT)
Received: from [9.61.113.35] (unknown [9.61.113.35])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 08:08:37 +0000 (GMT)
Message-ID: <47f4ec19-9e86-45f4-947a-6e00d0bf9c06@linux.ibm.com>
Date: Tue, 24 Nov 2026 13:38:36 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme-hwmon: notify hwmon alarms on the SMART /
 Health Status AEN
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261123112342.2761131-1-kanie@linux.alibaba.com>
 <20261123112342.2761131-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261123112342.2761131-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b05460a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=0TV61TdiYlVJGL05wkQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMiBTYWx0ZWRfX28jvXy7QVhPu
 d7qPVy1B57EoNeiC/lsFEP1LLZ6AFh7vFPVHhM3nL6pOVVfx4L6MUFfauABvJqt+7rmkmuqUk18
 OoT/Z7fyB9a+eQ4eVpy3Sz8kgphMVbU=
X-Proofpoint-ORIG-GUID: 7db3_WCWPwlguKx7X3LGNapnGZHfRhgS
X-Proofpoint-GUID: CE_Ny1EE014ohpt7vXcKMU3LPD1R2Gsw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMiBTYWx0ZWRfX0qtizYtYmSND
 aUHOHNvc4JbjrhDHM+4ibsBn9kRBkV3Cskb8gPRorLlqzf3kNWuPwktjOmPBhdcdyMMLOKmBefF
 NgWzVtkSOivbCTQ4OaD0+y4y2Gw7H4Iu5WwElsTmlPSG/rm/TjWJqTyr8tum2eDcs1o6/JptYyh
 y/cQEo+6/j5TGRWAu1MvqxMl8k4V8nAyYAiSu5/SlFSBwQox0oSOmgofPmGgl1QrOZOxVNl2GlS
 Npv5h4WzGiO7tQamWQJzaV+sZI+yuq3yKJ+kVoWERKM73dJB1cnE8jWB+LsC2I9xtqWJAX6gUZj
 3FvvtmRzy/v0vKvkYeoTXWAiECqmzLRjzFeDKcz1Til+mnxzENv39jha+jRHcKx809J8Qgo2Kwf
 fCORmJHmotPr9X81VrGdaUOaf7wjGjYXfiGMMQ5uf/uq9zYMRtD+l+KlFSBHozHYwZFR3XaO2QQ
 fsPEbGPpabvEdTOlD7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_000854_251707_0F33B328 
X-CRM114-Status: GOOD (  18.58  )
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 4:53 PM, Guixin Liu wrote:
> +static void nvme_hwmon_smart_notify(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl =
> +		container_of(work, struct nvme_ctrl, smart_work);
> +	struct nvme_hwmon_data *data;
> +	struct device *hwmon;
> +	bool warn = false;
> +
> +	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE)
> +		return;
> +
> +	hwmon = ctrl->hwmon_device;
> +	if (!hwmon)
> +		return;
> +	data = dev_get_drvdata(hwmon);
> +
> +	mutex_lock(&data->read_lock);
> +	if (!nvme_hwmon_get_smart_log(data))
> +		warn = data->log->critical_warning & NVME_SMART_CRIT_TEMPERATURE;
> +	mutex_unlock(&data->read_lock);
> +
> +	if (warn)
> +		hwmon_notify_event(hwmon, hwmon_temp, hwmon_temp_alarm, 0);
> +}
> +
We only generate the notification if the NVME_SMART_CRIT_TEMPERATURE bit is set
in the SMART/Health log page. However, consider the following scenario:
the host receives a SMART/Health asynchronous event and schedules smart_work, but
by the time the work executes and reads the SMART/Health log page, the temperature
has already returned to the normal range.

In that case, the returned log page may no longer have the
NVME_SMART_CRIT_TEMPERATURE bit set, causing us to skip the notification
even though a temperature-threshold event was reported.

Perhaps we should also examine aer_subtype and, when it indicates a temperature-
threshold event, generate the hwmon notification regardless of whether the
corresponding temperature bit is currently set in the SMART/Health log page.

Other than this, the rest of the changes look good to me.

Thanks,
--Nilay

