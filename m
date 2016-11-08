From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 8 Nov 2016 12:30:11 +0200
Subject: [PATCH RFC nvme-cli 0/2] auto generate hostnqn file on
 installation
In-Reply-To: <1478550886.5463.14.camel@linux.intel.com>
References: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
 <20161106192451.GA18342@lst.de>
 <5a2ee2fb-8104-39cc-1af3-f0fca1caa48e@grimberg.me>
 <1478550886.5463.14.camel@linux.intel.com>
Message-ID: <8b97b0f3-750f-b892-a6f5-d15dbc2dfb50@grimberg.me>


> How about an extra tweak to that tool proposal?  Have the tool have the
> option to do both NQN supported formats:
>
> A. the first format that uses a date code in which I think that is what
> patch 2 in this series was trying to do
>
> and
>
> B. The second format the NVMe Host driver is already does in fabrics.c

Lets not over-complicate this, perhaps just do (A)?
