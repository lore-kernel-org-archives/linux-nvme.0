Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BCAC27C53
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jun 2024 15:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QZQQnIFZM1JwNsOsyrxiE8Uivcrws908qcJoiypi3cQ=; b=lSJK+nUdXYvfvyYCl7eO4s3aYs
	j6+qL1UK+1JJqjmk7peFdcDuKPvMVu7KtEO44lHeDRYcqpXKZpVCOsf8AnVrAJAFNeappXX15q+Hu
	z5NH926zqm/VCiFowxE6mRJ5/rUnPu6McIUPuvdO0bEs5aaV8Jxb+P6bUxCtIjudpMigy1ItBkWpP
	r0xyqJ/KwZpDQZe5Y3Ew6MWfXE08/r7LVZYuZem1yJn/ZLh2W3bS/4D9GaivpmxiGLCQS0BxhKFvz
	ZwKzY0eyEBWoPr01I3smf3Ebhs7y/dGwx9S9pDhjEtINA0NRz2zokg9rveoTQUM8rLMOZbk4iqI+F
	3JGuV/Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sL2L6-0000000CI8F-3QNP;
	Sat, 22 Jun 2024 15:07:40 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sL2L1-0000000CI6n-13E6
	for linux-nvme@lists.infradead.org;
	Sat, 22 Jun 2024 15:07:36 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45MEr1Lx013541;
	Sat, 22 Jun 2024 15:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=Q
	ZQQnIFZM1JwNsOsyrxiE8Uivcrws908qcJoiypi3cQ=; b=tlZWBhBsBsn70tMwz
	D7FkA59/ZuXQ7eGvcj9iT5fBINL/CA+7+kBbW40gmKW9XXXr6jPf7O63BWYXjY2O
	8ExtCL1FPxi7rnGL9WaetFAIeTCwbdAb7b7eKnriA0UEcCBWy3OAHmCpwZuN9+mW
	VLDJfWuosTcB74I0Q3ApUoNHRj8jSrMjQ8yNlWjVECCOFcVMY66MZW3dgE4nq8ui
	Tem3jlf2uv6d/9eSsJhFFwPTrF5IZmvoqvps37oTeBPxL/Opz74Xoya8sKBt6QYa
	Fo8tKD1kN8ymlR0QMcl/iRTF6VHUGIpF8qQZjEQWuw3ETMnzgefQ4OPrhBQdWSqR
	cW3sQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywwphracj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 15:07:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45MCalk2032326;
	Sat, 22 Jun 2024 15:07:10 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrspvu67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 15:07:10 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45MF77fc27198200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Jun 2024 15:07:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A487358043;
	Sat, 22 Jun 2024 15:07:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F25B758053;
	Sat, 22 Jun 2024 15:07:04 +0000 (GMT)
Received: from [9.43.65.57] (unknown [9.43.65.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Jun 2024 15:07:04 +0000 (GMT)
Message-ID: <653be192-cfa7-45d6-adf0-2a863960630a@linux.ibm.com>
Date: Sat, 22 Jun 2024 20:37:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme-pci : Fix EEH failure on ppc after subsystem
 reset
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        gjoyce@linux.ibm.com, axboe@fb.com
References: <20240604091523.1422027-1-nilay@linux.ibm.com>
 <20240604091523.1422027-2-nilay@linux.ibm.com> <ZnWsXmRdCCgMwL5V@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZnWsXmRdCCgMwL5V@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cuV9R4E72R4e1G03oxC6zRFM5gsQiLS5
X-Proofpoint-GUID: cuV9R4E72R4e1G03oxC6zRFM5gsQiLS5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_09,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406220105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240622_080735_663843_C885354C 
X-CRM114-Status: GOOD (  30.46  )
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



On 6/21/24 22:07, Keith Busch wrote:
> On Tue, Jun 04, 2024 at 02:40:04PM +0530, Nilay Shroff wrote:
>> The NVMe subsystem reset command when executed may cause the loss of
>> the NVMe adapter communication with kernel. And the only way today
>> to recover the adapter is to either re-enumerate the pci bus or
>> hotplug NVMe disk or reboot OS.
>>
>> The PPC architecture supports mechanism called EEH (enhanced error
>> handling) which allows pci bus errors to be cleared and a pci card to
>> be rebooted, without having to physically hotplug NVMe disk or reboot
>> the OS.
>>
>> In the current implementation when user executes the nvme subsystem
>> reset command and if kernel loses the communication with NVMe adapter
>> then subsequent read/write to the PCIe config space of the device
>> would fail. Failing to read/write to PCI config space makes NVMe
>> driver assume the permanent loss of communication with the device and
>> so driver marks the NVMe controller dead and frees all resources
>> associate to that controller. As the NVMe controller goes dead, the
>> EEH recovery can't succeed.
>>
>> This patch helps fix this issue so that after user executes subsystem
>> reset command if the communication with the NVMe adapter is lost and
>> EEH recovery is initiated then we allow the EEH recovery to forward
>> progress and gives the EEH thread a fair chance to recover the
>> adapter. If in case, the EEH thread couldn't recover the adapter
>> communication then it sets the pci channel state of the erring
>> adapter to "permanent failure" and removes the device.
> 
> I think the driver is trying to do too much here by trying to handle the
> subsystem reset inline with the reset request. It would surely fail, but
> that was the idea because we had been expecting pciehp to re-enumerate.
> But there are other possibilities, like your EEH, or others like DPC and
> AER could do different handling instead of a bus rescan. So, perhaps the
> problem is just the subsystem reset handling. Maybe just don't proceed
> with the reset handling, and it'll be fine?
> 
> ---
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 68b400f9c42d5..97ed33d9046d4 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -646,9 +646,12 @@ static inline void nvme_should_fail(struct request *req) {}
>  
>  bool nvme_wait_reset(struct nvme_ctrl *ctrl);
>  int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
> +bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> +		enum nvme_ctrl_state new_state);
>  
>  static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
>  {
> +	u32 val;
>  	int ret;
>  
>  	if (!ctrl->subsystem)
> @@ -657,10 +660,10 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
>  		return -EBUSY;
>  
>  	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
> -	if (ret)
> -		return ret;
> -
> -	return nvme_try_sched_reset(ctrl);
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
> +	if (!ret)
> +		ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &val);
> +	return ret;
>  }
>  
>  /*
> @@ -786,8 +789,6 @@ blk_status_t nvme_host_path_error(struct request *req);
>  bool nvme_cancel_request(struct request *req, void *data);
>  void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
>  void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
> -bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> -		enum nvme_ctrl_state new_state);
>  int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
>  int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
>  int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> --
> 
This is a nice idea! These changes look good. I have tested it on powerpc with 
EEH and I observed that post nvme subsystem-reset, EEH is able to recover the disk. 
I have also tested it on a platform which *doesn't* support EEH or pci error recovery
and on this platform I observed that nvme disk falls through the dead state. 

So I think you may submit a formal patch with this change.

Thanks,
--Nilay


