From: yizhan@redhat.com (yizhan)
Date: Wed, 27 Sep 2017 00:19:43 +0800
Subject: nvme_fc: nvme disconnect -n lead to kernel NULL pointer
In-Reply-To: <a8ce1220-64fa-8fee-26db-1447d8d51c71@broadcom.com>
References: <1545275004.9749092.1506410318764.JavaMail.zimbra@redhat.com>
 <a8ce1220-64fa-8fee-26db-1447d8d51c71@broadcom.com>
Message-ID: <203cca91-30d8-af40-3256-45a36d6962aa@redhat.com>



On 09/26/2017 11:29 PM, James Smart wrote:
> Yes, but...   the working setup has a bunch of fixes added by the 
> devloss support patches which have not been picked up.
>
> I'll be reposting what's outstanding shortly.
>
OK, will try it later, thanks for the update.

Thanks
Yi
> -- james
>
>
> On 9/26/2017 12:18 AM, Yi Zhang wrote:
>> Hello
>>
>> Does nvme disconnect support for nvme_fc? I tried the cmd[1] on host 
>> after setup the nvme fc, NULL pointer observed.
>>
>> [1]
>> nvme disconnect -n fctest1
>>
>> Environment:
>> HW:
>> # lspci | grep -i emulex
>> 04:00.0 Fibre Channel: Emulex Corporation Lancer Gen6: LPe32000 Fibre 
>> Channel Host Adapter (rev 01)
>> 04:00.1 Fibre Channel: Emulex Corporation Lancer Gen6: LPe32000 Fibre 
>> Channel Host Adapter (rev 01)
>> Topology: Point to Point
>> Firmware version:
>> # cat /sys/class/scsi_host/host11/fwrev
>> 11.2.216.9, sli-4:2:c
>>
>> Host side log:
>> [  749.408489] nvme nvme0: NVME-FC{0}: new ctrl: NQN "fctest1"
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
