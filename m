Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A975C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Apr 2024 09:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iYOKwt8HiCkklb3VSOIlb38GG/oASr47H3DCmzQy+QM=; b=Ny8hzB4mY/Su6/JX57tnS8IlIU
	fLRLgQbz16AxLD527mnLngw8+wXm5cWf+MAFFYT+mdB00vWaXIg895zK3R1vqe22uifneFywSPwm+
	sVaO3V1SnNZGo23U7LrAoI3oNpw3MjujbDXj32WTIR4NHigbbSuoMoq+JfSXKdQkhgxvgoa/XI+9h
	Fjt6QekCZVXK4fkflbwBmR6HyF3thvBfrk8Pv/ZVG8egQC7Ut9O2wU4TmWlgIpF6BHmQGT2kc3ttM
	Ql/HO83RcmccOW8XP8cSEymuy+YYF4Xx7ZXxrGVgucrlUo94gHjl7PaLvcKMHN0jQegbrKTU21w8x
	0/zKvgpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzCpr-0000000Gjso-32l4;
	Tue, 23 Apr 2024 09:53:11 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzCpo-0000000GjrS-11P3
	for linux-nvme@lists.infradead.org;
	Tue, 23 Apr 2024 09:53:09 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N9WPS2006188;
	Tue, 23 Apr 2024 09:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iYOKwt8HiCkklb3VSOIlb38GG/oASr47H3DCmzQy+QM=;
 b=AQCn/ltUmP6L2Ha0zuMvFzDD9rYaM4/PZoQf9V2hObN+YYxNOsx8FSvJXNxDRu3aFxub
 TTrByD95jyGyPa2vETxGKyzQ1MBa38t09a/iwLyuzn6drqCnX/7/d7Qo4vTVbbNIJyjx
 JSxofWx2RecPaik5cmTU4iRTu74qG3xF6g24jhAhRHZrWt8EvyTPkoCpWG0WIsH1noQ4
 82bnr4nDDIhC4+X1GgtR4OJX6jaJN/q1T40yb9lea303EPVBZWZ8zPAT0bj1tXdZbQ4C
 XAiBmCN4UACQNbXcNWOEnQ4a02ZOGzdU6v03mzolzb5BlryE4j0j4ZYjNT6MfZPO51PO hQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpaekg14x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 09:52:55 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43N8qB9s005355;
	Tue, 23 Apr 2024 09:52:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3cbm16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 09:52:54 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43N9qpj020644450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 09:52:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 221CC58066;
	Tue, 23 Apr 2024 09:52:51 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C69E58055;
	Tue, 23 Apr 2024 09:52:48 +0000 (GMT)
Received: from [9.109.198.147] (unknown [9.109.198.147])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Apr 2024 09:52:48 +0000 (GMT)
Message-ID: <2e10ca7f-0da8-47e4-9bfb-4a6cbf4abaec@linux.ibm.com>
Date: Tue, 23 Apr 2024 15:22:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] PCIe errinject and hot-unplug causes nvme driver
 hang
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        Gregory Joyce <gjoyce@ibm.com>,
        Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>
References: <199be893-5dfa-41e5-b6f2-40ac90ebccc4@linux.ibm.com>
 <579c82da-52a7-4425-81d7-480c676b8cbb@grimberg.me>
 <d33a5681-b195-4258-8eee-e0eae46ade5b@linux.ibm.com>
 <627cdf69-ff60-4596-a7f3-0fdd0af0f601@grimberg.me>
 <ZiZrmSW6s7lY7j98@kbusch-mbp.dhcp.thefacebook.com>
 <ZiZ1mB0pE6lBrJkN@kbusch-mbp.dhcp.thefacebook.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZiZ1mB0pE6lBrJkN@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: krckAl5bhRtRL8DDrEFxzWmDaAmWBUa9
X-Proofpoint-GUID: krckAl5bhRtRL8DDrEFxzWmDaAmWBUa9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_08,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_025308_426793_D00AD11E 
X-CRM114-Status: GOOD (  34.72  )
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



On 4/22/24 20:05, Keith Busch wrote:
> On Mon, Apr 22, 2024 at 07:52:25AM -0600, Keith Busch wrote:
>> On Mon, Apr 22, 2024 at 04:00:54PM +0300, Sagi Grimberg wrote:
>>>> pci_rescan_remove_lock then it shall be able to recover the pci error and hence
>>>> pending IOs could be finished. Later when hot-unplug task starts, it could
>>>> forward progress and cleanup all resources used by the nvme disk.
>>>>
>>>> So does it make sense if we unconditionally cancel the pending IOs from
>>>> nvme_remove() before it forward progress to remove namespaces?
>>>
>>> The driver attempts to allow inflights I/O to complete successfully, if the
>>> device
>>> is still present in the remove stage. I am not sure we want to
>>> unconditionally fail these
>>> I/Os.    Keith?
>>
>> We have a timeout handler to clean this up, but I think it was another
>> PPC specific patch that has the timeout handler do nothing if pcie error
>> recovery is in progress. Which seems questionable, we should be able to
>> concurrently run error handling and timeouts, but I think the error
>> handling just needs to syncronize the request_queue's in the
>> "error_detected" path.
> 
> This:
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8e0bb9692685d..38d0215fe53fc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1286,13 +1286,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  	u8 opcode;
>  
> -	/* If PCI error recovery process is happening, we cannot reset or
> -	 * the recovery mechanism will surely fail.
> -	 */
> -	mb();
> -	if (pci_channel_offline(to_pci_dev(dev->dev)))
> -		return BLK_EH_RESET_TIMER;
> -
>  	/*
>  	 * Reset immediately if the controller is failed
>  	 */
> @@ -3300,6 +3293,7 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>  			return PCI_ERS_RESULT_DISCONNECT;
>  		}
>  		nvme_dev_disable(dev, false);
> +		nvme_sync_queues(&dev->ctrl);
>  		return PCI_ERS_RESULT_NEED_RESET;
>  	case pci_channel_io_perm_failure:
>  		dev_warn(dev->ctrl.device,
> --
> 
I tested the above patch, however, it doesn't help to solve the issue.
I tested it for two cases listed below:

1. Platform which doesn't support pci-error-recovery:
-----------------------------------------------------
On this platform when nvme_timeout() is invoked, it falls through 
nvme_shoud_reset()
  -> nvme_warn_reset() 
    -> goto disable

When nvme_timeout() jumps to the label disable, it tries setting the
controller state to RESETTING but that couldn't succeed because the 
(logical) hot-unplug/nvme_remove() of the disk is started on another 
thread and hence controller state has already changed to 
DELETING/DELETING_NOIO. As nvme_timeout() couldn't set the controller 
state to RESETTING, nvme_timeout() returns BLK_EH_DONE. In summary, 
as nvme_timeout() couldn't cancel pending IO, the hot-unplug/nvme_remove() 
couldn't forward progress and it keeps waiting for request queue to be freezed. 

2. Platform supporting pci-error-recovery:
------------------------------------------
Similarly, on this platform as explained for the above case, when 
nvme_timeout() is invoked, it falls through nvme_shoud_reset()
-> nvme_warn_reset() -> goto disable. In this case as well, 
nvme_timeout() returns BLK_EH_DONE. Please note that though this 
platform supports pci-error-recovery, we couldn't get through 
nvme_error_detected() because the pci-error-recovery thread is pending 
on acquiring mutex "pci_lock_rescan_remove". This mutex is acquired by 
hot-unplug thread before it invokes nvme_remove() and nvme_remove() 
is currently waiting for request queue to be freezed. For reference,
I have already captured the task hang traces in previous email of this 
thread where we could observe these hangs (for both pci-error-recovery
thread as well as hot-unplig/nvme_remove()).

I understand that we don't want to cancel pending IO from the nvme_remove()
unconditionally as if the disk is not physically hot-unplug then we still 
want to  wait for the in-flight IO to be finished. Also looking through 
the above cases, I think that the nvme_timeout() might be the code path 
from where we want to cancel in-flight/pending IO if controller is 
in the terminal state (i.e. DELETING or DELETING_NOIO). Keeping this idea in
mind, I have worked out the below patch:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692685..e45a54d84649 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1286,6 +1286,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
        u32 csts = readl(dev->bar + NVME_REG_CSTS);
        u8 opcode;
 
+       if (nvme_state_terminal(&dev->ctrl))
+               goto disable;
+
        /* If PCI error recovery process is happening, we cannot reset or
         * the recovery mechanism will surely fail.
         */
@@ -1390,8 +1393,13 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
        return BLK_EH_RESET_TIMER;
 
 disable:
-       if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
+       if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+               if (nvme_state_terminal(&dev->ctrl)) {
+                       nvme_dev_disable(dev, false);
+                       nvme_sync_queues(&dev->ctrl);
+               }
                return BLK_EH_DONE;
+       }
 
        nvme_dev_disable(dev, false);
        if (nvme_try_sched_reset(&dev->ctrl))

I have tested the above patch against all possible cases. Please let me know
if this looks good or if there are any further comments.

Thanks,
--Nilay

