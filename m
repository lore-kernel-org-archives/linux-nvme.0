From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Apr 2017 14:46:29 +0300
Subject: NVMe over fabrics - Caching controller Identity data
In-Reply-To: <20170420054709.GB18181@infradead.org>
References: <603f53f6-1211-3b5f-31c8-dfa1e8700c26@oracle.com>
 <20170420054709.GB18181@infradead.org>
Message-ID: <7bb84d87-0c17-20e8-d362-65483ea7356e@grimberg.me>


>> As I understand it, the linux initiator caches the controller Identity data
>> and some other values.  These only get loaded when it first connects, or
>> when the controller is reset.  Now If a target wishes to change any of these
>> values, capsule size for instance, it might set the new values and restart
>> itself, but when the initiator reconnects to an existing controller, it
>> still has the old values. Is there a way for the target to force the
>> initiator to reload these values somehow?
>
> Identify controller is supposed to be static data for a controller.
>
> If your controller has changed you need to reject the reconnect and
> present a new controller.

Given that we support dynamic controllers on the host side we need
to issue identify again.

I have some works to centralize this path and there I do re-identify
the controller.
