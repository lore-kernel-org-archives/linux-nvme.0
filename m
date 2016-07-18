From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Mon, 18 Jul 2016 08:20:54 -0700
Subject: [PATCH 0/2] Get rid of transport layer retry count config
 parameter
In-Reply-To: <20160622161559.GA18361@infradead.org>
References: <1466597161-5242-1-git-send-email-sagi@grimberg.me>
 <20160622161559.GA18361@infradead.org>
Message-ID: <12b64608-1d42-ffe6-c11a-58139cbabd3a@sandisk.com>

On 06/22/2016 09:15 AM, Christoph Hellwig wrote:
> On Wed, Jun 22, 2016@03:05:59PM +0300, Sagi Grimberg wrote:
>> This parameter was added in order to support a proper timeout for
>> error recovery before the spec defined a periodic keep-alive.
>>
>> Now that we have periodic keep-alive, we don't need a user configurable
>> transport layer retry count, the keep-alive timeout is sufficient,
>> transports can retry for as long as they see fit.
>
> Isn't there some IB protocol level rationale for a low retry count
> in various fabric setups?

The IB spec defines an end-to-end credit mechanism for RC connections. 
So if the transport layer is reliable (InfiniBand, RoCE with DCB 
enabled) setting the retry count high enough is only needed to avoid 
connection shutdown due to brief cable disconnect/reconnect events.

Bart.
