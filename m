From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Jun 2018 11:40:22 +0300
Subject: [PATCH 0/7] few nvme-rdma fixes for 4.18
In-Reply-To: <20180620084011.GC3284@lst.de>
References: <20180619123415.25077-1-sagi@grimberg.me>
 <20180620084011.GC3284@lst.de>
Message-ID: <306127fb-c15e-a5c7-70cf-b4e39c328979@grimberg.me>


>> Patches 1-5 fixes some allocation/free glitches reported. patches
>> 6-7 try to centralize some setup/teardown logic such that fixes
>> can be applied in a single location (which can probably go to
>> 4.19).
> 
> Yeah, the last two are clearly 4.19 material.
> 
> But even the ones before are pretty invasive.  I'll apply them to
> nvme-4.18 for now, but I feel a bit uneasy.

Let me try and ease your feel ;)

1-3 fix crashes, so they are must.
4 is needed to prevent a theoretical hang in controller removal, but
never encountered.
5 is theoretical to a case where a dynamic controller changes its
attributes.

So 4-5 can safely be included in 4.19
