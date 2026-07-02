Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89089C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 13:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=47Pd3Uj9HD2qY0x+zNsdusogHoNUiQ6D3dx+S+4NXf4=; b=WH6rTb7aCoIq5B1l6ITlDxUtiD
	7vNNrl8/Z0EZg6py/82+KpDWm6kLKt5UBMQg65eyHrWj63N/bFREuPagDqGKsBtvZ7WKKCw91Gk2P
	UsUm20VTu2xmoZyMCZv9eq4PMLGW4Hm1PRstloFZgN0S5iw2MT7ifq/1tAjQHFjCv7tSlm2XTaQBj
	TUyA5bLY1PihOXFya1Nd1r+vTSgRtZOOP8g6sjtM+GFblXUHomTRuViEY0pjfMDncPqtncRRjQ632
	/h84U1VHFtSUPpU/z1JPmKyBu69570rK241FHU6H44Mt/pYfP69VlTjhFxEPFnNenY2Ues6ULZMFo
	CQ7W0L0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfHCC-00000004Ux4-2OKi;
	Thu, 02 Jul 2026 13:11:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfHCA-00000004Uwk-2oK4
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 13:11:11 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KsrK2647620;
	Thu, 2 Jul 2026 13:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=47Pd3U
	j9HD2qY0x+zNsdusogHoNUiQ6D3dx+S+4NXf4=; b=bSu+EdZHOmS3vv9sXspsto
	o8u4CEI8sYiN0Da2xZyrEvlq+cEDQW/y9zcjr3OM8rS8I4N0zuQgiF6U+G/ftxs7
	qBFyZ/lovI1GxaVIvzQZTXwmWSBQiIwAhRf5r9rNBo/Edh9QdIFfasFcvkBORWR0
	SRsbkaZgXFVdC5zB2etn07d5sb/gybc2ooRxuwSuaLDsJSkFRkJ4wazoJQEM2ka2
	DSIq8+d8SiZ5mNAurGx+x+X729Ly6pylwzXRopsro+ru1odDss/eXk4nBI556Kie
	ennwrjJWou2nsH1lupiI8ZfOSGa0r4OX7jEEfBCLIxEa6t+qebgpnYS8ehcPNjjQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qga1vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 13:10:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662D4cAb022972;
	Thu, 2 Jul 2026 13:10:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukc39w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 13:10:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662DApc752167148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 13:10:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCE5E5805F;
	Thu,  2 Jul 2026 13:10:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 244F458055;
	Thu,  2 Jul 2026 13:10:48 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 13:10:47 +0000 (GMT)
Message-ID: <54c163fa-91a1-4535-aded-4beee698591a@linux.ibm.com>
Date: Thu, 2 Jul 2026 18:40:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 6/8] nvme: export I/O failure count when no path is
 available via sysfs
To: John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        venkat88@linux.ibm.com, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
References: <20260516183709.269937-1-nilay@linux.ibm.com>
 <20260516183709.269937-7-nilay@linux.ibm.com>
 <3bfd53f3-16b7-4585-b528-6745ee64e980@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <3bfd53f3-16b7-4585-b528-6745ee64e980@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a46635e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=2Xmf6U6kyasj2lau3csA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzNCBTYWx0ZWRfX42H18qU4tegg
 fCFMzmRO5fu5Cljb8YkBoKY5zu9nXAjqzS49hcOOddheDhjzds4ia5pw56iGrndSExf91Qa0BrM
 YD7V18nge98xwppys9rzF9ijHsMbUko=
X-Proofpoint-GUID: rVK8hl6sFurOEzGjuggahh08dKieWx8z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzNCBTYWx0ZWRfXx9OFW880Lg4u
 g/2S/tu+K0ekUxxmLlMrXioeM/gcvGSUKHIRZ91TmJlxS2wiWRrTjz5aP0ZUHaMepxGDeP5tROs
 gxqUCcgTSOXtXVPY8trUvK4HG9eWygpj+0ymH4WW1alFyYKnYDRfMFsdXnukNE2cVGyUH1gGk7j
 CJ0p7R7qf/veyMq3EsKyFPxYdBoRnnAXG1jxb2Rw3dRduib8q6t7YrMLRrT48tJAI0sEGNyJDdW
 hP7SgH3NTqZ1T8l7lNE9untjTThATZRRqROotjnr0kOtHPw42YD7/WHl9ZM2i/Eq4AXl5GDBSAE
 QhnN7gZNaAvSmKUNAEyB9bnqPUvZybWiiRDkm8Y2tFDAA3x9PxOWIg2SloGHxhF4bUhNG/8k1KZ
 BG4pVF5Ut2PslmdndkaOWH6l8FyAt8oW3HIXTKhQmsRraX3H1Coi/ut8h4pDBxW+cQWE5+MPULd
 CfxRyyrc9IIhfBBOITw==
X-Proofpoint-ORIG-GUID: rVK8hl6sFurOEzGjuggahh08dKieWx8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_061110_740774_A882A740 
X-CRM114-Status: GOOD (  16.05  )
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

On 7/2/26 1:45 PM, John Garry wrote:
 > On 16/05/2026 19:36, Nilay Shroff wrote:
 >> +
 >
 > I'm just looking at this now for the scsi multipath/libmultipath work.
 >
 >> +static ssize_t io_fail_no_available_path_count_store(struct device *dev,
 >> +        struct device_attribute *attr, const char *buf, size_t count)
 >> +{
 >> +    int err;
 >> +    unsigned long fail_cnt;
 >> +    struct gendisk *disk = dev_to_disk(dev);
 >> +    struct nvme_ns_head *head = disk->private_data;
 >> +
 >> +    err = kstrtoul(buf, 0, &fail_cnt);
 >
 > is fail_cnt ever going to be non-zero? I assume that we allow the value to be stored to just reset the counter (to zero).

Yes, this is possible when the namespace head has no available path to
forward I/O. In that case, the counter can become non-zero for a
transient period before the namespace head is deleted. The namespace
head is removed once its reference count drops to zero.

The primary purpose of this attribute is to aid debugging. Under normal
operation, the counter is expected to be zero most of the time because
the namespace head is short-lived after all paths are removed. However,
if there is a subtle bug in the namespace head reference counting logic
that prevents it from being deleted, a non-zero value would remain
visible under:

/sys/block/<nshead-dev>/diag/io_fail_no_available_path_count

And yes this attribute is writable (as all other diag attributes), only
to allow users to reset the counter to zero and then observe subsequent
events.

Thanks,
--Nilay

