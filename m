Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF083C83F17
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jul 2025 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FgVINm9NM1Dx2uSpMDIQFYSjaZOjojOmZ/qrEOZaTgI=; b=tGs60XRQ/nKVO7YjIm3e1K38Gf
	WDLh9BED1EA5D6cX0TrMBdxntO3cGPPpfeYU1OKFNjVAZ8WjFJruiBBvo/gHz7uzoerooQkQoZpkh
	sf6JXdFCl4ZBZswWfLC+0i/Rrkq748vuNZF1RelSbkIEID4cR28RB1i7dz3dZXpP7AyxWP7yUe/MB
	tvI8mlY1X4/2EJ+8yt30Cs/1u2jz0kCsJkduyPKr1Zcix4hdRg+HMSSuMsromn3MZ+vu4C3P0eF2x
	fLwJGfJqTAYlqJk37vaSY+49GDPbvL4AhcYSasGjiBFAyYCgHAPnBSiaKPN6RZmxodAO9VaAnJaCr
	Yte5i7ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZu6l-0000000COkU-26iq;
	Thu, 10 Jul 2025 16:26:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZrbd-0000000BztN-0K2k
	for linux-nvme@lists.infradead.org;
	Thu, 10 Jul 2025 13:46:34 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ACkwUN016492;
	Thu, 10 Jul 2025 13:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FgVINm
	9NM1Dx2uSpMDIQFYSjaZOjojOmZ/qrEOZaTgI=; b=pbk/KWk4yvWGC4R4Uaa51Z
	XqG6oAqdSFou1Me6zavgF63VHuMnefqUHqg2VPiz2Pvr38d8afg2UymCUCnd1dVW
	2izrre6WUJkVch7C9gUOPhsJKTT2flTorH3eQl90nADByDXHYlj1dF+16oUNgYV+
	TCKX5d2GVNqc/RXzzdEyiffNqPHmlgHGWMPS4Ybf8Kv2H8Z8/HR1tffo4jnbYGbd
	KBNrxgF3dAQMWZmdtmQirRyMo419MzgRe/z+LbBXP5EqynYo8zNWJoh8Dsz8Q94l
	8MbFNDeb2jLqkaUG0rPR945zeaSBl3Q3CVp73LJHbAEqnPxc3uvfVy/lKqkCNn1g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47t3xdb74r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 13:46:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56ABpQkC024311;
	Thu, 10 Jul 2025 13:46:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32njrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 13:46:13 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ADk6bt7013082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 13:46:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A952158061;
	Thu, 10 Jul 2025 13:46:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9CCC58055;
	Thu, 10 Jul 2025 13:46:10 +0000 (GMT)
Received: from [9.79.194.103] (unknown [9.79.194.103])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 13:46:10 +0000 (GMT)
Message-ID: <7fb98f70-cbf8-4ae2-bd72-cebf3d4c21f7@linux.ibm.com>
Date: Thu, 10 Jul 2025 19:16:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: extend show-topology command to add support for
 multipath
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org,
        gjoyce@ibm.com
References: <20250704135001.292763-1-nilay@linux.ibm.com>
 <20250704135001.292763-3-nilay@linux.ibm.com>
 <91e8e0de-70a7-484d-af9f-f06645011ae6@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <91e8e0de-70a7-484d-af9f-f06645011ae6@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ycdwh2Aj709z0dXQL5tWVD3x088jwc1V
X-Authority-Analysis: v=2.4 cv=MLRgmNZl c=1 sm=1 tr=0 ts=686fc435 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=2J7IuT7wAAAA:8 a=PO1_W1eBZwpx09oyezgA:9 a=QEXdDO2ut3YA:10
 a=RtgRkGnnZwJf8nmJIBi8:22
X-Proofpoint-GUID: ycdwh2Aj709z0dXQL5tWVD3x088jwc1V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDExOSBTYWx0ZWRfX+cNs6ltISGOR UsjqjYe1ppvDjTRG9AQaaEdKYrQJgA4W+rboPmflLyjXIMax/oHLKWENRx7vgI+zvjEMbGtdyu6 BVLVOPgZFFblj9VCOVSOEe7da0MRy0+sGymvYNFJ9gGP9pfHIO1LkQ8prouW9WbhxLwhdFAOB9P
 +JrOlcvvt25wQSmj6HRrZ6GNSmWpoI+vzALz827IRshbxAtQ/PdX79r0Yqs7VuHvn6Jm7WWjqAI E42wlnNIfTisiN9L+ZPK8F4x2+8xLVJx8F6dnnZjkG0GUsoYHBXeaWikiLOo/Yd+snbfZcNo+BE 0emSgqq8RXHlHcbX8heX96GACG8sELgqfSiLbOXAS8dzbcyEIXrbZjJQG8jmjupYJ4AzGVyfAUx
 Pi6O+yoHrwFD7ighOeUNNp560Hm0LeGxGTUDcasuVVb7nun+8S0adl9a+/N6Pfchv4KdUms5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_064633_470496_BF325AD9 
X-CRM114-Status: GOOD (  17.81  )
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



On 7/9/25 2:58 PM, Daniel Wagner wrote:
> Hi Nilay,
> 
> On Fri, Jul 04, 2025 at 07:19:54PM +0530, Nilay Shroff wrote:
>> $ nvme show-topology -r multipath
>>
>> nvme-subsys2 - NQN=nvmet_subsystem
>>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
>>                iopolicy=numa
>>
>>           _ _ _<head-node>
>>          /              _ _ _ <ana-state>
>>         /              /      _ _ _ <numa-node-list>
>>        /              /      /  _ _ _<queue-depth>
>>       |              /      /  /
>>  +- nvme2n1 (ns 1)  /      /  /
>>  \                 |      |  |
>>   +- nvme2c2n1 optimized 1,2 0 nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
>>   +- nvme2c3n1 optimized 3,4 0 nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live
>>
>> Please note that the headers shown above (e.g., <numa-node-list>,
>> <ana-state>, <hed-node>, and <queue-depth>) are included for clarity
>> only and are not part of the actual output.
> 
> I do like the annotation what the numbers mean. Could you also add those
> annotation to the output?
> 

Yes, I agree that the annotations explaining the numbers are helpful. 
However, if there are multiple subsystems on a host, including such
annotations inline might make the output look cluttered.

Instead, I propose using the following tabular format, which is more 
readable and scalable. We can display this enhanced format only when
the user specifies a --verbose option. Without the --verbose flag, we
can continue using the current tree-style format.

Example verbose output:

$ nvme show-topology --verbose -r multipath

nvme-subsys2 - NQN=nvmet_subsystem
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
               iopolicy=numa
               model=Linux
               serial=d5dc1170f62100d47204
               firmware=6.16.0-r
               type=nvm

<head-node> <namespace>   <path>    <ana-state>  <numa-list>  <queue-depth>   <ctrl>  <state>  <transport>    <address>                  
    |          |             |           |           |            |              |       |          |             |
nvme2n1        1          nvme2c2n1   optimized     1,2           0            nvme2   live        tcp        traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 
nvme2n1        1          nvme2c3n1   optimized     3,4           0            nvme3   live        tcp        traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1

What do you think?

Thanks,
--Nilay


