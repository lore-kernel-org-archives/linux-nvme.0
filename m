Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AA5C83F17
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jul 2025 03:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DbOGqWArItDIBandpG94NYcXnPFCFZMmf3p2FXRkLNo=; b=HY90uyYAHfWZFv+AGB2PBwdVOd
	VOmtMW7jWcatd3vQuq+ZUG/0eP70jZDSiD50YHiuxuZ2q5rqwAFPvnKHI+rwJ6WZRYXAy+cpg6VVC
	nafUhoR0stZgf9p6cOFz9PU57X+5/iO+300xAL5h6ntp8m9w59/08R32JsAfXGmcr3ArtTCd2yCz+
	hTKKYoj2K0tS9Zg12TeMpM87lYXAyQoOMXGFhyNFOmCxBpwnJBOK/HrFCUrhxpye9o/Cc41X4Mpo/
	PwXu1uU7pqU4tv38ywRDpQXpZZK2q0btTYic3O/k59Tycgl1KWxxUflR8k8LhKF7HpfX2vfxO+yiF
	d382hSOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugEtT-0000000DXuX-36j7;
	Mon, 28 Jul 2025 03:51:19 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugEtI-0000000DXu2-2TFB
	for linux-nvme@lists.infradead.org;
	Mon, 28 Jul 2025 03:51:11 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RGe6e9031356;
	Mon, 28 Jul 2025 03:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DbOGqW
	ArItDIBandpG94NYcXnPFCFZMmf3p2FXRkLNo=; b=qIi6/QJupqxP7px10rhsce
	SQuL9aslFrNCTB4pIhj2iJTiCys8x/nKfSvpXPcccbFTa8+I5kzCbmrwA+1crYvZ
	QlMG7iqu09p0g/0jtUYS0p/QDwugL4N+tnhfUXhljCWtTSUl2AsV/O5qlkaVg3Rl
	uggw0Tv1nWz9dWpVv2e9qBCfkh0XO1ZC6OJ+1qrtMPLUs+n6uTEBseci+4MujaZ2
	oAGXxG3MveFumTOPVqcLvG0bjWWlumC/7IA+qpphCBfuLNJ1aex9pWCcNPzBFstY
	d9us9hd54MA5fdY02LaBcco0DHgIyiqyXvJb2jo3DPOUVZyGc8TQbuO+40LVocKw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcfpsfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 03:51:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56S1nfYF006209;
	Mon, 28 Jul 2025 03:50:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjkuuqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 03:50:58 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56S3ownf42926530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 03:50:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAC885805E;
	Mon, 28 Jul 2025 03:50:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4305F58056;
	Mon, 28 Jul 2025 03:50:54 +0000 (GMT)
Received: from [9.43.67.38] (unknown [9.43.67.38])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Jul 2025 03:50:53 +0000 (GMT)
Message-ID: <237cb015-feed-4c9c-a23e-8c3dc25466ba@linux.ibm.com>
Date: Mon, 28 Jul 2025 09:20:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: Remove unnecessary assignment to ret in
 nvmet_ns_enable()
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>,
        Randy Jennings
 <randyj@purestorage.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250725230639.2017274-1-mkhalfella@purestorage.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250725230639.2017274-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDAyNyBTYWx0ZWRfX8Iu/zl8JPzIW
 45W7lanB45DsZ1oRMihoh8/RX9qtQHuwcFsCM1SfkRiHpb7iliHxAp4zgzjbdP0PBqGvg6+x62C
 vRxlKoFgESbaEeymB2vNVl4GmfuIV+ulxjthLa1qz1SQJ+xIvAvOp+WGN8SXJp3R6JQ9W+EfK2N
 NdoCpwL99YiQR1fPC2uRpf11azmrwPw9dblxq7UBj3rwpsPGjG77E2wvY0HwjhosTAufm/C72+b
 HQpiJJJwGrQ3bucOMSd/9tEbs5Iu2OSYv0PR9G0jEuaBsKfqRWxlO5p5coTbB2mn7He5Vg0+eYu
 yFOrs8TwzjOgxzAhpljy73YKCWkEYy0FiednWlah0qUEbgLmsfjlO8SiujK+TnKO0y+BmRgbMfO
 rOj5kUa1VrGNiD+pdVYafWi2jXrIguXHdNQQQz1axsno0VjLJr7mO9ncHofrXNgewm02IYUE
X-Proofpoint-ORIG-GUID: LRqPzrUpa55xHa5PNvzZEQe4rhK9nDxr
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=6886f3a4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=WTJdmG3rAAAA:8 a=VnNF1IyMAAAA:8
 a=HMNGUcPwllwntIP3TpoA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10 a=q3NGepEMMmKWaCv8Sx90:22
X-Proofpoint-GUID: LRqPzrUpa55xHa5PNvzZEQe4rhK9nDxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=865 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280027
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250727_205109_100353_B2BBB931 
X-CRM114-Status: GOOD (  10.90  )
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



On 7/26/25 4:36 AM, Mohamed Khalfella wrote:
> Commit 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
> moved checking maximum number of namespaces in subsystem from
> nvmet_ns_enable() to nvmet_ns_alloc(). The assignment to ret in
> nvmet_ns_enable() is no longer needed, remove it.
> 
> Fixex: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

