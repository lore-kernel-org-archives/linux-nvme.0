From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 8 Aug 2016 11:41:48 +0300
Subject: [PATCH nvme-cli 3/4] fabrics: Remove redundant build_options
In-Reply-To: <20160808070124.GC12598@lst.de>
References: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
 <1470572365-20674-4-git-send-email-sagi@grimberg.me>
 <20160808070124.GC12598@lst.de>
Message-ID: <cfa7f2e7-efd7-4021-db23-3a0f9658cbc4@grimberg.me>

>> We call it again in do_discover.
>
> Do we?  At least in my copy of the tree we don't, and given that
> connect_ctrl builds the argstr differently that would be a bad idea..

I wasn't rebased... you can discard this one...
