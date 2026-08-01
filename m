Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587CFC55173
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Aug 2026 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4KaR25d7I/tB+vdjFKdyZCTPnseo5TYPvyf6WvU1BwA=; b=OMvzXo6RjVfKu7CvQdZ7+BQYwm
	teMwiC2yfwLRUyqwx/Z6ZIPbmYHAQtMRYasRmz8sKz+iPoLOV75yQ6gK+vcEcPrbnSKLhysQ41s9S
	Yb/FxHloSmEyYogU4HaoMqLiIYE9cFvwMeUKuffV8IZJ96RDvxDBGVvaE3oTh5i4YshBXXYDkXOIa
	qWjVGZsSTK8nHDrngX7Cd75ssm1+SSOnUNy426TllFytW/jADA7Rv9KlOmwpPayd8bVM2PwsWWhXU
	EpApMWY9zBcoGoyjIwwcfYic7W4e1qN30hpo2HIYtUGLPIcQQdi3eUSmKm/QaBi6A3my5/Jpd6r+g
	+ipEb71Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqA4W-0000000EhIx-3LxJ;
	Sat, 01 Aug 2026 13:48:16 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqA4U-0000000EhIc-3e5K
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 13:48:16 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671CljR1587818;
	Sat, 1 Aug 2026 13:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4KaR25
	d7I/tB+vdjFKdyZCTPnseo5TYPvyf6WvU1BwA=; b=f18uuSLKD8L8afwgjoQA/w
	GhxeVDTaqponEgun1Dj5DKn5F4Pn+Eljv1pUOsi2NGqY09brZsHb7jmhcTH3pDwc
	ciexZW7FV1LdVaYnzhZWjfszVN/J8+VSYg2rIi4/QYQYGC647yTz8cxK3vGrIY9p
	Ce8+Tw6GKhyoWXO8FNWxY7QfIOdfLJS3ahAOc+yxpFOmwm0qdhmB2FTNyGR3OONA
	c/2BGfMQKFatT9Bmdfu7bBpauuIEBEZDfAnyw5PQ5tCYt8unKgSw+JQVNSYQHVJK
	Tx1xNiXrKWFyChrpjgd4FlS9tKn6nVuPjqTDc2USkw9CCWzsg4qvSvoDtPsrNEzA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3hfks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Aug 2026 13:48:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671DfKsF003982;
	Sat, 1 Aug 2026 13:48:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yktwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Aug 2026 13:48:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671DlOrc5898994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 13:47:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7506F5805C;
	Sat,  1 Aug 2026 13:48:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6EDA58051;
	Sat,  1 Aug 2026 13:47:56 +0000 (GMT)
Received: from [9.43.78.15] (unknown [9.43.78.15])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 13:47:56 +0000 (GMT)
Message-ID: <16986c93-097f-46ec-be40-7e4b6aeb42da@linux.ibm.com>
Date: Sat, 1 Aug 2026 19:17:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 3/4] nvme: add debugfs helpers for NVMe drivers
To: Maurizio Lombardi <mlombard@arkamax.eu>, kbusch@kernel.org, hch@lst.de,
        hare@suse.de, sagi@grimberg.me, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org
References: <20260731073918.614014-1-nilay@linux.ibm.com>
 <20260731073918.614014-4-nilay@linux.ibm.com>
 <DKCLUFJYS7HH.2EBXAQNUPN5B2@arkamax.eu>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <DKCLUFJYS7HH.2EBXAQNUPN5B2@arkamax.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a6df913 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=4b_1iKFbeTtuySlefewA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _xZa8TTlHa74HiU1CbokRxsbbZWTdfYN
X-Proofpoint-GUID: pTbYDd_ei5kMUaRr688voIQfNjtYQJx6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDExMCBTYWx0ZWRfX6eBjVHkmrOWL
 LM12Mtn6QpuqQV+8SRI/dV82qUgwGhE0EJegbHUnE1tFOljvOYdAs8pmbJqBut+k8S6NC+rGDT9
 MeeHstvSY2Tv/it+0yqojQZmUmEzOpA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDExMCBTYWx0ZWRfX22UZnumTjjDX
 nnmSSL9QWx7JSyeeUvDSAkMqVImhWFZQByvNI6fiI65geTvYVML74yRLm4+LGunpETQ5Y9brYVr
 zcWJYOBrn9Q2+MhiMqq0ypwsQaVMt88P+IAiLbXdgOVG+hzJ+KvVeHy+R7UhFwGPGsHrwbbl+/0
 cCmqnkgRV3DdDVI9Tm0ErqZpJAfYo/ZdXecJqFZALrz3nHbN+iec6UHWT0x+HC512vPqGM4GPdE
 tBNWhhfLnzsdPlHa5pWG/OsRt5e3YSyW5E2A+aPy+NqRtjNfmVPlFyoA0wW7DSLIrBO6AupXeDP
 JVjx7YT2iqzGKuLD4OP9ACz8PCaxWFkwVHR2jjo/f7NPK6CgI+q5WHTaz71i+BJQzruy5+zU6vJ
 0q1u8YGTXXnFW92g40yE2u4gZUeXdhbwoATH85khUGdgxjBdQl63NnIkHscL5rraCgxP1vVnuNA
 /trxQ8INHTnZ2xAb4wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_01,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_064814_924488_18C176C3 
X-CRM114-Status: GOOD (  13.19  )
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

On 7/31/26 1:44 PM, Maurizio Lombardi wrote:
> On Fri Jul 31, 2026 at 9:39 AM CEST, Nilay Shroff wrote:
>> +static int nvme_debugfs_open(struct inode *inode, struct file *file)
>> +{
>> +	void *data = inode->i_private;
>> +	struct nvme_debugfs_attr *attr = debugfs_get_aux(file);
>> +	struct nvme_debugfs_ctx *ctx;
>> +	struct seq_file *m;
>> +	int ret;
>> +
>> +	if (attr->get && !attr->get(data))
>> +		return -ENODEV;
>> +
>> +	ctx = kzalloc_obj(*ctx);
>> +	if (WARN_ON_ONCE(!ctx)) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
> 
> Just a nit, I don't think that raising a warning just because
> kzalloc() returned NULL is a good idea as failures can naturally
> occur under OOM conditions and aren't bugs.
> 

Alright, I'll change it to just return -ENOMEM without producing
a warning, in case kzalloc fails.

Thanks,
--Nilay

