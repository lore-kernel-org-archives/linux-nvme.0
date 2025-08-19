Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81995CA0EEB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WGMXxLO3N1AtvrVMEexcAnbUqM4Mc1qxVKvCypbtwLg=; b=E44dk1vlivI9ET3+ADaM4rabDC
	NFXmKkJLPEEfZHAlo3tB9wshird6h5E5lFFQAhDgHOajq9++tpDxoBaYEI0dXRb5X7Vv7YJMdNkFA
	M44JzXIYBJG5wudNgSlepKBHoXr3ZAP5S5+5qZpjD249vO+fXgoNdGfR7jlRTx2U3Tt6Dv0pCmrTP
	OnPrt0kC67oSKSKkglU7B5bdFmKaPafyp39K290RZtA0rzSmgYXxbCYy4Suw7fUX8qE4xaNYi8Sor
	2dOVFCHfzpblki+ul4g5Kt/Ej1QQ8uE/ZDPHOvFHz/29xsKGBA3GrVBV1lvW5P3sU8IQD/Uxp3v4l
	tZap32Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoM9j-0000000AYN7-1qAD;
	Tue, 19 Aug 2025 13:13:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoKXs-0000000AHZC-3puv
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 11:30:30 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J7Vvfw009506;
	Tue, 19 Aug 2025 11:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WGMXxL
	O3N1AtvrVMEexcAnbUqM4Mc1qxVKvCypbtwLg=; b=ocJbVNI2ehr2kCF//f/WBp
	gUcK9IucKtXMGmBN/buvKhOa3iJyp777To3OwOLBeape1lQ/alrvTripYVpUx4V3
	f0VvNCFJvPP2unPK4C/uYufFu0ZMfDcWJHxf2xsfXpze03aXFbaYk0w6Voyl2zSH
	mW0r0GCQd/GG4DIXX68o+CxSlg3A3QFndT3c5OUEYKe8X0NQQhTNrtDjQZXTBScK
	GDEk1kEtz5/0niz8LZMKDIK1o6Sk9G+9Bw27GB3u+mS+4l/vhBK6JHtn/CQdXq+b
	0rsumAmDxYI0+TE/qFRb1yxiKo3zjrQY1Dier3cRVOU72XWKJKQvz7kGvAziiYZQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48k60g3cu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 11:30:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J9FaGq001470;
	Tue, 19 Aug 2025 11:30:25 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48k4q0t3xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 11:30:25 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57JBUOLX33096264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 11:30:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61D2F5805C;
	Tue, 19 Aug 2025 11:30:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 978855805E;
	Tue, 19 Aug 2025 11:30:22 +0000 (GMT)
Received: from [9.61.13.229] (unknown [9.61.13.229])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Aug 2025 11:30:22 +0000 (GMT)
Message-ID: <da8f1eeb-258f-4e4a-be20-2d69636abde6@linux.ibm.com>
Date: Tue, 19 Aug 2025 17:00:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] nvme: extend show-topology command to add support
 for multipath
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-3-nilay@linux.ibm.com>
 <93be5b21-8897-44d3-a590-42ba8f1b6abb@suse.de>
 <a06660fb-821f-447e-9ea6-ef0f3372a844@linux.ibm.com>
 <ecd33303-830d-4e26-b49a-14a558725e67@suse.de>
 <a1132d3c-ac1b-4807-82f9-a1f195cef0f5@linux.ibm.com>
 <dcb26ea8-6951-4b98-8df3-003ed6d6b5d7@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <dcb26ea8-6951-4b98-8df3-003ed6d6b5d7@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yw_yAiEFGAD_T5LiFamu8Qf8pkmYqfYx
X-Authority-Analysis: v=2.4 cv=coObk04i c=1 sm=1 tr=0 ts=68a46052 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=2J7IuT7wAAAA:8 a=bWBGFn-jx6Y5lBdfNXcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=RtgRkGnnZwJf8nmJIBi8:22
X-Proofpoint-GUID: yw_yAiEFGAD_T5LiFamu8Qf8pkmYqfYx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDAxNiBTYWx0ZWRfX9Ain2rfY4tBd
 Ob3elfknYTWi6qOYZnDacq1qAtlu9unoctVwTB54VS+ZsV/jI2oSkBsxIFtjaxbxWFGLh6ke6hi
 TuNhtW6u0rMqXhrKN8oTGRqe9iSpmse3DKJwZKOFNTJvv19CExKnIpl1d/7y+Y9L381QdD8n/ZW
 iquv/ti7W4Y6SjhiVPt7YpuDD+hhDHAeVYaKh8Nqq2ciDhj+Y/yZoiqwO9t3YRDmBFkmXzKyNPU
 ckLWykTCWGA/tu3cIsPbzuAC/Vpb5UvBVmEb3xPTSwoUhowzyDPIDpQNYGOoaQDeamb6+f2sWKY
 /N/3x5ydSVoP28Hay9p5sZeoSNAaHK47Ye6nXAFRhUobKVXVFAueYYjpD+PCD8kVJQ8yxriGiGN
 2RrFcAtA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508170016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_043029_299801_3DEF8295 
X-CRM114-Status: GOOD (  21.95  )
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



On 8/19/25 4:35 PM, Hannes Reinecke wrote:
> On 8/19/25 12:31, Nilay Shroff wrote:
>>
>>
>> On 8/19/25 11:45 AM, Hannes Reinecke wrote:
>>> On 8/19/25 06:49, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 8/18/25 12:52 PM, Hannes Reinecke wrote:
>>>>> On 8/12/25 14:56, Nilay Shroff wrote:
>>>>>> This commit enhances the show-topology command by adding support for
>>>>>> NVMe multipath. With this change, users can now list all paths to a
>>>>>> namespace from its corresponding head node device. Each NVMe path
>>>>>> entry then also includes additional details such as ANA state, NUMA
>>>>>> node, and queue depth, improving visibility into multipath configs.
>>>>>> This information can be particularly helpful for debugging and
>>>>>> analyzing NVMe multipath setups.
>>>>>>
>>>>>> To support this functionality, the "--ranking" option of the nvme
>>>>>> show-topology command has been extended with a new sub-option:
>>>>>> "multipath".
>>>>>>
>>>>>> Since this enhancement is specific to NVMe multipath, the iopolicy
>>>>>> configured under each subsystem is now always displayed. Previously,
>>>>>> iopolicy was shown only with nvme show-topology verbose output, but
>>>>>> it is now included by default to improve usability and provide better
>>>>>> context when reviewing multipath configurations via show-topology.
>>>>>>
>>>>>> With this update, users can view the multipath topology of a multi
>>>>>> controller/port NVMe disk using:
>>>>>>
>>>>>> $ nvme show-topology -r multipath
>>>>>>
>>>>>> nvme-subsys2 - NQN=nvmet_subsystem
>>>>>>                   hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
>>>>>>                   iopolicy=numa
>>>>>>
>>>>>>              _ _ _<head-node>
>>>>>>             /              _ _ _ <ana-state>
>>>>>>            /              /      _ _ _ <numa-node-list>
>>>>>>           /              /      /  _ _ _<queue-depth>
>>>>>>          |              /      /  /
>>>>>>     +- nvme2n1 (ns 1)  /      /  /
>>>>>>     \                 |      |  |
>>>>>>      +- nvme2c2n1 optimized 1,2 0 nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
>>>>>>      +- nvme2c3n1 optimized 3,4 0 nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live
>>>>>>
>>>>>> Please note that the annotations shown above (e.g., <numa-node-list>,
>>>>>> <ana-state>, <hed-node>, and <queue-depth>) are included for clarity
>>>>>> only and are not part of the actual output.
>>>>>>
>>>>>
>>>>> Hmm. Why do we have the values for 'numa-node-list' and 'queue-depth'
>>>>> both in here? They are tied to the selected IO policy, and pretty
>>>>> meaningless if that IO policy is not selected.
>>>>> Please include only the values relevant for the selected IO policy;
>>>>> this will increase readability of the resulting status string.
>>>>>
>>>> Okay makes sense, so we'd print <numa-node> and exclude <queue-depth> if iopolicy
>>>> is numa. For 'queue-depth' iopolicy, we'd print <queue-depth> and exclude <numa-node>.
>>>> And for 'round-robin' iopolicy, we'd neither print <numa-node> nor <queue-depth>.
>>>> I'll update this in the next patch.
>>>>
>>> Hmm. I'd rather have _some_ value for 'round-robin', too, as otherwise
>>> the number of fields will be different (and making parsing harder).
>>>
>> Okay so then how about printing <numa-node> for round-robin policy as well?
>>
>> I looked at the NVMe path selection code for the round-robin iopolicy, and it
>> appears the kernel uses the NUMA node ID of the I/O submitting CPU as the
>> reference for path selection.
>> For example, on a system with two NUMA nodes (0 and 1) and two NVMe paths
>> (PA and PB):
>> - If an I/O from node 0 selects PA, that choice is cached.
>> - Next time when kernel receives the I/O from the node 0, it'd retrieve
>>    the cached path value and find the last path chosen was PA. So now it
>>    will choose next available path which is PB to forward this IO.
>>
>> This way kernel alternates between PA and PB in round-robin fashion.
>> So the selection is still tied to the submitting NUMA node, just with path
>> rotation layered on top. Given that, I think it makes sense to also print
>> <numa-node> for round-robin iopolicy, to keep field consistency and still
>> provide meaningful context. Agreed?
>>
> Can't we print the current path? That would be more meaningful than just printing the NUMA node ...
> 
The current path is already printed in the output. For instance, if we look at
the below output then it's apparent:

              _ _ _<head-node>
             /              _ _ _ <ana-state>
            /              /     _ _ _ <numa-node>
           /              /     /  
          |              /     /  
     +- nvme2n1 (ns 1)  /     /  
     \                 |     |  
      +- nvme2c2n1 optimized 1 nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
      +- nvme2c3n1 optimized 2 nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live


In the above output, node1 represents the current path nvme2c2n1 and node2 represents 
the current path nvme2c3n1.

Thanks,
--Nilay

