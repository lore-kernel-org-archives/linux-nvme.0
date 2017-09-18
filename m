From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 18 Sep 2017 08:58:22 -0700
Subject: Host reconnecting need more than 60s to start after nvmetcli
 clear on target
In-Reply-To: <402757886.5318604.1504871077415.JavaMail.zimbra@redhat.com>
References: <506214967.5315130.1504869110572.JavaMail.zimbra@redhat.com>
 <402757886.5318604.1504871077415.JavaMail.zimbra@redhat.com>
Message-ID: <20170918155822.GA9145@infradead.org>

On Fri, Sep 08, 2017@07:44:37AM -0400, Yi Zhang wrote:
> Hi
> 
> I found this issue on latest 4.13, is it for designed?  I cannot reproduce it on 4.12.
> 
> Here is the log from host:
> 4.13
> [  637.246798] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.0.90:4420
> [  637.436315] nvme nvme0: creating 40 I/O queues.
> [  637.939988] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.90:4420
> [  645.319803] nvme nvme0: rescanning
> 
> -->need more than 60 seconds to start reconnect
> 
> [  706.073551] nvme nvme0: Reconnecting in 10 seconds...

How did you initiate the reconnect?  Cable drop?
