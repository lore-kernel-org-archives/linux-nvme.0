From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Jul 2017 19:38:27 +0300
Subject: [PATCH] nvmet: preserve controller serial number between reboots
In-Reply-To: <20170713130652.GA24376@lst.de>
References: <20170713104806.12353-1-jthumshirn@suse.de>
 <d32c32f6-3f8f-c63a-f961-ee16407c2fd6@grimberg.me>
 <20170713130652.GA24376@lst.de>
Message-ID: <5b7b436c-eed1-d731-50be-0733f9ac7155@grimberg.me>


>> It seems weird that a subsystem has a serial.
> 
> But that's actually how NVMe defines them.

Where is that wording?

> Which mean we first
> need to fix our code to generate a serial number per subsystem,
> and on top of that the patch from Johannes seems perfectly reasonable.

If that is indeed the case then sure.
