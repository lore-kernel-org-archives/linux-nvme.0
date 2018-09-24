From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 24 Sep 2018 07:04:22 -0700
Subject: Kernel v4.19-rc4 KASAN complaint
In-Reply-To: <6b1a7562-2aa1-c5ff-5dd4-c7a6f7af3697@grimberg.me>
References: <6892a170-0dcf-9498-19c2-50e1ae89f4ef@acm.org>
 <20180920071040.GA8685@infradead.org>
 <6b1a7562-2aa1-c5ff-5dd4-c7a6f7af3697@grimberg.me>
Message-ID: <ce9ff005-5b51-af6f-73b5-7aa7372ca83e@acm.org>

On 9/23/18 9:27 PM, Sagi Grimberg wrote:
> Did this get resolved?

Not yet unfortunately.

> Bart, did this reproduce with nvme.multipath=1? or was it disabled?

The nvmeof-mp tests only work with CONFIG_NVME_MULTIPATH enabled. Is the 
nvme.multipath parameter relevant in that mode?

Bart.
