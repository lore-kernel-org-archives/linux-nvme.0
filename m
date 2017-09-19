From: brudas@exadel.com (Bogdan Rudas)
Date: Tue, 19 Sep 2017 16:59:11 +0300
Subject: NVMe and SR-IOV, how to use together?
In-Reply-To: <128DFAA9-A4F3-4657-851C-B9DB67A5BFBF@intel.com>
References: <CAO+XWgk1o26gj5n-3vszuoQqXzaLjKdevU133X3206FMzxO6rQ@mail.gmail.com>
 <20170918161148.GA310@infradead.org>
 <CAO+XWgkEZZUqFos7ZV7YbO4HtsUnWjARRTnuDTrSOxm_T0_zmw@mail.gmail.com>
 <20170918184153.GF17096@localhost.localdomain>
 <CAO+XWgkcykO_Udntm7pQR2g0-AvgD=Jy9YOHGxtUPjQUV14XSg@mail.gmail.com>
 <128DFAA9-A4F3-4657-851C-B9DB67A5BFBF@intel.com>
Message-ID: <CAO+XWgnVB_ahFvG3GfRDHbZD6prVcZkrQijphYcEVAEzT7G-Ug@mail.gmail.com>

Sadly no, I've got the drive for compatibility test from local
hardware supplier. Samsung support said "We are very sorry. We could
support only our direct customer." so I'm going to return the drive to
supplier.

On Tue, Sep 19, 2017 at 3:49 PM, Gruher, Joseph R
<joseph.r.gruher@intel.com> wrote:
> It would be interesting to confirm the device really supports SR-IOV. At launch the device claimed it on paper but we were told firmware support had not been implemented. Do you have any support from the manufacturer to confirm the device HW/FW really supports SR-IOV today?
>
>
>> On Sep 19, 2017,@1:31 PM, Bogdan Rudas <brudas@exadel.com> wrote:
>>
>> Hi!
>>
>> I've checked the device on 4.14.0 rc1 kernel. And see no SR-IOV files
>> for SSD PCI device in /sys/devices/..../sriov_*, SR-IOV works for
>> Intel I350 LOM at the same host.
>> However manufactures brochure claims the SR-IOV support for this
>> series. Should I report this as a bug in Linux nvme driver? Is so,
>> what the information should I gather?
>>
>> Here is a brochure with SR-IOV mention:
>> http://www.samsung.com/semiconductor/global/file/insight/2016/08/Samsung_PM1725a-1.pdf
>>
>> Here is SSD information:
>> root at ubuntu-test:~# nvme list
>> Node             SN                   Model
>>        Namespace Usage                      Format           FW Rev
>> ---------------- --------------------
>> ---------------------------------------- ---------
>> -------------------------- ---------------- --------
>> /dev/nvme0n1     S3HBNA0J600073       SAMSUNG MZPLL1T6HEHP-00003
>>        1           1.60  TB /   1.60  TB    512   B +  0 B   GPNA4B3Q
>>
>>> On Mon, Sep 18, 2017@9:41 PM, Keith Busch <keith.busch@intel.com> wrote:
>>>> On Mon, Sep 18, 2017@09:20:16PM +0300, Bogdan Rudas wrote:
>>>> I run kernel 4.4.27 which don't have a support for SR-IOV in NVMe
>>>> driver, that's why I do not see a VFs in lspci output.
>>>
>>> The driver has nothing to do with what lspci will output. If you don't
>>> see the SR-IOV capability structure there, that means your drive doesn't
>>> support it.
>>
>>
>>
>> --
>> Bogdan Rudas
>> Director of IT Europe
>> Exadel Inc.
>> http://www.exadel.com/
>> E-mail: brudas at exadel.com
>> Skype ID: bogdan.rudas
>>
>> --
>>
>>
>> CONFIDENTIALITY NOTICE: This email and files attached to it are
>> confidential. If you are not the intended recipient you are hereby notified
>> that using, copying, distributing or taking any action in reliance on the
>> contents of this information is strictly prohibited. If you have received
>> this email in error please notify the sender and delete this email.
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme



-- 
Bogdan Rudas
Director of IT Europe
Exadel Inc.
http://www.exadel.com/
E-mail: brudas at exadel.com
Skype ID: bogdan.rudas

-- 


CONFIDENTIALITY NOTICE: This email and files attached to it are 
confidential. If you are not the intended recipient you are hereby notified 
that using, copying, distributing or taking any action in reliance on the 
contents of this information is strictly prohibited. If you have received 
this email in error please notify the sender and delete this email.
