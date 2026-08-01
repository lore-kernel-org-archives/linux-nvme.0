Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCA4C55173
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Aug 2026 14:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xXJlW879nntaanZOK2FIHzSjh19Wnn8AH29eV7xE6pg=; b=rZsc0D8PgAlM28ye9psB2bJhTR
	12aWH9gaXY+v7ZqknsNLlJ9UT411Z+1MxF+AYH+SL9cDnqGALbArOreyxMd3reZPY4Y5JWccf3EO+
	PrWsk6oOAJXfDDhcYDiTuv7iRZv0D12X57H67Gl8FFOmtECm2GdIVms730yhYOm49/B+2+OyqSjQn
	7wurRBqzOFnW7U7QtBW2LWVOcsL/u2S/f2lLSvQhX67v5rhsZkX6IlYKBzYC02c1uUoY0h7pv5i3+
	9Ict3ocR/WmoAjyJh/8a5DzEYPIQFiJt5/VWaxTtAYVRnk4Eg+/b8wjNog3y8nbasxiPksTjn48He
	/r8chWzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqAHn-0000000EhgM-1G6k;
	Sat, 01 Aug 2026 14:01:59 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqAHl-0000000Ehg1-0iNr
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 14:01:58 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671Clcom2923843;
	Sat, 1 Aug 2026 14:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xXJlW8
	79nntaanZOK2FIHzSjh19Wnn8AH29eV7xE6pg=; b=VerTylqsqwzQLFkXgQZM7f
	TIZZaLjFodow9ozmhnvT24FNTaJbEuazVKYvyigGedRFBQTYRvx7fQkp913N7IAa
	d513+IplwKssZ0aAXKWBlPGlzsYPXjKMRZBVyUNt5UiYlMYJ9+SH74woSkuLJqYh
	hvDU7a2WrUZFbzO5e49etOsORiqBNn4Cg3gls/vhvg4AlVbvmUNz0p6X+UrhHjVp
	zeywuzPWiXMG96t7M3hL+/zcQovxXUSK1gi9H/TCFO/C2pZWhdBiJVkiRlLO/X0U
	Ek4AgbcLJpqdLSU2R3zXkpR6+tlgnmnezavyt2NokUdME7LYeIJmmdP61uWJSipg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fq9fd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Aug 2026 14:01:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671DfFwc019968;
	Sat, 1 Aug 2026 14:01:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkm4u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Aug 2026 14:01:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671E1hF345810024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 14:01:43 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1FC35805A;
	Sat,  1 Aug 2026 14:01:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81A4258051;
	Sat,  1 Aug 2026 14:01:39 +0000 (GMT)
Received: from [9.43.78.15] (unknown [9.43.78.15])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 14:01:39 +0000 (GMT)
Message-ID: <6f4a1b76-50f4-45f8-9a56-e6f66637d7e7@linux.ibm.com>
Date: Sat, 1 Aug 2026 19:31:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/070: add a test for Identify CNS 07h NULL
 pointer dereference
To: Guixin Liu <kanie@linux.alibaba.com>, shinichiro.kawasaki@wdc.com,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org
References: <20260731032601.1100664-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260731032601.1100664-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: jQNXJKuRezt3EupqSQ4Z6s-MbX8SiJ2T
X-Proofpoint-ORIG-GUID: Rc7v9RMSWeNdqEqHY6DPQKL_t_w84DoM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDExMCBTYWx0ZWRfXxvxmifJQnxAS
 8sTbHEtEWUuhDyk+Sj3h2WQ6ATFf4aKP6h23GEZdpqtvDRD7seIVWr1mpmBfEujh94u1A8vTucy
 bZhYO2pdLYTW3ZiRr3WL+Y7OTNM9xws=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a6dfc49 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=MkjvqwrSNOGWUdQk704A:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDExMCBTYWx0ZWRfX5CXXOr5CJtEe
 JFRAqZuwPI2KUKI567o0+9zdpy+iZtn+GRN1ebPzOigHg7Qa6srC533uPl2swBgh1sRjKGn2PdF
 6mQK3pt9Jf4nlJRQaPtKr7Sj6bveg/5EP6q3D+D/09UKX7jd93RsFXIxOYQWiH5Wd07l/gqmGat
 zwv8cG+Iu6X8MbakdEygje58ELDmnj20d/KBfJqAbDamBopu/3b4WP43Fc4FQvM+RFK8eesnLGQ
 fR03vcA73cy2XxM3jOTVTYL3s4q+raeSK8Og7HPC4XzVlVf1GkjbaM1dMSnpb9l4el9EtvSi7nu
 Lx+u7PCMftvV96/67XMyM9Cbt85ND4r5e/ihvYQc1J9zYxFlCj43kc1XJ83nsPYNxaCs+QVBOLb
 juOe3Ne1jsJ+bqyBbSgVFMC1kd44fev97CY1ovUNLWnu3FqmrVkuOK2BjQqM/7tGVbfEUAkvOF4
 CqTvxC1flh7Vt+m4R5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_01,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_070157_226908_9C8C0AB3 
X-CRM114-Status: GOOD (  12.94  )
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

On 7/31/26 8:56 AM, Guixin Liu wrote:
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	_nvmet_target_setup
> +
> +	_nvme_connect_subsys
> +
> +	local nvmedev
> +	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
> +
> +	# CNS 07h == Active Namespace ID list for the specified I/O Command Set.
> +	# CDW10 bits[7:0] hold the CNS; CDW11 bits[31:24] hold the CSI (0 == NVM).
> +	# Request from NSID 0 so the enabled namespace (NSID 1) is listed, which
> +	# is exactly the condition that used to dereference the NULL req->ns.
> +	if ! nvme admin-passthru "/dev/${nvmedev}" --opcode=0x06 \
> +		--namespace-id=0 --cdw10=0x07 --cdw11=0 --data-len=4096 -r \
> +		>> "${FULL}" 2>&1; then
> +		echo "Error: Identify CNS 07h failed"
> +	fi

The nvme admin-passthru ... works but why instead not use the existing
"nvme list-ns /dev/<nvmedev> --csi=0 ?

Thanks,
--Nilay

