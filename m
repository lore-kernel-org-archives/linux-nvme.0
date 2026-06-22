Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C015ECD98F6
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 05:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+z79SEjSr069dlSxaoH/nQITPA3aGi+YpAdKxsS2wCI=; b=Wi976IpIjtQh7//rL0VOqS9cDV
	kqs3v2YXSS4YoQ3AArglXSgw4gLNFedRiFeso1mQdNqwgRAZcsVYbdmk5MJrgYvoXJmwjvDmQQvbp
	rVIaOTBV0EptvLu5m+8kmpr21Bts0Cxpx3mXoHkJ0C/aukRhtXCW0gOputUH6Heze+S8kj/kRqwFg
	baQaTUk7Zrzm4+a7G5qP5rWWRcpUyxlfq+kBaAFpl5ZwBaMyaKK19xUOXEWX7oyJo3Fd+MU+FnGwv
	BFAh+0a2yxhe6pa3iUztOiGl5A7epptu4R5pMCBX2QAsaAVIRutS6Bx04fIwWz7E9AacrcM7x7ULr
	RzrxSC2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbWw3-00000004QMY-0fJk;
	Mon, 22 Jun 2026 05:11:03 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbWw1-00000004QLs-05R6
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 05:11:02 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65LEICI74090893;
	Mon, 22 Jun 2026 05:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+z79SE
	jSr069dlSxaoH/nQITPA3aGi+YpAdKxsS2wCI=; b=N0vj9mMwozD3001lJ0VRKX
	qKvKqc1oSNZ5KhLsEgrUjnEXA/z2gR5llW21kFg6TiwBxKIcJBiQjbpOwGaC9rp2
	q7YtzuP/G/4D8OOEFvINQdlMZL3lQtfbPDQv7iQLQPN4vyc1bdvZOQB52g/HGq0e
	gmWl1liL6BDCCeTH45dOKs28J2i3zXODNH38RuojEzCnkG28l1LNOMKolJkKiAeD
	I/AH6Tz1sWiYpzWHfnbi7asMuf2gn3s+hIMgDbm0mZaKQbKbcYQ4WGC3fvkScTN3
	XVSJ/zloV7sv2AMGK09MoKZ2Lsbjg3KlkX894n35Rc43A8ZNbMIm9mlTTfBDZ20A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4783m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 05:10:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65M54dIx006329;
	Mon, 22 Jun 2026 05:10:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyc6n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 05:10:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65M5Ac6q65601888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 05:10:38 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A175A58043;
	Mon, 22 Jun 2026 05:10:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A0F458053;
	Mon, 22 Jun 2026 05:10:33 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 05:10:32 +0000 (GMT)
Message-ID: <38c7c98a-03cf-4c35-90d5-d7557eaa8a4d@linux.ibm.com>
Date: Mon, 22 Jun 2026 10:40:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: expose path_state via sysfs
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
References: <20260617121543.2291455-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260617121543.2291455-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA0NCBTYWx0ZWRfX4UIcIZRVxvSM
 wu/l3AzVb2X1KlFe2UYy565ktS1MrInU0c82JJ1LfUorQhyVyoC3YT42RZhGt4h2+yAZgS9VTKu
 op76KZF8pkQNT8ynRUV9R/rvQes9niw=
X-Proofpoint-ORIG-GUID: YjyGRfRAjapyrMa78bBJWd6Jg8nwUILA
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a38c3d0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=SRrdq9N9AAAA:8
 a=vMYqDPKrJP85V8vt8vsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA0NCBTYWx0ZWRfXyRHjXGj5WRTN
 26oHkJB0vRQ/2p4nWvpgdz90ehuWzBn28TOd1c2n24fmp97dS1jrNR0xvFVjmb5/EXpHm1vWqhB
 +vVeyu0SsBmDsCA7dmLKA37OiyucOIObui/QxKimstM5+igbwnsarVuVq8pGPcGBxce+WR428+G
 5MPIJUJsWdXsFdMt5pgCtcA251WoOEfzIwL8sw9vpwjmbnz/qRHtTv+3uq6cVyye3RSQVnZskCE
 FLucSvtxDvcqJyT8D/B35YJjjYHECzjM12MzYfrd4zrtmRb5OrJ980L9+sucSWCjB/s7Bv1GnWC
 VJOITIU3ZFRmCkGpO8iekQtcouPVcGtyEmnzGoNp/DZOwskcgCtac/Ab3GX2JuHDX9KHyPbbi/c
 JbFVwmiWJfDXYBK8V92xy+bKDic5IDPWIs32fUeaQzMQM5bQYofGlAfSqTmwC4Azd44DHl4KNaM
 T5Nj66wJbtVUhzzddbw==
X-Proofpoint-GUID: WpHLbWauBnZ710WDRvzardj65RfcRswj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-21_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260621_221101_077331_B3C287C0 
X-CRM114-Status: GOOD (  24.82  )
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

On 6/17/26 5:45 PM, Guixin Liu wrote:
> Add a read-only "path_state" sysfs attribute to each NVMe path namespace
> device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes whether
> the path is currently enabled or disabled.
> 
> The attribute reflects the result of nvme_path_is_disabled(), showing
> "disabled" when the controller is not live/deleting, the namespace has
> an ANA state change pending, or the namespace is not ready. Otherwise
> it shows "enabled".
> 
> This gives userspace visibility into the multipath path selection state
> without requiring users to piece together controller state and namespace
> flags manually.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/multipath.c | 10 ++++++++++
>   drivers/nvme/host/nvme.h      |  1 +
>   drivers/nvme/host/sysfs.c     |  4 +++-
>   3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 81fff2f20d23..65bd3dd188ee 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1210,6 +1210,16 @@ static ssize_t in_flight_bytes_show(struct device *dev,
>   }
>   DEVICE_ATTR_RO(in_flight_bytes);
>   
> +static ssize_t path_state_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
> +
> +	return sysfs_emit(buf, "%s\n",
> +			  nvme_path_is_disabled(ns) ? "disabled" : "enabled");
> +}
> +DEVICE_ATTR_RO(path_state);
> +

Instead of only exposing disabled/enabled state, can we also expose the
reason why the path was not usable?

For instance, path_state attribute shall expose "enabled" when it's
available for I/O (this is straightforward):
- enabled

But in case path is not usable/available then expose "disabled" along
with the reason:
- disabled (ctrl_down)
- disabled (ana_pending)
- disabled (ns_not_ready)

Or any other combination depending on the ns->flags and ctrl->state.

That way, the userspace would know the exact reason when path is
not available/usable for I/O.

Thanks,
--Nilay

