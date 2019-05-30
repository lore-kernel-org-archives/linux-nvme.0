From: john.p.donnelly@oracle.com (John Donnelly)
Date: Thu, 30 May 2019 14:29:24 -0500
Subject: [GIT PULL] nvme fixes for 5.2
In-Reply-To: <12ddd385-22a3-d109-7997-31d7ed4f0ee6@broadcom.com>
References: <20190516082541.GA19383@infradead.org>
 <5175ce5c-1943-a167-52f5-094a3d2dc4a4@Oracle.com>
 <FA7D2A4E-6CEF-467C-8153-F1DBCA624626@oracle.com>
 <0eb19967-e0bc-ed16-c2a1-39e624e2d7ab@grimberg.me>
 <18AE3540-5173-4A25-A28E-F0B644BA0AAF@oracle.com>
 <4cab00ed-e56f-f963-921d-87d5156eea63@grimberg.me>
 <12ddd385-22a3-d109-7997-31d7ed4f0ee6@broadcom.com>
Message-ID: <FF2176CE-C846-448A-AF71-E5C0AAA90CBB@oracle.com>



> On May 30, 2019,@2:21 PM, James Smart <james.smart@broadcom.com> wrote:
> 
> 
> 
> On 5/30/2019 11:35 AM, Sagi Grimberg wrote:
>> 
>>> HI Sagi;
>>> 
>>>      Prior to implementing the noted commits we never gotten this far before in recovery because the system encountered the OOPS as noted in those commits and fell apart with just one namespace. Now this  occurs during path failover testing while trying to reconnect two name spaces,  and it  ended up with max reconnect attempts of 60 that produced a  different stack trace.
>> 
>> I see.
>> 
>>> A message did appear in the log with the name ?nvme0? , but I can?t tell if that is the device name that was  being deleted , or the next one :  nvme1;  I have no farther explanation why the  OOPS would occur in the print statement unless ?name? was null,   do you ?
>> 
>> This does not realte to the device name, but rather to the device parent
>> that seems to be NULL (we have a valid kobj but it points to a NULL
>> parent. This usually happens in a use-after-free conditions.
>> 
>> What is the FC device parent? the FC adapter device? or the /dev/nvme-fabrics device?
> 
> Warning:   tracking down an issue based on 2 individual commits that were pulled into a kernel base that does not contain the other commits found in the upstream tree, is dangerous.

 Yes. I can see that ; 
> 
> It's recommended that the issue be reported when running what is in the upstream tree (at least the infradead branch).
> 
> Also, relative to:
> >  It appears to me the caller nvme_free_ctrl()  is using a device name that has been cleared :
> >       sysfs_remove_link(&subsys->dev.kobj, dev_name(ctrl->device));
> >  The name passed in is null in kernfs_remove_by_name_ns() :
> >
> >  if (!parent) {
> >      WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",   name);
> 
> This is the nvme controller device, referencing it's own device struct which it created it's own name for, which has its parent set to the the nvmf_device passed through nvmf_create_ctrl() to the transport ops->create_ctrl() to nvme_init_ctrl().
> 
> 
>> 
>>> Here is the preamble to the previous stack trace.
>>> 
>>> May 24 21:09:31 interop-57-161 kernel: nvme nvme0: NVME-FC{0}: reset: Reconnect
>>> attempt failed (-22)
>>> May 24 21:09:31 interop-57-161 kernel: nvme nvme0: NVME-FC{0}: Max reconnect
>>> attempts (60) reached.
>>> May 24 21:09:31 interop-57-161 kernel: nvme nvme0: Removing ctrl: NQN
>>> "nqn.1992-08.com.netapp:sn.3d9037c53fed11e9922200a0986a8b60:subsystem.ol_nvme1_ss1" 
>>> May 24 21:09:31 interop-57-161 kernel: kernfs: can not remove 'nvme0', no directory
>>> May 24 21:09:31 interop-57-161 kernel: ------------[ cut here ]------------
>>> May 24 21:09:31 interop-57-161 kernel: WARNING: CPU: 6 PID: 14206 at
>>> fs/kernfs/dir.c:1481 kernfs_remove_by_name_ns+0x7e/0x87
>>> 
>>> We are not seeing failover work at all using the lpfc driver. The connections are established on boot, but when one of the paths are disabled on the NetApp target the system never is able to restores the paths.
>> 
>> So I/O failover is not working with lpfc? that seems to be a different
>> issue to me. What do you mean that the NetApp target never is able to
>> restore the paths? That is just an explanation to what triggers the
>> bug or is that somehow related?
> 
> too many leaps and bounds are being stated when the base sources aren't consistent.   Things work when all the dependencies are put together.  When bits are cherry picked - it's a b*#%@ to figure out which piece is missing to get everything working together.
> 
> -- james
> 
> 
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwIGaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=EJDfq5Vcx2ufCv4SsZ1s5hnMGt-2lrtfPwCuuS-dbhI&s=vJVjop4Ccn8M-VxkQ2WwRE4nHdxS39qjgARDpnrOWTI&e=
