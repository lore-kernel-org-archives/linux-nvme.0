Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D68C5AD5A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 11:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfRmWvu0tVeS6/pLrCHDx2e+b36Cf5WvuQHTyeHszRw=; b=oyrooLTtmrrbapHND9EA2d8O0s
	EUZRhzECMUb9Lw2UxHsS42a+kn+yrS5GrI5Ox8VJ5K3nGG5+dObAEZfagumYvtSgXYIw37cwk9NUM
	h1a9UinYN3m7PlzCB+Zaqd0q1WaICrSIFf6zkTxxwEurQtMMuVt6X6a4F3CzyC4iZs8DKxH+4gYcJ
	aXgAbMJmzc85UEuGpvw89PA64iUaSCiL3UM5fvGg7NbrTtVNkvjrLBuDaUX/ABH5t5ElnMMPcikpL
	+DDnMybwSam8cyewd629k8QfpMQHjn2weE5lRBR/kJRItSNONWm/tZTbH8kabqIWXWHUlb7wWh4Bx
	JK7BRc2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7TR-0000000G8He-15Th;
	Wed, 12 Aug 2026 11:50:21 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7TN-0000000G8H3-4AH3
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 11:50:19 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3iGi2205442;
	Wed, 12 Aug 2026 11:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qfRmWv
	u0tVeS6/pLrCHDx2e+b36Cf5WvuQHTyeHszRw=; b=CfIUV4IbZW/isv+EzyNFzf
	Y7qd3LzqwtB944SSVa30AHP2EHxLn5bCLyf5suge3lAtoZJ3mfBhfjpMcIyOO8l3
	5pvm1dl1mE9qqocmKQhbqUhr6Znpil9jRVizsuEC60bTpw7m9axnuAQqVcK5Ph/B
	8rRbssw/iKFd9cJcrQXxDA879LhiO66dQBMZUpgKeXfM7rg1k1YgT1LPIJJ1n8xD
	BGem2fp3NLbzUQFyoDFcfUpIDkef+D5CjxjAgZ4Kj7MC9LmZj+bXKSSlUnW1O3Cg
	2VgeMvpZzEUx0SmW1u+z7S4UDG5xn1iMXU78561WDbg4SVwGI50MIf/PIZXj/3kw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23tsfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:50:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBns4t018709;
	Wed, 12 Aug 2026 11:50:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gdp2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:50:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBo1tj28115612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:50:01 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D04E658056;
	Wed, 12 Aug 2026 11:50:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27B8258052;
	Wed, 12 Aug 2026 11:49:58 +0000 (GMT)
Received: from [9.61.0.237] (unknown [9.61.0.237])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:49:57 +0000 (GMT)
Message-ID: <7c68c535-8ae0-4a93-a5ee-5012edcf529b@linux.ibm.com>
Date: Wed, 12 Aug 2026 17:19:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: kernel test robot <yi1.lai@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, kbusch@kernel.org, hch@lst.de,
        hare@suse.de, sagi@grimberg.me, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com
References: <20260727151652.3660476-1-nilay@linux.ibm.com>
 <20260727151652.3660476-3-nilay@linux.ibm.com>
 <202608111002.8c383e35-lkp@intel.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <202608111002.8c383e35-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c5deb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=sxdaxH8PD2DPu5lfcSEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX7SNnmwvsKgg/
 LfTzfxkUR2W3QceCZh4iuH+nbLH/BjSbLErl/0h7vIfACzn+wzVQh4pm7RKbgPTomJjX11x3EcS
 By7ch+G6sW8OeIAHgn45skYYwXSr4yGgtUdc21+YnWc3dtHvMcczX5BMWDazkOH5/c7ZFckISzO
 Kbfu7txXi2C09JlnfCkQDsi2T4wRkmz3XQ7Rav/v10OQVnvh7NB5guH8AX2vJXZQTVVxdlwZc87
 Aab6aGb7p0/CtUiltdoBWD0cusP6fSqT36G+T83B2AiArXowqL0/t/dlrc2FD8SIwidY+jJ/9Y/
 9Qr2MycPGD+gIxhUGYWLyFTSlEwkH0ORPzFctASsFzrqKhNEXhh18vRk9/LcecqVuYJHVM6u4yk
 nKrhMTa9QjFkJ94LhhYvbq8ic9kHQesbxT37n0VOprDgCYJs6tRG0u/0/KbtuqeIfDLv+gRfqn8
 U8pUGp0K9KBICqLyqVw==
X-Proofpoint-ORIG-GUID: 4guXMY6qjv7scyglCU4CpduYkFdVvXHU
X-Proofpoint-GUID: 4guXMY6qjv7scyglCU4CpduYkFdVvXHU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX2yCtrBf3ZwLb
 UD4eI/F/44gcJG6gvYirg+d5w4TA+jm7YSBkjhBfDuAWtAaGYbGb5l0h9/iz+uLDFyksZU4Wk+q
 kc0UjYXTmAnFeWo4epoUk3HPX/O6kPM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_045018_152606_3E3F9D94 
X-CRM114-Status: GOOD (  17.26  )
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

On 8/11/26 2:06 PM, kernel test robot wrote:
> 
> Hello,
> 
> kernel test robot noticed "blktests.nvme/048.fail" on:
> 
> commit: 657b4cd151e042afc228615869b2a6876b91b8fc ("[PATCH v2 2/4] nvme-tcp: limit I/O queue count based on NIC queue count")
> url: https://github.com/intel-lab-lkp/linux/commits/Nilay-Shroff/net-add-helper-for-device-lookup-by-destination-address/20260731-154725
> patch link: https://lore.kernel.org/all/20260727151652.3660476-3-nilay@linux.ibm.com/
> patch subject: [PATCH v2 2/4] nvme-tcp: limit I/O queue count based on NIC queue count
> 
> in testcase: blktests
> version: blktests-x86_64-72a6349-1_20260804
> with following parameters:
> 
> 	disk: 1SSD
> 	test: nvme-group-02
> 	nvme_trtype: tcp
> 
> 
> 
> config: x86_64-rhel-9.4-func
> compiler: gcc-14
> test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <yi1.lai@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-lkp/202608111002.8c383e35-lkp@intel.com
> 
> 
> nvme/048 (tr=tcp) (Test queue count changes on reconnect)
>      runtime  4.358s  ...
> nvme/048 (tr=tcp) (Test queue count changes on reconnect)    [failed]
>      runtime  4.358s  ...  7.340s
>      --- tests/nvme/048.out	2026-08-04 23:49:51.000000000 +0000
>      +++ /mnt/nvme-group-02/nodev_tr_tcp/nvme/048.out.bad	2026-08-06 06:04:55.281322408 +0000
>      @@ -1,2 +1,4 @@
>       Running nvme/048
>      +expected queue count 3 not set
>      +FAIL
>       Test complete
> 
Thanks for the report!

This requires changes in blktests nvme/048. So once this change/commit
is merged upstream, I'd send another patch to update the test.

On another note, you may want to check your automation script which sends
auto-email. I see the email subject line is empty.

Thanks,
--Nilay

