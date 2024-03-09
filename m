Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DCAC54E60
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Mar 2024 19:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UZAFognNk+AYCGOevK2lWXxE6/LCjw8XeD/hiikS/DY=; b=Ok/Pu8Lq5pp1P2FtXiF1vpeuE8
	NxRK5UhofeN7wxqN1QonJWLDiZFLGWZrc/ZXtQMGgOvNw5bB+w+HYHaN3VhUl2CE/+gljbumzB6DF
	u1txDhTci0czx8lDOzh/LLYx5NKm3TJlaJ2qLGxBilE93pCHZQU1sU4YBCMRLFDw4+tx6ezMajclo
	pUzhXQNIE9g74OXstByw7fNKQPjKnuuCA/IUsYTKzB615KM5HfA1zr1FqfGUbRwy94CdxqctEyF2p
	uOCTYE+kXoghk5nDOkK3TBhPL7yCrou7nashZb09jKOmpK25VDFQuJKSrvs+bsB1IfgeJGZVBvU/W
	T39D88vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rj20t-0000000E384-1fWG;
	Sat, 09 Mar 2024 19:05:43 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rj20p-0000000E37c-3axJ
	for linux-nvme@lists.infradead.org;
	Sat, 09 Mar 2024 19:05:41 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 429HR40w019788;
	Sat, 9 Mar 2024 19:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UZAFognNk+AYCGOevK2lWXxE6/LCjw8XeD/hiikS/DY=;
 b=GDwE+pdhgPQLYmK1CiqZnA05pD0q813/PplQw2TdPOdGqdAVi4LdzjkyXp+PISydaRpJ
 PsP0jEGmBZwUVFY7fpnKFKex9eEnUqsBu/egTLBLaCxL9F2WeQMbUkzEIgLAM28gvE5p
 3jMJb8LmoQtXX9CWvGAgoD1O/OXqnzcRQDZz6Iejfq9FzufSei1OhS47wbPQICF2g5jQ
 g3kHSV7tAAEBAaqf/ILev5ORLEmAkPrhXHvC6kp0MvJSOC9gwKg+/QQVF8ZLPjGd25kJ
 L0+7YZ3YuQp26eaH8PpHUcxBfWez/ESGguBw6cvwiTOPYL+02Zz81mUGHzZw4f62S9S3 zA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wrv64rw5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 Mar 2024 19:05:15 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 429HBnxG024204;
	Sat, 9 Mar 2024 19:05:14 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsydfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 Mar 2024 19:05:14 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 429J5BhC50332080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 9 Mar 2024 19:05:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D14558056;
	Sat,  9 Mar 2024 19:05:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F5D258052;
	Sat,  9 Mar 2024 19:05:08 +0000 (GMT)
Received: from [9.171.55.210] (unknown [9.171.55.210])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  9 Mar 2024 19:05:07 +0000 (GMT)
Message-ID: <301b8f41-a146-497a-916f-97d91829d28c@linux.ibm.com>
Date: Sun, 10 Mar 2024 00:35:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, gjoyce@linux.ibm.com
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <Zesxq81eJTnOGniB@kbusch-mbp>
 <039541c8-2e13-442e-bd5b-90a799a9851a@linux.ibm.com>
 <ZeyD6xh0LGZyRBfO@kbusch-mbp>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZeyD6xh0LGZyRBfO@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3q-mfBjixf7DtrWo9FVDsDe3511wwCem
X-Proofpoint-ORIG-GUID: 3q-mfBjixf7DtrWo9FVDsDe3511wwCem
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-09_03,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403090157
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240309_110540_156723_85D048FC 
X-CRM114-Status: GOOD (  24.64  )
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



On 3/9/24 21:14, Keith Busch wrote:
> On Sat, Mar 09, 2024 at 07:59:11PM +0530, Nilay Shroff wrote:
>> On 3/8/24 21:11, Keith Busch wrote:
>>> On Fri, Feb 09, 2024 at 10:32:16AM +0530, Nilay Shroff wrote:
>>>> @@ -2776,6 +2776,14 @@ static void nvme_reset_work(struct work_struct *work)
>>>>   out_unlock:
>>>>  	mutex_unlock(&dev->shutdown_lock);
>>>>   out:
>>>> +	/*
>>>> +	 * If PCI recovery is ongoing then let it finish first
>>>> +	 */
>>>> +	if (pci_channel_offline(to_pci_dev(dev->dev))) {
>>>> +		dev_warn(dev->ctrl.device, "PCI recovery is ongoing so let it finish\n");
>>>> +		return;
>>>> +	}
>>>> +
>>>>  	/*
>>>>  	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
>>>>  	 * may be holding this pci_dev's device lock.
>>>> @@ -3295,9 +3303,11 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>>>>  	case pci_channel_io_frozen:
>>>>  		dev_warn(dev->ctrl.device,
>>>>  			"frozen state error detected, reset controller\n");
>>>> -		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
>>>> -			nvme_dev_disable(dev, true);
>>>> -			return PCI_ERS_RESULT_DISCONNECT;
>>>> +		if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
>>>> +			if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
>>>> +				nvme_dev_disable(dev, true);
>>>> +				return PCI_ERS_RESULT_DISCONNECT;
>>>> +			}
>>>>  		}
>>>>  		nvme_dev_disable(dev, false);
>>>>  		return PCI_ERS_RESULT_NEED_RESET;
>>>
>>> I get what you're trying to do, but it looks racy. The reset_work may
>>> finish before pci sets channel offline, or the error handling work
>>> happens to see RESETTING state, but then transitions to CONNECTING state
>>> after and deadlocks on the '.resume()' side. You are counting on a very
>>> specific sequence tied to the PCIe error handling module, and maybe you
>>> are able to count on that sequence for your platform in this unique
>>> scenario, but these link errors could happen anytime.
>>>
>> I am not sure about the deadlock in '.resume()' side you mentioned above.
>> Did you mean that deadlock occur due to someone holding this pci_dev's device lock?
>> Or deadlock occur due to the flush_work() from nvme_error_resume() would never 
>> return?
> 
> Your patch may observe a ctrl in "RESETTING" state from
> error_detected(), then disable the controller, which quiesces the admin
> queue. Meanwhile, reset_work may proceed to CONNECTING state and try
> nvme_submit_sync_cmd(), which blocks forever because no one is going to
> unquiesce that admin queue.
> 
OK I think I got your point. However, it seems that even without my patch
the above mentioned deadlock could still be possible. 
Without my patch, if error_detcted() observe a ctrl in "RESETTING" state then 
it still invokes nvme_dev_disable(). The only difference with my patch is that 
error_detected() returns the PCI_ERS_RESULT_NEED_RESET instead of PCI_ERS_RESULT_DISCONNECT.

Regarding the deadlock, it appears to me that reset_work races with nvme_dev_disable()
and we may want to extend the shutdown_lock in reset_work so that nvme_dev_disable() 
can't interfere with admin queue while reset_work accesses the admin queue. I think
we can fix this case. I would send PATCH v2 with this fix for review, however, please let 
me know if you have any other concern before I spin a new patch.

Thanks,
--Nilay







