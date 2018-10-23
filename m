From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 23 Oct 2018 00:27:25 -0700
Subject: [PATCH] nvmet:added support for identifying controller list
In-Reply-To: <7a927786-cd97-63e3-b2a2-561492580db8@huawei.com>
References: <1540265095-11360-1-git-send-email-lijie34@huawei.com>
 <52246ba4-0b38-b129-edda-e6bc18165e5e@grimberg.me>
 <7a927786-cd97-63e3-b2a2-561492580db8@huawei.com>
Message-ID: <40fc2c0c-8c10-4c5d-d6b2-ae89ab2d1929@grimberg.me>


> Hi Sagi,
> When I use the nvme list-ctrl command, it doesn't work because the
> target side doesn't support querying the controller list. So I added
> these codes to the target side.

But what is the meaning of this information at all? We never connect to
a specific controller in Linux (we don't even support such a thing in
nvmet which implements only dynamic controllers). AFAICT, This is a dump 
of irrelevant information as these cntlids are simply ids of whatever
controllers we have connected at this particular time.

So what I'm asking is, what information are you trying to obtain? I
prefer that if we respond back any information it should be useful
information and not a dump of whatever controllers we have connected.
