Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E213C27C79
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 09:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QnmaW93Q33m0zXFbUDVwvCtNyI5p+YI2vMvf9T5Et40=; b=jL0UJum7uE9XX+kTPYUSC51u3k
	TXE2PKXM0PgxgihikGjYISxu4aiJgTu8YgCglTwV9Z+NMlRNj+2iYROeKScs1KM0rJ8zRoeCut7rF
	p6SBvtL2ZIiNrsoqYctBIKMQeht7qrl7gSrj52LBztW2xxm4SzbYIsyz5D5RkXKroqmblB1mXLf9S
	7QPPCBMvt4NJ5CCVp3qLYmnJBgspF/r0/eBqoS4UtE9f060Y1u/y8EgYmGnyS+44ZqC1F05HlFwjQ
	+Om+eQGJ7/sZqV2JN9ACEveKKLXlQTdEwY0CBYQ7OL8pcJiTkSrynx9pZgB7v/HxBIKOmNyK575Mg
	Hf65icMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKDgs-00000004JMU-09DR;
	Thu, 20 Jun 2024 09:02:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKDgp-00000004JLp-25UB
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 09:02:45 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K6vb5g000339;
	Thu, 20 Jun 2024 09:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=Q
	nmaW93Q33m0zXFbUDVwvCtNyI5p+YI2vMvf9T5Et40=; b=Ls+PXMrTYd4R4YGyZ
	MPu7wd/cXJn9phmsp75qxxseelqLBUZ569H6mzJeLqhrdnAVZCcpvmlJR33FjHcG
	ru5zdsW/xUMAQ8Wzvg9Iw20SqWXigk6DGUrKDUXRcrMzD7rMlj01VJCWe5qHivxB
	TKnTQnyYsqGO0XClh7/SugWnh3u9b4/JD4n6MV5CnfX/6tWAeM4i9CRCPtqSHeb1
	tzuw0mlh6X878GUuILsUQjBFp/+Te0FxCaZzxrPNlJtCdW91CXam/gBymlJRsJ5w
	B7su3d5CNcYMTffjNK5egtTrjRrjCIA3M/fUAiPxqR3FH3l2g2+Vo2DG4KrTv2Mw
	FypMw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvf6prcy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 09:02:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45K7UBJh006136;
	Thu, 20 Jun 2024 09:02:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysn9v4q2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 09:02:35 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45K92WT225166192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Jun 2024 09:02:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E67958068;
	Thu, 20 Jun 2024 09:02:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 243C658063;
	Thu, 20 Jun 2024 09:02:29 +0000 (GMT)
Received: from [9.43.39.114] (unknown [9.43.39.114])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Jun 2024 09:02:28 +0000 (GMT)
Message-ID: <0b60dbd7-7f6c-4aa2-b930-399976a5dc60@linux.ibm.com>
Date: Thu, 20 Jun 2024 14:32:27 +0530
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
 <wyl5mqslq24pjjprd44ezt2pwhdbsj5gfwcfzvwrqoynwqokzv@25rthmjworl5>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <wyl5mqslq24pjjprd44ezt2pwhdbsj5gfwcfzvwrqoynwqokzv@25rthmjworl5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LF4imSMLuTzodk0aO2SEnCNCwqGBmaMf
X-Proofpoint-GUID: LF4imSMLuTzodk0aO2SEnCNCwqGBmaMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_06,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_020243_730334_A23BCB80 
X-CRM114-Status: GOOD (  30.99  )
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



On 6/20/24 12:22, Daniel Wagner wrote:
> On Tue, May 07, 2024 at 05:14:40PM GMT, Nilay Shroff wrote:
>> I think the information which we need to contain this issue is already
>> available through sysfs. If we scan nvme topology then we could find 
>> the controller id assigned to each controller under each nvme subsystem.
>> We can then leverage this information to figure out whether each controller 
>> id specified in the attach-ns command is valid or not. So essentially we 
>> match controller id specified in attach-ns command against the controller id 
>> learnt through scanning the topology. If we find that any discrepancy then we
>> can show the WARNING to the user. I have worked out a patch using this method. 
>> I have attached the patch below for suggestion/feedback.
> 
> So this is just about issuing a warning. That's fine. I thought you want
> to do some more 'difficult' stuff.
> 
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
> 
> use the early return pattern to avoid long indents, e.g.
> 
>     if (!s)
>         return false;
> 
ok will do.

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
> 
> Wouldn't this check also trigger when the user wants to attach to the
> discovered controller?
> 
Yes it will be triggered however in that case the if check would evaluate 
to false and hence we would not enter into the exception case.

> I would also suggest to move this check into a helper function in order
> to keep this function a bit more readable.
Yeah I will create a helper and call it from nvme_attach_ns().

> 
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

I think, I will send a formal patch now with above comments incorporated and we may 
discuss further if there's any additional comment.
 Thanks,
--Nilay

