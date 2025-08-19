Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC44ECA0EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 04:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rcqmYywqZ/vIvrXZlJAVkmq6IZRNkYladq6ibN4fGDI=; b=RWZuAxtOeuewclLTY7q0CVUaqn
	3gdPSb03STuZv8MnHvJqjrTyf6+ZmiUidPJTA69gS1/ve7IA/6sujK7IeUaBT4ZGuo2qUtzEKFZiI
	e17ymCctMhhLD9FyflUBpWNmeMl0kB0Y42uaaFbe5rrUUI4U2JGTKUPsGqt2dz6AreHMXpOXZrzhL
	k+Co2x247knGCY1RbdjPmcX1cVXB5Qi9Nt+YBeZX8xjNQ5Lyn19C6vCsAcauzxjcqU7mdEnIAfDhe
	MhsfuwMD7gdygB43UnZ44lBJC+dQN0DsFah8i+TvqU5N6moufv4M4lri3UXMUdF5WMozY1szxRXQI
	3fhWWAvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoECV-00000009NzD-3xJu;
	Tue, 19 Aug 2025 04:43:59 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoECS-00000009Nyo-3Y35
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 04:43:58 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57INOUoE028607;
	Tue, 19 Aug 2025 04:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rcqmYy
	wqZ/vIvrXZlJAVkmq6IZRNkYladq6ibN4fGDI=; b=GA9s+evTyXSxCUZK5LduWK
	NYkedxWElgtTcM8CLEPeucw0QAIfc6O8JoG+ktW//AmRsyMkhmvrvvncsZBbkZmm
	3t+yJ60GiBXYPTDLZUI2PnQhDrAJ7uClaftdJAQRbECd64KArwiUsbsA/dOnPVGs
	HHbaoXg/mKGsfywgPgGSwUPvYp8gICxyITZmCzMOu4qobkZ0S9fb8qnxJr0rFN1K
	Bh50sEOKSuvBR+CbEABAFS7ubHp5tPWL/aaAKavmZY1c43emc1oBLmJ+nSQGMyUe
	H3qSVPMvrmJje53bHWDiE4kRKnuBgM3Cw73AY0ddovuTHcS0pXYur3dJ8D2MXXBg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhq9vt1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 04:43:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J4PipA001470;
	Tue, 19 Aug 2025 04:43:46 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48k4q0rutn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 04:43:46 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57J4hkGa38601438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 04:43:46 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 628C65805A;
	Tue, 19 Aug 2025 04:43:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 721CF5805D;
	Tue, 19 Aug 2025 04:43:44 +0000 (GMT)
Received: from [9.61.13.229] (unknown [9.61.13.229])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Aug 2025 04:43:44 +0000 (GMT)
Message-ID: <742adb3b-6441-43f2-a1cd-c19b55d97ec4@linux.ibm.com>
Date: Tue, 19 Aug 2025 10:13:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/4] nvme: support <device> option in show-topology
 command
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-2-nilay@linux.ibm.com>
 <39506d0c-9205-4638-a516-0cfe0de9a8ff@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <39506d0c-9205-4638-a516-0cfe0de9a8ff@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N50pF39B c=1 sm=1 tr=0 ts=68a40104 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=1bGLrzpakWICxYchNDMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX7WK9ljItCMVU
 r0B2jUt81nvA3yR8KpElwLGwW7UcoQXc/kyhhm057Za5TIfxmdyTyrb802pOa7lx63a4CvaoSDI
 YQDIsrA23LAh6B8SinJLbyDDH/NV37+sqz0req60IVLMbm42yyW4t/XTjxbOL+ZRC4DvRCqRPQM
 vigjsz4F8Too4W41rHyae7N4CTrCmBfWdyO0wLUmcrISNV59YtnpdIptU/AMvE+PWfpEtBI+ckd
 tQq9M+daPQIHgrW4iP/jvBh122a5cc6GSXjYTH/nrqfo4OJ1w6hG1oWdHrB9gJSTGe3KamCg5Vz
 HSnqAe2/p2gGYpaDyd/k27lJhmO8LUaAhb+FDkoaPaAZjsQn79Ik3VLL01ac6uM8eLbvX8ndckN
 Prn8QrY1
X-Proofpoint-GUID: dVKks-ebsUtg_Ol-KsuXFo71YzI-n1Yx
X-Proofpoint-ORIG-GUID: dVKks-ebsUtg_Ol-KsuXFo71YzI-n1Yx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_214357_227445_AB62837A 
X-CRM114-Status: GOOD (  19.40  )
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



On 8/18/25 12:42 PM, Hannes Reinecke wrote:
> On 8/12/25 14:56, Nilay Shroff wrote:
>> Although the help text for the nvme show-topology command indicates
>> support for a <device> option, this option has no effect in practice
>> — specifying an NVMe device name does not filter the output.
>>
>> This commit adds proper support for the <device> option, enabling users
>> to filter the topology output based on the specified NVMe device.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   nvme-print-stdout.c |  9 +++++++++
>>   nvme.c              | 17 ++++++++++++++++-
>>   2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
>> index c597b608..eb56349a 100644
>> --- a/nvme-print-stdout.c
>> +++ b/nvme-print-stdout.c
>> @@ -5683,6 +5683,15 @@ static void stdout_simple_topology(nvme_root_t r,
>>         nvme_for_each_host(r, h) {
>>           nvme_for_each_subsystem(h, s) {
>> +            bool no_ctrl = true;
>> +            nvme_ctrl_t c;
>> +
>> +            nvme_subsystem_for_each_ctrl(s, c)
>> +                no_ctrl = false;
>> +
>> +            if (no_ctrl)
>> +                continue;
>> +
>>               if (!first)
>>                   printf("\n");
>>               first = false;
>> diff --git a/nvme.c b/nvme.c
>> index 27dac37b..c6779cf4 100644
>> --- a/nvme.c
>> +++ b/nvme.c
>> @@ -10155,6 +10155,8 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
>>       const char *ranking = "Ranking order: namespace|ctrl";
>>       nvme_print_flags_t flags;
>>       _cleanup_nvme_root_ nvme_root_t r = NULL;
>> +    char *devname = NULL;
>> +    nvme_scan_filter_t filter = NULL;
>>       enum nvme_cli_topo_ranking rank;
>>       int err;
>>   @@ -10197,7 +10199,20 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
>>           return -errno;
>>       }
>>   -    err = nvme_scan_topology(r, NULL, NULL);
>> +    if (optind < argc)
>> +        devname = basename(argv[optind++]);
>> +
>> +    if (devname) {
>> +        int subsys_id, nsid;
>> +
>> +        if (sscanf(devname, "nvme%dn%d", &subsys_id, &nsid) != 2) {
>> +            nvme_show_error("Invalid device name %s\n", devname);
>> +            return -EINVAL;
>> +        }
>> +        filter = nvme_match_device_filter;
>> +    }
>> +
>> +    err = nvme_scan_topology(r, filter, (void *)devname);
>>       if (err < 0) {
>>           nvme_show_error("Failed to scan topology: %s", nvme_strerror(errno));
>>           return err;
> 
> While I welcome this change, we've had discussions that
> 'nvme show-topology <device>' really should _not_ print out
> anything if the device does not exist.
> Have you checked this for your patch?
> 
Yes I checked that. If <device> doesn't exist then 
nvme show-topology would print nothing.

Thanks,
--Nilay



