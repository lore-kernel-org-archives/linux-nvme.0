Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B63AC43458
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 09:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2hXv2virSLEXwJjvZBUaoErivzy8DFjEMDdJxms3Uzw=; b=scYaTjrxLW9MIp1j5HbXpVQObr
	3V5gujZMNvx+jL4oVjKbnmlNqSpjh5AKU+S5vBRLtxsG/rlGL0Gw24Xwrfod1E3i5D3RSS6pXatrc
	APjDcvTn25s9VDWEYeVPrfDquT2TI4eEW8pOAOxP9Y8JuQPRHZnb3NRMXL3xkW/9aJk4g2hzJQebH
	htmRsgEQabEq81kmFQyjlOz8xvLCjlJUoEC0lshqWmJclifFJgIQgTuo5ojzlTpDRX0YR0BhAly1U
	2KfkmJEuCVRxzycXqlPRfZJBm/OuOUeQgN04vQBQTQaODPoM+6ylglQ8dtu0oEMrS1Tu1JmfgfQiN
	NkGVPl+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weUsw-0000000GS8F-0GXh;
	Tue, 30 Jun 2026 09:36:06 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weUss-0000000GS7M-0mPW
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 09:36:03 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5mkua1192575;
	Tue, 30 Jun 2026 09:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2hXv2v
	irSLEXwJjvZBUaoErivzy8DFjEMDdJxms3Uzw=; b=FrRZMFZqFSwHshf8rnLNTc
	7272sl5AXQmJ7yZcNvwejszs01h0Vefl7aXAXFV7CKkfShcqFXD8VqnsVewhehEt
	3wQE+2K9NFXAf3Z7H/FlwipaxDcRcrl2nSOVfGIg9qN3Ud+6Upq48ne0+M5P6C5R
	gHfhYK1LCjQx4LZmdtthASWPPl0064U80hba/FM7X8uOUXSAQABFJ3YTfMrJIgpk
	c+WzRKTSoV67ACqrYfGIlSqavxqcBaa6q5G4DFnpyIPJf8LqH9j9T4i8lufjBVRg
	8/RboELH0TNEmx+1YogvKSekNjCkG+bV4fZMIJ7QefZKTP4JsfkQ5aggKLJ4OfNg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdwyb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:35:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65U9YghC010379;
	Tue, 30 Jun 2026 09:35:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbh9dwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:35:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65U9ZnAk63177148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 09:35:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BC335806A;
	Tue, 30 Jun 2026 09:35:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEB3958055;
	Tue, 30 Jun 2026 09:35:45 +0000 (GMT)
Received: from [9.43.78.19] (unknown [9.43.78.19])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 09:35:45 +0000 (GMT)
Message-ID: <4fba3fdb-73df-4cd0-9318-00ff5a1e4fe6@linux.ibm.com>
Date: Tue, 30 Jun 2026 15:05:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 14/17] nvme: fix Clang context analysis warning in
 rdma.c
To: Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org,
        gjoyce@linux.ibm.com
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-15-nilay@linux.ibm.com>
 <20260626064916.GC11106@lst.de>
 <d72e3efb-875e-40b4-80cb-1fa642bea7a5@linux.ibm.com>
 <20260629125054.GC23695@lst.de>
 <CANpmjNPgvdKLvQTFvt2OUYzG4V7GMPSmrDfV0jPbbtNxv36GJA@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CANpmjNPgvdKLvQTFvt2OUYzG4V7GMPSmrDfV0jPbbtNxv36GJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: SY6ekqw6Ep40kjP8sscCqzOhc3yZ1PdK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4MyBTYWx0ZWRfX7vvVQ8p7rLpJ
 VAL+iezejoURXevVrNQaVEidnWrmE07pZOGOUnb6QywivXWI3qjmKj1MONNiYpm2Xi+/sWWhJnT
 eNnHDdHFZhcJH4Xmka4NJ3Bd68jcR0Q=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a438df7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=HKUyhHdtx_kpi5CP2MwA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4MyBTYWx0ZWRfXwL3FIFG0o1QO
 +aEI2rseeMRSl4xEbbLt9c36tYQclzibDTQGHhQLPWKBWeFD/pgsrzycBsD9N+sm8Zzi63rOqfG
 1+W+aXIxeEyJI9gE1Ndi8LkWRi/+LzZlgcH276KaY7dEesRucwrQCRoBH8rmtDZuDhjpWEgfqXu
 UTtAD7tX5aHciDKGFZluOXh3JkITAEir+HGliP4H3bLjuTzOW5aNdB1EuZPx2sRD75V6SThuDAg
 VSaxU/P3yGWztBGgx3Zk127dHH6f9w5k0f3hftslEFiJAzrZroSn6xQaxj+twFWGHxC31ONVg84
 yJUkkiH8IPODd5EiswvPgNQ7trQ/TLdoVCcb5WO9Kh0KH+Y2ikwWyhTj6l4B7OMXTUaBOcRJfRc
 Ba4DoAdDnVAVdQnf4EKaPiZbsdovnp4aQT32WKVqwHb2OPgtGT/CAxyht6HSKe0rJI5lxgMYtk5
 vBTHErdT+5C3QAKEfqQ==
X-Proofpoint-ORIG-GUID: oMraGGCRCY2yhksKcGtrFjajGU35avAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_023602_862567_DA62FFA6 
X-CRM114-Status: GOOD (  21.34  )
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

On 6/30/26 4:17 AM, Marco Elver wrote:
> On Mon, 29 Jun 2026 at 14:50, Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Fri, Jun 26, 2026 at 09:01:20PM +0530, Nilay Shroff wrote:
>>>> Does switching to list_empty_careful fix this?  If not, does
>>>> list_empty_careful need annotations to make this work?
>>>>
>>>
>>> I tried using list_empty_careful() but clang still throws the
>>> same warning. And yes it needs same annotation to suppress
>>> the warning.
>>
>> Sounds like we should have annotations (or just use of data_race)
>> in list_empty_careful, as it is designed to be used without holding
>> the relevant lock used for modifications?
> 
> Given list_empty_careful() is a real inline function (not a macro),
> you can just add __no_context_analysis to list_empty_careful(), which
> should also suppress warnings about pointer-to-guarded-variable being
> passed as an argument into it. data_race() wouldn't work, as the
> warning is generated in the caller, but when the attribute is added to
> the callee, it also suppresses warnings about arguments in the caller.

That sounds reasonable. So you're suggesting adding __no_context_analysis
to list_empty_careful(). If we agree that's the right approach, I think
it would make sense as a separate infrastructure patch rather than embedding
it in an NVMe-specific change. So are you planning to send such a patch?

Thanks,
--Nilay

