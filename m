Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A047C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Apr 2024 16:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pp7art5nwVMxZvAHZ1//5si+rNHK1yWGyXnM1DnZLO8=; b=LoDerjPSJBguC6VeW1etwjaMBN
	BMRCwxEsPGmOs11rhMqRyVRHf3pIljt6Nri7T/iTonBHDnP+Kc02Zwh3Gr2Xa3pPD7WUOQzDEYIGk
	wu0Q6N6Toi2PFkV3dlqf5GXmPefZOUWvFFjePYhE+NKk/0yM9noaK/Z2DfJV9UBqVMBuxBDaclLw0
	gIu9u5tQCW+C3TYMDJm52DFNS5tYhJj27toTeGIfMRRkX5sBzntIQLi+ae9XedC33u6j27IbRghY6
	aGDA2TbdvdQPRq7j1R65WMHA7AGlbNMEey4IKer8fSUkdUhH9BxNQq4fSKN4PzSkqYK+Zrw8AWlz+
	P3gwrQLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryaRj-0000000AsIN-2Dpx;
	Sun, 21 Apr 2024 16:53:43 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryaRg-0000000AsHH-3BdO
	for linux-nvme@lists.infradead.org;
	Sun, 21 Apr 2024 16:53:42 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43LGm3kU022178
	for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 16:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pp7art5nwVMxZvAHZ1//5si+rNHK1yWGyXnM1DnZLO8=;
 b=pltOlho3mjvxBcvw/zdRY467kD1qpiHMWLuM2P6BE+JvLfiNCZa86ALH3dAm6Ns5UoSL
 t/TVrQX71LmwmHlOU6hdR9MhoUiS6I2uPm2zx1g5qc4kgM8NdSD4BSKV2XBjUGcz71B0
 htLXpmi+KRHGs8NdlX8R3QV9unaT3jBmn066XwUC8LfY0izW+uqqpX24Gi3dJvVuxdFB
 P96TDXC+RWfkbHC90CrVZ62rs2rOEddcVcrye+/aQkFuR5+ohBL7ghlsDq8YUh0VmkXA
 z/lGJ+OzUvMQOrpUT30AU9u9J6ZLZIjRpjwXwhtmWpUVAZu5MLb7d+22xyp8c32Kzm68 lg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xn6mhr08k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 16:53:37 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43LFojcH005373
	for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 16:53:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3c20gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 16:53:36 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43LGrY6G6423276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 16:53:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E999C58068
	for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 16:53:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A84358052
	for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 16:53:33 +0000 (GMT)
Received: from [9.171.13.75] (unknown [9.171.13.75])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP
	for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 16:53:32 +0000 (GMT)
Message-ID: <486e0e88-7e28-454b-9184-7be5a0bcfb1c@linux.ibm.com>
Date: Sun, 21 Apr 2024 22:23:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] PCIe errinject and hot-unplug causes nvme driver
 hang
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <199be893-5dfa-41e5-b6f2-40ac90ebccc4@linux.ibm.com>
 <579c82da-52a7-4425-81d7-480c676b8cbb@grimberg.me>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <579c82da-52a7-4425-81d7-480c676b8cbb@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FFJqbhh14iYJL1AEtqKLQ8-fLkB7Uiqv
X-Proofpoint-ORIG-GUID: FFJqbhh14iYJL1AEtqKLQ8-fLkB7Uiqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-21_16,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404210106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_095341_057377_D8D188FE 
X-CRM114-Status: GOOD (  28.87  )
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



On 4/21/24 15:58, Sagi Grimberg wrote:
> 
> 
> On 18/04/2024 15:52, Nilay Shroff wrote:
>> Hi,
>>
>> We found nvme driver hangs when disk IO is ongoing and if we inject pcie error and hot-unplug (not physical but logical unplug) the nvme disk.
>>
>> Notes and observations:
>> ======================
>> This is observed on the latest linus kernel tree (v6.9-rc4) however we believe this issue shall also be present on the older kernels.
>>
>> Test details:
>> =============
>> Steps to reproduce this issue:
>>
>> 1. Run some disk IO using fio or any other tool
>> 2. While disk IO is running, inject pci error
>> 3. disable the slot where nvme disk is attached (echo 0 > /sys/bus/pci/slots/<slot-no>/power)
>>
>> Kernel Logs:
>> ============
>> When we follow steps described in the test details we get the below logs:
>>
>> [  295.240811] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
>> [  295.240837] nvme nvme1: Does your device have a faulty power saving mode enabled?
>> [  295.240845] nvme nvme1: Try "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug
>> [  490.381591] INFO: task bash:2510 blocked for more than 122 seconds.
>> [  490.381614]       Not tainted 6.9.0-rc4+ #8
>> [  490.381618] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  490.381623] task:bash            state:D stack:0     pid:2510  tgid:2510  ppid:2509   flags:0x00042080
>> [  490.381632] Call Trace:
>> [  490.381635] [c00000006748f510] [c00000006748f550] 0xc00000006748f550 (unreliable)
>> [  490.381644] [c00000006748f6c0] [c00000000001f3fc] __switch_to+0x13c/0x220
>> [  490.381654] [c00000006748f720] [c000000000fb87e0] __schedule+0x268/0x7c4
>> [  490.381663] [c00000006748f7f0] [c000000000fb8d7c] schedule+0x40/0x108
>> [  490.381669] [c00000006748f860] [c000000000808bb4] blk_mq_freeze_queue_wait+0xa4/0xec
>> [  490.381676] [c00000006748f8c0] [c00000000081eba8] del_gendisk+0x284/0x464
>> [  490.381683] [c00000006748f920] [c0080000064c74a4] nvme_ns_remove+0x138/0x2ac [nvme_core]
>> [  490.381697] [c00000006748f960] [c0080000064c7704] nvme_remove_namespaces+0xec/0x198 [nvme_core]
>> [  490.381710] [c00000006748f9d0] [c008000006704b70] nvme_remove+0x80/0x168 [nvme]
>> [  490.381752] [c00000006748fa10] [c00000000092a10c] pci_device_remove+0x6c/0x110
>> [  490.381776] [c00000006748fa50] [c000000000a4f504] device_remove+0x70/0xc4
>> [  490.381786] [c00000006748fa80] [c000000000a515d8] device_release_driver_internal+0x2a4/0x324
>> [  490.381801] [c00000006748fad0] [c00000000091b528] pci_stop_bus_device+0xb8/0x104
>> [  490.381817] [c00000006748fb10] [c00000000091b910] pci_stop_and_remove_bus_device+0x28/0x40
>> [  490.381826] [c00000006748fb40] [c000000000072620] pci_hp_remove_devices+0x90/0x128
>> [  490.381831] [c00000006748fbd0] [c008000004440504] disable_slot+0x40/0x90 [rpaphp]
>> [  490.381839] [c00000006748fc00] [c000000000956090] power_write_file+0xf8/0x19c
>> [  490.381846] [c00000006748fc80] [c00000000094b4f8] pci_slot_attr_store+0x40/0x5c
>> [  490.381851] [c00000006748fca0] [c0000000006e5dc4] sysfs_kf_write+0x64/0x78
>> [  490.381858] [c00000006748fcc0] [c0000000006e48d8] kernfs_fop_write_iter+0x1b0/0x290
>> [  490.381864] [c00000006748fd10] [c0000000005e0f4c] vfs_write+0x3b0/0x4f8
>> [  490.381871] [c00000006748fdc0] [c0000000005e13c0] ksys_write+0x84/0x140
>> [  490.381876] [c00000006748fe10] [c000000000030a84] system_call_exception+0x124/0x330
>> [  490.381882] [c00000006748fe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
>>
>> NVMe controller state:
>> ======================
>> # cat /sys/class/nvme/nvme1/state
>> deleting (no IO)
>>
>> Process State:
>> ==============
>> # ps -aex
>>     [..]
>>     2510 pts/2    Ds+    0:00 -bash USER=root LOGNAME=root HOME=/root PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin SHELL=/bin/bash TERM=xterm-256colo
>>     2549 ?        Ds     0:14 fio --filename=/dev/nvme1n1 --direct=1 --rw=randrw --bs=4k --ioengine=psync --iodepth=256 --runtime=300 --numjobs=1 --time_based
>>     [..]
>>
>> Observation:
>> ============
>> As it's apparent from the above logs that "disable-slot" (pid 2510) is waiting (uninterruptible-sleep)
>> for queue to be freezed because the in-flight IO(s) couldn't finish. Moreover the IO(s) which were
>> in-flight actually times-out however nvme_timeout() doesn't cancel those IOs but logs this error
>> "Try "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug" and returns BLK_EH_DONE.
>> As those in-fligh IOs were not cancelled, the NVMe driver code which runs in the context of
>> "disable-slot" couldn't forward progress and NVMe controller state remains in "deleting (no IO)"
>> indefinitely. The only way we found to come out of this state is to reboot the system.
>>
>> Proposed fix:
>> ============
>> static void nvme_remove(struct pci_dev *pdev)
>> {
>>     struct nvme_dev *dev = pci_get_drvdata(pdev);
>>
>>     nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>>     pci_set_drvdata(pdev, NULL);
>>
>>     if (!pci_device_is_present(pdev)) {
>>         nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
>>         nvme_dev_disable(dev, true);
>>     }
>>     flush_work(&dev->ctrl.reset_work);
>>     nvme_stop_ctrl(&dev->ctrl);
>>     nvme_remove_namespaces(&dev->ctrl); <== here cntrl state is set to "deleting (no IO)"
>>          [..]
>> }
>>
>> As shown above, nvme_remove() invokes nvme_dev_disable(), however, it is only invoked if the
>> device is physically removed. As nvme_dev_disable() helps cancel pending IOs, does it makes
>> sense to unconditionally cancel pending IOs before moving on? Or are there any side effect if
>> we were to unconditionally invoke nvme_dev_disable() at the first place?
> 
> Shouldn't the correct place to handle the cancellation is nvme_error_detected() given that the
> pci error is preventing the request from completing and the timeout handler from addressing it?
> 
If a platform supports pci-error-recovery then it may be possible to cancel pending IOs from 
nvme_error_detected(), however, if the platform doesn't support pci error recovery then 
nvme_error_detected() would never be called. In fact, the issue which I reported above was
discovered on a platform which has pci-error-recovery disabled.

I also tested this scenario on a platform supporting the pci error recovery. On this platform, 
when I ran this test (PCI error injection followed by NVMe hot unpulg), I found that the 
pci-error-recovery thread races with hot-unplug task, please find below the dmesg logs 
collected when this issue manifests:

INFO: task eehd:187 blocked for more than 122 seconds.
      Not tainted 6.9.0-rc4+ #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:eehd            state:D stack:0     pid:187   tgid:187   ppid:2      flags:0x00000000
Call Trace:
[c0000000089bf890] [c000000000fb027c] vsnprintf+0x3f8/0x578 (unreliable)
[c0000000089bfa40] [c00000000001f3fc] __switch_to+0x13c/0x220
[c0000000089bfaa0] [c000000000fb87e0] __schedule+0x268/0x7c4
[c0000000089bfb70] [c000000000fb8d7c] schedule+0x40/0x108
[c0000000089bfbe0] [c000000000fb93f8] schedule_preempt_disabled+0x20/0x30
[c0000000089bfc00] [c000000000fbbe84] __mutex_lock.constprop.0+0x5f4/0xc54
[c0000000089bfca0] [c000000000916380] pci_lock_rescan_remove+0x28/0x3c
[c0000000089bfcc0] [c00000000004fa4c] eeh_pe_report_edev+0x3c/0x52c
[c0000000089bfda0] [c00000000004ffdc] eeh_pe_report+0xa0/0x158
[c0000000089bfe40] [c000000000050490] eeh_handle_normal_event+0x310/0xa24
[c0000000089bff30] [c000000000051078] eeh_event_handler+0x118/0x19c
[c0000000089bff90] [c00000000018d29c] kthread+0x138/0x140
[c0000000089bffe0] [c00000000000dd58] start_kernel_thread+0x14/0x18

INFO: task bash:5420 blocked for more than 122 seconds.
      Not tainted 6.9.0-rc4+ #8
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:bash            state:D stack:0     pid:5420  tgid:5420  ppid:5419   flags:0x00042080
Call Trace:
[c000000054c67510] [c000000054c67550] 0xc000000054c67550 (unreliable)
[c000000054c676c0] [c00000000001f3fc] __switch_to+0x13c/0x220
[c000000054c67720] [c000000000fb87e0] __schedule+0x268/0x7c4
[c000000054c677f0] [c000000000fb8d7c] schedule+0x40/0x108
[c000000054c67860] [c000000000808bb4] blk_mq_freeze_queue_wait+0xa4/0xec
[c000000054c678c0] [c00000000081eba8] del_gendisk+0x284/0x464
[c000000054c67920] [c00800000b7174a4] nvme_ns_remove+0x138/0x2ac [nvme_core]
[c000000054c67960] [c00800000b717704] nvme_remove_namespaces+0xec/0x198 [nvme_core]
[c000000054c679d0] [c008000006294b70] nvme_remove+0x80/0x168 [nvme]
[c000000054c67a10] [c00000000092a10c] pci_device_remove+0x6c/0x110
[c000000054c67a50] [c000000000a4f504] device_remove+0x70/0xc4
[c000000054c67a80] [c000000000a515d8] device_release_driver_internal+0x2a4/0x324
[c000000054c67ad0] [c00000000091b528] pci_stop_bus_device+0xb8/0x104
[c000000054c67b10] [c00000000091b910] pci_stop_and_remove_bus_device+0x28/0x40
[c000000054c67b40] [c000000000072620] pci_hp_remove_devices+0x90/0x128
[c000000054c67bd0] [c008000004380504] disable_slot+0x40/0x90 [rpaphp]
[c000000054c67c00] [c000000000956090] power_write_file+0xf8/0x19c
[c000000054c67c80] [c00000000094b4f8] pci_slot_attr_store+0x40/0x5c
[c000000054c67ca0] [c0000000006e5dc4] sysfs_kf_write+0x64/0x78
[c000000054c67cc0] [c0000000006e48d8] kernfs_fop_write_iter+0x1b0/0x290
[c000000054c67d10] [c0000000005e0f4c] vfs_write+0x3b0/0x4f8
[c000000054c67dc0] [c0000000005e13c0] ksys_write+0x84/0x140
[c000000054c67e10] [c000000000030a84] system_call_exception+0x124/0x330
[c000000054c67e50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec


As we can see above the task eehd:187 (pci-error-recovery thread) is blocked for 
acquiring the mutex (pci_rescan_remove_lock). The hot-unplug task (bash: 5420)
is blocked on the request queue to be freezed. The hot-unplug task first acquires
the pci_rescan_remove_lock and then invokes nvme_remove() method. So in summary, 
in the traces shown above, as hot-unplug task is unable to proceed, it has also 
blocked the pci-error-recovery thread. 

On another note, if pci-error-recovery thread could progress first acquiring 
pci_rescan_remove_lock then it shall be able to recover the pci error and hence
pending IOs could be finished. Later when hot-unplug task starts, it could 
forward progress and cleanup all resources used by the nvme disk. 

So does it make sense if we unconditionally cancel the pending IOs from 
nvme_remove() before it forward progress to remove namespaces?

Thanks,
--Nilay

















 

