From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 7 Mar 2017 15:41:02 +0200
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <fbd647dd-3a16-8155-107d-f98e8326cc63@mellanox.com>
References: <08131a05-1f56-ef61-990a-7fff04eea095@gmail.com>
 <de1a559a-bf24-0d73-5fc7-148d6cd4d4e0@grimberg.me>
 <1848296658.37025722.1487782361271.JavaMail.zimbra@redhat.com>
 <1554c1d1-6bf4-9ca2-12d4-a0125d8c5715@gmail.com>
 <DE927C68B458BE418D582EC97927A92854655137@ORSMSX112.amr.corp.intel.com>
 <3eb5814f-14cb-2b94-adf8-335d4b2eb7e9@grimberg.me>
 <26912d0c-578f-26e9-490d-94fc95bdf259@mellanox.com>
 <16c4bd86-fd63-f230-40bc-f52cb106e11b@grimberg.me>
 <fbd647dd-3a16-8155-107d-f98e8326cc63@mellanox.com>
Message-ID: <c5a6f55b-a633-53ca-4378-7a7eaf7f77bd@grimberg.me>


> Hi,
>
> Shahar/Joseph, what is your link layer conf (IB/Eth) ?
> In eth case, have you configured some PFC ? if not, can you try it ?
> I suspect that this is the root cause

The root cause is that the device fails frwr in retransmission
flow, if PFC is not on, it will happen almost immediately, if not
it will happen at some point...

> and it might help you avoiding
> this case, meanwhile we're looking for for the best solution.
>
> Adding Vladimir that will run iSER on his performance setup with the new
> fencing patch (not an NVMEoF related issue).
> We can run also NVMEoF later on if needed.

Thanks.
