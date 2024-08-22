Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A59CC3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e2KeThm8c5bnYm6vH+93xF+syKa0YiHEABGNts5jRQo=; b=t93EuqGRi1eLsVJkNDtsD5+sqs
	UX+rfsE5O5lXG+pFjoB1OLFhR2gqTHG0map58MMzrTd/qvwEOhVNmzG7gO6Z+rFOXMAvT2JB8fhz4
	IXhpiY0ScMmwKINq9ZlQXHIIjnSYGiE3Dw1dDq3GZARP/7moU+8xvG4B7XAdjEH/atiSE1Nip8rg5
	SuevTGDJP9mN+WRWUmqZDMLUj8HycYg1WpPJGFCp1/PurjgBLpTU9SndhPneMb1pQRXTmAUn2bpJg
	0+/z7xx1sQg6NU/mfHg0bCuihNGCXk467lD91TPpTbqspBSqAkjkn09fvhcJsO7KcWuTcuhWkqHqm
	8EuO4xUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shAFH-0000000DUJL-3Rhz;
	Thu, 22 Aug 2024 16:01:07 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh9yL-0000000DNoH-3nvm
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 15:43:40 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47M578Y0027428;
	Thu, 22 Aug 2024 15:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=e
	2KeThm8c5bnYm6vH+93xF+syKa0YiHEABGNts5jRQo=; b=Atgnesln03HjEWO08
	8VJ5+YGOQnMM0IqkV8NyyDwCouS6XEKQZ63nKrgsBEOT+Svjb3farvKZS4hqCy6A
	S7u8GfudIdahyExQdKdtz5qrgRuZGVDJPwWUPo3mnyFO8cHp569ymJEP3vC9FWXz
	HTV1EVvOaXxqYtsOYbseFNH2MItEMmkSs74nr4kqYN5NYaVDFVl4gtQ+ow5ajFbP
	LlmhfsA/YpgOot/JfTzO9fCrTDioV9Iyh5UlG48eJwfw9dedUEaoFhOSSGUg4Lh4
	fWhYcsVcTwIW7DK5+Z6IKZdisPbvYHkWAWeqio6p1E3yb9mvr3J//KvpMvMIGCgL
	X6NFA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y214ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 15:43:36 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47MFd4FO024465;
	Thu, 22 Aug 2024 15:43:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y214wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 15:43:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47MFYuoT017663;
	Thu, 22 Aug 2024 15:43:35 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w3d46e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 15:43:35 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47MFhW6X11993608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 15:43:35 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C00DB58067;
	Thu, 22 Aug 2024 15:43:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E347858066;
	Thu, 22 Aug 2024 15:43:30 +0000 (GMT)
Received: from [9.171.17.129] (unknown [9.171.17.129])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Aug 2024 15:43:30 +0000 (GMT)
Message-ID: <20a3f01c-0992-45e8-8970-30a2747ed8bf@linux.ibm.com>
Date: Thu, 22 Aug 2024 21:13:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/052: wait for namespace removal before
 recreating namespace
To: Daniel Wagner <dwagner@suse.de>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20240820102013.781794-1-shinichiro.kawasaki@wdc.com>
 <d22e0c6f-0451-4299-970f-602458b6556d@linux.ibm.com>
 <zzodkioqxp6dcskfv6p5grncnvjdmakof3wemjemnralqhes4e@edr2n343oy62>
 <0750187c-24ad-4073-9ba1-d47b0ee95062@linux.ibm.com>
 <wf32ec6ug34nxuqjxrls5uaxkvhtsdi4yp2obf5rbxfviwlqzt@7joov5mngfed>
 <12fa9b5b-8a8b-42a6-9430-94661bfbdd21@linux.ibm.com>
 <wpapwfrmpkwxdqahiwvp5y6l53z2xuidc2qyloolzfundec3p6@vsuen2jtxot2>
 <a9a79fc9-6c0b-4a35-afea-85f34e9889bf@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a9a79fc9-6c0b-4a35-afea-85f34e9889bf@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LBeUGAE66jnqjsNjtBvTRF28ZD5dvFpI
X-Proofpoint-ORIG-GUID: Er2gZvnbPBC5bdS7nf3BvHySemqjvEhu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_09,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408220117
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_084338_221804_470F988E 
X-CRM114-Status: GOOD (  15.24  )
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



On 8/22/24 20:19, Daniel Wagner wrote:
> On Thu, Aug 22, 2024 at 11:59:35AM GMT, Shinichiro Kawasaki wrote:
>> I can agree with this point: it is odd to suppress errors only for the namespace
>> removal case. I did so to catch other potential errors that _find_nvme_ns() may
>> return in the future for the namespace creation case. But still this way misses
>> other potential errors for the namespace removal case. Maybe I was overthinking.
>> Let's simplify the test with just doing
>>
>>    ns=$(_find_nvme_ns "${uuid}" 2>/dev/null)
>>
>> as you suggest. Still the test case can detect the kernel regression, and I
>> think it's good enough. Will reflect this to v2.
> 
> Not sure if this is relevant, but I'd like to see that we return error
> codes so that the caller can actually decide to ignore the failure or
> not.
The _find_nvme_ns(), when fails to find the relevant namespace, it returns 
"empty string" and if it could find namespace then it returns the namespace 
value to the caller. And then caller (in this case nvmf_wait_for_ns()) would 
take action depending on the return value from _find_nvme_ns().

Thanks,
--Nilay

