From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Aug 2019 10:19:04 -0700
Subject: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
In-Reply-To: <20190814201900.GA3511@localhost.localdomain>
References: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
 <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
 <20190814201900.GA3511@localhost.localdomain>
Message-ID: <0cafca37-011d-4c19-4462-14687046a153@grimberg.me>


>> Mario,
>>
>> Can you please respin a patch that applies cleanly on nvme-5.4?
> 
> This fixes a regression we introduced in 5.3, so it should go in
> 5.3-rc. For this to apply cleanly, though, we'll need to resync to Linus'
> tree to get Rafael's PCIe ASPM check after he sends his linux-pm pull
> request.

We need to coordinate with Jens, don't think its a good idea if I'll
just randomly get stuff from linus' tree and send an rc pull request.
