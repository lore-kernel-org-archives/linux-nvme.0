From: john.p.donnelly@oracle.com (John Donnelly)
Date: Wed, 29 May 2019 08:44:54 -0500
Subject: [GIT PULL] nvme fixes for 5.2
In-Reply-To: <0eb19967-e0bc-ed16-c2a1-39e624e2d7ab@grimberg.me>
References: <20190516082541.GA19383@infradead.org>
 <5175ce5c-1943-a167-52f5-094a3d2dc4a4@Oracle.com>
 <FA7D2A4E-6CEF-467C-8153-F1DBCA624626@oracle.com>
 <0eb19967-e0bc-ed16-c2a1-39e624e2d7ab@grimberg.me>
Message-ID: <18AE3540-5173-4A25-A28E-F0B644BA0AAF@oracle.com>



> On May 29, 2019,@1:22 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
> 
> 
>>   It appears to me the caller nvme_free_ctrl()  is using a device name that has been cleared :
>>     sysfs_remove_link(&subsys->dev.kobj, dev_name(ctrl->device));
>> The name passed in is null in kernfs_remove_by_name_ns() :
>>  if (!parent) {
>>    WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",   name);
> 
> Where do you see this warning in the log?
> 
>> I don?t have a actual crash dump to examine though.
> 
> Is this a regression then? or did this not work before the above
> patches?
> 
> Would it be possible to get some more of the log?
> 
> Also, I see that this is the removal flow, was that intentional
> removal during the reconnect? or did ctrl_loss_tmo expired?


HI Sagi;

    Prior to implementing the noted commits we never gotten this far before in recovery because the system encountered the OOPS as noted in those commits and fell apart with just one namespace. Now this  occurs during path failover testing while trying to reconnect two name spaces,  and it  ended up with max reconnect attempts of 60 that produced a  different stack trace.

A message did appear in the log with the name ?nvme0? , but I can?t tell if that is the device name that was  being deleted , or the next one :  nvme1;  I have no farther explanation why the  OOPS would occur in the print statement unless ?name? was null,   do you ?   


Here is the preamble to the previous stack trace. 

May 24 21:09:31 interop-57-161 kernel: nvme nvme0: NVME-FC{0}: reset: Reconnect
attempt failed (-22)
May 24 21:09:31 interop-57-161 kernel: nvme nvme0: NVME-FC{0}: Max reconnect
attempts (60) reached.
May 24 21:09:31 interop-57-161 kernel: nvme nvme0: Removing ctrl: NQN
"nqn.1992-08.com.netapp:sn.3d9037c53fed11e9922200a0986a8b60:subsystem.ol_nvme1_ss1"
May 24 21:09:31 interop-57-161 kernel: kernfs: can not remove 'nvme0', no directory
May 24 21:09:31 interop-57-161 kernel: ------------[ cut here ]------------
May 24 21:09:31 interop-57-161 kernel: WARNING: CPU: 6 PID: 14206 at
fs/kernfs/dir.c:1481 kernfs_remove_by_name_ns+0x7e/0x87

We are not seeing failover work at all using the lpfc driver.   The connections are established on boot, but when one of the paths are disabled on the NetApp target the system never is able to restores the paths. 
