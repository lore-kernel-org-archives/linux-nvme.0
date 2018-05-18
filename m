From: ming.lei@redhat.com (Ming Lei)
Date: Sat, 19 May 2018 07:51:29 +0800
Subject: [PATCH V6 11/11] nvme: pci: support nested EH
In-Reply-To: <20180518234500.GB31749@localhost.localdomain>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180518001958.GA2742@ming.t460p>
 <20180518135751.GI23555@localhost.localdomain>
 <20180518222622.GA18334@ming.t460p>
 <20180518234500.GB31749@localhost.localdomain>
Message-ID: <20180518235128.GA19799@ming.t460p>

On Fri, May 18, 2018@05:45:00PM -0600, Keith Busch wrote:
> On Sat, May 19, 2018@06:26:28AM +0800, Ming Lei wrote:
> > So could we please face to the real issue instead of working around
> > test case?
> 
> Yes, that's why I want you to stop referencing the broken test.

Unfortunately I don't care if it is broken or not, and I think
the test case is great because it can expose the real problem.
That is its value!

The reason why I referenced this test is that everyone can reproduce
this real issue easily, that is it.

Thanks,
Ming
