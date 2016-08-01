From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 1 Aug 2016 14:24:10 +0300
Subject: [PATCH 2/2] nvme-rdma: Add handling for connecting to IPv6 targets
In-Reply-To: <20160801110956.GI16141@lst.de>
References: <1469950060-18098-1-git-send-email-roland@kernel.org>
 <1469950060-18098-2-git-send-email-roland@kernel.org>
 <4acdd466-b8f6-8208-7287-e97dfd45bbf1@grimberg.me>
 <33dfc646-1804-363e-4d83-1ba618303dbb@grimberg.me>
 <20160801110956.GI16141@lst.de>
Message-ID: <e6e54d3f-c6ee-2057-d4e5-13981cd95140@grimberg.me>


>> Currently the target driver doesn't support ipv6 addresses.
>>
>> These complementary patches [1,2] makes the it work e2e! So,
>
> I think we should use the same ipv6 addr parsing that Roland used
> in the host, and preferably have another module export that as a helper.

I can try to unify them, but unlike the host that first tries ipv4 and
then fall to ipv6, the target needs to enforce the address family so
it's somewhat different. I kinda think that these are different enough
to stay separate don't you think?
