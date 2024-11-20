Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A13D63923
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2024 10:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jhdrnn74XKG1BThRZBNrakwPwfk1rY8nLdOjLfvbelA=; b=GEVoiBvcI23tXEGhDGDdwJNmHo
	1ydUhmv3ksCI2GhlP5mjs0T68j13HZxTXftbWX44EOmf5pfVN6n9rLDxWiF+qqKmuOx2v4CiF+8h5
	Y8ykgigANiUtGJnq60DnUXsdywJY2iVoY2NBS6oOiKppegBHiUdZM54IM5Ess4BhZY0uVAsmLlBfc
	33kQKweEv6e89ShN6uvuV7fhA6nVC5ALfPAUP99l2n33OlOa2yKWtZEseSlutF/dsoq0yLUQIIGzd
	OjZLvTS5I+tvt9BTe12MkFqo2JdR3xbgWSnzddG1Dxt8SzqbsS5fFxK7b7tS0ZOcI8ELJ/FVua8j+
	MDLDTxSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDiH5-0000000F5s6-0DZT;
	Wed, 20 Nov 2024 10:49:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDiH3-0000000F5rC-1AZw
	for linux-nvme@lists.infradead.org;
	Wed, 20 Nov 2024 10:49:30 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK5KKu1021942;
	Wed, 20 Nov 2024 10:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jhdrnn
	74XKG1BThRZBNrakwPwfk1rY8nLdOjLfvbelA=; b=nEEc6OAAEBJQ6eIqwC0CqH
	xaroGhEro0ZxPdiLE9PGZG00si2HRBDvazF4McINbNXsRQkkU0l0v/Iy5Chn1HJ+
	sZk7SD7rirP/6Az5cYZ6e2dwZXficNFuKy7XfDfy2oeoYcIeCheGr9m6gyc44DFL
	t15J5TLh4F+7FY8d9BbeXloI4nwz9ywls3XVCKDISr2HKnVIPg0AciWUiRs+vE06
	cdu4UmCR/G7uzJgpPmy7Vz70G8TVMpmNrRHmt2Cw9NMCZAJfNncOEt9jw80Vruyo
	jlSdkB89BV57EVqkoiY8HwZVe/k3IYpfbKHTzv3BmQq4+TgkSioZ6JwiVWO7CikA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtjvebx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 10:49:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK8SPP8030962;
	Wed, 20 Nov 2024 10:49:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y5qseg08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 10:49:25 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AKAnP0S55443752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 10:49:25 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FC425805E;
	Wed, 20 Nov 2024 10:49:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4273358052;
	Wed, 20 Nov 2024 10:49:23 +0000 (GMT)
Received: from [9.109.198.240] (unknown [9.109.198.240])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Nov 2024 10:49:22 +0000 (GMT)
Message-ID: <e45cf4be-3135-4d5d-afb8-83172d632d8b@linux.ibm.com>
Date: Wed, 20 Nov 2024 16:19:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_NVME_MULTIPATH - Do we need this?
To: John Meneghini <jmeneghi@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Ewan Milne <emilne@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
        Chris Leech <cleech@redhat.com>,
        Maurizio Lombardi <mlombard@redhat.com>
References: <889e1d2a-1cda-4979-8279-f2f665350376@redhat.com>
 <1548948a-3cc6-4372-8d24-7a501da8b31e@linux.ibm.com>
 <1ef1539e-87a2-47c9-af15-d6b32da36312@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <1ef1539e-87a2-47c9-af15-d6b32da36312@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fwLmTVwuh-Yv2vrsembXvHXoxXsAelw2
X-Proofpoint-GUID: fwLmTVwuh-Yv2vrsembXvHXoxXsAelw2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=884
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411200073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_024929_455770_034ADAD4 
X-CRM114-Status: GOOD (  13.11  )
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



On 11/19/24 20:25, John Meneghini wrote:
> At this point I think we are going to remove the module_param(multipath) and leave the KCONFIG option alone.
> 
> That should be a little less disruptive and we can always submit a separate patch to remove the KCONFIG option later.
> 
Agreed!
> Red Hat is currently testing this change internally and will submit a patch for consideration sometime next week.
> 
OK makes sense. I would help review and test changes on PPC with multi controller nvme disk.
> Thanks,
> 
> /John
Thanks,
--Nilay


