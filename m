Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3B7CA0EE6
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 04:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5zI7SMQpyPHnXVK6w73vNOWSYGdhNdBtmFII6lGni4k=; b=hNqq6HT1a/hgUTWMbTajQugzbz
	S0lyAMlxpMQLvHeD3C2bUBTV/1CqDHP5ZLG60/xGdxhOFnGKYKn4JBw27zMejF70n0F0epcL9WIWb
	HdCb1ZD4obAPK4GhQbu3caMpK4QAOIeZ4g9lBwh6BqY6cyxTqVIqZEjWgAg8Rn8SVxKdd9yEFhwdB
	CdosTnG4fX0pmsLQc3eVaUjc31a7GnEHekB5gWSNxu+TQ31W0uAk/XSOcpRVmQzyewrIz29uVOP/f
	Rail7ri2gNOqsimIu8/noEkoQg2vvhjPbnqQGbV1jHiLGk5b99jB6o8v55tJPHjFSTxVsfPBDSBNe
	wT19criQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoEHt-00000009OPP-0eJs;
	Tue, 19 Aug 2025 04:49:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoEHr-00000009OP7-21GB
	for linux-nvme@bombadil.infradead.org;
	Tue, 19 Aug 2025 04:49:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5zI7SMQpyPHnXVK6w73vNOWSYGdhNdBtmFII6lGni4k=; b=ZZlh021YIR5zFvMYmmJg5J5QKa
	3FJUVlEDfsXiUk2SM3CEFTzQn77DRNKdFsTJWRrVEfP2YwLx61aginMlP8WScuUP7FIJNF5HPDm7B
	bTH/Ns3JGhD0xDq6UwDpXEXEaS9dw5w+vw+CFDzDCP2XoqtT9dVbqnDHENqfkq8yQnUQDSd4xPyRN
	fO0S0YRh+jCdm/tTeQT1Bdd02BZtElFj8bLKXLh17BYjbmuRsi28fmU1Y4MGBtwEt2FYcQ/3QVkTR
	nWLfgoHAgR9m8vun9pExbJQGQTwIH7IoFg/wB3WgK88QPKN8viRaPoP1eqMnoY6GIsNw53MPuS2b2
	zvYOwnxw==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoEHi-0000000HZLD-4Bkd
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 04:49:28 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ILfLIL016120;
	Tue, 19 Aug 2025 04:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5zI7SM
	QpyPHnXVK6w73vNOWSYGdhNdBtmFII6lGni4k=; b=LIaEzi2eXY1BCHB3GZ5QH1
	VHrENP+TIbuESnaPuxxsfU9MPgwkBgcEr+LWBiFWSShjcuaxatuvYOzMZPICmJ6l
	ZoKr2OMtIJx7nU0RDJ3xuQiQbFgcS591DW112wLqgdwRyn1OV/m59gQkrLLZaCK2
	m5tIOnX5P7Io7iYIg+Z+xMA8Co65OYxPTRDlzuMiqtvxphaobhQRG772PM0ACuGS
	LVRA52oFL52DWv2ekx5Vo/UcDMZx18GqYs3o4BgBDRRRRu7VISu2DFTflOY81X3U
	fSh8m3otfdVmockvN7/cMSPMOMz+1pHR1zavpW49uc1hLIIIwiSfnNCybVHsOqwA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhn3vf1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 04:49:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J3PRYW010675;
	Tue, 19 Aug 2025 04:49:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k4au8wep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 04:49:14 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57J4nE3524052226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 04:49:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 187975805D;
	Tue, 19 Aug 2025 04:49:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B2FD58054;
	Tue, 19 Aug 2025 04:49:12 +0000 (GMT)
Received: from [9.61.13.229] (unknown [9.61.13.229])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Aug 2025 04:49:11 +0000 (GMT)
Message-ID: <a06660fb-821f-447e-9ea6-ef0f3372a844@linux.ibm.com>
Date: Tue, 19 Aug 2025 10:19:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] nvme: extend show-topology command to add support
 for multipath
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-3-nilay@linux.ibm.com>
 <93be5b21-8897-44d3-a590-42ba8f1b6abb@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <93be5b21-8897-44d3-a590-42ba8f1b6abb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VACTXoDe20RCJgcb7uNBGtdiovsNl3ba
X-Authority-Analysis: v=2.4 cv=L6wdQ/T8 c=1 sm=1 tr=0 ts=68a4024b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=2J7IuT7wAAAA:8 a=iY_JdiDuVxxYQvAz17IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=RtgRkGnnZwJf8nmJIBi8:22
X-Proofpoint-GUID: VACTXoDe20RCJgcb7uNBGtdiovsNl3ba
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX2eAYDJKZ5xE1
 8Z6VS4SL5+SCzragnOZHbnEtmU8gwGRfOxDGirwMf7ljsvdXTCoQdoMQChrSiYe+E6ksMQmnmff
 hO59KN9IXiFTzcWB70EuR/4/BchKdPlSm9WNpiBd/usypxYkdMHeVhzve+yb0gp6Q9Efcnh4E8M
 9HrLgNj2Bp26WlSrl+J+cmwIe9cYGgGPACfTM/AbBR+eW8UwxnlDmFu63QwVe0HrQeyhfj9vfbR
 1wIbpk/6NHi598HSayz3f24Md+/8Ol7rO4dfqYa8dNf16ddG1ayU0PIuMdCA1mEwvZ1RYF817uj
 0xNAgsoOmY8dL6EKSGtEuHqjElr1x0BqvXHMLtfkIYUgpmHfSZt3Zpv3VH7nhgpqPk4ZRoLOUtL
 KbShLCQd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_054925_630600_27788444 
X-CRM114-Status: GOOD (  17.57  )
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



On 8/18/25 12:52 PM, Hannes Reinecke wrote:
> On 8/12/25 14:56, Nilay Shroff wrote:
>> This commit enhances the show-topology command by adding support for
>> NVMe multipath. With this change, users can now list all paths to a
>> namespace from its corresponding head node device. Each NVMe path
>> entry then also includes additional details such as ANA state, NUMA
>> node, and queue depth, improving visibility into multipath configs.
>> This information can be particularly helpful for debugging and
>> analyzing NVMe multipath setups.
>>
>> To support this functionality, the "--ranking" option of the nvme
>> show-topology command has been extended with a new sub-option:
>> "multipath".
>>
>> Since this enhancement is specific to NVMe multipath, the iopolicy
>> configured under each subsystem is now always displayed. Previously,
>> iopolicy was shown only with nvme show-topology verbose output, but
>> it is now included by default to improve usability and provide better
>> context when reviewing multipath configurations via show-topology.
>>
>> With this update, users can view the multipath topology of a multi
>> controller/port NVMe disk using:
>>
>> $ nvme show-topology -r multipath
>>
>> nvme-subsys2 - NQN=nvmet_subsystem
>>                 hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
>>                 iopolicy=numa
>>
>>            _ _ _<head-node>
>>           /              _ _ _ <ana-state>
>>          /              /      _ _ _ <numa-node-list>
>>         /              /      /  _ _ _<queue-depth>
>>        |              /      /  /
>>   +- nvme2n1 (ns 1)  /      /  /
>>   \                 |      |  |
>>    +- nvme2c2n1 optimized 1,2 0 nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
>>    +- nvme2c3n1 optimized 3,4 0 nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live
>>
>> Please note that the annotations shown above (e.g., <numa-node-list>,
>> <ana-state>, <hed-node>, and <queue-depth>) are included for clarity
>> only and are not part of the actual output.
>>
> 
> Hmm. Why do we have the values for 'numa-node-list' and 'queue-depth'
> both in here? They are tied to the selected IO policy, and pretty
> meaningless if that IO policy is not selected.
> Please include only the values relevant for the selected IO policy;
> this will increase readability of the resulting status string.
> 
Okay makes sense, so we'd print <numa-node> and exclude <queue-depth> if iopolicy
is numa. For 'queue-depth' iopolicy, we'd print <queue-depth> and exclude <numa-node>.
And for 'round-robin' iopolicy, we'd neither print <numa-node> nor <queue-depth>.
I'll update this in the next patch.

Thanks,
--Nilay




