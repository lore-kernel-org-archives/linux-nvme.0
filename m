Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571BAC61DD3
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 00:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1tQIcY7vdfuqIzWrChlfjA8mVsVOS37DgQuFcL+ud6k=; b=Wy8Zcuq8aw5HKMNyPevLEtg/kA
	Dm5sfrZR3bVFsib5gE0mzYisq0lWo5sU1OMPGZHDkOqnz68ccGbfYQ4deZGBGwbiAgfh5UtlCFBx9
	vXNzXoHxIuRs8TAPC6VL1lvR3Ju8a+jvxT01zXzvjc1G5qWsgSxGaNorNiOBloeSp/yMPJoMFqLHY
	tVHG6q2/jFyyyZJjInXYD3o4HP5uRMg+/ZcohiuWCfHwFh9p4CFoNpqng2+1blr9oVTULojWIvBe1
	bJKf8QTt77IfkgRmBCFRz/N7ys7k/gCHnlHu1VMFHoyYob6IAkQ79tQEauLnpJPmU0mcv8fYHO6lg
	jpG8n7TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1YiP-0000000DZVj-0KZO;
	Wed, 02 Sep 2026 00:20:33 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1YiN-0000000DZVJ-26Na
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 00:20:32 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KWXY02236437;
	Wed, 2 Sep 2026 00:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1tQIcY
	7vdfuqIzWrChlfjA8mVsVOS37DgQuFcL+ud6k=; b=qNyHrI6PwItO35I1a6Q7Tf
	IPK9Em+JL5uUENzTAT8Ovs5b841hXGFeB+vL0I3JUs3yFOP4c7rIkHwJw16T/pMe
	U8u5buQAZoH7KH2pqNkiqTPxWEIxh20lxE1ckpkzsgWcYkb0+jBjuAQDZ/saz2Yk
	dIu9RlTPbYKSft/8/0EUIqw1BpVWlQENiCjIzer74qHy2N/4re26ltnjmyqcsFQA
	1BRRtHjFttI1hgPPtjeoWdE+eE/fF0Gn9kS87CpI1b/TWE2Fw1mVydzjxs8l0xQ9
	cSzEENkNmmCiSXf0Jc/G/fj02nMnqOBwZuWkkpkwQBEKznQeTznEEPM+oXdwnlug
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5ka58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 00:20:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6820BIwd023764;
	Wed, 2 Sep 2026 00:20:16 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygejqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 00:20:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6820KFlx12976894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 00:20:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE36E58099;
	Wed,  2 Sep 2026 00:20:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C2FF58098;
	Wed,  2 Sep 2026 00:20:14 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 00:20:14 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 01 Sep 2026 19:20:14 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        hch@lst.de, axboe@fb.com, john.g.garry@oracle.com,
        gjoyce@linux.ibm.com
Subject: Re: [PATCH 1/2] nvme: keep transport module referenced while head
 node is open
In-Reply-To: <20260831152006.819471-2-nilay@linux.ibm.com>
References: <20260831152006.819471-1-nilay@linux.ibm.com>
 <20260831152006.819471-2-nilay@linux.ibm.com>
Message-ID: <bef962f5dc39ef3c177e10d76f9ed811@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a976bc1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=3rXfYopxgoUhIfHtWu0A:9 a=CjuIK1q_8ugA:10 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-GUID: 5QOXPv254FItFR7PI5_AlPNa8qbbg482
X-Proofpoint-ORIG-GUID: 5QOXPv254FItFR7PI5_AlPNa8qbbg482
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDIxMSBTYWx0ZWRfXxb+6anIKvupR
 3CC2/ALCsnPtsWhchs3/2Wa94bGyZzWUP5wMEm82w0pF6GQWWpZFRapaJHEIca+RV+nmlnSraEh
 yD7bW1EkPYUNe1RQoEVo0Mh5ovjWzKU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDIxMSBTYWx0ZWRfXztxVWBi67sy/
 h53D+pl6YoodwZ7ItQ2fC8dMm7zroIsmgY5UQRdnCjKqqPuzO37NL9WLW457owhmwpXDGhiCr/Q
 q4vlv1UGny1M+TtjjpDoLJLntbNL8IGt/3dz/tkfdVq7asSePV70jUHtJUpoi5WOSQyVPl4W4AG
 2N0BUzuXZGRyc6NbyZAf9af6hVPYxQfm8sRhf87HcVsZ6rgaxF2wxJLcrQfUv81XjUQ1w+MOjpA
 Fa4sWDVaeghlzen/8WxUQ4rspbPjf/jkI5J1oMrsHYKMCQ5UNydEslZU7B5ulHvQdLNGdm6Umb8
 SnYzinjzJFGaH7ieB14xmQExcVaVY+tCyq/ynWnH8PcP5jxlMghBMrR84YGgY0Oezprv5OiUGLD
 XiIKK8MdLXQPJLgOndr6+EwxVvsqyGx1/qkUWCS+fvRmLXO7bWVjY14UkZVBvKNxwMpsCFrtwOm
 FYS9RBQ1GG7GQNAnN+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010211
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_172031_558079_2EC8D80C 
X-CRM114-Status: GOOD (  17.17  )
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

On 2026-08-31 10:19, Nilay Shroff wrote:
> When a user opens an NVMe multipath head node, we take a reference to
> the head node, but this does not prevent the transport module backing
> its paths from being unloaded. This can result in the multipath head
> remaining open while its underlying transport module is unloaded.
> 
> Fix this by taking a reference to the transport module for each active
> path when the multipath head node is opened. Keep track of the number
> of active head node openers so that dynamically added paths acquire the
> same number of transport module references.
> 
> Similarly, when a path is removed while the head node is open, release
> the transport module reference once for each active head node opener.
> When the head node is closed, release the transport module reference
> held for each remaining active path.
> 
> This ensures that a transport module cannot be unloaded while it is
> still referenced by an open multipath head node.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Hi Nilay,

Thank you for your time and effort in working on this issue. I really 
appreciate your help!

Reviewed-by: Wen Xiong <wenxiong@linux.ibm.com>

Thanks,
Wendy

