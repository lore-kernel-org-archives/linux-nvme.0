From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 11 Apr 2018 19:23:26 +0300
Subject: [PATCH 1/1] nvme-rdma: Add IB event handling support
In-Reply-To: <351db80c-ed94-3b92-fc68-97f1873d8a1d@grimberg.me>
References: <1521647315-10011-1-git-send-email-maxg@mellanox.com>
 <351db80c-ed94-3b92-fc68-97f1873d8a1d@grimberg.me>
Message-ID: <be067eff-d337-0f75-c472-97417b9c9c5d@mellanox.com>



On 4/4/2018 4:02 PM, Sagi Grimberg wrote:
> 
>> IB devices may invoke IB events that need a special treatment
>> from the ib_client. For example, fatal event notification raised
>> to registered clients due to an invalid port/device state after EEH.
>> IB clients should be aware of this fatal event and not post any WR's
>> to the device. Draining the QP, for example, is forbidden and will
>> stuck forever waiting for the flushed work completions.
> 
> Where can we find a documentation to what should and should not
> work in this event?

I'll probably abandon this commit since there should be low level 
mechanism that needs to be aware of attempts to post WR to a device in a 
fatal error and generate a "fake" completions.
I'll update if this patch is needed.
