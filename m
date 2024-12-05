Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB07E7716C
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 09:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FNJC7tohnIFrWiow4jPi6imPYabs/tXwb1OiFJBDuBI=; b=hbuIqYMqCnNmyZhlfw7ikkYrC+
	gwzBzxwbLvmrY4RI1CWzDu29Q/ffSMKhnB7Aw4Crmg6arCc+ToSc+9oPBmmtJC0327aTDL7DZRJDC
	/zlU7qhVKIUQiqE1EVljxYcfarKrnZmkhs4bhk6dOEn3BSD1g/XRPvYthHNk0Pk9qp/gG4Z22JHYC
	VUMNo+0fcuGZS4Rm3RhZwrlBildFtFwohIJuUl37S/2xse/8JNwmRukYE7toU36flWcp1ugEY3j1y
	y6P22IkqDLO/owr0aDkjqotrFj8IQ30o6Sk82yGDYmww1jnYgF3nrPD73ABGISZtZYOUCW2mQlkym
	6fGdIInQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJ8Lo-0000000FOab-0p6p;
	Thu, 05 Dec 2024 09:40:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJ8Li-0000000FOa4-2jEd
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 09:40:43 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B510Xrb010823;
	Thu, 5 Dec 2024 09:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FNJC7t
	ohnIFrWiow4jPi6imPYabs/tXwb1OiFJBDuBI=; b=kGT+c8QW4a1/zZ7cp8iajM
	bs1A+l/BQb27leMkmV5lDoLahpOH2QFPHkW4ruEDDSwTEYrXHnKpNnXf0/wYunvH
	Rq50U4HqmnPg1GkMEz5XaKK/plJov7CK4RgujpynmcluhYU93oBoH+AAd00nCajB
	peZvNpgMrAti5Hhom+7/byp8N+5U9nFooIblO1IH+vqAkPlfnOc8vP6Lm8uoRIva
	DbxJVYEb2vO6k+DOB4RB5qtkGIwj1h111CNOPIJzafx9e3nv4h2TDpgsL6KSHg5K
	USi17jPhNrmgWx8TOHbY+txX2oWhhtToRh/5KNC4Srk2lEJ5rnPozyY8JegslUMw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b24r9xsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 09:40:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B58mal3005286;
	Thu, 5 Dec 2024 09:40:28 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 438fr1s8a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 09:40:28 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B59eShh62128398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Dec 2024 09:40:28 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 259AA58043;
	Thu,  5 Dec 2024 09:40:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D61F25805D;
	Thu,  5 Dec 2024 09:40:24 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Dec 2024 09:40:24 +0000 (GMT)
Message-ID: <62addb0a-d115-4b2d-af3c-cedc41991f7c@linux.ibm.com>
Date: Thu, 5 Dec 2024 15:10:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 blktests 2/2] nvme: add test for writing to file-ns just
 after disabling it
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "dwagner@suse.de" <dwagner@suse.de>
Cc: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
References: <20241204114755.190660-1-nilay@linux.ibm.com>
 <20241204114755.190660-3-nilay@linux.ibm.com>
 <5178056a-4297-43ca-b15b-dfb8d9b21857@nvidia.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <5178056a-4297-43ca-b15b-dfb8d9b21857@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0O78zD94oH7AxDjTom-xQuN2rzWNb5jE
X-Proofpoint-ORIG-GUID: 0O78zD94oH7AxDjTom-xQuN2rzWNb5jE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_014042_695075_489C6953 
X-CRM114-Status: GOOD (  30.84  )
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



On 12/5/24 13:02, Chaitanya Kulkarni wrote:
> 
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	local iteration=1 i=0
>> +
>> +	_setup_nvmet
>> +
>> +	_nvmet_target_setup
>> +
>> +	_nvme_connect_subsys
>> +
>> +	img="$(mktemp /tmp/blk_img_XXXXXX)"
>> +	dd if=/dev/urandom of="$img" bs=512 count=1 status=none
> 
> why can't we just use the standard block device backed ns ?
Using standard block device would also work however using the file backed block 
device would be handy in case user doesn't have a spare standard block device 
available which could be used for writing a random junk to it. 
> 
>> +
>> +	subsys_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
>> +	ns_path="${subsys_path}/namespaces/${def_nsid}"
>> +
>> +	while (( i < iteration )); do
>> +		# Wait until async request is processed and default ns
>> +		# is created
>> +		if ! _nvmf_wait_for_ns "${def_subsys_uuid}" created; then
>> +			echo "FAIL"
>> +			break
>> +		fi
>> +
>> +		disk="/dev/$(_find_nvme_ns "${def_subsys_uuid}")"
>> +
>> +		# Disable ns change async event notification from target. It
>> +		# would ensure that when we disable the target ns, the host
>> +		# would not receive ns removal notification from target and
>> +		# so from host we can attempt writing to a disabled ns.
>> +		if ! nvmf_disable_ns_change_aen "${disk}"; then
>> +			echo "FAIL"
>> +			break
>> +		fi
>> +
> 
> I'm really not sure disabling a functionality for testing
> purpose gives us full coverage, for a tests I believe it is important
> to have full functionality running and available so it will reflect the
> real setup, e.g. for this scenario we cannot dependent on disabling AEN
> since users are not disabling the AEN's every-time they disable the
> namespace and ends up writing to the ns on host side triggering the BUG.
> 
OK I think maybe there's a confusion, let me clarify one thing here: We're
*not* disabling AEN functionality but only masking the ns-changed async even 
notification from target and I believe that's perfectly legal per spec. I 
shall update the comment added in the test case to avoid this confusion. 

> Can this be an exception for some reason ?
> 
> Shinichiro, Daniel any thoughts ?
> 
> why not something like following ? (totally untested and rough)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 1f4e9989663b..eede3a7c5594 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -5,6 +5,7 @@
>    */
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   #include <linux/module.h>
> +#include <linux/delay.h>
>   #include <linux/random.h>
>   #include <linux/rculist.h>
>   #include <linux/pci-p2pdma.h>
> @@ -18,6 +19,11 @@
>   #include "nvmet.h"
>   #include "debugfs.h"
> 
> +unsigned int ns_disable_error_inject;
> +module_param(ns_disable_error_inject, int, 0644);
> +MODULE_PARM_DESC(ns_disable_error_inject,
> +                "delay xa_erase() in ns-disable path in seconds 
> (default 0)");
> +
>   struct kmem_cache *nvmet_bvec_cache;
>   struct workqueue_struct *buffered_io_wq;
>   struct workqueue_struct *zbd_wq;
> @@ -649,6 +655,8 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>                  goto out_unlock;
> 
>          ns->enabled = false;
> +       if (ns_disable_error_inject)
> +               msleep(ns_disable_error_inject * 1000);
>          xa_erase(&ns->subsys->namespaces, ns->nsid);
>          if (ns->nsid == subsys->max_nsid)
>                  subsys->max_nsid = nvmet_max_nsid(subsys);
> 
> 
> and add load the module with modprobe ns_disable_error_inject=10 ?
> or we can even mode this module as a part of ns configfs attr.
IMO, adding sleep won't help always because it's not guaranteed that 
write to ns would happen *always* at the correct time. Yes, in theory,
above change would work most of the time but may not always?
> 
> with above change following statement will block for 10 seconds.
>> +		# disable target namespace and write to it
>> +		echo 0 > ${ns_path}/enable
>> +		nvme write --start-block=1 --block-count=0 \
>> +			--data-size=512 --data="$img" "$disk" 2>>"$FULL"
> 
> -ck
> 
> 
So, as you suggested, I think lets wait for Daniel, Shinichiro and others to
comment on this.

Thanks,
--Nilay

