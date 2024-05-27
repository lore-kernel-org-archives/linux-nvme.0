Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139C8C25B7C
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 11:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1HuxVbYxRMzyqjyaftlbO5/aiaDX1zpVP34KGQGcrVo=; b=fA3dPzPKF+qibH0LJ3NX1/awYr
	ibc2wmJwBfQ06311ZHJniqQ7bEzDmr5iQ5ZhNAu7dO4wDulRJ3AARGqXZL/6i3POS+MhbTwbfz/HI
	PCsSELShjyiN4egXlPAP7twIqpYXp3FlQpUL1FZ1WYLiomq2WE3LL9eo07TB+mhwReCm1CUl7MNtM
	x27aFq4i6EwVukjYPZvCO2b+nzsHzrcEdFRnfwwgKpzWiCF8jTMsTFnQre3oidgP9Yit6o1dm8i6S
	PxzuKJqt1rR5nwuh7+5+clYiXnrF9aCmLaSaII/HZjs7dyb7O57dx/cKKqr7TKunhfU+iFv0nXIWk
	SB3sYO6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBYPS-0000000EgkY-3haY;
	Mon, 27 May 2024 11:20:58 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBYPP-0000000Egjl-3qtq
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 11:20:57 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RBGoSf032508;
	Mon, 27 May 2024 11:20:43 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dibm.com;_h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3D1Hu?=
 =?UTF-8?Q?xVbYxRMzyqjyaftlbO5/aiaDX1zpVP34KGQGcrVo=3D;_b=3DqCYrDVKZy/lrxl?=
 =?UTF-8?Q?Be0GcI937+cYapKja4+W9euORFBqtDSsS+o4vTTo6OSPVu2+mM8khS_Ym/qSLxy?=
 =?UTF-8?Q?t19bO6iYoPW9Xr9RTbDRvd+b+mmFBMgd7XSrVku+YibpxioIUlsyxFKB5KQK_r1?=
 =?UTF-8?Q?IGqPb/XnmizSLrF2Ilaf9SLNCQ4s2uC5p1ICiex/n8MjNdfs8nDtWSOAedsVkP/?=
 =?UTF-8?Q?bdO_z+iDpJia7IP/CpkPHUPDZOBvwFz+dCLOGSV0JwUyxvxlZHCZK8ew0f8D6Hi?=
 =?UTF-8?Q?nLCplkLlt_XSwGgiHV0/RirkbqsmvAViMn8u84XpXrzoOBm1dw0IvcQ7CTd3q+q?=
 =?UTF-8?Q?qxEeYw4QucRA2aw_BQ=3D=3D_?=
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycphf8cqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 11:20:42 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44R9jqPL027098;
	Mon, 27 May 2024 11:20:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybvhkgape-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 11:20:41 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44RBKcRB23528048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 11:20:40 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 391A55806D;
	Mon, 27 May 2024 11:20:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C63A25805D;
	Mon, 27 May 2024 11:20:35 +0000 (GMT)
Received: from [9.171.63.169] (unknown [9.171.63.169])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 May 2024 11:20:35 +0000 (GMT)
Message-ID: <56198b02-b8fa-4afc-8405-5232d1bf23ab@linux.ibm.com>
Date: Mon, 27 May 2024 16:50:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-cli : attaching a namespace to an undiscovered nvme
 controller on multi-controller nvme disk
From: Nilay Shroff <nilay@linux.ibm.com>
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
Content-Language: en-US
In-Reply-To: <88f230c4-e16e-4a16-a4e6-a48e605147f1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bLZTZgHmCVw9PvPH_V6uQ12rvIOQtTCO
X-Proofpoint-GUID: bLZTZgHmCVw9PvPH_V6uQ12rvIOQtTCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_01,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405270092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_042056_119255_DE59D9E4 
X-CRM114-Status: GOOD (  26.94  )
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


On 5/16/24 11:55, Nilay Shroff wrote:
> 
> 
> On 5/7/24 17:14, Nilay Shroff wrote:
>>
>>
>> On 5/6/24 20:35, Daniel Wagner wrote:
>>> On Mon, May 06, 2024 at 07:45:20PM GMT, Nilay Shroff wrote:
>>>> There could be multiple ways to address this issue. However my proposal would be to address
>>>> it in nvme-cli. As nvme-cli builds the nvme topology it shall be easy
>>>> for nvme-cli to detect
>>>
>>> The topology scan in libnvme is only using the information available in
>>> sysfs. libnvme doesn't issue any commands anymore and I'd like to keep
>>> it this in this way. So if the kernel doesn't exposes this information
>>> to userspace via sysfs, I don't think it's simple to 'fix' this in
>>> nvme-cli/libnvme.
>>>
>> I think the information which we need to contain this issue is already
>> available through sysfs. If we scan nvme topology then we could find 
>> the controller id assigned to each controller under each nvme subsystem.
>> We can then leverage this information to figure out whether each controller 
>> id specified in the attach-ns command is valid or not. So essentially we 
>> match controller id specified in attach-ns command against the controller id 
>> learnt through scanning the topology. If we find that any discrepancy then we
>> can show the WARNING to the user. I have worked out a patch using this method. 
>> I have attached the patch below for suggestion/feedback.
>>
>> diff --git a/nvme.c b/nvme.c
>> index c1d4352a..533cc390 100644
>> --- a/nvme.c
>> +++ b/nvme.c
>> @@ -2784,6 +2784,23 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
>>  	return err;
>>  }
>>  
>> +static bool nvme_match_subsys_device_filter(nvme_subsystem_t s, nvme_ctrl_t c,
>> +		   nvme_ns_t ns, void *f_arg)
>> +{
>> +	nvme_ctrl_t _c;
>> +	const char *devname = (const char *)f_arg;
>> +
>> +	if (s) {
>> +		nvme_subsystem_for_each_ctrl(s, _c) {
>> +			if (!strcmp(devname, nvme_ctrl_get_name(_c)))
>> +				return true;
>> +		}
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>  static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, struct command *cmd)
>>  {
>>  	_cleanup_free_ struct nvme_ctrl_list *cntlist = NULL;
>> @@ -2839,12 +2856,68 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
>>  
>>  	nvme_init_ctrl_list(cntlist, num, ctrlist);
>>  
>> -	if (attach)
>> +	if (attach) {
>> +		const char *cntlid;
>> +		int __cntlid;
>> +		char *p;
>> +		nvme_host_t h;
>> +		nvme_subsystem_t s;
>> +		nvme_ctrl_t c;
>> +		nvme_root_t r = NULL;
>> +		int matched = 0;
>> +		nvme_scan_filter_t filter = nvme_match_subsys_device_filter;
>> +
>> +		r = nvme_create_root(stderr, log_level);
>> +		if (!r) {
>> +			nvme_show_error("Failed to create topology root: %s",
>> +					nvme_strerror(errno));
>> +			return -errno;
>> +		}
>> +
>> +		err = nvme_scan_topology(r, filter, (void *)dev->name);
>> +		if (err < 0) {
>> +			if (errno != ENOENT)
>> +				nvme_show_error("Failed to scan topology: %s",
>> +						nvme_strerror(errno));
>> +			nvme_free_tree(r);
>> +			return err;
>> +		}
>> +		nvme_for_each_host(r, h) {
>> +			nvme_for_each_subsystem(h, s) {
>> +				nvme_subsystem_for_each_ctrl(s, c) {
>> +					cntlid = nvme_ctrl_get_cntlid(c);
>> +					errno = 0;
>> +					__cntlid = strtoul(cntlid, &p, 0);
>> +					if (errno || *p != 0)
>> +						continue;
>> +					for (i = 0; i < num; i++) {
>> +						if (__cntlid == list[i])
>> +							matched++;
>> +					}
>> +				}
>> +			}
>> +		}
>> +
>> +		nvme_free_tree(r);
>> +
>> +		if (matched != num) {
>> +			fprintf(stderr,
>> +				"You are about to attach namespace 0x%x to an undiscovered nvme controller.\n",
>> +				cfg.namespace_id);
>> +			fprintf(stderr,
>> +				"WARNING: Attaching nampespace to undiscovered nvme controller may have undesired side effect!\n"
>> +				"You may not be able to perform any IO to such namespace.\n"
>> +				"You have 10 seconds to press Ctrl-C to cancel this operation.\n\n");
>> +			sleep(10);
>> +			fprintf(stderr, "Sending attach-ns operation ...\n");
>> +		}
>> +
>>  		err = nvme_cli_ns_attach_ctrls(dev, cfg.namespace_id,
>>  					       cntlist);
>> -	else
>> +	} else {
>>  		err = nvme_cli_ns_detach_ctrls(dev, cfg.namespace_id,
>>  					       cntlist);
>> +	}
>>  
>>  	if (!err)
>>  		printf("%s: Success, nsid:%d\n", cmd->name, cfg.namespace_id);
>>
> Gentle ping... 
> 
> If there's no objection to the above proposed patch then may I send a formal patch?
> 
> 
Hi Daniel,

A gentle ping, if the proposed patch looks good then may I send a formal patch?

Thanks,
--Nilay

