From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 15 Oct 2018 00:50:23 -0700
Subject: [EXT] Re: bad IOPS when running multiple btest/fio in parallel
In-Reply-To: <707ebd2e96d9460f9a6188c9cb6ae141@SC-EXCH03.marvell.com>
References: <1539319463418.78556@marvell.com>
 <1539359350.249485.6.camel@acm.org>
 <707ebd2e96d9460f9a6188c9cb6ae141@SC-EXCH03.marvell.com>
Message-ID: <f5349a26-0cae-8a3b-30e8-cdf16d8fd74f@grimberg.me>


> Thanks Bart. In my original post, I list the performance from 2 different 100G NICs. I worked with the engineer for the NIC that performs better. Their driver does support large number of IRQ which are assigned to all 28 CPUs in a round-robin manner. But even with this  design, that NIC can hit only 76Gb/s for RoCEv2 traffic.
> 
> I haven't got the response from the other NIC vendor. Their RoCEv2 throughput has never exceed 55Gb/s. I will take a look at the source code.

What kernel version are you running?

Do you happen to run irq balancer?
