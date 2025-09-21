Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03670CAC5A7
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Sep 2025 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xQM+rmQra2vY9zm3cFHIlfLhApPsUcmWTKQ8btFfl+I=; b=KyWeXF2U1AY7JGiL/N5BiFRNgk
	QEUhS09wl+2kLvUA0myVMekzmR2RVj7y5CLrKBOovymuQIzJNsdMHNLm7SsTMuFPtbH6o/VksdQD5
	CmJLglYRn+UrB5Q2NFydbO5fncxhrfWlM7nDb7+X2tcmPoCsVuPX/KgOxj3kwLJqSU1fJbf0fAX3H
	qjDT8sncfOMWL4+5rY2Wg5Hc0eH5scun+HBq6Tfc8IBdDLdEjGrGg+g3vjvLa+aMQlSiJFcs0S8xt
	07wFUZT281UIg/mVOL0cfs+43FjnG+a68dcQh1+VpfQC0iq1a8p9HXK79Cjt55leh+iMvgnN1d9yw
	UyTaDaNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0IvL-00000007QzZ-46Sk;
	Sun, 21 Sep 2025 12:12:11 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0IvI-00000007QzB-3izs
	for linux-nvme@lists.infradead.org;
	Sun, 21 Sep 2025 12:12:10 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L6RG6G003348;
	Sun, 21 Sep 2025 12:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xQM+rm
	Qra2vY9zm3cFHIlfLhApPsUcmWTKQ8btFfl+I=; b=aPCcQZCAZWGKMv/f9fOKjI
	VbJ7aSJR0YMYRZs+XdK16kEXaSOLMM+HjO+ecrizuZTp0RyfQrp9EH+vnx07CWPh
	puvwIZEOagWy+vh7RzNw3fhGSttHMgaBSsn6BkHY9em4cfKywmmZOU3hdCU9Qor5
	FVqm4xgXp0FnM8oX/X3XrTdY3n/LNUZ5eWq1yTwvABHigSC7hujFjOoqSbPa0P7M
	8AcsLe/jaIGr4v8CpFR8b2rG9RHbg/ryOUB74/V+hNH+8KSEwKBI5nSa2cia/eVx
	n6/XxNO6M2vDulHYXdrcIh8LsDWAIxam7dGLNZ27HszNnR4c5jDMWkoK3fwPKtzQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky5nh9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 12:12:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58LBMEcK029488;
	Sun, 21 Sep 2025 12:12:04 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a6krhvg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 12:12:04 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58LCC3oG24052254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 12:12:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7E2B5805A;
	Sun, 21 Sep 2025 12:12:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8DE158051;
	Sun, 21 Sep 2025 12:12:01 +0000 (GMT)
Received: from [9.43.45.7] (unknown [9.43.45.7])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 21 Sep 2025 12:12:01 +0000 (GMT)
Message-ID: <8ade15d7-9e73-4f29-a482-283991667499@linux.ibm.com>
Date: Sun, 21 Sep 2025 17:41:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/4] nvme-cli: enhance the visibility of multipath using
 show-topology command
From: Nilay Shroff <nilay@linux.ibm.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: hare@suse.de, kbusch@kernel.org, gjoyce@ibm.com,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20250904175654.1183750-1-nilay@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250904175654.1183750-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MkJ2zEVEBbngpI3XVZvtt4nZAglnp7jF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX1yPzmAIBM21g
 X2Yjx6aEtDD/f1SDrPMvRgtYZTUZtPN7mpLNQAo4ddPkrUqnh6yFbUvIkRnUy1yy1K2ig0FrQqh
 mYoAMU7xwbIhNeec3wrmCg7jm2MP1e3lWhUGlvbQlBFX+6+wbie+ndPVOMnD3LBlNu+XZ3brq+l
 lJ8RaROzKxD2YnfyxHBmKVOlG2t2yzb4TkjOil6unyBqQL6mVuWRxAVZoUhw0J3wlEuTehU5Y75
 +/qsETyY2q8vZptCjf3Oxqc/JCG3zd2VerXKBss99U1IP8UQOPxKxxi+e6qhpcyPIpndhNIMdpw
 MQT3IpRE57oVVqVUZq0EeDHrx51RNmn3jzwuxIl7kXiS5xnC5MHWJsFBzXGJ3iKMgJTkgRm1KmW
 NTCRQanm
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68cfeb95 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4zi28OMO5Ye6PTEUMa4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MkJ2zEVEBbngpI3XVZvtt4nZAglnp7jF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_051209_121061_4C3C64DC 
X-CRM114-Status: GOOD (  27.24  )
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

Hi Daniel,

A gentle ping on this patchset. Please let me know, in case, if you've
any further query/comment/suggestion for this patchset. 

Thanks,
--Nilay

On 9/4/25 11:26 PM, Nilay Shroff wrote:
> Hi,
> 
> There has been recent work to improve the visibility of NVMe multipath
> configurations. The native NVMe multipath kernel driver supports three
> I/O path selection policies: numa, round-robin, and queue-depth. However,
> until now, users have had no insight into which path is selected by the
> multipath logic for forwarding I/O.
> 
> To address this, an RFC was proposed [1] and has since been merged into
> the Linux kernel as of v6.15. Following that, libnvme was extended to
> discover multiple paths to a shared NVMe namespace [2]. This patchset
> builds on those efforts to improve userspace observability of multipath
> configurations via nvme-cli.
> 
> This patchset contains four patches:
> The first patch in the series fixes a <device> filter option using which
> we could be able to filter the output of nvme show-topology command.
> 
> The second patch in the series enhances the nvme show-topology command to
> display multipath configuration, including all discovered paths to a
> namespace, along with details such as ANA state, NUMA nodes, and queue
> depth. The show-topology "--ranking" option is extended with a new sub-
> option: multipath.
> 
> The third patch in the series adds common table APIs for printing nvme cli
> command output in tabular format.  With these APIs, developers no longer
> need to pre-calculate column or row widths. The output is consistently
> aligned and easy to read.
> 
> The fourth patch adds support for printing show-topology in tabular form
> leveraging the introduced table APIs to produce well-aligned, easy-to-read
> output.
> 
> As usual, any feedback/sugegstion is most welcome!
> 
> Thanks!
> 
> Changes from v2:
>   - For iopolicy=numa, print NUMA nodes and exclude queue-depth.
>     Similarly, for iopolicy=queue-depth, print queue-depth but exclude
>     NUMA nodes. And for iopolicy=round-robin, exclude printing
>     both NUMA nodes and queue-depth. (Hannes Reinecke, Daniel
>     Wagner)
> Link to v2: https://lore.kernel.org/all/20250812125614.164445-1-nilay@linux.ibm.com/
> 
> Changes from v1:
>   - Added the third patch in the series that implements the common table
>     APIs for printing nvme cli command output in tabular format
>     (Daniel Wagner)
>   - Added the fourth patch in the series which adds the support for
>     printing show-topology in tabular form (Daniel Wagner)
> Link to v1: https://lore.kernel.org/all/20250704135001.292763-1-nilay@linux.ibm.com/
> 
> Nilay Shroff (4):
>   nvme: support <device> option in show-topology command
>   nvme: extend show-topology command to add support for multipath
>   nvme: add common APIs for printing tabular format output
>   nvme: add support for printing show-topology in tabular form
> 
>  nvme-print-binary.c |   1 +
>  nvme-print-json.c   |  36 ++++-
>  nvme-print-stdout.c | 312 +++++++++++++++++++++++++++++++++++++++++-
>  nvme-print.c        |   9 +-
>  nvme-print.h        |   3 +
>  nvme.c              |  29 +++-
>  nvme.h              |   2 +
>  util/meson.build    |   3 +-
>  util/table.c        | 320 ++++++++++++++++++++++++++++++++++++++++++++
>  util/table.h        | 149 +++++++++++++++++++++
>  10 files changed, 849 insertions(+), 15 deletions(-)
>  create mode 100644 util/table.c
>  create mode 100644 util/table.h
> 


