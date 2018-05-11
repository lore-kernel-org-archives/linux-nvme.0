From: mr.nuke.me@gmail.com (Alex G.)
Date: Fri, 11 May 2018 09:18:53 -0500
Subject: [PATCH] nvme/pci: Sync controller reset for AER slot_reset
In-Reply-To: <4934e3b2-4c74-16a8-8530-d05430cf4aee@gmail.com>
References: <20180510160113.4432-1-keith.busch@intel.com>
 <93d528ce-043a-5118-02b3-986d151b37cf@gmail.com>
 <20180510191417.GA4787@localhost.localdomain>
 <4934e3b2-4c74-16a8-8530-d05430cf4aee@gmail.com>
Message-ID: <906bbf2e-8f95-0959-90b2-5fd11aad0521@gmail.com>



On 05/10/2018 02:20 PM, Alex G. wrote:
> 
> 
> On 05/10/2018 02:14 PM, Keith Busch wrote:
>> On Thu, May 10, 2018@01:56:56PM -0500, Alex G. wrote:
>>>> @@ -2681,8 +2681,15 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
>>>>   
>>>>   	dev_info(dev->ctrl.device, "restart after slot reset\n");
>>>>   	pci_restore_state(pdev);
>>>> -	nvme_reset_ctrl(&dev->ctrl);
>>>> -	return PCI_ERS_RESULT_RECOVERED;
>>>> +	nvme_reset_ctrl_sync(&dev->ctrl);
>>>
>>> This does wonders when nvme_reset_ctrl_sync() returns in a timely
>>> manner. I was also able to get the nvme drive in a state where
>>> nvme_reset_ctrl_sync() does not return. Then we end up with the device
>>> lock in report_slot_reset, which, as you may imagine, is not a great thing.
>>
>> It never returns? That shouldn't happen. There are cases where it may take
>> a very long time, depending on what the controller reports in CAP.TO. The
>> only other case it may stall is if the controller never responds to the
>> initialization admin commands, but that should delay by 60 seconds under
>> default parameters.
> 
> Took 28 minutes before I gave up and rebooted the machine. Maybe I
> should have waited 30.
> Even 60 seconds seems like a terribly long time to wait in AER. Simple
> stuff like block IO and 'nvme list' hangs in kernel space this entire
> time. I can raise a separate issue once I find a reliable way to repro.

I've been playing some more with this. With recovery from a malformed 
TLP resulting from a bad MPS value in the switch upstream port we are 
likely to not return in a timely manner (a few minutes to infinity). 
This happens with less than 100% consistency. I am in a state of 
disbelief, since this makes little sense to me.
Log excerpt below.
Do you think it's a separate issue, or related?

Alex

[   16.828656] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
[ 1605.101288] megaraid_sas 0000:86:00.0: invalid short VPD tag 00 at 
offset 1
[ 1621.514702] pcieport 0000:ae:00.0: AER: Multiple Uncorrected (Fatal) 
error received: id=b020
[ 1621.696135] pcieport 0000:b0:04.0: PCIe Bus Error: 
severity=Uncorrected (Fatal), type=Transaction Layer, id=b020(Receiver ID)
[ 1621.707429] pcieport 0000:b0:04.0:   device [10b5:9733] error 
status/mask=00440000/01a10000
[ 1621.715780] pcieport 0000:b0:04.0:    [18] Malformed TLP          (First)
[ 1621.722568] pcieport 0000:b0:04.0:    [22] Uncorrectable Internal Error
[ 1621.729192] pcieport 0000:b0:04.0:   TLP Header: 60000040 b10000ff 
00000004 4f4bb000
[ 1621.736942] pcieport 0000:b0:04.0: broadcast error_detected message
[ 1621.736945] nvme 0000:b1:00.0: HACK: report_error_detected: Preparing 
to lock
[ 1621.736946] nvme 0000:b1:00.0: HACK: report_error_detected: locked 
and ready
[ 1621.736948] nvme nvme2: frozen state error detected, reset controller
[ 1625.649049] INFO: NMI handler (ghes_notify_nmi) took too long to run: 
175.406 msecs
[ 1634.244302] nvme 0000:b1:00.0: HACK: report_error_detected: Unlocked 
and DONE
[ 1635.290798] pcieport 0000:b0:04.0: downstream link has been reset
[ 1635.290804] pcieport 0000:b0:04.0: broadcast slot_reset message
[ 1635.290811] nvme 0000:b1:00.0: HACK: report_slot_reset: Preparing to lock
[ 1635.290815] nvme 0000:b1:00.0: HACK: report_slot_reset: locked and ready
[ 1635.290823] nvme nvme2: restart after slot reset
