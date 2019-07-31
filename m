From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 31 Jul 2019 13:08:05 -0700
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <20190731193257.GB15643@localhost.localdomain>
References: <464bb489-552f-b67e-545d-48616a1e76dd@grimberg.me>
 <CACVXFVO+e5De4+o8cqzvaVbMU22geicCbpmfk6zZStykEiDVmw@mail.gmail.com>
 <82a91815-f7ed-5931-58ac-5893e68cc940@grimberg.me>
 <CACVXFVN6o+dOFwDV=FPSHjVnhYSLBUWNHsXc4B=fwE5PAny_dQ@mail.gmail.com>
 <8bd6d219-f4fd-de58-a341-257c6274eddd@grimberg.me>
 <CACVXFVNT5sjk4MC6qJoBFug8K9YgEFQEy6LSknJT6=O-2ispMg@mail.gmail.com>
 <2825eb74-1df5-5dd2-3e90-c696bc7fa3d1@grimberg.me>
 <20190730173048.GC13948@localhost.localdomain>
 <61445d6f-f4ca-f8d4-cef2-5bfe40aa1e7f@suse.de>
 <2f7535ab-3d45-b24d-1512-a937e16e620f@grimberg.me>
 <20190731193257.GB15643@localhost.localdomain>
Message-ID: <0720636c-8706-e927-3c0b-c2687694664f@grimberg.me>


>> I think I asked this but was not answered, why are we removing
>> the namespace at all? do others do the same thing (remove the
>> disk if revalidation fails)?
> 
> If a namespace no longer exists,

Why is it no longer exists? it failed revalidate..

> what do you want to do with it instead of removing it?

Well, I don't see anyone else even checking the return
status of revalidate_disk.. Perhaps Hannes can share more
on how scsi handles this?
