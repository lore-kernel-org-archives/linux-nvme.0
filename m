Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FF3C61DB9
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 19:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MbXLnoqqKxzJeccDYxgw0PFA6qdn7L6BhRI3iELWRng=; b=ulA5HVgI/uTlvU0KQ5S5n7z7Tv
	j6YgXypFCPJ7ROVFOoRkFFzrKUpkOm6pFkCxNgvKTsV5CyexsVBAnmnmzk9c43oDCThzOj7N8VkeK
	Yn68L+igMZduy6tfhXCbGz0//G6eizOHRWxc7eDyzC+38qUr+afoQFaBVnn+xbQh+5/7atLqC+6Rg
	t0+3o7ZZTAbFoFKVBqWSyfOrpQ7QAEjsabj2rm6G1nUtBgENaPwByi0+bOkKMmwwLWoLGGMtOvSAr
	8+ZU5pnqcRmAsd/p0U9P+Luj1Qhr70QdwoMLCvU5APvcifys0v9YDqqx8d8iAK20SpqbNVQejtuL2
	c0e3ZeKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wywYi-00000001MfJ-1ebm;
	Tue, 25 Aug 2026 19:11:44 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wywYe-00000001Mec-3N4q
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 19:11:42 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PI1ebi1495135;
	Tue, 25 Aug 2026 19:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MbXLno
	qqKxzJeccDYxgw0PFA6qdn7L6BhRI3iELWRng=; b=MC/XoOOEuB3PyqKTA/rh40
	VYdLHQ/OWqyVVq07xGmeZUSpiVh8SmtR9v4GrLxMYTq/+wskzD+qu8dkreJ5Zj98
	/GtaFF9QFpnMW0QlgepQvxo+vR4+OduETWy+a5ha+4tRY/0/shEKUS+8Uji/Y4hJ
	wX7XMqBL+42t5pJpi8Rdvian1LQyjspV5aixmrCxsPIuVVaSK8efnHNMESB0yeTz
	oS2Nl1t5v/1El+KPfm2d2chSRAFEIKOVDka3azuYdk/EapqP+6yp9kxbnyuTHXo9
	FYrtax0s+ZUQ+vC7YrWgarE52b3W39MzrDGxNmURZ4dn85emXJhlIPVNm95HelKQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716htd3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 19:11:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PJBJ2b014995;
	Tue, 25 Aug 2026 19:11:25 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragduwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 19:11:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PJBJ3v30212664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 19:11:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EF745805D;
	Tue, 25 Aug 2026 19:11:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC0A458055;
	Tue, 25 Aug 2026 19:11:18 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 19:11:18 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 25 Aug 2026 14:11:18 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Gjoyce <gjoyce@ibm.com>,
        Nilay Shroff
 <nilay@linux.ibm.com>, Wenxiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH V2] nvme: Add module reference counting for multipath
 devices
In-Reply-To: <d58d0c4f-0789-4c99-94bc-e2e2121e7b7a@grimberg.me>
References: <20260812223206.720363-1-wenxiong@linux.ibm.com>
 <a9d90f41-1493-4efa-abd1-a7071046414a@grimberg.me>
 <d58d0c4f-0789-4c99-94bc-e2e2121e7b7a@grimberg.me>
Message-ID: <5626e2342490081fc4acb47f370009ba@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE2MiBTYWx0ZWRfX9aWstpVgzVGT
 cvw8GCtL4OlfyBtF647KGGHVlWF48epKJUoPV3ltyV5/jWPrzN75nduN6c44eUVmcswIRefdxE+
 qtNUdTIqJHnw75fNPBSiZ2EuFg1x+DU=
X-Proofpoint-GUID: 0YEHMzV6G5kmvYF2yFnnnJIg9c8KC1L5
X-Proofpoint-ORIG-GUID: 0YEHMzV6G5kmvYF2yFnnnJIg9c8KC1L5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE2MiBTYWx0ZWRfX08g7AKr3QWum
 YiqfDS3e8Soe638Q88ajh5RjmvDovnIGWxIxLkytm2BgSlYo9vR150QS+FBRNypn2ehrtN+m6Vj
 30jNg3/f+o3IOpucd8aU3Ev31plR8NvHbsnYWG6dLzY+6vDLKCzGQ91iBm2p9+AjfVjxbBnuJM8
 +B3y8pLzSM7uwQ2zDtfOZsqq+AOmP+ZryDo96EYGMa3meL1P8AV797VNs8FBKnXw5GZ7LMh4HBF
 wkfPfosk5HgkVpp4ZioGzf6Q5ld9h4McqqehYW6XqP1Iiiy9Zla3Dv1FH7EByw6KLQtplZVmTGA
 pPQZ6AVAMXqxqTCjKwLMMo6xLF6jaBYYp9zOHfP0q4uvPsI/OnC8fVG8gc4q6XMxam7vWRmUxMq
 KeWuo80OuuYXp3n3MFhX4YpOwOZW9tbYZBquc2SwNHJ2T2Lnrek56JjpS6o7hoa39h30e2Xw908
 BL0joRzmKcYMpShl9Ng==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8de8de cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=hcsIBT7GoXAFS9bo04kA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250162
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_121140_967015_F0A1FBDA 
X-CRM114-Status: GOOD (  12.37  )
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

On 2026-08-22 19:46, Sagi Grimberg wrote:

> OK, I now read the original report regarding nvme root device. please 
> disregard.

Hi Keith and Sagi,

For single port nvme device, I found out:
If NS does not have any filesystems configured and the root filesystem 
is located on another SCSI disk, the NVMe device's reference count is 0.
When a filesystem is created on NS, the NVMe device's reference count 
increases to 1.

With my V2 patch for multipath devices,
Nvme's reference count always increases if NS doesn't have any 
filesystem configured.
If nvme1 has 1 NS without any filesystem, reference count is 2 after 
system boots up.

Should Nvme's reference count increases if no filesystem configured on a 
NS?

Thanks,
Wendy


