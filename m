Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50053D2AB3C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0uMgcVPTXq1WP7boja6PLKHW3vyqJdcnNIytbjo0xE=; b=m82RPoowfcwsNlmAGEMYvgQFnR
	z2P493gTxyLSbYd7IkVkWmgWHz1MEoH/dva7bDsD8Nmmse0aqwpb7Xc5m2w8LtQQSi0a8LLk0qGWB
	g2kLJ/66YH+SUDznLGWR28JCNv2D7g73nM6G39IFb5/2QZX2Z73fDDkIADSTidWeQkUv/HgabWBxG
	eApNey85SXUbaD03EI+2l28Z1S0KHxNlDMxie8dP7psC09NFxu8OGuWh99IZEltHJ2LNJLs2rirFe
	okabRz0ghZrB8E5gkmCIZBad7NhoxUsCrD2WKN4hH0tV7nSuc6l7W21+l8fDo0tjEQ1u5CiczriDc
	hGZf27Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5m57-0000000EXVW-2U72;
	Tue, 29 Oct 2024 13:16:21 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5lbw-0000000ESKC-3c6f
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 12:46:50 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T25PjE023281;
	Tue, 29 Oct 2024 12:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M0uMgc
	VPTXq1WP7boja6PLKHW3vyqJdcnNIytbjo0xE=; b=Yjq2KeT/2NOfBrG8WPGJAl
	+yuasDgg60pzEP49pqco2/rW4+g3/8S0DT4Lu5elGJqNlFCTs7ARgzWOl/4mIrGV
	ZB4mlG2UJFWiJLrBlil07qCxvpRFoyjVkdbH9pz7kijRtZz9kxkY5ujGD3Ih/hGh
	OCKTsONTcHQNvjme8dExxUKT8mEd/GNUySMvMxyrVC8uEFKWQI2LTPLyA7Sw7tln
	tiVod4Ols119E1lrWDABQuNrNS9VYkjTXv/V0Ln4dHme5bwHMWDhKquq1eHLCFr5
	fCYx+QWDlBPYtHpvG2yHcW1ffLr5gcjR2YxpcE7BjVLOOe9LdP7A9NdEqsBleQKg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j43g0gss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 12:46:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49TBohtZ024726;
	Tue, 29 Oct 2024 12:46:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hcyjas6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 12:46:06 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49TCk6MC44564866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 12:46:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03C985805B;
	Tue, 29 Oct 2024 12:46:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCD2658058;
	Tue, 29 Oct 2024 12:46:02 +0000 (GMT)
Received: from [9.109.198.181] (unknown [9.109.198.181])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Oct 2024 12:46:02 +0000 (GMT)
Message-ID: <22ac5b67-9968-4c53-af90-dd83b0efbd76@linux.ibm.com>
Date: Tue, 29 Oct 2024 18:16:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Revert "nvme: make keep-alive synchronous operation"
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
        dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241027170209.440776-1-nilay@linux.ibm.com>
 <20241027170209.440776-2-nilay@linux.ibm.com>
 <CAFj5m9Ka-EL34DbDCm4kMYoWXfQ6GhMRPJykywE4RztbB3zXYg@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAFj5m9Ka-EL34DbDCm4kMYoWXfQ6GhMRPJykywE4RztbB3zXYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yy56sXWXrgBQmsqidKuFA1kDXtsUytgR
X-Proofpoint-ORIG-GUID: Yy56sXWXrgBQmsqidKuFA1kDXtsUytgR
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=874 clxscore=1015
 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410290097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_054613_009628_E628DD7E 
X-CRM114-Status: GOOD (  19.21  )
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



On 10/29/24 12:18, Ming Lei wrote:
> On Mon, Oct 28, 2024 at 1:03 AM Nilay Shroff <nilay@linux.ibm.com> wrote:
>>
>> This reverts commit d06923670b5a5f609603d4a9fee4dec02d38de9c.
>> This reverts commit 599d9f3a10eec69ef28a90161763e4bd7c9c02bf.
>>
>> It was realized that the fix implemented to avoid the race
>> condition between keep alive task and the fabric shutdown code
>> path in the commit d06923670b5ia ("nvme: make keep-alive
>> synchronous operation") is not optimal.
> 
> I saw you have discussed it a while, but it is still better to describe
> the reason in the commit log.
> 
Sure, I would enhance the commit message to clarify it further.
>>
>> We also found that the above race condition is regression caused
>> due to the changes implemented in commit a54a93d0e359 ("nvme: move
>> stopping keep-alive into nvme_uninit_ctrl()"). So we decided to
> 
> Can you explain a bit why commit a54a93d0e359 is a regression?
> And what is the race condition?
> 
> Without providing the context info, it is hard to review the change.
> 
> Thanks,
> 
> 
OK, the root cause of the race condition and how it could be triggered 
has been already discussed here[1].

In any case, if you still want me to clarify it further then please let
me know.

[1]https://lore.kernel.org/all/b03863b2-8816-48cd-aa18-436f1c49ec8c@linux.ibm.com

Thanks,
--Nilay

