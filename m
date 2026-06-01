Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C550CD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 07:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ng8b0azL82V1EVHi/WoGx53kuxDv6nrGbej+IcsIf8=; b=ltb+rHgRSSqlWzgvmn9jxiW8UN
	YCZS9txpJ7o63pfiGoxLmQ43ln3kLu8Q1j281RGLTVe3DCqmOawDtZgCq0nTpWRziqJ7gEBcztxFz
	QoArQeq+kOntIygT/cIT07yJbjYQ++RG9ktxtszt2Q+J8Kc9KKRpyjjtV36YPqnXT4togs97NVWjE
	qcBVidXTda1dn72V95/KKyR4wNJ7NxlB2XTIsMpP03WAu5iLKzSYpcjLIwzRsIpz6k5CdXCY/lsZk
	WMtvMFkT5R/p5yTG/jIPukAGl53jXygR8l4y64XB12GZ0LiR643/7E8HKoVmpqz13dF7pWogyob7o
	biFqu3KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwrf-0000000AHyl-2giS;
	Mon, 01 Jun 2026 07:15:11 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwrd-0000000AHyI-0LB5
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 07:15:10 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6514USXv1024631;
	Mon, 1 Jun 2026 07:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2ng8b0
	azL82V1EVHi/WoGx53kuxDv6nrGbej+IcsIf8=; b=KxDzb0+66EebqWrPBt/+mX
	Y3mXVzzNuM4e+dvlROl/T4IusutcQ+WtWQul4AgHx5lJTpLMXnjAawbIaXk6q4bf
	TQ9yWGWQyPRu0VT4YcE365j4sF1NM2kntjHJ0i1a7CN0eGLs4vp6W10NQb5n1b8O
	ehEkcydNnZtm+uUk/0joCdEBO6B0cBL0QfH6ouoLBqLJxZ2YPJycjI17DbUo+GPA
	yc3kRYE9y6EFikXc+RIeumR4IPSjkP0W6BgZfpaBmw4umBZQU7/1Vc8sddP+jMRH
	FTrobBlB0M63xf6+uogNnElLo6LopOg79P4AQNZ3fLFLpmC6mv+QbScdQ4lMiNkg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjpydv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 07:14:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65179A5V031639;
	Mon, 1 Jun 2026 07:14:57 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwy4mns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 07:14:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6517Eu1S59506988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 07:14:56 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64C3058054;
	Mon,  1 Jun 2026 07:14:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1C7358045;
	Mon,  1 Jun 2026 07:14:52 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.253.231])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Jun 2026 07:14:52 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] nvme-tcp: Use WQ_PERCPU explicitly if wq_unbound is
 false.
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260530081059.428303-1-kuniyu@google.com>
Date: Mon, 1 Jun 2026 12:44:39 +0530
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Marco Crivellari <marco.crivellari@suse.com>,
        Tejun Heo <tj@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
        linux-nvme@lists.infradead.org,
        syzbot+d078cba4418e65f61984@syzkaller.appspotmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DFED7A6-83AF-4A88-BEBA-95D4E9C4BC49@linux.ibm.com>
References: <20260530081059.428303-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: sG9rXzG_htoSEe1gBWoscmnOyj_FB7q1
X-Proofpoint-GUID: hSY0MSInALlwKzAS7cmRM93sDLwVaHEN
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1d3172 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=hSkVLCK3AAAA:8 a=nrwuNwfaiopwcPU0MygA:9
 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA3MCBTYWx0ZWRfXwVDeUGFYrCGu
 4U/xfiOEA/4P2gm6tqp+a+mtlkjcVOfH/UEZzgxUoJ61A27zqkL5jbvxfVo3iKFIy+St8kovteY
 nR4+UlL14NprAHdD6nQ1BzU5wDRjH1NrRFbJGViL70JQr1i66asAPcuOeEXEMs3UMlaQeuWuJTe
 ImqNF+xm4slSMm0u3fV1nwC0WKRgJMi1UCaEfMKxSn7Je/ZsVptwJQB6nK8xSSiZxWxiFry6a1f
 4eP83Xq6SjX4xZmBf2l39Wervr5La+Y9nK4SiLWvlaU9o1nPNmXo9J488H3wI3caiIEE88TiADx
 e6DClRtmCRmm1VnuzUjduajGmbsq8QMjs1Qz8yvfqj0yKXwUC2a/0zl1w4347aU5xRUXzgrGk9I
 SI7g7Mf+xfsjzn2txmrcOAlwbyBaLRqZEy7t7bKOxnhQZl90lCdpCmPF1Z5t4ESrsDBdx1ZDieP
 EJJaYPm/b8cBpU2m48A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_001509_130283_B66B0E22 
X-CRM114-Status: GOOD (  19.68  )
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



> On 30 May 2026, at 1:40=E2=80=AFPM, Kuniyuki Iwashima =
<kuniyu@google.com> wrote:
>=20
> Since commit 21c05ca88a54 ("workqueue: Add warnings and ensure
> one among WQ_PERCPU or WQ_UNBOUND is present"), we must explicitly
> set WQ_PERCPU or WQ_UNBOUND when creating workqueue.
>=20
> nvme_tcp_init_module() sets WQ_UNBOUND when the module param
> wq_unbound is set, but otherwise, WQ_PERCPU is missing, triggering
> the warning below:
>=20
>  workqueue: nvme_tcp_wq is using neither WQ_PERCPU or WQ_UNBOUND. =
Setting WQ_PERCPU.
>  WARNING: kernel/workqueue.c:5856 at __alloc_workqueue+0x1d02/0x2070 =
kernel/workqueue.c:5855, CPU#0: swapper/0/1
>=20
> Let's set WQ_PERCPU if wq_unbound is false.
>=20
> Reported-by: syzbot+d078cba4418e65f61984@syzkaller.appspotmail.com
> Closes: =
https://lore.kernel.org/all/6a1a9a86.323e8352.141b09.0001.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

This issue is seen on IBM Power server also [1].

And tested this patch, and it fixes reported issue. Please add below =
tag.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

[1]: =
https://lore.kernel.org/all/dab729b3-fa8e-4d17-894d-07f0c6845e01@linux.ibm=
.com/

Regards,
Venkat.
> drivers/nvme/host/tcp.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 22be0e0eee07..fcf54cc38c3c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -3046,6 +3046,8 @@ static int __init nvme_tcp_init_module(void)
>=20
> if (wq_unbound)
> wq_flags |=3D WQ_UNBOUND;
> + else
> + wq_flags |=3D WQ_PERCPU;
>=20
> nvme_tcp_wq =3D alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
> if (!nvme_tcp_wq)
> --=20
> 2.54.0.823.g6e5bcc1fc9-goog
>=20
>=20


