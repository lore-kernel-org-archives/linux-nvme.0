Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B1AC54E41
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Mar 2024 14:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XukhAcTgGqe3dRiMqhUcGbZ12/fPjtue4GE6jgfkZJY=; b=V24iA0blTZHByaCCOXsvuuEHW1
	p+mV/GXCe2h+DxCatGCSO5c4/dioH01heXTiDtUHa56a/9S12X+GF+JEXnDbPHbfNyXwtftjYtX6F
	0F6qkqXoB5ElvDt8Pk48EgS3P1nd8rydwceDztZ3Gmnqo9LZql1B/3VBUS5AciFhNGernENfPmIGy
	rChcoAYbPLFcYmGMaxLdkYYbdPqKYXmjKb8xti79jjaBapfq3L6aIuwsZs3Vx7WW1esmuOhyqccS2
	Y97gl0hDL0kiUnuVayrG2ZxE4Yn7hPUFqlKO4O5XRw/bNWP2kf726V3yOFkn8DZByMTje0Q5TZJJ9
	TBVz9X3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rixhT-0000000DWvj-2MFB;
	Sat, 09 Mar 2024 14:29:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rixhQ-0000000DWuw-1ZJn
	for linux-nvme@lists.infradead.org;
	Sat, 09 Mar 2024 14:29:22 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 429Dvxmf023354
	for <linux-nvme@lists.infradead.org>; Sat, 9 Mar 2024 14:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XukhAcTgGqe3dRiMqhUcGbZ12/fPjtue4GE6jgfkZJY=;
 b=UyeQkVd7ZkuncgaR/aG99mNMoPGjDyLv+Eu05rMG2ik1XjwcydZYWKQtEAjTlQ4GMqOy
 dcx1DODUBUHONCqd5Pmd+UUeeAr3eeT2SgdzYukRZjKcRj4Pkkmqnf+OWkIPF+g7lV6j
 ZN7CnOCgfOXnx+Y1VIb6GSSfAh2KZOkZSfLWQ0DL9gkAPmoGwQ3rUiNo+8MdNtKR5Pe9
 N1c24eFuywSyLyCKOU80q/iJr711NLZqlQnyf0L4kfLW33qpv3TiLQVSOkgQRvmpeHU7
 f5splgPTfeXBTbQPfXME9/l4kULS5wynjR45O0TOa0zcHECaHpST0VimYMHsBX/MQnDa Qw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wrs41r89g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sat, 09 Mar 2024 14:29:17 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 429Aftou025396
	for <linux-nvme@lists.infradead.org>; Sat, 9 Mar 2024 14:29:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmeu0b5s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sat, 09 Mar 2024 14:29:16 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 429ETEgb21037486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Sat, 9 Mar 2024 14:29:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F004C58059
	for <linux-nvme@lists.infradead.org>; Sat,  9 Mar 2024 14:29:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A8EE5806C
	for <linux-nvme@lists.infradead.org>; Sat,  9 Mar 2024 14:29:13 +0000 (GMT)
Received: from [9.171.21.50] (unknown [9.171.21.50])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP
	for <linux-nvme@lists.infradead.org>; Sat,  9 Mar 2024 14:29:12 +0000 (GMT)
Message-ID: <039541c8-2e13-442e-bd5b-90a799a9851a@linux.ibm.com>
Date: Sat, 9 Mar 2024 19:59:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <Zesxq81eJTnOGniB@kbusch-mbp>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Zesxq81eJTnOGniB@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X3belxD5MLhTRcdvuoJCN1THW-I2flOD
X-Proofpoint-GUID: X3belxD5MLhTRcdvuoJCN1THW-I2flOD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403090118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240309_062920_788147_3675EE7B 
X-CRM114-Status: GOOD (  36.29  )
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



On 3/8/24 21:11, Keith Busch wrote:
> On Fri, Feb 09, 2024 at 10:32:16AM +0530, Nilay Shroff wrote:
>> @@ -2776,6 +2776,14 @@ static void nvme_reset_work(struct work_struct *work)
>>   out_unlock:
>>  	mutex_unlock(&dev->shutdown_lock);
>>   out:
>> +	/*
>> +	 * If PCI recovery is ongoing then let it finish first
>> +	 */
>> +	if (pci_channel_offline(to_pci_dev(dev->dev))) {
>> +		dev_warn(dev->ctrl.device, "PCI recovery is ongoing so let it finish\n");
>> +		return;
>> +	}
>> +
>>  	/*
>>  	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
>>  	 * may be holding this pci_dev's device lock.
>> @@ -3295,9 +3303,11 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>>  	case pci_channel_io_frozen:
>>  		dev_warn(dev->ctrl.device,
>>  			"frozen state error detected, reset controller\n");
>> -		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
>> -			nvme_dev_disable(dev, true);
>> -			return PCI_ERS_RESULT_DISCONNECT;
>> +		if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
>> +			if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
>> +				nvme_dev_disable(dev, true);
>> +				return PCI_ERS_RESULT_DISCONNECT;
>> +			}
>>  		}
>>  		nvme_dev_disable(dev, false);
>>  		return PCI_ERS_RESULT_NEED_RESET;
> 
> I get what you're trying to do, but it looks racy. The reset_work may
> finish before pci sets channel offline, or the error handling work
> happens to see RESETTING state, but then transitions to CONNECTING state
> after and deadlocks on the '.resume()' side. You are counting on a very
> specific sequence tied to the PCIe error handling module, and maybe you
> are able to count on that sequence for your platform in this unique
> scenario, but these link errors could happen anytime.
> 
I am not sure about the deadlock in '.resume()' side you mentioned above.
Did you mean that deadlock occur due to someone holding this pci_dev's device lock?
Or deadlock occur due to the flush_work() from nvme_error_resume() would never 
return?

If the reset_work finishes before pci sets channel offline and nvme_timeout() detects
the pci channel offline then we would fall through the below sequence of events:
eeh_event_hadnler()
  ->nvme_error_detected() => set ctrl state to RESETTING
    ->nvme_slot_reset() => it schedules reset_work
      ->nvme_error_resume() => it waits until reset_work finishes
      "Device recovers"

If error handling work happens to see RESETTING state (it means that reset_work
has been scheduled or might have started running) then the controller state can't 
transition to CONNECTING state. In this case, the reset_work would not finish as the 
reset_work would try accessing the pci iomem and that would fail before setting
the controller state to CONNECTING.The reset_work invokes nvme_dev_disable() and 
nvme_pci_enable() (before setting controller state to CONNECTING) and both these
functions access pci iomem space.

> And nvme subsystem reset is just odd, it's not clear how it was intended
> to be handled. It takes the links down so seems like it requires
> re-enumeration from a pcie hotplug driver, and that's kind of how it was
> expected to work here, but your platform has a special way to contain
> the link event and bring things back up the way they were before. And
> the fact you *require* IO to be in flight just so the timeout handler
> can dispatch a non-posted transaction 30 seconds later to trigger EEH is
> also odd. Why can't EEH just detect the link down event directly?
I think EEH could detect the link down event however the eeh recovery 
mechanism piggy-backs on the PCI hotplug infrastructure so that device drivers 
do not need to be specifically modified to support EEH recovery on ppc 
architecture. Hence the eeh recovery is triggered when driver tries to 
access pci IO memory space and that starts the kernel generic pci error 
recovery.

> 
> This driver unfortunately doesn't handle errors during a reset well.
> Trying to handle that has been problematic, so the driver just bails if
> anything goes wrong at this critical initialization point. Maybe we need
> to address the reset/initialization failure handling more generically
> and delegate the teardown or retry decision to something else. Messing
> with that is pretty fragile right now, though.
> 
> Or you could just re-enumerate the slot.
Just another thought, how about serializing reset_work and error handling work?
> 
> I don't know, sorry my message is not really helping much to get this
> fixed.
Yeah, I know this is fragile right now and so it would require 
detailed review and discussion.

Thanks,
--Nilay


