From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Jun 2019 01:02:06 -0700
Subject: [PATCH] nvmet-rdma: move port tsas initialization to rdma code
In-Reply-To: <20190620062914.GD20765@lst.de>
References: <20190619230006.15715-1-sagi@grimberg.me>
 <20190620062914.GD20765@lst.de>
Message-ID: <b9fa7da3-8bc3-eaf6-aaf0-0928231ec610@grimberg.me>


>> Also, look at the device transport capability to send
>> the correct trtype (ib/roce/rocev2/iwarp). Note that if
>> we are listening on addr_any we still return "not specified"
>> trtype and the same goes for referrals.
> 
> I very much disagree with sending the type.  That whole concept
> has been a horrible layering violation in the spec that we should
> not support.

Well, I was asked offline why Linux was not providing this information
and I couldn't find a reason why given that its exposed to the upper
layer...

I don't necessarily think that this is a layering violation, what
I can see as a layering issue though is that these helpers require
port_num, which is cumbersome to extract from the ip address. I guess
this can lead to misinformation in case of dual port devices where each
port has a different rdma link/transport (however this is more theoretic
than practical afaict).

Having said that, its not really a pressing issue, so if there is
resistance to have it, we can drop the prtype.
