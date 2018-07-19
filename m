From: james.smart@broadcom.com (James Smart)
Date: Thu, 19 Jul 2018 08:04:09 -0700
Subject: [PATCH 0/4] Rework NVMe abort handling
In-Reply-To: <20180719145422.2tdrbwa34gheuam3@linux-x5ow.site>
References: <20180719132838.15556-1-jthumshirn@suse.de>
 <20180719134203.GA15212@lst.de>
 <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
 <20180719142355.GA18800@lst.de>
 <20180719143534.i36vo45lhz24xbrg@linux-x5ow.site>
 <20180719145005.GA21000@lst.de>
 <20180719145422.2tdrbwa34gheuam3@linux-x5ow.site>
Message-ID: <8d1ad465-c6b2-b67d-39f5-c88d849a89dd@broadcom.com>

On 7/19/2018 7:54 AM, Johannes Thumshirn wrote:
> On Thu, Jul 19, 2018@04:50:05PM +0200, Christoph Hellwig wrote:
>> The upper layer is only going to retry after tearing down the transport
>> connection.  And a tear down of the connection MUST clear all pending
>> commands on the way.  If it doesn't we are in deep, deep trouble.
>>
>> A NVMe abort has no chance of clearing things at the transport layer.
> OK so all I can do in my case (if I want soft error recovery) is send
> out a transport abort in the timeout handler and then rearm the timer
> and requeue the command.
>
> Which leaves us to the FC patch only, modified of cause.
>

Which I'm going to say no on. I originally did the abort before the 
reset and it brought out some confusion in the reset code. Thus the 
existing flow which just resets the controller which has to be done 
after the abort anyway.

-- james
