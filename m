Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A88E77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 12:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kDcXmloSpokUGSnHnTZkh0q6XcD+QRLkYpsDhZYqux4=; b=jdOxPk5ftjDbRmYs64OWvmPWsE
	1P7qn31kWFwN4GfC4FR+DO/WqRy5wSwUAprKanPO9w3eror0F+7XEBE0MSe9F0D0yQXx9tYAKlEeY
	VXryWuYUNU5TCmgvRkYWeO4z4XSkLx9NMoMn/uOZZv6jyTrvZaxMr1j8xODLf2JFcEqX4bt7GDQue
	GDad8Of6NI2HrHBDfa7fT8EeitpBQFD35wdGITRyNFokCTdLDDFhp2a5VzEzeTeT0mdtBTin5LJwM
	y87Tej5Y5wu5eoPHJ9x6rmm/Ims5IXp/qKLjGrdaET/s+x4B4hNZR1tlOzgS/o1ez11dSD0w7rz72
	d5/pCGgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJXnC-00000001clm-3c1J;
	Fri, 06 Dec 2024 12:50:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJXnA-00000001clI-3WJ7
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 12:50:46 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6BUBP5011002;
	Fri, 6 Dec 2024 12:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kDcXml
	oSpokUGSnHnTZkh0q6XcD+QRLkYpsDhZYqux4=; b=TexU1R8ZRPsb3cToyvahC3
	Uk58N/VeWwJ9UrQQdYPG7R1JbWiM34Dxug6WzV7FGsADxlEF0zmLzNrrQoEG/Xwy
	xLQRexi0D6LmKVT8RaIgsxoUfUQxaMzSIJ2hm/b1JWcDzyFBuECOh7k14EuSeev3
	qJdtm1uvmdBQD97+OQrVs6qmKl1Jpi44Qv+b076nGdBVVDJqlyQK/ZPeqjjUSbhw
	weNjhqtX8E/C0A6u6UAwhMHrn9KwG8sxzIxpEObVD/SehB0LtpoVmokJZldGlu63
	c33cQZxsfsGEq4n2DUECjxgJhRaFh4MEwh+z0hGAJYYmChJRfqeC4BTn1gLfmG8w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bk99keuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 12:50:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B69mwKQ007467;
	Fri, 6 Dec 2024 12:50:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jxjb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 12:50:33 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B6CoWKt53739786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 12:50:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EB1B58058;
	Fri,  6 Dec 2024 12:50:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E408458057;
	Fri,  6 Dec 2024 12:50:29 +0000 (GMT)
Received: from [9.179.0.162] (unknown [9.179.0.162])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Dec 2024 12:50:29 +0000 (GMT)
Message-ID: <2d47ea9f-44bd-43b4-bac6-113b55f415e4@linux.ibm.com>
Date: Fri, 6 Dec 2024 18:20:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/2] nvme: add test for writing to file-ns just after
 disabling it
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com,
        chaitanyak@nvidia.com, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        axboe@kernel.dk, gjoyce@linux.ibm.com
References: <20241206111812.489140-1-nilay@linux.ibm.com>
 <20241206111812.489140-3-nilay@linux.ibm.com>
 <8b57ae43-e01a-4b08-9eae-bba43ba2c851@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <8b57ae43-e01a-4b08-9eae-bba43ba2c851@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 54kvycMA_yAZC2EEIpseYPAqLL8hcXWS
X-Proofpoint-ORIG-GUID: 54kvycMA_yAZC2EEIpseYPAqLL8hcXWS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=731 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_045045_023363_E2FE06A3 
X-CRM114-Status: GOOD (  11.58  )
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



On 12/6/24 18:02, Daniel Wagner wrote:
> On Fri, Dec 06, 2024 at 04:48:08PM +0530, Nilay Shroff wrote:
>> +		# disable target namespace and write to it
>> +		echo 0 > ${ns_path}/enable
>> +		nvme write --start-block=1 --block-count=0 \
>> +			--data-size=512 --data="/dev/urandom" "$disk" 2>>"$FULL"
>>
> I haven't checked if this was already discussed. Just wondering what
> --block-count=0 is supposed to. Is it the 0 based thing?
> 
Yes it's zero based field.

# nvme write --help 
Usage: nvme write <device> [OPTIONS]

Copy from provided data buffer (default
buffer is stdin) to specified logical blocks on the given device.

Options:
  [  --verbose, -v ]                    --- Increase output verbosity
  <snip>
  [  --block-count=<NUM>, -c <NUM> ]    --- number of blocks (zeroes based)
                                            on device to access

> Rest looks good. So feel free to add
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> 

