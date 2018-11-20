From: davem@davemloft.net (David Miller)
Date: Mon, 19 Nov 2018 17:44:35 -0800 (PST)
Subject: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <0de07d6d-ed90-df0e-5710-1f5cdddd6187@grimberg.me>
References: <f4997fa5-a0f1-2783-4732-15fbd7fcafd8@grimberg.me>
 <20181119.151805.2250212740843808194.davem@davemloft.net>
 <0de07d6d-ed90-df0e-5710-1f5cdddd6187@grimberg.me>
Message-ID: <20181119.174435.86984692860441620.davem@davemloft.net>

From: Sagi Grimberg <sagi@grimberg.me>
Date: Mon, 19 Nov 2018 15:24:13 -0800

> 
>>> Also, looking a bit closer there is a slight difference between the
>>> copy vs. the copy_and_csum variants. copy allows for a short_copy if
>>> we copy less than we expect while the csum faults it. I'm thinking
>>> that the copy_and_hash variant should also fault? Although I'm not
>>> sure I understand the fault entirely as csum is supposed to be
>>> cumulative, any insight?
>> When we are writing and signal an error, sockets have this recurring
>> pattern where we return immediately the amount of bytes successfully
>> transferred.  Then on the next sendmsg() call we give the error.
>> I don't know if that is what is influencing the behavior here or not
>> but it could be.
> 
> That makes sense... Does recvmsg() have the same semantics? this is
> the
> rx path where we copy fragments to an iter..

I just checked and TCP at the very least behaves this way on recvmsg()
(report short length, then -EFAULT on next recvmsg() call).

It maintains a local variable "copied" which is increased every time
skb_copy_datagram_msg() is successful.  If in a subsequent iteration
of the loop skb_copy_datagram_msg() returns -EFAULT, it will instead
return 'copied' from recvmsg() if non-zero else the -EFAULT.
