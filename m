From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 15:24:13 -0800
Subject: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <20181119.151805.2250212740843808194.davem@davemloft.net>
References: <21b60ffc-d9eb-2f2e-fa1a-891f7f8d5239@grimberg.me>
 <20181119.145343.2254073323355763213.davem@davemloft.net>
 <f4997fa5-a0f1-2783-4732-15fbd7fcafd8@grimberg.me>
 <20181119.151805.2250212740843808194.davem@davemloft.net>
Message-ID: <0de07d6d-ed90-df0e-5710-1f5cdddd6187@grimberg.me>


>> Also, looking a bit closer there is a slight difference between the
>> copy vs. the copy_and_csum variants. copy allows for a short_copy if
>> we copy less than we expect while the csum faults it. I'm thinking
>> that the copy_and_hash variant should also fault? Although I'm not
>> sure I understand the fault entirely as csum is supposed to be
>> cumulative, any insight?
> 
> When we are writing and signal an error, sockets have this recurring
> pattern where we return immediately the amount of bytes successfully
> transferred.  Then on the next sendmsg() call we give the error.
> 
> I don't know if that is what is influencing the behavior here or not
> but it could be.

That makes sense... Does recvmsg() have the same semantics? this is the
rx path where we copy fragments to an iter..

If so, I guess that it makes sense that we fault and not allow short
copies as we have an incomplete csum in this case...

I'm wandering how we can consolidate the code paths together with this
subtle difference? Perhaps a short_copy flag?
