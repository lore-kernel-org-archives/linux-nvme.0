From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 29 Jun 2017 17:25:52 +0300
Subject: nvme defintions not used in the kernel
In-Reply-To: <20170629133159.GA10896@lst.de>
References: <20170628231129.GA20902@lst.de>
 <6503552c-afac-b740-5db6-31d4a7e34256@grimberg.me>
 <20170629083228.GE3808@linux-x5ow.site> <20170629133159.GA10896@lst.de>
Message-ID: <71cc5d10-0f33-f083-601f-a042f9a284a9@grimberg.me>

> Absolutely not.  It's not a userspace API/ABI.  It's an internal header
> that we want to be able to refactor if needed, e.g. if NVMe splits or
> renames fields, or adds unions, etc.  It just happens that nvme-cli
> needs the same defintions.

Yea, lets NOT do that :)
