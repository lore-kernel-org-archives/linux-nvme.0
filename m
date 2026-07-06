Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DF9C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 08:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aFMIUgZvtLJ8zKf0bGC0aL+izBI+H8TAkAn1ru1WwQU=; b=WaQPcZi5w2lIcWXEoS2XtHuHXu
	uW+0Uw1OIo6B+dpNNwdWv6oXFInug+xOwY22imx3vhX3H3aDKLWR22O7U8Au7buK+WPNkJI8VyCDu
	FnTkF+1lwYPmwzfAK+6r9y9MWXJNpHjCtkjo+oLg62D/tojY8yePkcVhh+2qbQNyXNgEHAc62xT6i
	mb/8oYBr+U9fzHWuPzvG6n+wA5hAuO1cG1K8FNIA8AazNYn5zfFH1RxKczwpxjIS6wEr/uWPBwHgF
	5rPeviT6oDQf+StJyAJjJG/EnWxGFZaaQKgbWoyWTfCntgRfvgFCCD9+mz+L+LgxDVHr7k4BOmM+1
	/aQdlhfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgerR-0000000Br1h-3B0I;
	Mon, 06 Jul 2026 08:39:29 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgerO-0000000Bqzy-1ncE
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 08:39:27 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIWCo2250720;
	Mon, 6 Jul 2026 08:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aFMIUg
	ZvtLJ8zKf0bGC0aL+izBI+H8TAkAn1ru1WwQU=; b=dB0KDhQ7tDFPpQQTvfin6E
	lRpkEwZAni3GzixNzEcNl4ecPdIegNPbZuNACqvqUnXy4XhNPGoYVGZPLRjMAe6D
	cCtUexxKEvIzq4RbATO4OPAPxCxyC9B/BTC1ZSG1JY4giKrQlPQQUep2FnICPXpr
	lbQrMbpsey7nhEorNEbuS/tJKQRGYwOw4/r0cKCpNQgkuzXWPiokfNKADadhkVdG
	t0Tnre5gwl6M3A2tOFbZSYa6hUfiHUX/zEJAqpk1KtxL+WoSlYfCk+AM6rHjUYl3
	PxXdfxFF4RHhNjPji/HfThEfjtkjZzDDjHCQ06ty8DuZLDsocDE1d8ufXGW36AWw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn8mh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:39:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668YZ0u026498;
	Mon, 6 Jul 2026 08:39:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpvyyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:39:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668dBOu48103694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:39:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E1065805D;
	Mon,  6 Jul 2026 08:39:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70B0C5805B;
	Mon,  6 Jul 2026 08:39:07 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:39:07 +0000 (GMT)
Message-ID: <96f86707-6806-43d2-a459-29d0e6466219@linux.ibm.com>
Date: Mon, 6 Jul 2026 14:09:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] nvme: add ABI documentation for host sysfs
 interfaces
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com,
        oliver.yang@linux.alibaba.com
References: <20260706023439.3054578-1-kanie@linux.alibaba.com>
 <20260706023439.3054578-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260706023439.3054578-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4b69b1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=SRrdq9N9AAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=OG9dgyQsJ6ROf7aGtHQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: P1Cw6mRuvuMPbegDm_HgxNRsYxxX0Esw
X-Proofpoint-ORIG-GUID: oMLQweBhmZW7fJGUP3jTWw26egC7Swo5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX2fDcH64fK9gy
 mBazweyXWIKbmkx9MtOZZFwRXd3YLRhfw4yy8GZMZkvyTDBHqDwPBMDQNH+YpGy64IYRuzktKA6
 t0K0lzOPWE95ZuTJTG43dAzcw7EPNYQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX56bhmZOLvTqD
 S5S4VHgN0o/uzAHhGp6d0FEGpjBujMHifSqXdoNtYO/AtPCeyapKoP5xQIxPemFFof4+VT75ZUE
 1prvC8O6mdv1QV6TWAbXxeAs9S+T+ZobRUEhx9teVoApljRb0TosTBjtvucsTcBjnXTRirOBd7K
 AEiKPcXUBb44rFe6aerHwk1wndhas8niZ9AkxFVrFk8II0JsS49Ql9nQcARXzZHnIEu5AZz+rsM
 Q9SUNKMZ7qr/CpoMJ5CC3kVOdNmMAloTe6x3X9rASpC908my0LgauS3lX1Z+xv/+Dp0sc805vdL
 M0OIMWrv6BzFB6COJZ2T9S8S92Qge1C+PveyLhLPbhxTBNktGbumyOuBU6cdvZHldAAwM5jkkee
 rMvWkpYUPZyExBasE8MHdFpeT72IrixzngipHQX36/Df7ZBZf77/IkwK0FtnTSjCger31ABWE8q
 fWpFAxydF1w9/sa+chg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_013926_620752_63575405 
X-CRM114-Status: GOOD (  12.47  )
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

On 7/6/26 8:04 AM, Guixin Liu wrote:
> Add Documentation/ABI/testing/sysfs-nvme documenting all NVMe host
> sysfs attributes, covering controller attributes under
> /sys/class/nvme/nvmeX/, namespace attributes under
> /sys/block/nvmeXnY/, and subsystem attributes under
> /sys/class/nvme-subsystem/nvme-subsysX/.
> 
> Each entry has been traced to its original introducing commit to
> provide accurate Date, KernelVersion, and Contact information.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
> Reviewed-by: Hannes Reinecke<hare@kernel.org>
> ---

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


