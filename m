Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0449CC43458
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 15:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y7KG3aWVjjABvFSsEvFOYonDBZJARoHq93Z0Ub8cgZo=; b=v69ZqPyLpEthq7so5Y3sknx6vE
	h+wimtiWbNFyNMRyez6h+q19FZxGKL73zFrg1e0NHAt0wgsYfTDA2rs9twtTYEFyVeiwJw2aGD+zj
	xIkkhnfeGBfbgENSSthkFB6iY25TywZZWGrvHwtIAgyVHpnAJUwvt0OHSSP9ypm7x0HrTJcKruIY2
	CT9zBoJJEkNmpm69NNElqDwoestrO7jWFP66Jw0wShL7GyXx+uIeBiTinjg9gtmnCxeS3S241a84l
	gREV/6jeaApkKF1Uu3DF0d+KmMh/BAKHAzqRVvrEcASKTg/eR9fv6Eiri8CMvMQy46bqMq3miJBzw
	mrwbGVHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd8bG-0000000BYnT-2L1N;
	Fri, 26 Jun 2026 15:36:14 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd8bE-0000000BYn7-2xdg
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 15:36:13 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QFIUVc3356640;
	Fri, 26 Jun 2026 15:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y7KG3a
	WVjjABvFSsEvFOYonDBZJARoHq93Z0Ub8cgZo=; b=PVwipafH3y9n7kalusfKK7
	HyTq4Fsu80RlrClmsVhMLW2Z7FdwXIL5AoKRjN7O7ORDAAbnkblBBYi2Ah1do2St
	uXd3MDNhsf8PNVPZgUqlnyhNNIHGdG/AK9TTvHeB5Du2eWp/5Tzrwq8oJk5qhTx1
	+RQTCsonDJrFWQqqRqwXYxTvgu6PNoQjKn6p4Px6MqxwNynXJS/mJBdVpQwir+ux
	F1fz1k6wmxGPAqCVoALaKZ4mj5eRsMzp0A2jrJ1U1SgTBxD65Lej5I2IMWrxav/p
	czNiMkuNOx8iZBxBGZYCeHc4t4dsfJzb+kfL30p7Jn7pMrPNa48lgmQOdrd2BMtg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4yu1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 15:36:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QFYhDJ032160;
	Fri, 26 Jun 2026 15:36:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dgkgug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 15:36:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QFa2k125363154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 15:36:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B6F558057;
	Fri, 26 Jun 2026 15:36:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D43758058;
	Fri, 26 Jun 2026 15:35:58 +0000 (GMT)
Received: from [9.43.54.234] (unknown [9.43.54.234])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 15:35:58 +0000 (GMT)
Message-ID: <b0be30c3-e2ab-47cd-a07b-aa9e82ece233@linux.ibm.com>
Date: Fri, 26 Jun 2026 21:05:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 05/17] nvme: add Clang context annotations for
 nvme_ns_head::current_path
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org,
        elver@google.com, gjoyce@linux.ibm.com,
        "Paul E. McKenney"
 <paulmck@kernel.org>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-6-nilay@linux.ibm.com>
 <20260626064050.GE10731@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260626064050.GE10731@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyNiBTYWx0ZWRfX+uFy4oRBkDym
 gHUdO2s+NUWbD8uOJd2+yjUuk7rPKhgloqH414V1nCKneQK1QAshpp3X2ODLCtLpleRHwFdlblt
 KcjRZantts0Kom7FeVZAvyAKXAUv/h0=
X-Proofpoint-ORIG-GUID: LY265qMJR9Sw8jd4MfJuNc7vSmemCWLf
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3e9c63 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=XItdjK9yAn4fJZ3DEfgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyNiBTYWx0ZWRfX9sxdDc+Et21Q
 NeNrznx1bFgrRzeehRFhuvKruwPT9NgDtvh7TcuPv4P/IM6RGnqAeun2x+K84lnwIr7zv3nl/uO
 TuBOIuDl7bN9MYZO1A8BJ8Qz/AIz86Es71UueMP2wpxBNXKTWmOcswMX3M2GnVJ3xwj0zbCYp/k
 Qd/i4yIx4k0KsRN0QrdDLI49I+SXLEZduKMPczyjOFR3qph6UPYY1K99VWiE+ZmDOykAyI0KUMO
 dVgaLcolq9iaa+YhZiCXiWK7ew05cPaR6QYW+A6fxgF6231mxD95skTIxDTkXHmYxLIFHNvlr6A
 3Nvs9pil7y1O1/dcTIbB7Jb48gTtyuAH9Wy9xzhmTrcYuKRS43+YFZDRE3DOmUx6W/Y89WTrNLO
 EaQtA4NjUY40pt8ZwRp/0f4kny5CFBe13oclo9pls7Kh1YGq8swumHSZ58E8BZ90DcIpXe5RvGX
 rHt3nnsInkyDguXkN1w==
X-Proofpoint-GUID: BFcLJFWfqu_havzfDW9BQ4CRac9ixr9l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_083612_776225_668E00A0 
X-CRM114-Status: GOOD (  18.80  )
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

On 6/26/26 12:10 PM, Christoph Hellwig wrote:
> On Sun, Jun 14, 2026 at 06:45:20PM +0530, Nilay Shroff wrote:
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -231,8 +231,16 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
>>   	bool changed = false;
>>   	int node;
>>   
>> +	/*
>> +	 * This helper is used by namespace failover/teardown and I/O policy
>> +	 * update paths. We only compare the head->current_path[] pointer value
>> +	 * and do not dereference the referenced namespace, so suppress the
>> +	 * context analysis warning for this lockless inspection of the
>> +	 * __rcu_guarded pointer.
>> +	 */
>>   	for_each_node(node) {
>> -		if (ns == rcu_access_pointer(head->current_path[node])) {
>> +		if (context_unsafe(ns ==
>> +				rcu_access_pointer(head->current_path[node]))) {
> 
> I think we need a helper for this, as for a simple pointer value
> comparison without a dereference we don't really need either
> rcu_access_pointer nor locking.
> 
> Maybe somthing like a
> 
> 	rcu_compare_pointer(rcu_pointer, nonrcu_pointer)
> 
> ?

Probably a good idea to have such helper. And if it's implemented
then it should be wrapped under contetx_unsafe() as is done for
other rcu helpers. But lets wait for Paul/Marco to comment on it.

Thanks,
--Nilay

