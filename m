Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159B6C25B79
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S90rMtHFZP3Iq30tFJARfy4OuYa4F+sQzb5QznlHVuk=; b=mxHklvWQX7wmmyKzdkundo+WAP
	Q0A+rBRezXmm6Ktuf+1z4sRmUNCmDNEUsf2od7OkyQ/e/Nr5Cmhu5WzV3OGLCswivnlAW5zhgd7t4
	kzNgy0spOvx9xfUJ1rzp3HwclgO3vVrTMRdPzPfoQ8NQ2e52iUgqmTA21g03NkSrBS5E+RIupxISQ
	l9L8A4bVm116bWkBaFCsCByPNMcgS2aMMj23lcKRa81TmSMGWqIKfxjBzwiN0HYJnHneDLJZHSm2I
	qbJ9g6R7946bwSSxJRtGTqI6IWkUQzUo7uMU545zumHWRTDFbnPsJAKV8aYHPITwJGoFrfxM0dre0
	J8JZ4Ncw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBawy-0000000FFlg-3IYB;
	Mon, 27 May 2024 14:03:44 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBavp-0000000FF0W-2RKO
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 14:02:42 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RD8njI011579;
	Mon, 27 May 2024 14:02:27 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dibm.com;_h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3DS90?=
 =?UTF-8?Q?rMtHFZP3Iq30tFJARfy4OuYa4F+sQzb5QznlHVuk=3D;_b=3DJV1r+HxZNVG4dA?=
 =?UTF-8?Q?9vssjnKzTJK2vndHohJxT86SWiMKp1rKfCU122AOzHBw+sZ0DfHBRK_Y6tNSS2P?=
 =?UTF-8?Q?LsIknZ8Vjco73PIO7vIu1EDUlbvfyfN6GfopY3WnS4jF4kNj9+De+FBa570O_ng?=
 =?UTF-8?Q?Mdqd3ZbmRdH0U3If4tNSUifYnN1g4Drz6gaxePNFtAz9PgBFR//bShTZRB0Ddrb?=
 =?UTF-8?Q?8Sh_WJVPfeSA2EGloICWp3WrY5axsqer5iB7rVl/6IsCPxn/p8WwJyrhXELAn2E?=
 =?UTF-8?Q?ZAPh+VBzL_qkdghR4IUT2FqjdfsHRlri8wUWKf6oUSajRn5aCdcstkLrNY3zioZ?=
 =?UTF-8?Q?w8vcGa94XK416lD_VA=3D=3D_?=
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yctsfr4cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 14:02:26 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44RAxU7Q006711;
	Mon, 27 May 2024 14:02:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybtat9n45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 14:02:26 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44RE2MNc27263704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 14:02:24 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81FAE5806E;
	Mon, 27 May 2024 14:02:20 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E40458068;
	Mon, 27 May 2024 14:02:18 +0000 (GMT)
Received: from [9.171.63.169] (unknown [9.171.63.169])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 May 2024 14:02:17 +0000 (GMT)
Message-ID: <73e15f32-950c-416f-b488-bc5244f8fcf3@linux.ibm.com>
Date: Mon, 27 May 2024 19:32:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-cli : attaching a namespace to an undiscovered nvme
 controller on multi-controller nvme disk
To: Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Gregory Joyce <gjoyce@ibm.com>,
        Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>,
        "axboe@fb.com" <axboe@fb.com>
References: <f1a7c1e2-3203-4b7a-a922-82fa812455bd@linux.ibm.com>
 <yhvmfctxhfzrcsq4lx6nr3f5n67kegrixtthh3pals7vn5qr26@k5as5whcdrum>
 <dfb2488a-6275-4822-94ec-07a575cbf09c@linux.ibm.com>
 <88f230c4-e16e-4a16-a4e6-a48e605147f1@linux.ibm.com>
 <56198b02-b8fa-4afc-8405-5232d1bf23ab@linux.ibm.com>
 <i2pwif6tfqt4cuodue7bs2lrithuxplmtwmsgwioraih4h3ppd@krnf2pxuijet>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <i2pwif6tfqt4cuodue7bs2lrithuxplmtwmsgwioraih4h3ppd@krnf2pxuijet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -6ryPj1jTHX3Q4k0eTFyWOPZCocxyLbt
X-Proofpoint-GUID: -6ryPj1jTHX3Q4k0eTFyWOPZCocxyLbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_03,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=686 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405270114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_070234_010857_962DE509 
X-CRM114-Status: GOOD (  10.75  )
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



On 5/27/24 19:06, Daniel Wagner wrote:
> On Mon, May 27, 2024 at 04:50:34PM GMT, Nilay Shroff wrote:
>> A gentle ping, if the proposed patch looks good then may I send a formal patch?
> 
> Sorry for the delay, very busy month. I'll look into it next week.
> 
Sure no problem...

Thanks,
--Nilay

