From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 5 Dec 2017 09:30:31 +0200
Subject: "nvme0c1n1: detected capacity change from 0 to 268435456000"
 message in controller reset
In-Reply-To: <20171204222408.GA19382@lst.de>
References: <a40e737d-33e3-b2fe-b079-048ecdc92963@grimberg.me>
 <20171204222408.GA19382@lst.de>
Message-ID: <e9376480-263d-c2bb-f695-ed8bd77a6bde@grimberg.me>


>> I get this message when running nvme reset /dev/nvme0
> 
> What's the exact setup?

Nothing special, just connect with a single fabrics controller
(pick your favorite transport, I used loop) and just reset it.
