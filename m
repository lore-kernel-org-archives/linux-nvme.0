Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81101C54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=keke/RHsgLPtgpV2YsTbNo8QH3RGmjjUM7GUT79SdEQ=; b=H5rwsJkxop5zFcvvyLS+vY6NbQ
	qOLoSi5p/UunKfsU3sX9edbno7C+RoXj1Yizm/ws95ihlz+nVA2lABVTpq508dk1xwvQJCvAYF+6T
	3WZgY9JGUKPL9QLyNjN+ECyvkEhH4DDp8v/M8W8EJBBhJOUHD/MMeEhrnlWPjksbuVcKIXCvjzN86
	WacXU5dxJ8KQi/5QrITHoe5lIJd7wOujjD37lgVQOKTcyuwHagpvaD6gdeMfZHl8V3qjKqTXMBQBn
	j7EKTpW2eeB0qCyS5gyGcZ8re9oQinZpCgIdFNYw0WA0s1h97BM9OX0LdMbdE7q4PHBgB5fjYjNtB
	NrV+MZRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpn0o-0000000DZSw-1CVz;
	Thu, 28 Mar 2024 10:29:34 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpn0k-0000000DZRq-1RZV
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 10:29:31 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S8N31S021057;
	Thu, 28 Mar 2024 10:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=keke/RHsgLPtgpV2YsTbNo8QH3RGmjjUM7GUT79SdEQ=;
 b=E+xSe1GHwCbRytNAeTlrfH8e/7RPusySPi7kwZiuiVbUZxDS7Esvj+EuGLTI2hj6Ncfb
 ptPfW1XDt2ZoVaH1K23LPmopRKJRaWJj5QuuyJ59iKosZIUo4ZU4Xtj+pRmqKaUiIGy6
 QwoCOD0w/IASTEB/QWR/2bj+UOITuL/1+jVmuoE9eRpulUsp9AgGuyIOPP0jeo37l5ll
 WvlAqwKLBOAZKGN9nJwZDea06ZKC5Si53LmSEXiKsF8YTYi4cDcRpFTTINpkeixQnkXT
 kf9cstaIn11VCb8IONNgtuR0dBOQnNO4kJ2/oeByhIrbkQa2kzEKy2CkrpQfewjtHk42 cw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x54ysg9jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:29:25 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42SAD6c9013370;
	Thu, 28 Mar 2024 10:25:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x29t0w1he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:25:51 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42SAPndo15008304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 10:25:51 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E1DF58056;
	Thu, 28 Mar 2024 10:25:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FEF05805D;
	Thu, 28 Mar 2024 10:25:47 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Mar 2024 10:25:46 +0000 (GMT)
Message-ID: <4f10606c-654b-4ee8-9a91-a56bf49e0ecd@linux.ibm.com>
Date: Thu, 28 Mar 2024 15:55:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node and
 print error
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@fb.com,
        Gregory Joyce <gjoyce@ibm.com>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
 <20240328071552.GA18319@lst.de>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240328071552.GA18319@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3rJ8AFXgT_t-lLcXdK0gdTmhVU1zj8XI
X-Proofpoint-GUID: 3rJ8AFXgT_t-lLcXdK0gdTmhVU1zj8XI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_10,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_032930_505169_24B7F2C2 
X-CRM114-Status: GOOD (  18.85  )
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



On 3/28/24 12:45, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 12:00:07PM +0530, Nilay Shroff wrote:
>> One of namespaces has zero disk capacity:
>>
>> # nvme id-ns /dev/nvme0 -n 0x3
>> NVME Identify Namespace 3:
>> nsze    : 0
>> ncap    : 0
>> nuse    : 0
>> nsfeat  : 0x14
>> nlbaf   : 4
>> flbas   : 0
>> <snip>
> 
> How can you have a namespace with a zero capacity?  NCAP is used
> as the check for legacy pre-ns scan controllers to check that
> the namespace exists.
> 
> 
I have this NVMe disk which has a namepsace with zero capacity.

# nvme list -v 
Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys2     nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1                                                 nvme0, nvme2

<snip>

Device       Generic      NSID       Usage                      Format           Controllers     
------------ ------------ ---------- -------------------------- ---------------- ----------------
/dev/nvme2n1 /dev/ng2n1   0x1          0.00   B /  46.01  GB      4 KiB +  0 B   nvme0
nvme2n2      /dev/ng2n2   0x3          0.00   B /   0.00   B    512   B +  0 B   nvme0

I didn't create that namespace with zero capacity and I didn't know about it until 
recently I upgraded to 6.9-rc1 kernel. It became only apparent with latest kernel. 
However as Daniel mentioned in another thread latest nvme-cli wouldn't exhibit the 
issue I reported. And I'm going to wipe this namespace anyways. 

Thanks,
--Nilay



