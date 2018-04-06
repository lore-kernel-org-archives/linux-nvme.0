From: mr.nuke.me@gmail.com (Alex G.)
Date: Fri, 6 Apr 2018 10:46:11 -0500
Subject: IRQ/nvme_pci_complete_rq: NULL pointer dereference yet again
In-Reply-To: <20180406153236.GK10098@localhost.localdomain>
References: <5d6d1a8c-6490-4046-0fba-da0a0df3d00c@gmail.com>
 <20180405213847.GG10098@localhost.localdomain>
 <20180405212205.33dqwqck2co25a3x@sbauer-Z170X-UD5>
 <719ea777-e57d-511e-52c5-cf83027d1fd0@gmail.com>
 <20180405224138.GH10098@localhost.localdomain>
 <20180405224830.GI10098@localhost.localdomain>
 <20180405230515.GJ10098@localhost.localdomain>
 <75edea4e-b961-82a1-3612-fc682a248819@gmail.com>
 <d9497570-5e5e-cc4d-2c63-ff273a48725a@gmail.com>
 <20180406153236.GK10098@localhost.localdomain>
Message-ID: <43f32a5a-b147-3620-154c-e3bb839c5aba@gmail.com>

On 04/06/2018 10:32 AM, Keith Busch wrote:
> On Thu, Apr 05, 2018@06:44:21PM -0500, Alex G. wrote:
>> Actually, it crashed very fast [1]
> 
> Could you possibly do an experiment for this? Does this happen if you're
> not using MD RAID and disable NVME_MULTIPATH?

I can, though the whole point of the lvm mirror is to cause IO to the
drive after hot-insert. Without that IO, there's a much smaller window
to get PCIe errors on SURPRISE!!! removal.

Alex
