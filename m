From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 10 Jul 2017 16:09:05 -0600
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <A342254B-1ECB-4644-8D68-328A52940C52@oracle.com>
References: <66b1b8be-e506-50b8-c01f-fa0e3cea98a4@grimberg.me>
 <9D8C7BC8-7E18-405A-9017-9DB23A6B5C15@oracle.com>
 <11aa1a24-9f0b-dbb8-18eb-ad357c7727b2@grimberg.me>
 <9E30754F-464A-4B62-ADE7-F6B2F6D95763@oracle.com>
 <20170709164755.GB3058@obsidianresearch.com>
 <A7C8C159-E916-4060-9FD1-8726D816B3C0@oracle.com>
 <20170710212430.GA21721@obsidianresearch.com>
 <C142385D-3A54-44C9-BA3D-0AABBC5E9E7B@oracle.com>
 <20170710213251.GA21908@obsidianresearch.com>
 <A342254B-1ECB-4644-8D68-328A52940C52@oracle.com>
Message-ID: <20170710220905.GA22589@obsidianresearch.com>

On Mon, Jul 10, 2017@06:04:18PM -0400, Chuck Lever wrote:

> > The server sounds fine, how does the client work?
> 
> The client does not initiate RDMA Read or Write today.

Right, but it provides an rkey that the server uses for READ or WRITE.

The invalidate of that rkey at the client must follow the same rules
as inline send.

Jason
