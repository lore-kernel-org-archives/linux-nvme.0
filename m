Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0415DD6395B
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2024 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1GuDeFUj6LqwrNYgCSdn4xFiJPa0CXZ9bYmm3HhkVBE=; b=c+8lVHKBvtSDyyeW0gCY0WlPny
	symzUqO/Qux/D5T38tWjbrTCrGK/NzMBjHZ9XVZgFgdVg08xNrdtdoeA+Zkw2G/esf3laT+nP1K5U
	FeASW0PRIYod/o6+fxj8WcA38wPuQC9MT8IBKKbpJfF1OqW3BC2hguPDN182YFYf66Vj9qa1ijxYB
	wpA3U32qWde4G1JoYx2QFV1DgD+Am9Ecw02O7uEBjjBLrmMdYFFZqbXMgBXTjMPUIG6f8rwJgklG7
	yIDQwUFyc2yNQHg4dR210h0gAS+aGX7bFUrTM/vhjWl5yy2twt2J+yuRzg0icQYvGfS4zLl09Wk6z
	StVwcy+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDlOT-0000000FUgd-0O6v;
	Wed, 20 Nov 2024 14:09:21 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDlMI-0000000FUAP-3uSh
	for linux-nvme@lists.infradead.org;
	Wed, 20 Nov 2024 14:07:08 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK7lm3g002773;
	Wed, 20 Nov 2024 14:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1GuDeF
	Uj6LqwrNYgCSdn4xFiJPa0CXZ9bYmm3HhkVBE=; b=OWEGsKqnDiW7wXpc6UWAUH
	TgUeHP8N5xmqlhtvNfforfRljWbSrnIZzvm1Unl8AG6JbaOg4Vq9COVxh1wdKs0P
	E0QTrfVjuW2LnKOH2Hj1omdWMmL7Lf+Y75dEFNNWobg65KUvdTnOucCz4CUzOF4K
	Ikjlljap9WbSYJtC7q3HugcxEUOPJ9mHyw+spGzdDh8kjyHIjJ8tyZCS6X+Q/biH
	THtvW/ulbX+lW6tmUX6XDgdbYAoRRyMVokmt+c9wlpxdYjsQn2ew8Jealtj8jRXg
	tUXKFIF2u8uJ4P7fKqITvmcs5zqc5/5so57YXzADGU1CR5hzGp/ce8FTDN6rw0Bg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtjw88p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 14:07:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKDSLKN000576;
	Wed, 20 Nov 2024 14:07:02 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y77mbg24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 14:07:02 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AKE71GX56230284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 14:07:01 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E4F05805E;
	Wed, 20 Nov 2024 14:07:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B27875805A;
	Wed, 20 Nov 2024 14:06:59 +0000 (GMT)
Received: from [9.109.198.240] (unknown [9.109.198.240])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Nov 2024 14:06:59 +0000 (GMT)
Message-ID: <7f35cbe9-9e12-498b-b46a-be1f570772fc@linux.ibm.com>
Date: Wed, 20 Nov 2024 19:36:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report][regression] blktests nvme/029 failed on latest
 linux-block/for-next
To: Yi Zhang <yi.zhang@redhat.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Cc: Keith Busch <kbusch@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rU-Xj3lsQs21YkDwzdMlCRvWdMKZNC-i
X-Proofpoint-GUID: rU-Xj3lsQs21YkDwzdMlCRvWdMKZNC-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411200092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_060707_117869_82D30550 
X-CRM114-Status: GOOD (  13.82  )
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



On 11/19/24 16:34, Yi Zhang wrote:
> Hello
> 
> CKI recently reported the blktests nvme/029 failed[1] on the
> linux-block/for-next, and bisect shows it was introduced from [2],
> please help check it and let me know if you need any info/test for it, thanks.
> 
> [1]
> nvme/029 (tr=loop) (test userspace IO via nvme-cli read/write
> interface) [failed]
>     runtime    ...  1.568s
>     --- tests/nvme/029.out 2024-11-19 08:13:41.379272231 +0000
>     +++ /root/blktests/results/nodev_tr_loop/nvme/029.out.bad
> 2024-11-19 10:55:13.615939542 +0000
>     @@ -1,2 +1,8 @@
>      Running nvme/029
>     +FAIL
>     +FAIL
>     +FAIL
>     +FAIL
>     +FAIL
>     +FAIL
>     ...
>     (Run 'diff -u tests/nvme/029.out
> /root/blktests/results/nodev_tr_loop/nvme/029.out.bad' to see the
> entire diff)
> [2]
> 64a51080eaba (HEAD) nvmet: implement id ns for nvm command set
> 
> 
> --
> Best Regards,
>   Yi Zhang
> 
> 
I couldn't reproduce it even after running nvme/029 in a loop 
for multiple times. Are you following any specific steps to 
recreate it?

Thanks,
--Nilay

