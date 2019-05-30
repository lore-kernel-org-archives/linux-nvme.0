From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 30 May 2019 11:35:09 -0700
Subject: [GIT PULL] nvme fixes for 5.2
In-Reply-To: <18AE3540-5173-4A25-A28E-F0B644BA0AAF@oracle.com>
References: <20190516082541.GA19383@infradead.org>
 <5175ce5c-1943-a167-52f5-094a3d2dc4a4@Oracle.com>
 <FA7D2A4E-6CEF-467C-8153-F1DBCA624626@oracle.com>
 <0eb19967-e0bc-ed16-c2a1-39e624e2d7ab@grimberg.me>
 <18AE3540-5173-4A25-A28E-F0B644BA0AAF@oracle.com>
Message-ID: <4cab00ed-e56f-f963-921d-87d5156eea63@grimberg.me>


> HI Sagi;
> 
>      Prior to implementing the noted commits we never gotten this far before in recovery because the system encountered the OOPS as noted in those commits and fell apart with just one namespace. Now this  occurs during path failover testing while trying to reconnect two name spaces,  and it  ended up with max reconnect attempts of 60 that produced a  different stack trace.

I see.

> A message did appear in the log with the name ?nvme0? , but I can?t tell if that is the device name that was  being deleted , or the next one :  nvme1;  I have no farther explanation why the  OOPS would occur in the print statement unless ?name? was null,   do you ?

This does not realte to the device name, but rather to the device parent
that seems to be NULL (we have a valid kobj but it points to a NULL
parent. This usually happens in a use-after-free conditions.

What is the FC device parent? the FC adapter device? or the 
/dev/nvme-fabrics device?

> Here is the preamble to the previous stack trace.
> 
> May 24 21:09:31 interop-57-161 kernel: nvme nvme0: NVME-FC{0}: reset: Reconnect
> attempt failed (-22)
> May 24 21:09:31 interop-57-161 kernel: nvme nvme0: NVME-FC{0}: Max reconnect
> attempts (60) reached.
> May 24 21:09:31 interop-57-161 kernel: nvme nvme0: Removing ctrl: NQN
> "nqn.1992-08.com.netapp:sn.3d9037c53fed11e9922200a0986a8b60:subsystem.ol_nvme1_ss1"
> May 24 21:09:31 interop-57-161 kernel: kernfs: can not remove 'nvme0', no directory
> May 24 21:09:31 interop-57-161 kernel: ------------[ cut here ]------------
> May 24 21:09:31 interop-57-161 kernel: WARNING: CPU: 6 PID: 14206 at
> fs/kernfs/dir.c:1481 kernfs_remove_by_name_ns+0x7e/0x87
> 
> We are not seeing failover work at all using the lpfc driver.   The connections are established on boot, but when one of the paths are disabled on the NetApp target the system never is able to restores the paths.

So I/O failover is not working with lpfc? that seems to be a different
issue to me. What do you mean that the NetApp target never is able to
restore the paths? That is just an explanation to what triggers the
bug or is that somehow related?
