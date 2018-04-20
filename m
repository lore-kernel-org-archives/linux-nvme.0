From: maxg@mellanox.com (Max Gurtovoy)
Date: Fri, 20 Apr 2018 22:07:49 +0300
Subject: [PATCH 1/2] IB/mlx5: posting klm/mtt list inline in the send
 queue for reg_wr
In-Reply-To: <1524189891.11756.12.camel@redhat.com>
References: <1509295101-14081-1-git-send-email-idanb@mellanox.com>
 <1509295101-14081-2-git-send-email-idanb@mellanox.com>
 <CAL1RGDXbUXcrRyEtHWpBmWpbbCB6nuQVfWC1bi+4K_yp3pB0LQ@mail.gmail.com>
 <1524189891.11756.12.camel@redhat.com>
Message-ID: <9a3fb6ea-151a-117b-182a-6c14c393b898@mellanox.com>

Thanks Roland.
Our team was actually running the patch again using ConnectX-4 and 
ConnectX-5 last week succesfully with NVMe-oF/RDMA. We'll push it throw 
Jason's PR with all the great results published.

-Max.

On 4/20/2018 5:04 AM, Doug Ledford wrote:
> On Thu, 2018-04-19@14:11 -0700, roland wrote:
>>> The fetch of the MTT/KLM list becomes the bottleneck in
>>> number of IO operation could be done by NVMe over Fabrics
>>> host driver on a single adapter as shown below.
>>>
>>> This patch is adding the support for inline registration
>>> work request upon MTT/KLM list of size <=64B.
>>
>> It looks like this patch never made it upstream, and I don't see any
>> discussion or reason why it might have been dropped.
>>
>> This still seems like a good idea - should we respin it against the latest tree?
> 
> If you want it included, then you'll have to respin it if for no other
> reason than the fact that it isn't readily available in patchworks and
> that's what we're using to track/grab patches now a days.  I supposed I
> could go hunting for it, but that's a good way to grab an out of date
> patch and make a mistake by accident...
> 
