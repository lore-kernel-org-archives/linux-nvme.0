Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C64CA6012
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 09:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hHpFLzRLdzBTbS1f3kcSgiEB5HDKM66NOw6vCBtDe24=; b=JLDYHSDFJmOIA9ZPie414RJtnr
	819IG2lWFIeQg89bNvkNxLtbhPMS4AuEGWFF9OlZS5xRY/++/2sLJjfFpwcktjpeDGTh2pWIUWlEt
	vt3QJbJSYvNwCDQRm22goAchTLSMCdBNRcBypKFqaX1eD9G6eKXiMr1ZYjn2ytKBeajapf+Yh9+05
	tree2HIsShwV3z3M888QQ/2iodXn6laI78k4dzYlAfbxiy5DUW4RcljvseoCkclHArqWfYabpCtj7
	wW2CDVRFjoXjz4HBx62VRN18IR3Uwjlt+oGoGy93nXlMQrT+BTyksiSa79nAQJCliFLBRylt1t5eX
	ZsHo+t5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF6xL-00000005vVx-2lzg;
	Fri, 09 Oct 2026 09:31:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF6xH-00000005vVa-3SPu
	for linux-nvme@lists.infradead.org;
	Fri, 09 Oct 2026 09:31:57 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZYuj3813770;
	Fri, 9 Oct 2026 09:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hHpFLz
	RLdzBTbS1f3kcSgiEB5HDKM66NOw6vCBtDe24=; b=AHbfQLmwZ6PaHNJuU5Vafv
	TymoQ60J3jPJOAGL0FAXjp+aYeTEtLS/RPcaaaSPa676Gf/d9IR1GjxOPJm/aDYd
	pDG9ElJLaf5kM6CcYemcrEYE4Sf6U42rTHJYDG93X00AIqQzKDnpiNIBOOaOilVi
	J2FXsgR+IeecUdoVo8SpzjNnx5Kb7r9SV0N+NJ46MUJD7f4zY6rPssUpK/+JaW+k
	2iA9vu0jDZNcqhqNnNRaovuslru6oh5R4gII4/UNtj2ncKYGlyx8itisMW9hiRiB
	IhaCH8xoiUMywCRFYaGE2TF0ZVBqrzOIu8x9EvpfeWXSn6PETvzr8yy+8AZidJ/w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvs1yp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:31:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I0cx578905;
	Fri, 9 Oct 2026 09:31:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6v76rb34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:31:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6999UuM565339694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 09:30:56 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 533A758056;
	Fri,  9 Oct 2026 09:31:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFC255806A;
	Fri,  9 Oct 2026 09:31:39 +0000 (GMT)
Received: from [9.61.159.15] (unknown [9.61.159.15])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 09:31:39 +0000 (GMT)
Message-ID: <e164ee63-41e1-41cc-9b10-d7cb44a9b3ed@linux.ibm.com>
Date: Fri, 9 Oct 2026 15:01:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme-cli: NIC topology aware I/O queue scaling
To: Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        hare@suse.de, kbusch@kernel.org, hch@lst.de, gjoyce@linux.ibm.com,
        chaitanyak@nvidia.com
References: <20260821144329.3620389-1-nilay@linux.ibm.com>
 <4a80220a-2cba-4a4a-85c2-7c3d3ae8a20a@grimberg.me>
 <32bcaf68-a142-4612-9967-815dd28ee2a0@linux.ibm.com>
 <9271266f-3d7e-426e-93b6-6f1f28bc9b0f@grimberg.me>
 <9691f1d3-ec06-45d2-a427-ba46df5fa57c@linux.ibm.com>
 <26f90121-b787-4d06-8741-4fac21b46ecb@linux.ibm.com>
 <11d3490e-f8ce-4559-b1d3-f115f7dbced2@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <11d3490e-f8ce-4559-b1d3-f115f7dbced2@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fv28Ifto5fCeYah-G3pZlZ-yL95fM-UI
X-Proofpoint-ORIG-GUID: Fv28Ifto5fCeYah-G3pZlZ-yL95fM-UI
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac8b47f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=FmmBDWpQUB-u4RO40wQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNiBTYWx0ZWRfX+t/WNSN6i8JO
 ybEZ7GzHLw9Uo/eH3nA9+bejRE8/IxJR3cu4bnWJcuVos77UqBvhvTl3dZn4MRHllI3g+H1jxfE
 mBe8DhKb21R96Y3d3GFLp0MY1fHRb3s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNiBTYWx0ZWRfX27d80ByL+R9D
 pxhVMUPsMXdBtUuXyrIXXHlm9yRZXN5cXcu2F1nT5LjVnI6h37iUejPafBu6qcD3cRKP2lE19sA
 KLSPkS/Z0CoQ5hQbm8SVrwO35svpR19CkJT0CdVKLtnTkzMAKuyBjmDoB2Iy+Ye4/pVtb7rGEuF
 /D4EZKAJNxeOz6pJ0i0C/Bn2jwVlghwva05tMcVkn/BSyfbxfmgGkDcbtkAmupMwizqfjVO05pL
 gHl4c3dQZdq3qwICrtHJ9EaBb/agyg8hQOPblTxFiOcHP2V4rV2NaveSm/nr2FXqtNiO7cShPus
 ww4C2XEfi0egjn3G9kx7Vhix7fORPtikSkd+dc3YP/t8XHpKoh6cZhtYi7dmnPzurMKpLbeCy1Z
 M9mrNzr7zNU24GqqdCVTG8JmuBWxaot8uYKonv7FGw4QK8QQ1+Fsog9Naoszrm9iBIQt6NraPTg
 07rtd9dCDuP7treB/XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090036
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261009_023156_556261_002667A5 
X-CRM114-Status: GOOD (  13.35  )
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

On 10/6/26 12:08 PM, Daniel Wagner wrote:
> Hi Nilay,
> 
> On Sat, Sep 12, 2026 at 05:41:07PM +0530, Nilay Shroff wrote:
>>> This would preserve the existing behavior for single-queue devices while still using the
>>> NIC hardware queue count to constrain the default on multi-queue devices.
>>>
>>> Does this look reasonable?
> 
> Could you rebase and send also a PR on github. I'd like to run the
> review bot on this.

Yes, I have pushed this PR: https://github.com/linux-nvme/nvme-cli/pull/4140

Thanks,
--Nilay

