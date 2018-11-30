From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 30 Nov 2018 12:37:42 -0800
Subject: [PATCH v4 00/13] TCP transport binding for NVMe over Fabrics
In-Reply-To: <20181129.181403.1046644111319738364.davem@davemloft.net>
References: <20181127231615.9446-1-sagi@grimberg.me>
 <20181128070116.GB20369@lst.de>
 <133a9650-4413-8692-4200-9d54710e7358@grimberg.me>
 <20181129.181403.1046644111319738364.davem@davemloft.net>
Message-ID: <7bfee670-1658-3888-fc00-3d8c1f4a369e@grimberg.me>


>>> What is the plan ahead here?  I think the nvme code looks pretty
>>> reasonable now (I'll do another pass at nitpicking), but we need the
>>> networking stuff sorted out with at least ACKs, or a merge through
>>> the networking tree and then a shared branch we can pull in.
>>
>> I would think that having Dave ack patches 1-3 and taking it via the
>> nvme tree should be easier..
>>
>> Dave? What would you prefer?
> 
> No preference, if the nvme tree makes things easier for you then
> please do it that way.
> 
> Acked-by: David S. Miller <davem at davemloft.net>

Thanks Dave.
