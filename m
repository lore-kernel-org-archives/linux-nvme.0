Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3559ACD98C6
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2026 04:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H+z6azS+N00F6ldHNHxBN5F0o4OUi+zrHlSCZxmylkg=; b=U8eSDsqc0gxhNTbzHhWBvCf1YM
	uhfSyo8YWPinfhoifJEdeYF99NulMXC+xROiVd5zpMUdzMrx2DAaUG6TS0z5iAddjWhZ0q8GT4naD
	HXv65aW2Jqz/kbBQY6ojh4U9FubsQx7Ub8tIeL+B1uxiHQrTBdxK++cIdMcYB8PhXxfc1Uic/e4Fk
	5FGSnzg8UiIwUH59pAYtAYWkpIVqTXl2T5aUKJnyNb/d9U8PXLnNFsA+6UfuQAdsgREtIrJL9S4sY
	TA9OZZ5imSmjGxif6CAF/UPt4oc7RBywIy0LdvUrThx2sPSqL+1F6bBM5h6HWrbNlt5I2TaYsm5cU
	wzn5alTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXXRM-00000008hKZ-3lcW;
	Thu, 11 Jun 2026 04:54:52 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXXRK-00000008hKF-3HJw
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jun 2026 04:54:51 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu58E4146558;
	Thu, 11 Jun 2026 04:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H+z6az
	S+N00F6ldHNHxBN5F0o4OUi+zrHlSCZxmylkg=; b=h0kAO2XZGRZC4AcT0d5/4t
	EnvSGuCp9AcyIggGAeZG+FWT/ACWXn3UGKn+RRu5Qe62HNgfPTKOOgfxmqXedskM
	KK+EY9r7KbELkhiwBanx5zSSCElDWpdm7oPVJM6d5MaqXNnEHVJ4DWx/HBGdeHk6
	xUKQDrEpUfXR6qcY8dCw4g72PtTyLRJhUP2S2CbbotOhxt0B2mMxH8sW7k9ogooK
	GQaCxMKPRnh34W5/jgk+Gd9S7ParOlfzzcG2jm15Y5b+9ags4OaHF6/70RSKaTku
	AVuRevQTf7nly7xAJCKQifdxfoRB2k/SPDhRKq/meeQD+tFpr3ME8xvEtSK2BISA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c1ft3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 04:54:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65B4nhdm006049;
	Thu, 11 Jun 2026 04:54:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09sp7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 04:54:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65B4scJ954657328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 04:54:38 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD95858043;
	Thu, 11 Jun 2026 04:54:37 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78E5558055;
	Thu, 11 Jun 2026 04:54:34 +0000 (GMT)
Received: from [9.43.60.77] (unknown [9.43.60.77])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 04:54:34 +0000 (GMT)
Message-ID: <917afe98-75bc-4237-a9fa-7888b37dd3f6@linux.ibm.com>
Date: Thu, 11 Jun 2026 10:24:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] nvme: add Clang context annotations for
 nvme_queue::cq_poll_lock
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org, elver@google.com,
        gjoyce@linux.ibm.com
References: <20260610142743.115898-1-nilay@linux.ibm.com>
 <20260610142743.115898-13-nilay@linux.ibm.com> <aimVA51B7z4dsMja@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aimVA51B7z4dsMja@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA0MiBTYWx0ZWRfX8Gyq2GVo8TmG
 WQg0jUms+Ep1kxJoSi+ZMO4QEF/4FP4ZW8AqX5gjWgmNcPTWqPdZLcURvLGHSGIxCxzyVn0St/A
 mTUjDSQX4e1/LNyFrjgz4bnnnmIyE4g=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2a3f90 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=-BXssvoQmy4FsglJak8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IyGLlf64j6KKPiQPbeE38_IdVS3IxvKP
X-Proofpoint-ORIG-GUID: ARVgYIszUWeUNbeRqIPJgq7xh3VJqXvG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA0MiBTYWx0ZWRfX3QRfjROrcstS
 LqS8WZkM2WxYv3amGdX9vLLZxvJtoPgnXqg6MSdDGR5BoegzE2W7vUXSdilJxGQ4MuBDranHypj
 8sXPm8YQb0Bi8dbJ7Tn72HW8Mv7M/gRAVUA9pnpCekvPjQABCCMYUkAYjLPaVijcsZgLUVbpgs2
 9L3LSdLe310iQi+g9KzflTvb+LoDdhUOELRtMsQPB0fGR95vX4QicET6f99VtMTuj1fD72T69d8
 rkps/j9KkMEV5L2k+nvB8T5L2cTinN3SU3pBp1KxeA9y3YwS5O73ESwMWT3bYgkoXa1nRm7dA3F
 U0p60hBLjc2LuGG0Rbfr0WzrVSUUofpPAe+Pn8ylzK1fvUM4YdFVSopvE7lqufZx1+1bOxWn9sM
 cYBv2UoXuspXXuDkEIidtwGOx/QgLBxMYQ4B3SxTO6d4bARN5SbN2naOH/aPtYFWYEPCMr4sdv2
 xEGk/yFrjAPqHWuiM3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_215450_826300_F0F7B7AF 
X-CRM114-Status: GOOD (  10.98  )
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

On 6/10/26 10:16 PM, Keith Busch wrote:
> On Wed, Jun 10, 2026 at 07:57:32PM +0530, Nilay Shroff wrote:
>> Fix the warning by acquiring nvme_queue::cq_poll_lock before invoking
>> nvme_cqe_pending() in nvme_poll().
> 
> The check outside the lock was done on purpose, though.

Oh okay, I didn't know that. In that case we could skip
the locking around nvme_cqe_pending() and silence the
compiler warning using context_unsafe().

Thanks,
--Nilay

