From: yizhan@redhat.com (Yi Zhang)
Date: Wed, 20 Sep 2017 08:50:17 +0800
Subject: Host reconnecting need more than 60s to start after nvmetcli
 clear on target
In-Reply-To: <20170919141803.GA6216@infradead.org>
References: <506214967.5315130.1504869110572.JavaMail.zimbra@redhat.com>
 <402757886.5318604.1504871077415.JavaMail.zimbra@redhat.com>
 <20170918155822.GA9145@infradead.org>
 <1d56f10c-ca41-a594-9f88-8c8c5e2711a3@redhat.com>
 <20170919141803.GA6216@infradead.org>
Message-ID: <b0a4793b-ab9e-1c82-72aa-a0736ecf038d@redhat.com>



On 09/19/2017 10:18 PM, Christoph Hellwig wrote:
> On Tue, Sep 19, 2017@05:09:05PM +0800, Yi Zhang wrote:
>>
>> On 09/18/2017 11:58 PM, Christoph Hellwig wrote:
>>> On Fri, Sep 08, 2017@07:44:37AM -0400, Yi Zhang wrote:
>>>> Hi
>>>>
>>>> I found this issue on latest 4.13, is it for designed?  I cannot reproduce it on 4.12.
>>>>
>>>> Here is the log from host:
>>>> 4.13
>>>> [  637.246798] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.0.90:4420
>>>> [  637.436315] nvme nvme0: creating 40 I/O queues.
>>>> [  637.939988] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.90:4420
>>>> [  645.319803] nvme nvme0: rescanning
>>>>
>>>> -->need more than 60 seconds to start reconnect
>>>>
>>>> [  706.073551] nvme nvme0: Reconnecting in 10 seconds...
>>> How did you initiate the reconnect?  Cable drop?
>> Just execute "nvmetcli clear" on target side, and check the log on host
>> side.
> Ok.  60 seconds is when the first commands will time out, so that's
> expected.   The NVMeoF protocol has no way to notify the host that
> a connection went away, so if you ren't on a protocol that supports
> link up/down notifications we'll have to wait for timeouts.
Got, thanks Christoph.
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
