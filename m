From: sashal@kernel.org (Sasha Levin)
Date: Mon, 11 Mar 2019 13:21:44 -0400
Subject: [PATCH AUTOSEL 4.19 59/64] nvme-pci: fix rapid add remove sequence
In-Reply-To: <20190228151642.GA21796@localhost.localdomain>
References: <20190228151105.11277-1-sashal@kernel.org>
 <20190228151105.11277-59-sashal@kernel.org>
 <20190228151642.GA21796@localhost.localdomain>
Message-ID: <20190311172144.GF158926@sasha-vm>

On Thu, Feb 28, 2019@08:16:43AM -0700, Keith Busch wrote:
>On Thu, Feb 28, 2019@10:11:00AM -0500, Sasha Levin wrote:
>> From: Keith Busch <keith.busch at intel.com>
>>
>> [ Upstream commit 5c959d73dba6495ec01d04c206ee679d61ccb2b0 ]
>
>This patch was broken, so please make sure to include the one that
>fixes this:
>
>  Upstream commit 4726bcf30fad37cc555cd9dcd6c73f2b2668c879
>  ("nvme-pci: add missing unlock for reset error")

I've queued this one as well, thank you.

--
Thanks,
Sasha
