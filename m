Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC452C88E53
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Sep 2026 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n26R9jiv+tsvarYTU98rS1CbuiYGkxrtGiJDspf7GoM=; b=oQXEHSESHVFXfTlLvL2ZrcFDSp
	iYShbc+H1bPtjT1Se0acmoyzi2vGIIJIHNOY1Mx50XDWSXOGUYwXIqUWrJmkhgYz/3EByeILDFjWC
	EobmA9X3Tzz9Ap5FlkX/mGb/crUCkTLxsi4OuL5qXPckJK7qMKGSY4+PD2LvtxG/FVknldLUjqhnS
	Q/HX+rhjDmsGao/GejsCHKpvenYa1I8ktnn5TZjKaAroAAmxwMDElCrDwa1phVGDcfGNzr4jnOqeC
	feDxZQgIdATNTROmUXkdMCuuLJ/0xaQMD969PkdHsPHtBsigckRJadigZ0kbyXP/LQRfMHN1wh+ag
	2uxyVtVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5Ksi-00000000mEn-0uD0;
	Sat, 12 Sep 2026 10:22:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5KsY-00000000mEM-3LJa
	for linux-nvme@lists.infradead.org;
	Sat, 12 Sep 2026 10:22:40 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C8W2OD070818;
	Sat, 12 Sep 2026 10:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n26R9j
	iv+tsvarYTU98rS1CbuiYGkxrtGiJDspf7GoM=; b=keGpsYKaySVKFua+6Bbu65
	1vmJzXH7cRV/o94vO13W4rDIc8sn9oRgDbjopvRGxVOcTCUiXkkBoLBm7FQ3HiNV
	pQgis73FtOp4yuqqZ3V69Zg5uR7AmiYpkPUyDtZRl6FuKu2p12MQ4sifWtdWYhK0
	w7IVE5xiujqKSAYHPfI8qiEUheR5+MXGa6sNVS+/4iSpDEfu7KF6aLZgsBYLu/ED
	WBxsAI5kBpCOJCg3jqgwKS4g288Hpmhly6Qr7l/ohBuVJ89y9sjX5pYZ7n4ucaQX
	Qe9TcV68zb/Lj0j0qlM5qc6GFvEME2AOh+aHNjrNBCMOdOygVG4bQg0VVwHgQ/Kg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcuh0f5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 10:22:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68C856f13025597;
	Sat, 12 Sep 2026 10:22:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq32tkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 10:22:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68CALbgr31130224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Sep 2026 10:21:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AEE358053;
	Sat, 12 Sep 2026 10:22:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AFEC58043;
	Sat, 12 Sep 2026 10:22:15 +0000 (GMT)
Received: from [9.61.162.129] (unknown [9.61.162.129])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Sep 2026 10:22:15 +0000 (GMT)
Message-ID: <4c27c15e-1269-4158-88c3-ad43719b4f3d@linux.ibm.com>
Date: Sat, 12 Sep 2026 15:52:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] nvme-multipath: pass I/O type to
 nvme_find_path()
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
 <20260815173502.1185929-5-nilay@linux.ibm.com> <aqSC9kxn5_MCJOPt@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aqSC9kxn5_MCJOPt@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE0MyBTYWx0ZWRfXwdXs9Hb0ZZiZ
 d2zZUasnzZM5DXkuH9MSDtRKR7ag5pfD1XxRV+QKilWM8lSpEeAbesLVItu59cafi8gxaaYv1u9
 vQHJWxrtGIxWcQwoBHcBGCi57PSvpfM=
X-Proofpoint-ORIG-GUID: HHNv0mN-B9bJr5mLbFEquIwJ4IpcXeNl
X-Proofpoint-GUID: 68Ua01j0nQHH3br0ddnLw_3KXVdtSxK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE0MyBTYWx0ZWRfX7gE8FC3/yNEO
 v8R7IhlCMDfCaUcmd4tOiFTzatSRkOz/zeAr8KM+SWVwUDp0hU3IumOM82C3TBuIs07NPvpeujG
 GBbqMogx/gWjEWvdXKlpHZ4G7mBBb983/B97kJ79wa5fyTLWNu5rJLSl8o1fI7KnodEWYumYbb8
 D9tgY8wfC1oGN0SYpfwb1wv/6VMFbg5Dq+Pw5drUx5yMop6Fk/ZVssNZ/zaeZ7Sw9xt1J+KFfkv
 yMciuchVvG1klVBahv/kqDj2xS1chjZbvrt9JeO24CUL1jH10Gk6sz67nrpaTSDEvI3oNkn0pc0
 T5jmmB8dIhXsAMqnCp9jEBaORlZaN6gKio1fNbGIEBCaYYLd20qZpJGbe5EEBCOXe4p31yuMPiE
 4qK+9PPgGpmKX8hFsxiOO3NYL58KvC9ZJNdPU2/8G04s6JpwMjPcg0KqzbILNaEBFZikwNF29+m
 d0w8UMA2GCWe9EsOCYA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa527dd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=0BZjBvD2gvo1naJr9sAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120143
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260912_032238_984236_66FBE1F9 
X-CRM114-Status: GOOD (  20.27  )
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

On 9/12/26 4:08 AM, Keith Busch wrote:
> On Sat, Aug 15, 2026 at 11:04:26PM +0530, Nilay Shroff wrote:
>> @@ -804,12 +830,24 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
>>   int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>>   		unsigned int issue_flags)
>>   {
>> +	struct nvme_ns *ns;
>> +	unsigned int op_type;
>>   	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
>>   	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
>>   	int srcu_idx = srcu_read_lock(&head->srcu);
>> -	struct nvme_ns *ns = nvme_find_path(head);
>>   	int ret = -EINVAL;
>> +	const struct nvme_uring_cmd *cmd = io_uring_sqe128_cmd(ioucmd->sqe,
>> +						struct nvme_uring_cmd);
>> +	__u8 opcode = READ_ONCE(cmd->opcode);
> 
> Just fyi, the READ_ONCE is used because this is shared memory with user
> space. We re-read the same field later when constructing the command, so
> if the user does something tricky like changing that opcode, you can
> have the wrong group for the command that actually gets dispatched.

Yes, agreed. If userspace modifies cmd->opcode while the SQE is being consumed
by the kernel, we could end up selecting a path based on one opcode value and
dispatching a command with another. However, per the io_uring ABI/protocol,
userspace must not modify or reuse an SQE after publishing it to the kernel
until the kernel has consumed it (i.e. advanced the SQ ring head). Therefore,
under the expected protocol, the SQE contents are stable while the kernel is
consuming them.

Nevertheless, if userspace modifies an SQE before it has been consumed by the
kernel, then that violates the io_uring SQE ownership protocol, and the
resulting behavior is not something we need to account for here, IMO.

Thanks,
--Nilay

