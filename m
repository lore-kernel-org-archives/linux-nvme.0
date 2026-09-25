Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5329EC98321
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fdfR8kZ6pdKMhQG10IVoMmg6ADasUtzgAjEjiMrrxkQ=; b=gG+Yb/pig0nA7FT3wgn3mKaeXl
	s8WASI274HJ0S2nN0efcumMs0cfUgLsd0J/yzbp/DrZdw4Af17iB8ljQkxRdHMUAatj6fKRx3YBT/
	0qRpvFCXJDIgd19mVMAkQBEsRMn2ASfGVBrpW67WGjLYiKlmKIGHVXrLHQ2iOdAeF8on8o880lq68
	JZqQtfSPTt5JDdH6FJ4VR1I5TSUJgjMyTlfy0OqWeHXcaPa0mRkOr4Td72wXyzrQ+cmBxqf87/uiv
	ovKPuK/NmTrQ/L+wY2IrQXHbgOhL4RS7IUetj5yFkHtIZuKeCaAJzPmdf4AML1mqurXpAb938uLjl
	wlCSrKdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA437-0000000DBq3-3URf;
	Fri, 25 Sep 2026 11:25:05 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA435-0000000DBpC-05EH
	for linux-nvme@lists.infradead.org;
	Fri, 25 Sep 2026 11:25:04 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aKvQ074996;
	Fri, 25 Sep 2026 11:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fdfR8k
	Z6pdKMhQG10IVoMmg6ADasUtzgAjEjiMrrxkQ=; b=AyHU2WW/3/aUTV1dAcmjCX
	GNE80Ec6LSFZod4anONbj5tJECPskUhjIQUadgpnIrWhI22Ne70aK8TjGX711qH8
	SMT/3DxEtiUr5r2eL7J38CgFO//IQ7dLqqtyqVXKm4I39DhkSRyMXUYUBksoKsrn
	JSCYMNnzqhf1fMniYJ8cwrpyee+B6QPWwch6CkEY3wPdciVihbv+QvTrxpsoHgvm
	k9sNjq8E84vIKWCXqvEXza5sEavFH0Lh/413Po0xLKi8hqn8DHs6IPo3HA1ZiojH
	shmsG4D+A3/6S2NOxyEkNn0IBOTOph6XmkciwhsWm8Foc+veiSwe+vrO7b/jnKBA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2xubs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 11:24:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P9xaLj1959492;
	Fri, 25 Sep 2026 11:24:56 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7eee49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 11:24:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PBOuQO30933688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 11:24:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC9815805B;
	Fri, 25 Sep 2026 11:24:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1A3458059;
	Fri, 25 Sep 2026 11:24:52 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 11:24:52 +0000 (GMT)
Message-ID: <6cd61a1c-d585-4b5c-b72e-2dd11ce07279@linux.ibm.com>
Date: Fri, 25 Sep 2026 16:54:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvmet: return Invalid Field for invalid NSIDs in
 Get Features 82h
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20260920033500.3209138-1-kanie@linux.alibaba.com>
 <20260920033500.3209138-3-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260920033500.3209138-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 8omGjIShvTtIQVwB4bLIAak9-5yL8Zih
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab65a09 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=7c2VuN2EFasamBEkFFEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfX9ItsA6pQpVfq
 ss8YvNguzj59z+UIVfG/X4B+9kP4k7U6GXP5Pnazp8Wfz33M2vJ/YBIwvXz2Lh2gONSRX3z+wNL
 TdsztXCQL1K0MRTWqsoSc3P66+zCOb/kdVrgJZ1FazzDDxvgf1DAOCxUeNSyvy5wq5ySexaCCa0
 ExzzmTF3/5n9DZCeGHYBRhrLd7MYVca1NEE8imRNkEhk4VIsZaUso2zxwvGXAa6kj/iBMO3FQdO
 hSGv2EUzHKWFqS1BZoo8rLMhUml4WM71scAB4FihX0M9BHAFYHyUYIhIu5nHNg17e2I/HJRMS8r
 hsU4xd48eFGcnxHaj5qwqaOFEJ9u2Q83P3+97JkYojeude/sTIzZ4JrT5HAbqN42ApHIsv4YeHC
 tLZL8tBi+P6Kbx8l5Y/Pn38ZlTl8Nuw8Jc34QrgnpXmbfxkUOqEtykNP1azO5lQl0MLcffOZUvU
 CFD7MlTuY6OqaxSFb2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfX43rIOXPo3sR8
 sil8nDJWviZq3lAjKLdD4J0kVbPAAkbJKvgKYnyDATcjaPiJa8bUXyOBccI0BhHORo7ZL7tdUGU
 dFX2NUxOjmLi+qLae3urwxhDfgOluAA=
X-Proofpoint-GUID: AQTfGsolmLIFX6DiVystCqt42acv3yED
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_042503_073768_B601261D 
X-CRM114-Status: GOOD (  16.12  )
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

On 9/20/26 9:05 AM, Guixin Liu wrote:
> The Reservation Notification Mask feature (FID 82h) rejects the same
> NSIDs for Get Features as for Set Features, plus the broadcast NSID:
> 
>    "A Get Features command that uses a namespace ID of FFFFFFFFh
>    shall be aborted with status code of Invalid Field in Command.
>    If a Set Features command or a Get Features command attempts to
>    access the Reservation Notification Mask on a namespace that does
>    not support reservations or is invalid, then that command is
>    aborted with status code of Invalid Field in Command."
> 
>    -- NVMe Base Specification, section 5.2.26.1.33
> 
> The Get Features handler routes the namespace lookup through
> nvmet_req_find_ns(), which returns Invalid Namespace or Format for an
> unknown NSID.  Both rejected cases land there: a nonexistent NSID
> fails the lookup, and so does the broadcast NSID, which never names a
> namespace.  Both are aborted with Invalid Namespace or Format instead
> of Invalid Field in Command.
> 
> Translate the lookup failure to Invalid Field in Command, as was done
> for Set Features.
> 
> Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>


Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

