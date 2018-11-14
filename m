From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 14 Nov 2018 08:32:21 -0800
Subject: [PATCH v2 4/4] nvme: disable fabrics SQ flow control when asked
 by the user
In-Reply-To: <20181114142135.GC27204@infradead.org>
References: <20181003081323.7504-1-sagi@grimberg.me>
 <20181003081323.7504-5-sagi@grimberg.me>
 <20181114142135.GC27204@infradead.org>
Message-ID: <b6119c20-6b1e-e24c-baf3-a8e35c4a0355@grimberg.me>


>> As for now, we don't care about sq_head pointer updates anyway, so
>> at least allow the controller to micro-optimize by omiting this update.
>>
>> Note that we will probably need to support it when a controller
>> that requires this comes along.
> 
> Shouldn't we default to disabling control for any controller that
> supports it instead of adding an option?

We only know if the controller supports it from the discovery log entry
which is processed from userspace, and it does default to disable if
the controller supports it.

Would you prefer that the flag would be opposite? that would change the
existing behavior as Hannes indicated in the last version.
