Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0E7C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 05:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=av82vEz2gRC3GlDYhRlwzSIlf4xpohLnclboELcqNig=; b=X3PUSFsc6oqNb7gjMjL2m01a26
	fyS6pVjQHvvTXj6wWsg94dHVWL3aKRT5YdWU5G2qp65DabKM9Fl2XWpjXFcutynvchKHnEFwvoXv0
	GWNR8egS6qwvEjVYSs0ep/ACy+7U2a7yM/bo0tbZqYt/uHg/jgFYk0dP2R8PjDm0W2pYnlE/W1ESS
	Z7l7bxq1bLDIIRiVauFyR4M6oVocQDZ/AZFTJjch5lVEp/nQ83q8s/8vcEHV6dHAyFwnjt/fMyIPz
	n5nqo+xKfHUKQqohY4Z0ZNDq4BQ8eunY/d0cHhSwDYEVp1XQuBLZarMSJu4ek4tfuIXUP+D3A9b2U
	ny8WQqFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnX2y-00000005mrO-1RQw;
	Fri, 22 Mar 2024 05:02:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnX2u-00000005mp1-0zCW
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 05:02:25 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M4xpdq009678;
	Fri, 22 Mar 2024 05:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=av82vEz2gRC3GlDYhRlwzSIlf4xpohLnclboELcqNig=;
 b=ts8r1l5tW0C3SXGZk2MyUqi4a9etOjXKCCPwDUPJY6+BvxGxA+uubYEsUtRHTQqDl3YG
 BpVJTZf2+4LL9OLHLXHgOyLdEYzSKcUASmsDCrIOQMLz5cPZIm/XkD4nTKu0QzX7HlAL
 /zoXJRM6ea6xczTYpvMEBlv+JxEyhhkaGb96M99Uk6l8QuSzynvy1Ps9cfFc5wCCjmrl
 0LRMm3VSSbMTUvubs5ye9qyCDUprGe0Te70izOwWojiaLLZqbMxNINvMq/ycRm0uPda9
 o7VqoqVi4P8rBcvNSwDRIxekguw3JsGdtrvSPecoAPtamsJU8w2l9v78HpBw1lFdE0/M bA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x11ej06pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 05:02:09 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42M281MG015725;
	Fri, 22 Mar 2024 05:02:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x0x15hksr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 05:02:08 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42M525xq58130776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 05:02:07 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0E8D5803F;
	Fri, 22 Mar 2024 05:02:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7FB05806B;
	Fri, 22 Mar 2024 05:02:02 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Mar 2024 05:02:02 +0000 (GMT)
Message-ID: <f261dc80-1939-4753-bf66-6a5a2ed930ba@linux.ibm.com>
Date: Fri, 22 Mar 2024 10:32:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
From: Nilay Shroff <nilay@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, gjoyce@linux.ibm.com
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <Zesxq81eJTnOGniB@kbusch-mbp>
 <039541c8-2e13-442e-bd5b-90a799a9851a@linux.ibm.com>
 <ZeyD6xh0LGZyRBfO@kbusch-mbp>
 <301b8f41-a146-497a-916f-97d91829d28c@linux.ibm.com>
 <Ze6LglWPqkHVFh-P@kbusch-mbp.mynextlight.net>
 <ac294adc-a7be-49af-88cd-e3aabd9f7c3f@linux.ibm.com>
 <ZfBm72xPozFN99GA@kbusch-mbp.mynextlight.net>
 <af991867-02a3-4ff9-94fc-50955913f227@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <af991867-02a3-4ff9-94fc-50955913f227@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ROH086BCf888ZQpAZl-T-3_OgvaQ9L40
X-Proofpoint-ORIG-GUID: ROH086BCf888ZQpAZl-T-3_OgvaQ9L40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_01,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_220224_680782_DCC1582E 
X-CRM114-Status: GOOD (  40.56  )
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

Hi Keith,

A gentle ping. I don't know whether you got a chance to review the last email on this subject.
Please let me know your feedback/thoughts.

Thanks,
--Nilay

On 3/13/24 17:29, Nilay Shroff wrote:
> 
> 
> On 3/12/24 20:00, Keith Busch wrote:
>> On Mon, Mar 11, 2024 at 06:28:21PM +0530, Nilay Shroff wrote:
>>> @@ -3295,10 +3304,13 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>>>         case pci_channel_io_frozen:
>>>                 dev_warn(dev->ctrl.device,
>>>                         "frozen state error detected, reset controller\n");
>>> -               if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
>>> -                       nvme_dev_disable(dev, true);
>>> -                       return PCI_ERS_RESULT_DISCONNECT;
>>> +               if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
>>> +                       if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
>>> +                               nvme_dev_disable(dev, true);
>>> +                               return PCI_ERS_RESULT_DISCONNECT;
>>> +                       }
>>>                 }
>>> +               flush_work(&dev->ctrl.reset_work);
>>
>> I was messing with a similar idea. I wasn't sure if EEH calls the error
>> handler inline with the error, in which case this would try to flush the
>> work within the same work, which obviously doesn't work. As long as its
>> called from a different thread, then this should be fine.
> The EEH recovery happens from different thread and so flush work should 
> work here as expected.
> 
>>> @@ -2776,6 +2776,16 @@ static void nvme_reset_work(struct work_struct *work)
>>>   out_unlock:
>>>         mutex_unlock(&dev->shutdown_lock);
>>>   out:
>>> +       /*
>>> +        * If PCI recovery is ongoing then let it finish first
>>> +        */
>>> +       if (pci_channel_offline(to_pci_dev(dev->dev))) {
>>> +               dev_warn(dev->ctrl.device, "PCI recovery is ongoing so let it finish\n");
>>> +               if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING)
>>> +                       WRITE_ONCE(dev->ctrl.state, NVME_CTRL_RESETTING);
>>
>> This may break the state machine, like if the device was hot removed
>> during all this error handling. This will force the state back to
>> RESETTING when it should be DEAD.
> Agreed, we shouldn't force reset state to RESETTING here.
>>
>> I think what you need is just allow a controller to reset from a
>> connecting state. Have to be careful that wouldn't break any other
>> expectations, though.
> Yeah ok got your point, so I have reworked the ctrl state machine as you 
> suggested and tested the changes. The updated state machine code is shown
> below:
> 
> @@ -546,10 +546,11 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>                 break;
>         case NVME_CTRL_RESETTING:
>                 switch (old_state) {
>                 case NVME_CTRL_NEW:
>                 case NVME_CTRL_LIVE:
> +               case NVME_CTRL_CONNECTING:
>                         changed = true;
>                         fallthrough;
>                 default:
>                         break;
>                 }
> 
> And accordingly updated reset_work function is show below. Here we ensure that
> even though the pci error recovery is in progress, if we couldn't move ctrl state
> to RESETTING then we would let rest_work forward progress and set the ctrl state
> to DEAD.
> 
> @@ -2774,10 +2774,19 @@ static void nvme_reset_work(struct work_struct *work)
>         return;
>  
>   out_unlock:
>         mutex_unlock(&dev->shutdown_lock);
>   out:
> +       /*
> +        * If PCI recovery is ongoing then let it finish first
> +        */
> +       if (pci_channel_offline(to_pci_dev(dev->dev))) {
> +               if (nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> +                       dev_warn(dev->ctrl.device, "PCI recovery is ongoing, let it finish\n");
> +                       return;
> +               }
> +       }
>         /*
>          * Set state to deleting now to avoid blocking nvme_wait_reset(), which
>          * may be holding this pci_dev's device lock.
>          */
>         dev_warn(dev->ctrl.device, "Disabling device after reset failure: %d\n",
> 
> 
> Now I have also included in my test the hot removal of NVMe adapter while EEH recovery
> is in progress. And the  EEH recovery code handles this case well : When EEH recovery 
> is in progress and if we hot removes the adapter (which is being recovered) then EEH
> handler would stop the recovery, set the PCI channel state to "pci_channel_io_perm_failure".
> 
> 
> Collected the logs of this case, (shown below):
> -----------------------------------------------
> # nvme list-subsys 
> nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:2.5-inch:S6EUNA0R500358
>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
>                iopolicy=numa
> 
> # lspci 
> 0018:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173X
> 
> # dmesg
> [  561.639102] EEH: Recovering PHB#18-PE#10000
> [  561.639120] EEH: PE location: N/A, PHB location: N/A
> [  561.639128] EEH: Frozen PHB#18-PE#10000 detected
> <snip>
> <snip>
> [  561.639428] EEH: This PCI device has failed 2 times in the last hour and will be permanently disabled after 5 failures.
> [  561.639441] EEH: Notify device drivers to shutdown
> [  561.639450] EEH: Beginning: 'error_detected(IO frozen)'
> [  561.639458] PCI 0018:01:00.0#10000: EEH: Invoking nvme->error_detected(IO frozen)
> [  561.639462] nvme nvme0: frozen state error detected, reset controller
> [  561.719078] nvme 0018:01:00.0: enabling device (0000 -> 0002)
> [  561.719318] nvme nvme0: PCI recovery is ongoing so let it finish
> 
> <!!!! WHILE EEH RECOVERY IS IN PROGRESS WE HOT REMOVE THE NVMe ADAPTER !!!!>
> 
> [  563.850328] rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
> <snip>
> [  571.879092] PCI 0018:01:00.0#10000: EEH: nvme driver reports: 'need reset'
> [  571.879097] EEH: Finished:'error_detected(IO frozen)' with aggregate recovery state:'need reset'
> <snip>
> <snip>
> [  571.881761] EEH: Reset without hotplug activity
> [  574.039807] EEH: PHB#18-PE#10000: Slot inactive after reset: 0x2 (attempt 1)
> [  574.309091] EEH: Failure 2 resetting PHB#18-PE#10000 (attempt 2)
> [  574.309091] 
> [  574.579094] EEH: Failure 2 resetting PHB#18-PE#10000 (attempt 3)
> [  574.579094] 
> [  574.579101] eeh_handle_normal_event: Cannot reset, err=-5
> [  574.579104] EEH: Unable to recover from failure from PHB#18-PE#10000.
> [  574.579104] Please try reseating or replacing it
> <snip>
> <snip>
> [  574.581314] EEH: Beginning: 'error_detected(permanent failure)'
> [  574.581320] PCI 0018:01:00.0#10000: EEH: no device
> 
> # lspci
> <empty>
> 
> # nvme list-subsys
> <empty>
> 
> 
> Another case tested, when the reset_work is ongoing post subsystem-reset command
> and if user immediately hot removes the NVMe adapter then EEH recovery is *not* 
> triggered and ctrl forward progress to the "DEAD" state.
> 
> Collected the logs of this case, (shown below):
> -----------------------------------------------
> # nvme list-subsys 
> nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:2.5-inch:S6EUNA0R500358
>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
>                iopolicy=numa
> 
> # lspci 
> 0018:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173X
> 
> # nvme subsystem-reset /dev/nvme0
> 
> <!!!! HOT REMOVE THE NVMe ADAPTER !!!!>
> 
> # dmesg
> [ 9967.143886] eeh_handle_normal_event: Cannot find PCI bus for PHB#18-PE#10000
> [ 9967.224078] eeh_handle_normal_event: Cannot find PCI bus for PHB#18-PE#10000
> <snip>
> [ 9967.223858] nvme 0018:01:00.0: enabling device (0000 -> 0002)
> [ 9967.224140] nvme nvme0: Disabling device after reset failure: -19
> 
> # lspci
> <empty>
> 
> # nvme list-subsys
> <empty>
> 
> 
> Please let me know if the above changes look good to you. If it looks good then 
> I would spin a new version of the patch and send for a review.
> 
> Thanks,
> --Nilay
> 
> 

